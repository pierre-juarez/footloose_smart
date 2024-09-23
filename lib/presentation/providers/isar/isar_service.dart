import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/infraestructure/isar/client.schema.dart';
import 'package:footloose_tickets/infraestructure/isar/config.schema.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  Isar? _isar;

  factory IsarService() {
    return _instance;
  }

  IsarService._internal();

  Future<Isar> getIsarInstance() async {
    if (_isar == null) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        _isar = await Isar.open([ConfigurationSchema, ClientSchema], directory: dir.path);
      } catch (e) {
        errorLog(e.toString());
      }
    }
    return _isar!;
  }
}
