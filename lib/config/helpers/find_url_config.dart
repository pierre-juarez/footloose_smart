import 'package:footloose_tickets/infraestructure/isar/config.schema.dart';
import 'package:footloose_tickets/presentation/providers/isar/isar_service.dart';
import 'package:isar/isar.dart';

Future<Configuration?> configurationWithKey(String searchKey) async {
  final isar = await IsarService().getIsarInstance();
  final Configuration? config = await isar.configurations.filter().claveContains(searchKey).findFirst();
  return config;
}
