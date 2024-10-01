package com.example.footloose_tickets

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import net.posprinter.IDeviceConnection
import net.posprinter.IConnectListener
import net.posprinter.POSConnect
import net.posprinter.TSPLConst
import net.posprinter.TSPLPrinter
import net.posprinter.model.AlgorithmType

class MainActivity : FlutterActivity() {

    private lateinit var channelBluetooth: MethodChannel
    private var deviceConnection: IDeviceConnection? = null // Objeto de conexión del dispositivo
    private var tsplPrinter: TSPLPrinter? = null // Objeto de impresora TSPL

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Inicialización del SDK
        POSConnect.init(applicationContext)

    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channelBluetooth = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "app.footloose_tickets/bluetooth")

        channelBluetooth.setMethodCallHandler { call, result ->
            when (call.method) {
                "connect" -> {
                    val macAddress: String? = call.argument("mac")
                    if (macAddress != null) {
                        connectToDevice(macAddress, result)
                    } else {
                        result.error("ERROR", "macAddress is null", null)
                    }
                }

                "disconnect" -> {
                    deviceConnection?.close()
                    result.success("Disconnected")
                }

                "printImage" -> {
                    val image: ByteArray? = call.argument("image")
                    val numberPrints: Int? = call.argument("numberPrints")
                    if (image != null && numberPrints != null) {
                        printImage(image, result, numberPrints)
                    } else {
                        result.error("ERROR", "Parameters are null", null)
                    }
                }

                else -> {
                    result.notImplemented()
                }

            }

        }



    }

    private fun connectToDevice(mac: String, result: MethodChannel.Result) {
        deviceConnection?.close()
        deviceConnection = POSConnect.createDevice(POSConnect.DEVICE_TYPE_BLUETOOTH)

        if (deviceConnection == null) {
            result.error("DEVICE_CREATION_FAILED", "No se pudo crear el dispositivo Bluetooth", null)
            return
        }

        val connectListener = object : IConnectListener {
            override fun onStatus(code: Int, connectInfo: String, message: String) {
                when (code) {
                    POSConnect.CONNECT_SUCCESS -> {
                        tsplPrinter = TSPLPrinter(deviceConnection) // Inicializar el objeto TSPLPrinter
                        Log.d("Bluetooth", "Conexión exitosa: $connectInfo")
                        result.success("Conexión exitosa")
                    }

                    POSConnect.CONNECT_FAIL -> {
                        Log.d("Bluetooth", "Conexión fallida: $message")
                        result.error("CONNECT_FAIL", message, null)
                    }

                    else -> {
                        Log.d("Bluetooth", "Estado desconocido: $message")
                        result.error("UNKNOWN_STATUS", message, null)
                    }
                }
            }
        }

        // Intentar conectar usando el objeto de dispositivo creado
        deviceConnection?.connect(mac, connectListener) 
    }

    private fun printImage(image: ByteArray, result: MethodChannel.Result, numberPrints: Int) {
        if (tsplPrinter == null) {
            result.error("PRINTER_NOT_CONNECTED", "Impresora no conectada", null)
            return
        }

        try {

            // Convertir ByteArray a Bitmap
            val bitmap: Bitmap = BitmapFactory.decodeByteArray(image, 0, image.size)
            if (bitmap == null) {
                result.error("BITMAP_ERROR", "Error al convertir la imagen a Bitmap", null)
                return
            }

            // Utiliza el objeto TSPLPrinter para imprimir la imagen

            tsplPrinter!!.sizeMm(76.0, 50.0).cls()
                    .bitmap(0, 0, TSPLConst.BMP_MODE_OVERWRITE, 600, bitmap, AlgorithmType.Threshold)
                    .print(numberPrints)

            // Calcular el tiempo total de espera
            val estimatedPrintTime = 800L // 800 milisegundos
            val totalWaitTime = estimatedPrintTime * numberPrints // Tiempo total en milisegundos

            // Esperar el tiempo total estimado
            Handler(Looper.getMainLooper()).postDelayed({
                result.success("Impresión finalizada")
            }, totalWaitTime);

        } catch (e: Exception) {
            Log.e("Bluetooth", "Error al imprimir la imagen: ${e.message}")
            result.error("PRINT_ERROR", e.message, null)
        }
    }


}
