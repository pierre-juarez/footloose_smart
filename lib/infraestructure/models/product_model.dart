class ProductModel {
  final int? exito;
  final String? mensaje;
  final DateTime? fechaPeticion;
  final List<Datum>? data;

  ProductModel({
    this.exito,
    this.mensaje,
    this.fechaPeticion,
    this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        exito: json["exito"],
        mensaje: json["mensaje"],
        fechaPeticion: DateTime.parse(json["fecha_peticion"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exito": exito,
        "mensaje": mensaje ?? "",
        "fecha_peticion": fechaPeticion?.toIso8601String(),
        "data": (data != null) ? List<dynamic>.from(data!.map((x) => x.toJson())) : [],
      };
}

class Datum {
  final String? sku;
  final String? nombre;
  final String? descripcion;
  final String? detalle;
  final double? pvp;
  final double? precioBlanco;
  final double? ultimaCompra;
  final double? costoUnitario;
  final double? precioUnitario;
  final double? costoUnitarioInicial;
  final double? precioUnitarioInicial;
  final DateTime? fechaRegistro;
  final DateTime? fechaMdificacion; // Puede ser DateTime o null
  final Caracteristica caracteristica;

  Datum({
    required this.sku,
    required this.nombre,
    required this.descripcion,
    required this.detalle,
    required this.pvp,
    required this.precioBlanco,
    required this.ultimaCompra,
    required this.costoUnitario,
    required this.precioUnitario,
    required this.costoUnitarioInicial,
    required this.precioUnitarioInicial,
    required this.fechaRegistro,
    required this.fechaMdificacion,
    required this.caracteristica,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sku: json["sku"] ?? "",
        nombre: json["nombre"] ?? "",
        descripcion: json["descripcion"],
        detalle: json["detalle"] ?? "",
        pvp: (json["pvp"] ?? 0).toDouble(),
        precioBlanco: (json["precio_blanco"] ?? 0).toDouble(),
        ultimaCompra: (json["ultima_compra"] ?? 0).toDouble(),
        costoUnitario: (json["costo_unitario"] ?? 0).toDouble(),
        precioUnitario: (json["precio_unitario"] ?? 0).toDouble(),
        costoUnitarioInicial: (json["costo_unitario_inicial"] ?? 0).toDouble(),
        precioUnitarioInicial: (json["precio_unitario_inicial"] ?? 0).toDouble(),
        fechaRegistro: json["fecha_registro"] != null ? DateTime.parse(json["fecha_registro"]) : null,
        fechaMdificacion: json["fecha_mdificacion"] != null ? DateTime.parse(json["fecha_mdificacion"]) : null,
        caracteristica: Caracteristica.fromJson(json["CARACTERISTICA"]),
      );

  Map<String, dynamic> toJson() => {
        "sku": sku,
        "nombre": nombre,
        "descripcion": descripcion,
        "detalle": detalle,
        "pvp": pvp,
        "precio_blanco": precioBlanco,
        "ultima_compra": ultimaCompra,
        "costo_unitario": costoUnitario,
        "precio_unitario": precioUnitario,
        "costo_unitario_inicial": costoUnitarioInicial,
        "precio_unitario_inicial": precioUnitarioInicial,
        "fecha_registro": fechaRegistro?.toIso8601String(),
        "fecha_mdificacion": fechaMdificacion?.toIso8601String(),
        "CARACTERISTICA": caracteristica.toJson(),
      };
}

class Caracteristica {
  final AccesorioCalzado tallas;
  final Material material;
  final AccesorioCalzado campana;
  final AccesorioCalzado temporada;
  final AccesorioCalzado presentacionAccesorio;
  final AccesorioCalzado tecPlantilla;
  final AccesorioCalzado materialPlantilla;
  final AccesorioCalzado materialForro;
  final AccesorioCalzado estiloPunta;
  final AccesorioCalzado tecPlanta1;
  final AccesorioCalzado tipoHuella;
  final AccesorioCalzado materialHuella;
  final AccesorioCalzado colorPlanta;
  final AccesorioCalzado materialPlanta;
  final AccesorioCalzado construccion;
  final AccesorioCalzado tipoConstruccion;
  final AccesorioCalzado tipoHorma;
  final AccesorioCalzado alturaCana;

  Caracteristica({
    required this.tallas,
    required this.material,
    required this.campana,
    required this.temporada,
    required this.presentacionAccesorio,
    required this.tecPlantilla,
    required this.materialPlantilla,
    required this.materialForro,
    required this.estiloPunta,
    required this.tecPlanta1,
    required this.tipoHuella,
    required this.materialHuella,
    required this.colorPlanta,
    required this.materialPlanta,
    required this.construccion,
    required this.tipoConstruccion,
    required this.tipoHorma,
    required this.alturaCana,
  });

  factory Caracteristica.fromJson(Map<String, dynamic> json) => Caracteristica(
        tallas: AccesorioCalzado.fromJson(json["TALLAS"] ?? {}),
        material: Material.fromJson(json["MATERIAL"] ?? {}),
        campana: AccesorioCalzado.fromJson(json["CAMPANA"] ?? {}),
        temporada: AccesorioCalzado.fromJson(json["TEMPORADA"] ?? {}),
        presentacionAccesorio: AccesorioCalzado.fromJson(json["PRESENTACION ACCESORIOS"] ?? {}),
        tecPlantilla: AccesorioCalzado.fromJson(json["TEC PLANTILLA"] ?? {}),
        materialPlantilla: AccesorioCalzado.fromJson(json["MATERIAL PLANTILLA"] ?? {}),
        materialForro: AccesorioCalzado.fromJson(json["MATERIAL FORRO"] ?? {}),
        estiloPunta: AccesorioCalzado.fromJson(json["ESTILO PUNTA"] ?? {}),
        tecPlanta1: AccesorioCalzado.fromJson(json["TEC PLANTA 1"] ?? {}),
        tipoHuella: AccesorioCalzado.fromJson(json["TIPO HUELLA"] ?? {}),
        materialHuella: AccesorioCalzado.fromJson(json["MATERIAL HUELLA"] ?? {}),
        colorPlanta: AccesorioCalzado.fromJson(json["COLOR PLANTA"] ?? {}),
        materialPlanta: AccesorioCalzado.fromJson(json["MATERIAL PLANTA"] ?? {}),
        construccion: AccesorioCalzado.fromJson(json["CONSTRUCCION"] ?? {}),
        tipoConstruccion: AccesorioCalzado.fromJson(json["TIPO CONSTRUCCION"] ?? {}),
        tipoHorma: AccesorioCalzado.fromJson(json["TIPO HORMA"] ?? {}),
        alturaCana: AccesorioCalzado.fromJson(json["ALTURA CANA"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "TALLAS": tallas.toJson(),
        "MATERIAL": material.toJson(),
        "CAMPANA": campana.toJson(),
        "TEMPORADA": temporada.toJson(),
        "PRESENTACION ACCESORIOS": presentacionAccesorio.toJson(),
        "TEC PLANTILLA": tecPlantilla.toJson(),
        "MATERIAL PLANTILLA": materialPlantilla.toJson(),
        "MATERIAL FORRO": materialForro.toJson(),
        "ESTILO PUNTA": estiloPunta.toJson(),
        "TEC PLANTA 1": tecPlanta1.toJson(),
        "TIPO HUELLA": tipoHuella.toJson(),
        "MATERIAL HUELLA": materialHuella.toJson(),
        "COLOR PLANTA": colorPlanta.toJson(),
        "MATERIAL PLANTA": materialPlanta.toJson(),
        "CONSTRUCCION": construccion.toJson(),
        "TIPO CONSTRUCCION": tipoConstruccion.toJson(),
        "TIPO HORMA": tipoHorma.toJson(),
        "ALTURA CANA": alturaCana.toJson(),
      };
}

class AccesorioCalzado {
  final String? id;
  final String? nombre;
  final int? padreId;
  final String? nombrePadre;

  AccesorioCalzado({
    required this.id,
    required this.nombre,
    required this.padreId,
    required this.nombrePadre,
  });

  factory AccesorioCalzado.fromJson(Map<String, dynamic> json) => AccesorioCalzado(
        id: json["ID"] ?? "",
        nombre: json["NOMBRE"] ?? "",
        padreId: json["PADRE_ID"] ?? 0,
        nombrePadre: json["NOMBRE_PADRE"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NOMBRE": nombre,
        "PADRE_ID": padreId,
        "NOMBRE_PADRE": nombrePadre,
      };
}

class Material {
  final AccesorioCalzado material1;
  final AccesorioCalzado material2;
  final AccesorioCalzado material3;

  Material({
    required this.material1,
    required this.material2,
    required this.material3,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
        material1: AccesorioCalzado.fromJson(json["MATERIAL 1"] ?? {}),
        material2: AccesorioCalzado.fromJson(json["MATERIAL 2"] ?? {}),
        material3: AccesorioCalzado.fromJson(json["MATERIAL 3"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "MATERIAL 1": material1.toJson(),
        "MATERIAL 2": material2.toJson(),
        "MATERIAL 3": material3.toJson(),
      };
}
