import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:footloose_tickets/config/constants/environment.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/infraestructure/models/login_model.dart';
import 'package:footloose_tickets/infraestructure/models/user_with_token_model.dart';
import 'package:jwt_decode/jwt_decode.dart';

// TODO - Migrate changeNotifier to riverpod

class AuthProvider with ChangeNotifier {
  Dio dio = Dio();

  late UserWithTokenModel userModelWithToken = UserWithTokenModel();
  bool _outLoadingLogin = false;
  bool _autenticando = false;
  bool _isConnect = false;
  bool _isConnetLogin = false;
  bool _conexionLentaServidor = false;
  bool _conexionLentaServidorLogin = false;
  bool _errorServidor = false;
  int _statusCodeLogin = 0;
  int _statusCodeLoggedIn = 0;

  String _tokenInApp = "";
  String _usercod = "";
  String _usuario = "";
  String _password = "";
  String _androidId = "";
  bool? _codeColaboradorValid;
  final _storage = const FlutterSecureStorage();

  //Login
  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  //OutLoadingLogin
  bool get outLoadingLogin => _outLoadingLogin;
  set outLoadingLogin(bool valor) {
    _outLoadingLogin = valor;
    notifyListeners();
  }

  //Is connect
  bool get isConnect => _isConnect;
  set isConnect(bool valor) {
    _isConnect = valor;
    notifyListeners();
  }

  bool get isConnetLogin => _isConnetLogin;
  set isConnetLogin(bool valor) {
    _isConnetLogin = valor;
    notifyListeners();
  }

  //Conexion lenta servidor
  bool get conexionLentaServidor => _conexionLentaServidor;
  set conexionLentaServidor(bool valor) {
    _conexionLentaServidor = valor;
    notifyListeners();
  }

  bool get conexionLentaServidorLogin => _conexionLentaServidorLogin;
  set conexionLentaServidorLogin(bool valor) {
    _conexionLentaServidorLogin = valor;
    notifyListeners();
  }

  bool get errorServidor => _errorServidor;
  set errorServidor(bool valor) {
    _errorServidor = valor;
    notifyListeners();
  }

  //user
  String get userCod => _usercod;
  set userCod(String user) {
    _usercod = user;
    notifyListeners();
  }

  //*guardar el token y validar si sigue logueado para mostrar
  //otra pantalla
  //tambien falta completar la logica del agregado a carrito
  String get tokenInApp => _tokenInApp;
  set tokenInApp(String valor) {
    _tokenInApp = valor;
    notifyListeners();
  }

  int get statusCodeLogin => _statusCodeLogin;
  set statusCodeLogin(int user) {
    _statusCodeLogin = user;
    notifyListeners();
  }

  int get statusCodeLoggedIn => _statusCodeLoggedIn;
  set statusCodeLoggedIn(int user) {
    _statusCodeLoggedIn = user;
    notifyListeners();
  }

  String get usuario => _usuario;
  set usuario(String valor) {
    _usuario = valor;
    notifyListeners();
  }

  String get password => _password;
  set password(String valor) {
    _password = valor;
    notifyListeners();
  }

  bool? get codeColaboradorValid => _codeColaboradorValid;
  set codeColaboradorValid(bool? valor) {
    _codeColaboradorValid = valor;
    notifyListeners();
  }

  String get androidId => _androidId;
  set androidId(String valor) {
    _androidId = valor;
    notifyListeners();
  }

  //usando el storage para guardar esta informacion
  //guardar Informacion Token y cod user
  Future _saveToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future _saveUsuario(String user) async {
    return await _storage.write(key: "user", value: user);
  }

  //esta propiedad estatica me permitira leer el token en toda la aplicacion
  static Future<String> getToken() async {
    try {
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      return token!;
    } catch (e) {
      return "";
    }
  }

  static Future<String> getUserCod() async {
    const storage = FlutterSecureStorage();
    final user = await storage.read(key: "user");
    return user!;
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "token");
  }

  void clearInputs() {
    _usuario = "";
    _password = "";
    notifyListeners();
  }

  Future<bool> login(String usuario, String clave, String mobileid, String urlParam, String typeRequest) async {
    try {
      autenticando = true;

      Options options = Options(
        method: typeRequest,
        headers: {
          "Content-Type": "application/json",
        },
      );

      final data = {"username": usuario, "password": clave, "mobileid": mobileid};

      Response resp = await dio.request(
        urlParam,
        options: options,
        data: data,
        queryParameters: {'env': Environment.development},
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          return Response(
            requestOptions: RequestOptions(path: urlParam),
            statusCode: 408,
            statusMessage: "Error",
          );
        },
      );

      infoLog("🚀 ~ file: auth_provider.dart ~ resp.data ~  ${resp.data}");
      infoLog("🚀 ~ file: auth_provider.dart ~ resp.statusCode ~  ${resp.statusCode}");

      autenticando = false;
      _statusCodeLogin = resp.statusCode ?? 400;

      if (resp.statusCode == 200) {
        final loginresponse = LoginModelResponse.fromJson(resp.data);
        Map<String, dynamic> payload = Jwt.parseJwt(loginresponse.data.tk);
        final subject = UserWithTokenModel.fromMap(payload);
        userModelWithToken = subject;
        //se guardará el token para confirmar la sesion del usuario
        await _saveToken(loginresponse.data.tk);
        await _saveUsuario(usuario);
        userCod = await AuthProvider.getUserCod();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      _statusCodeLogin = 404;
      throw ErrorDescription("Error al iniciar sesión - $e");
    }
  }

  //* PARA VALIDAR SI EL USUARIO SE ENCUENTRA LOGEADO
  Future<bool> isLoggedIn(String urlParam, String typeRequest) async {
    String? token = "";
    try {
      token = await _storage.read(key: "token");
    } catch (e) {
      token = "";
    }

    bool isLoged = false;

    try {
      Options options = Options(
        method: typeRequest,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      Response resp = await dio.request(
        urlParam,
        options: options,
        queryParameters: {'env': Environment.development},
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          statusCodeLoggedIn = 408;
          return Response(
            requestOptions: RequestOptions(path: urlParam),
            statusCode: 408,
            statusMessage: "Error",
          );
        },
      );

      if (resp.statusCode == 200) {
        //* VALIDACION CORRECTA DEL TOKEN
        final loginresponse = LoginModelResponse.fromJson(resp.data);
        await _saveToken(loginresponse.data.tk);
        Map<String, dynamic> payload = Jwt.parseJwt(loginresponse.data.tk);
        final subject = UserWithTokenModel.fromMap(payload);
        userModelWithToken = subject;
        userCod = await AuthProvider.getUserCod();

        isLoged = true;
        isConnect = true;
        return isLoged;
      } else {
        //* CONEXION LENTA

        isConnect = true;
        isLoged = false;
        conexionLentaServidor = true;
        return isLoged;
      }
    } catch (e) {
      //* ESTADO DE SIN CONEXION
      isConnect = false;
      return isConnect;
    }
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
