class Environment {
  static String development = "DEV";
  // static String tokenSISCONTI = "bd5bae4482fc445487445ca561f6c6f0=";
  static String backSmartDEV = "https://apisdevelopment.footloose.pe/smart-app";
  // static String backSmartDEV = "https://petite-cloths-laugh.loca.lt";
  static String backSmartPROD = "https://quick-zoos-march.loca.lt";
  static String tokenSmart = "YmFja19zbWFydGZvb3Rsb29zZTpvQiNaMEBjMTk3KEs1cnswRF5bQQ==";
  static bool withAPIProduct = true;
  static String get backSmartURL => development == "DEV" ? backSmartDEV : backSmartPROD;
}
