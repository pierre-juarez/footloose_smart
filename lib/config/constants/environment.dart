class Environment {
  static String urlBase = "https://apis.footloose.pe/pdv";
  static String development = "DEV";
  static String serverDEV = "apisdevelopment.footloose.pe";
  static String serverPROD = "apis.footloose.pe";
  static String serverURL = (development == "DEV") ? serverDEV : serverPROD;
  static String tokenSISCONTI = "bd5bae4482fc445487445ca561f6c6f0=";
}
