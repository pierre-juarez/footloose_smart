import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CredencialesProvider extends ChangeNotifier {
  String _usuario = "";
  String _clave = "";
  String _codeConfirmation = "";
  String _newPassword = "";
  String _newPassword2 = "";
  String _codTienda = "";
  String _numSerieHoneyWell = "Cargando...";
  String _androidId = "Cargando...";
  String _brandDevice = "Cargando...";

  String _ubicacionForInventory = "";
  String _ubicacionForInventoryCalzadoExhibicion = "";

  bool? _storeValid;
  bool? _codeColaboradorValid;

  String get androidId => _androidId;
  set androidId(String valor) {
    _androidId = valor;
    notifyListeners();
  }

  String get brandDevice => _brandDevice;
  set brandDevice(String valor) {
    _brandDevice = valor;
    notifyListeners();
  }

  String get usuario => _usuario;
  set usuario(String valor) {
    _usuario = valor;
    notifyListeners();
  }

  String get clave {
    return _clave;
  }

  set clave(String valor) {
    _clave = valor;
    notifyListeners();
  }

  String get codeConfirmation {
    return _codeConfirmation;
  }

  set codeConfirmation(String valor) {
    _codeConfirmation = valor;
    notifyListeners();
  }

  String get newPassword {
    return _newPassword;
  }

  set newPassword(String valor) {
    _newPassword = valor;
    notifyListeners();
  }

  String get newPassword2 {
    return _newPassword2;
  }

  set newPassword2(String valor) {
    _newPassword2 = valor;
    notifyListeners();
  }

  String get codTienda {
    return _codTienda;
  }

  set codTienda(String valor) {
    _codTienda = valor;
    notifyListeners();
  }

  String get numSerieHoneyWell {
    return _numSerieHoneyWell;
  }

  set numSerieHoneyWell(String valor) {
    _numSerieHoneyWell = valor;
    notifyListeners();
  }

  String get ubicacionForInventory => _ubicacionForInventory;
  set ubicacionForInventory(String valor) {
    _ubicacionForInventory = valor;
    notifyListeners();
  }

  String get ubicacionForInventoryCalzadoExhibicio => _ubicacionForInventoryCalzadoExhibicion;
  set ubicacionForInventoryCalzadoExhibicio(String valor) {
    _ubicacionForInventoryCalzadoExhibicion = valor;
    notifyListeners();
  }

  bool? get storeValid => _storeValid;
  set storeValid(bool? valor) {
    _storeValid = valor;
    notifyListeners();
  }

  bool? get codeColaboradorValid => _codeColaboradorValid;
  set codeColaboradorValid(bool? valor) {
    _codeColaboradorValid = valor;
    notifyListeners();
  }
}

final credencialesProvider = ChangeNotifierProvider((ref) => CredencialesProvider());
