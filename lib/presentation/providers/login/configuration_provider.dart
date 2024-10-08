import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:footloose_tickets/config/constants/environment.dart';
import 'package:footloose_tickets/infraestructure/isar/client.schema.dart';
import 'package:footloose_tickets/infraestructure/isar/config.schema.dart';
import 'package:footloose_tickets/presentation/providers/isar/isar_service.dart';
import 'package:isar/isar.dart';

// TODO - Migrate changeNotifier to riverpod

class ConfigurationProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  Dio dio = Dio();
  late Configuration config = Configuration();
  int _statusGetClient = 0;
  late Isar isar;
  String _idOption = "";

  int get statusGetClient => _statusGetClient;
  set statusGetClient(int user) {
    _statusGetClient = user;
    notifyListeners();
  }

  String get idOption => _idOption;
  set idOption(String optionId) {
    _idOption = optionId;
    notifyListeners();
  }

  ConfigurationProvider() {
    _initIsar();
  }

  Future saveConfiguration(String option, String optionId) async {
    idOption = optionId;
    await _storage.write(key: "configOption", value: option);
    await _storage.write(key: "configOptionId", value: optionId);
    notifyListeners();
  }

  Future<String> getConfigId() async {
    try {
      const storage = FlutterSecureStorage();
      final configId = await storage.read(key: "configOptionId");
      idOption = configId!;
      notifyListeners();
      return configId;
    } catch (e) {
      idOption = "";
      notifyListeners();
      return "";
    }
  }

  Future<void> deleteConfig() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "configOption");
    await storage.delete(key: "configOptionId");
    idOption = "";
    notifyListeners();
  }

  Future<void> _initIsar() async {
    isar = await IsarService().getIsarInstance();
  }

  void setupDio() {
    dio.options.headers['Authorization'] = 'Basic ${Environment.tokenSmart}';
  }

  Future<void> getConfigs(String idOptionSelected) async {
    try {
      await _initIsar();
      setupDio();

      Options options = Options(
        method: "GET",
        // headers: {
        //   "Content-Type": "application/json",
        // },
      );

      final data = {
        "ambiente": Environment.development,
      };

      final String url = "${Environment.backSmart}/api-configuration/$idOptionSelected";
      Response resp = await dio.request(url, options: options, data: data).timeout(
        const Duration(seconds: 5),
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
        final List<Configuration> configs =
            (resp.data as List).map((json) => Configuration.fromJson(json as Map<String, dynamic>)).toList();
        await addConfigIsar(configs);
      }
    } catch (e) {
      _statusGetClient = 404;
      throw ErrorDescription("Error al obtener las configuraciones - $e");
    }
  }

  Future<void> addConfigIsar(List<Configuration> configs) async {
    List<int> list = [];
    await isar.writeTxn(
      () async {
        for (var config in configs) {
          final existingConfig = await isar.configurations.filter().idConfigEqualTo(config.idConfig).findFirst();
          if (existingConfig == null) {
            int insertId = await isar.configurations.put(config);
            list.add(insertId);
          }
        }
      },
    );
  }

  Future<void> deleteTablesIsar() async {
    await isar.writeTxn(() async {
      await isar.clients.clear();
      await isar.configurations.clear();
    });
  }

  Future<bool> existClients() async {
    return await isar.clients.count() > 0;
  }
}

final configurationProvider = ChangeNotifierProvider((ref) => ConfigurationProvider());
