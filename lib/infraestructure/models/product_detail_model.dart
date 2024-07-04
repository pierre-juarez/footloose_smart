class ProductDetailModel {
  bool? status;
  List<Datum>? data;
  String? message;

  ProductDetailModel({
    this.status,
    this.data,
    this.message,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? false,
        "data": (data != null) ? List<dynamic>.from(data!.map((x) => x.toJson())) : [],
        "message": message ?? "",
      };
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
        producto: json["producto"],
        nombre: json["nombre"],
        preciocostoSiva: json["PRECIOCOSTO_siva"]?.toDouble(),
        preciobancoCiva: json["PRECIOBANCO_civa"]?.toDouble(),
        fechacompra: json["fechacompra"].toString().isNotEmpty ? DateTime.parse(json["fechacompra"]) : DateTime.now(),
        fechaing: json["fechaing"].toString().isNotEmpty ? DateTime.parse(json["fechaing"]) : DateTime.now(),
        fechaIngCd: json["fechaIngCD"],
        fechaIngTd: json["fechaIngTD"],
        proveedor: json["proveedor"],
        procedencia: json["PROCEDENCIA"],
        tallas: json["TALLAS"],
        material1: json["MATERIAL 1"],
        presentacionAccesorio: json["PRESENTACION ACCESORIO"],
        detalleArticulo: json["DETALLE ARTICULO"],
        modelo: json["MODELO"],
        color1: json["COLOR 1"],
        categoria: json["CATEGORIA"],
        colorForro: json["COLOR FORRO"],
        tipoConstruccion: json["TIPO CONSTRUCCION"],
        categoriaWeb: json["CATEGORIA WEB"],
        generoWeb: json["GENERO WEB"],
        colorPlantilla: json["COLOR PLANTILLA"],
        alturaCana: json["ALTURA CANA"],
        acabadoCapellada: json["ACABADO CAPELLADA"],
        uso: json["USO"],
        materialForro: json["MATERIAL FORRO"],
        estiloTaco: json["ESTILO TACO"],
        detallePlanta: json["DETALLE PLANTA"],
        unidadDeMedida: json["UNIDAD DE MEDIDA"],
        material2: json["MATERIAL 2"],
        material3: json["MATERIAL 3"],
        grupoDeArticulos: json["GRUPO DE ARTICULOS"],
        tipoDeArticulo: json["TIPO DE ARTICULO"],
        marca: json["MARCA"],
        color2: json["COLOR 2"],
        materialHuella: json["MATERIAL HUELLA"],
        materialPlantilla: json["MATERIAL PLANTILLA"],
        construccion: json["CONSTRUCCION"],
        tipoHorma: json["TIPO HORMA"],
        genero: json["GENERO"],
        estiloWeb: json["ESTILO WEB"],
        ocasion: json["OCASION"],
        estiloPunta: json["ESTILO PUNTA"],
        colorPlanta: json["COLOR PLANTA"],
        linea: json["LINEA"],
        temporada: json["TEMPORADA"],
        tipoHuella: json["TIPO HUELLA"],
        materialPlanta: json["MATERIAL PLANTA"],
        color3: json["COLOR 3"],
        urlimagen: json["urlimagen"],
      );

  Map<String, dynamic> toJson() => {
        "producto": producto,
        "nombre": nombre,
        "PRECIOCOSTO_siva": preciocostoSiva,
        "PRECIOBANCO_civa": preciobancoCiva,
        "fechacompra": fechacompra.toIso8601String(),
        "fechaing": fechaing.toIso8601String(),
        "fechaIngCD": fechaIngCd,
        "fechaIngTD": fechaIngTd,
        "proveedor": proveedor,
        "PROCEDENCIA": procedencia,
        "TALLAS": tallas,
        "MATERIAL 1": material1,
        "PRESENTACION ACCESORIO": presentacionAccesorio,
        "DETALLE ARTICULO": detalleArticulo,
        "MODELO": modelo,
        "COLOR 1": color1,
        "CATEGORIA": categoria,
        "COLOR FORRO": colorForro,
        "TIPO CONSTRUCCION": tipoConstruccion,
        "CATEGORIA WEB": categoriaWeb,
        "GENERO WEB": generoWeb,
        "COLOR PLANTILLA": colorPlantilla,
        "ALTURA CANA": alturaCana,
        "ACABADO CAPELLADA": acabadoCapellada,
        "USO": uso,
        "MATERIAL FORRO": materialForro,
        "ESTILO TACO": estiloTaco,
        "DETALLE PLANTA": detallePlanta,
        "UNIDAD DE MEDIDA": unidadDeMedida,
        "MATERIAL 2": material2,
        "MATERIAL 3": material3,
        "GRUPO DE ARTICULOS": grupoDeArticulos,
        "TIPO DE ARTICULO": tipoDeArticulo,
        "MARCA": marca,
        "COLOR 2": color2,
        "MATERIAL HUELLA": materialHuella,
        "MATERIAL PLANTILLA": materialPlantilla,
        "CONSTRUCCION": construccion,
        "TIPO HORMA": tipoHorma,
        "GENERO": genero,
        "ESTILO WEB": estiloWeb,
        "OCASION": ocasion,
        "ESTILO PUNTA": estiloPunta,
        "COLOR PLANTA": colorPlanta,
        "LINEA": linea,
        "TEMPORADA": temporada,
        "TIPO HUELLA": tipoHuella,
        "MATERIAL PLANTA": materialPlanta,
        "COLOR 3": color3,
        "urlimagen": urlimagen,
      };
}
