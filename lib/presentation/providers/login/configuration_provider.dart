import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConfigurationProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  Future saveConfiguration(String option, String optionId) async {
    await _storage.write(key: "configOption", value: option);
    await _storage.write(key: "configOptionId", value: optionId);
  }

  Future<String> getConfigId() async {
    try {
      const storage = FlutterSecureStorage();
      final configId = await storage.read(key: "configOptionId");
      return configId!;
    } catch (e) {
      return "";
    }
  }

  Future<void> deleteConfig() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "configOption");
    await storage.delete(key: "configOptionId");
  }
}

final configurationProvider = ChangeNotifierProvider((ref) => ConfigurationProvider());
