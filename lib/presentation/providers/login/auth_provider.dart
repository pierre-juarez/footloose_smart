import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:footloose_puntodeventa/src/domian/models/login_model.dart';
// import 'package:footloose_puntodeventa/src/domian/models/user_model.dart';
// import 'package:footloose_puntodeventa/src/domian/utils/globals.dart';
import 'package:footloose_tickets/config/constants/environment.dart';
import 'package:footloose_tickets/infraestructure/models/login_model.dart';
import 'package:footloose_tickets/infraestructure/models/user_with_token_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:logging/logging.dart';

//Servicios

//Serivio de login nuevo basado en la nueva API

class AuthProvider with ChangeNotifier {
  final Logger logger = Logger('MyApp');

  late UserWithTokenModel userModelWithToken = UserWithTokenModel();
  bool _outLoadingLogin = false;
  bool _autenticando = false;
  bool _isConnect = false;
  bool _isConnetLogin = false;
  bool _conexionLentaServidor = false;
  bool _conexionLentaServidorLogin = false;
  bool _errorServidor = false;
  int _statusCodeLogin = 0;

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

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "token");
  }

  Future logOut() async {
    await _storage.delete(key: "token");
  }

  //peticiones a la base de datos LOGIN
  Future<bool> login(String usuario, String clave, String mobileid) async {
    autenticando = true;

    final data = {"username": usuario, "password": clave, "mobileid": mobileid};

    try {
      final url = Uri.https("apis.footloose.pe", "/pdv/api/auth/login", {
        'env': Environment.development,
      });

      print("🚀 ~ file: auth_provider.dart ~ line: 173 ~ TM_FUNCTION: $url");
      print("🚀 ~ file: auth_provider.dart ~ line: 174 ~ TM_FUNCTION: $data");

      final resp = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        statusCodeLogin = 408;
        return http.Response("Error", 408);
      });

      print("🚀 ~ file: auth_provider.dart ~ line: 184 ~ TM_FUNCTION: ${resp.body}");
      print("🚀 ~ file: auth_provider.dart ~ line: 185 ~ TM_FUNCTION: ${resp.statusCode}");

      autenticando = false;
      _statusCodeLogin = resp.statusCode;

      if (resp.statusCode == 200) {
        final loginresponse = LoginModelResponse.fromJson(resp.body);
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

      // if (resp.statusCode == 500) {
      //   isConnetLogin = true;
      //   errorServidor = true;
      //   print(resp.body);
      //   return false;
      // } else if (resp.statusCode == 408) {
      //   //* CONEXION LENTA DE SERVIDOR
      //   conexionLentaServidorLogin = true;
      //   errorServidor = false;
      //   isConnetLogin = true;
      //   print(resp.body);
      //   return false;
      // } else {
      //   //* DATOS INCORRECTOS DE INICIO DE SESION
      //   print("STATUS CODE LOGIN:${resp.statusCode}");
      //   errorServidor = false;
      //   isConnetLogin = true;
      //   print(resp.body);
      //   return false;
      // }
    } catch (e) {
      // isConnetLogin = false;
      _statusCodeLogin = 404;
      logger.severe("Error al intentar logearse: ", e);
      return false;
    }
  }

  //* PARA VALIDAR SI EL USUARIO SE ENCUENTRA LOGEADO
  Future<bool> isLoggedIn() async {
    String? token = "";
    try {
      token = await _storage.read(key: "token");
    } catch (e) {
      token = "";
    }

    bool isLoged = false;

    try {
      final resp = await http.post(Uri.parse("${Environment.urlBase}/api/auth/renew"), headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      }).timeout(const Duration(seconds: 15), onTimeout: () {
        print("STATUS CONEXION LENTA IsLoggedIn: "); // TODO - Cambiar el mensaje conexión sin internet por uno de timeout
        print("🚀 ~ file: auth_service.dart ~ line: 204 ~ Timeout en el Renew Auth");
        return http.Response("Error", 408);
      });

      if (resp.statusCode == 200) {
        //* VALIDACION CORRECTA DEL TOKEN
        final loginresponse = LoginModelResponse.fromJson(resp.body);
        await _saveToken(loginresponse.data.tk);
        Map<String, dynamic> payload = Jwt.parseJwt(loginresponse.data.tk);
        final subject = UserWithTokenModel.fromMap(payload);
        userModelWithToken = subject;
        userCod = await AuthProvider.getUserCod();
        print("TOKEN ISLOGGEDIN>>> desencriptado $payload");
        print("USERCOD ISLOGGEDIN>>>  $userCod");

        isLoged = true;
        isConnect = true;
        return isLoged;
      } else if (resp.statusCode == 408) {
        //* CONEXION LENTA
        print("CONEXION LENTA");

        isConnect = true;
        isLoged = false;
        conexionLentaServidor = true;
        return isLoged;
      } else {
        //* REGISTRADO Y NO LOGEADO TOKEN EXPIRADO O NO REGISTRADO Y NO LOGEADO
        print("STATUS: ${resp.statusCode}");
        print("REGISTRADO Y NO LOGEADO TOKEN EXPIRADO O NO REGISTRADO Y NO LOGEADO");
        logOut();
        isConnect = true;
        isLoged = false;
        conexionLentaServidor = false;
        return isLoged;
      }
    } catch (e) {
      //* ESTADO DE SIN CONEXION
      isConnect = false;
      return false;
    }
  }

  ///REVISAR ESTA INFORMACION DE LA API POR QUE NO ME ESTA SIENDO UTIL
  ///TENGO SUBS IGUALES
  //peticiones a la base de datos GET PROFILE
  Future getProfile(String token, String sub) async {
    final resp = await http.get(Uri.parse("${Environment.urlBase}/api/auth/profile?sub=$sub"),
        headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"});

    if (resp.statusCode == 200) {
      final userResponse = UserModelResponse.fromJson(resp.body);
      userModelWithToken = userResponse.user;
      print(userResponse.user.persona);
      return true;
    } else {
      print("enviar bien parametros");
      return false;
    }
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
