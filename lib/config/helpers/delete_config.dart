import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';

Future<void> deleteConfigAll(ConfigurationProvider config) async {
  await config.deleteConfig();
  await config.deleteTablesIsar();
}
