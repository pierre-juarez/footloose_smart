import 'dart:math';

class ProductDetailModel {
  Datum? productDetail;

  ProductDetailModel({this.productDetail});

  static Datum getDummyData() {
    return Datum(
      producto: generateRandom11DigitNumber(),
      nombre: "Nombre del producto 1",
      preciocostoSiva: 100 + 0.toDouble(),
      preciobancoCiva: 150 + 0.toDouble(),
      fechacompra: DateTime.now().subtract(const Duration(days: 0)),
      fechaing: DateTime.now().add(const Duration(days: 0)),
      fechaIngCd: "CD${1}",
      fechaIngTd: "TD${1}",
      proveedor: "Proveedor ${1 % 5}",
      procedencia: "Procedencia ${1 % 3}",
      tallas: "40",
      material1: 0 % 2 == 0 ? 1 : 2,
      presentacionAccesorio: "Presentación ${1 % 2}",
      detalleArticulo: "Detalles del artículo ${1}",
      modelo: "Modelo ${1}",
      color1: 0 % 5,
      categoria: "Categoria ${1 % 6}",
      colorForro: "Color forro ${1 % 7}",
      tipoConstruccion: "Tipo de construcción ${1 % 8}",
      categoriaWeb: "Categoria web ${1 % 9}",
      generoWeb: "Genero web ${1 % 10}",
      colorPlantilla: "Color plantilla ${1 % 11}",
      alturaCana: "Altura cana ${1 % 12}",
      acabadoCapellada: "Acabado capellada ${1 % 13}",
      uso: "Uso ${1 % 14}",
      materialForro: "Material forro ${1 % 15}",
      estiloTaco: "Estilo taco ${1 % 16}",
      detallePlanta: "Detalles planta ${1 % 17}",
      unidadDeMedida: 0 % 18 == 0 ? "Unidad" : null,
      material2: 0 % 19,
      material3: 0 % 20,
      grupoDeArticulos: "Grupo de artículos ${1 % 21}",
      tipoDeArticulo: "Tipo de artículo ${1 % 22}",
      marca: "Marca ${1 % 23}",
      color2: 0 % 24,
      materialHuella: "Material huella ${1 % 25}",
      materialPlantilla: "Material plantilla ${1 % 26}",
      construccion: "Construcción ${1 % 27}",
      tipoHorma: "Tipo horma ${1 % 28}",
      genero: "Genero ${1 % 29}",
      estiloWeb: "Estilo web ${1 % 30}",
      ocasion: "Ocasión ${1 % 31}",
      estiloPunta: "Estilo punta ${1 % 32}",
      colorPlanta: "Color planta ${1 % 33}",
      linea: "Linea ${1 % 34}",
      temporada: "Temporada ${1 % 35}",
      tipoHuella: "Tipo huella ${1 % 36}",
      materialPlanta: "Material planta ${1 % 37}",
      color3: 0 % 38,
      urlimagen: "https://assets.footloose.pe/sip/_images/1x/585_111651_00030404_052_5_043_001.jpg",
    );
  }

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
        productDetail: Datum.fromJson(json),
      );

  Map<String, dynamic> toJson() => productDetail?.toJson() ?? {};

  ProductDetailModel.fromDatum() {
    getDummyData();
  }
}

class Datum {
  String producto;
  String nombre;
  double preciocostoSiva;
  double preciobancoCiva;
  DateTime fechacompra;
  DateTime fechaing;
  String fechaIngCd;
  String fechaIngTd;
  String proveedor;
  String procedencia;
  String tallas;
  int material1;
  dynamic presentacionAccesorio;
  String detalleArticulo;
  String modelo;
  int color1;
  String categoria;
  String colorForro;
  String tipoConstruccion;
  String categoriaWeb;
  String generoWeb;
  String colorPlantilla;
  String alturaCana;
  String acabadoCapellada;
  String uso;
  String materialForro;
  String estiloTaco;
  String detallePlanta;
  dynamic unidadDeMedida;
  int material2;
  int material3;
  dynamic grupoDeArticulos;
  dynamic tipoDeArticulo;
  String marca;
  int color2;
  String materialHuella;
  String materialPlantilla;
  String construccion;
  String tipoHorma;
  String genero;
  String estiloWeb;
  String ocasion;
  String estiloPunta;
  String colorPlanta;
  String linea;
  String temporada;
  String tipoHuella;
  String materialPlanta;
  int color3;
  String urlimagen;

