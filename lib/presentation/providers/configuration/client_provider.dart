import 'package:dio/dio.dart';
import 'package:footloose_tickets/config/constants/environment.dart';
import 'package:footloose_tickets/presentation/providers/isar/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/infraestructure/isar/client.schema.dart';
import 'package:isar/isar.dart';

class ClientProvider extends ChangeNotifier {
  Dio dio = Dio();
  late Client product = Client();
  int _statusGetClient = 0;
  late Isar isar;

  int get statusGetClient => _statusGetClient;
  set statusGetClient(int user) {
    _statusGetClient = user;
    notifyListeners();
  }

  ClientProvider() {
    _initIsar();
  }

  Future<void> _initIsar() async {
    isar = await IsarService().getIsarInstance();
  }

  void setupDio() {
    dio.options.headers['Authorization'] = 'Basic ${Environment.tokenSmart}';
  }

  Future<void> getClients() async {
    try {
      await _initIsar();
      setupDio();

      Options options = Options(
        method: "GET",
      );

      final String url = "${Environment.backSmartURL}/api-client";

      Response resp = await dio.request(url, options: options).timeout(
        const Duration(seconds: 25),
        onTimeout: () {
          return Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 408,
            statusMessage: "Error",
          );
        },
      );

      _statusGetClient = resp.statusCode ?? 400;

      if (resp.statusCode == 200) {
        final List<Client> clients = (resp.data as List).map((json) => Client.fromJson(json as Map<String, dynamic>)).toList();
        await addClientIsar(clients);
      }
    } catch (e) {
      _statusGetClient = 404;
      throw ErrorDescription("Error al obtener configuración de api-client - $e");
    }
  }

  Future<void> addClientIsar(List<Client> clients) async {
    List<int> list = [];
    await isar.writeTxn(
      () async {
        for (var client in clients) {
          // Verifica si el client ya existe
          final existingClient = await isar.clients.filter().idClienteEqualTo(client.idCliente).findFirst();
          // Si el client no existe, agrégalo
          if (existingClient == null) {
            int insertId = await isar.clients.put(client);
            list.add(insertId);
          }
        }
      },
    );
  }
}

final clientProvider = ChangeNotifierProvider((ref) => ClientProvider());
