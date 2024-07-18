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

  Future<void> getClients() async {
    try {
      await _initIsar();

      Options options = Options(
        method: "GET",
      );

      // FIXME - Apuntar a localhost y ver porqué se repite (O simular un error de API)
      final String url = "${Environment.backSmart}/api-client";

      Response resp = await dio.request(url, options: options).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          print("🚀 ~ file: client_provider.dart ~ line: 45 ~ TM_FUNCTION: ");
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
      print("🚀 ~ Error al obtener el cliente: $e");
      _statusGetClient = 404;
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
    print("🚀 ~ file: client_provider.dart ~ line: 94 ~ TM_FUNCTION: $list");
  }
}

final clientProvider = ChangeNotifierProvider((ref) => ClientProvider());