  Datum({
    required this.producto,
    required this.nombre,
    required this.preciocostoSiva,
    required this.preciobancoCiva,
    required this.fechacompra,
    required this.fechaing,
    required this.fechaIngCd,
    required this.fechaIngTd,
    required this.proveedor,
    required this.procedencia,
    required this.tallas,
    required this.material1,
    required this.presentacionAccesorio,
    required this.detalleArticulo,
    required this.modelo,
    required this.color1,
    required this.categoria,
    required this.colorForro,
    required this.tipoConstruccion,
    required this.categoriaWeb,
    required this.generoWeb,
    required this.colorPlantilla,
    required this.alturaCana,
    required this.acabadoCapellada,
    required this.uso,
    required this.materialForro,
    required this.estiloTaco,
    required this.detallePlanta,
    required this.unidadDeMedida,
    required this.material2,
    required this.material3,
    required this.grupoDeArticulos,
    required this.tipoDeArticulo,
    required this.marca,
    required this.color2,
    required this.materialHuella,
    required this.materialPlantilla,
    required this.construccion,
    required this.tipoHorma,
    required this.genero,
    required this.estiloWeb,
    required this.ocasion,
    required this.estiloPunta,
    required this.colorPlanta,
    required this.linea,
    required this.temporada,
    required this.tipoHuella,
    required this.materialPlanta,
    required this.color3,
    required this.urlimagen,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        producto: json["producto"] ?? "",
        nombre: json["nombre"] ?? "",
        preciocostoSiva: json["precioCostoSiva"]?.toDouble() ?? 0.0,
        preciobancoCiva: json["precioBancoCiva"]?.toDouble() ?? 0.0,
        fechacompra: json["fechaCompra"] != null && json["fechaCompra"].toString().isNotEmpty
            ? DateTime.parse(json["fechaCompra"].replaceAll("Z", ""))
            : DateTime.now(),
        fechaing: json["fechaIng"] != null && json["fechaIng"].toString().isNotEmpty
            ? DateTime.parse(json["fechaIng"].replaceAll("Z", ""))
            : DateTime.now(),
        fechaIngCd: json["fechaIngCD"] ?? "",
        fechaIngTd: json["fechaIngTD"] ?? "",
        proveedor: json["proveedor"] ?? "",
        procedencia: json["procedencia"] ?? "",
        tallas: json["tallas"] ?? "",
        material1: json["material1"] ?? "",
        presentacionAccesorio: json["presentacionAccesorio"] ?? "",
        detalleArticulo: json["detalleArticulo"] ?? "",
        modelo: json["modelo"] ?? "",
        color1: json["color1"] ?? "",
        categoria: json["categoria"] ?? "",
        colorForro: json["colorForro"] ?? "",
        tipoConstruccion: json["tipoConstruccion"] ?? "",
        categoriaWeb: json["categoriaWeb"] ?? "",
        generoWeb: json["generoWeb"] ?? "",
        colorPlantilla: json["colorPlantilla"] ?? "",
        alturaCana: json["alturaCana"] ?? "",
        acabadoCapellada: json["acabadoCapellada"] ?? "",
        uso: json["uso"] ?? "",
        materialForro: json["materialForro"] ?? "",
        estiloTaco: json["estiloTaco"] ?? "",
        detallePlanta: json["detallePlanta"] ?? "",
        unidadDeMedida: json["unidadDeMedida"] ?? "",
        material2: json["material2"] ?? "",
        material3: json["material3"] ?? "",
        grupoDeArticulos: json["grupoDeArticulos"] ?? "",
        tipoDeArticulo: json["tipoDeArticulo"] ?? "",
        marca: json["marca"] ?? "",
        color2: json["color2"] ?? "",
        materialHuella: json["materialHuella"] ?? "",
        materialPlantilla: json["materialPlantilla"] ?? "",
        construccion: json["construccion"] ?? "",
        tipoHorma: json["tipoHorma"] ?? "",
        genero: json["genero"] ?? "",
        estiloWeb: json["estiloWeb"] ?? "",
        ocasion: json["ocasion"] ?? "",
        estiloPunta: json["estiloPunta"] ?? "",
        colorPlanta: json["colorPlanta"] ?? "",
        linea: json["linea"] ?? "",
        temporada: json["temporada"] ?? "",
        tipoHuella: json["tipoHuella"] ?? "",
        materialPlanta: json["materialPlanta"] ?? "",
        color3: json["color3"] ?? "",
        urlimagen: json["urlImagen"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "producto": producto,
        "nombre": nombre,
        "precioCostoSiva": preciocostoSiva,
        "precioBancoCiva": preciobancoCiva,
        "fechaCompra": fechacompra.toIso8601String(),
        "fechaIng": fechaing.toIso8601String(),
        "fechaIngCD": fechaIngCd,
        "fechaIngTD": fechaIngTd,
        "proveedor": proveedor,
        "procedencia": procedencia,
        "tallas": tallas,
        "material1": material1,
        "presentacionAccesorio": presentacionAccesorio,
        "detalleArticulo": detalleArticulo,
        "modelo": modelo,
        "color1": color1,
        "categoria": categoria,
        "colorForro": colorForro,
        "tipoConstruccion": tipoConstruccion,
        "categoriaWeb": categoriaWeb,
        "generoWeb": generoWeb,
        "colorPlantilla": colorPlantilla,
        "alturaCana": alturaCana,
        "acabadoCapellada": acabadoCapellada,
        "uso": uso,
        "materialForro": materialForro,
        "estiloTaco": estiloTaco,
        "detallePlanta": detallePlanta,
        "unidadDeMedida": unidadDeMedida,
        "material2": material2,
        "material3": material3,
        "grupoDeArticulos": grupoDeArticulos,
        "tipoDeArticulo": tipoDeArticulo,
        "marca": marca,
        "color2": color2,
        "materialHuella": materialHuella,
        "materialPlantilla": materialPlantilla,
        "construccion": construccion,
        "tipoHorma": tipoHorma,
        "genero": genero,
        "estiloWeb": estiloWeb,
        "ocasion": ocasion,
        "estiloPunta": estiloPunta,
        "colorPlanta": colorPlanta,
        "linea": linea,
        "temporada": temporada,
        "tipoHuella": tipoHuella,
        "materialPlanta": materialPlanta,
        "color3": color3,
        "urlimagen": urlimagen,
      };
}

String generateRandom11DigitNumber() {
  Random random = Random();

  // Genera el primer dígito entre 1 y 9 para evitar que empiece con 0
  String firstDigit = random.nextInt(9).toString();

  // Genera los siguientes 10 dígitos entre 0 y 9
  String otherDigits = List.generate(10, (_) => random.nextInt(10).toString()).join();

  // Retorna el número completo como string
  return firstDigit + otherDigits;
}
