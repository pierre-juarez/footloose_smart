class Environment {
  static String urlBase = "https://apis.footloose.pe/pdv";
  static String urlAppCol = "https://api.footloose.pe:999/icq01/appcol";
  static String development = "DEV";
  static bool withIzipay = false;
  static double width = 1280;
  static String serverDEV = "apisdevelopment.footloose.pe";
  static String serverPROD = "apis.footloose.pe";
  static String serverURL = (development == "DEV") ? serverDEV : serverPROD;
  static String tokenSIP = "ZmwtdG9vbHMtYmFjazpkMDIzOTM2NC0zNTAwLTRlYjgtODAwMi1jZDZkZjEwODk4ZGU=";
  static String tokenDocumentPerson = "ZmxfYWRtaW46MGY1MmQxM2Q3MGI3MmJfazN5Xzk5ODg2NzI0N2VhMmY";
  static String tokenMKT = "ZmwtcGR2LXVzZXI6OVRhUEVGN3k5eldnV3o0SEo3aWFRdW1adEtZZGhm=";
}
