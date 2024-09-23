class EtiquetaModel {
  final String nombre;
  final String marcaAbrev;
  final String tipoArticulo;
  final String modelo;
  final String color;
  final String material;
  final String precio;
  final String talla;
  final String sku;
  final String cu;
  final String fechaCreacion;
  final String temporada;
  final String imageUrl;
  final String abrev;
  final String marca;
  final int numberOfPrints;
  final String id;

  EtiquetaModel({
    required this.id,
    required this.nombre,
    required this.marcaAbrev,
    required this.tipoArticulo,
    required this.modelo,
    required this.color,
    required this.material,
    required this.precio,
    required this.talla,
    required this.sku,
    required this.cu,
    required this.fechaCreacion,
    required this.temporada,
    required this.imageUrl,
    required this.abrev,
    required this.marca,
    required this.numberOfPrints,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'marcaAbrev': marcaAbrev,
      'tipoArticulo': tipoArticulo,
      'modelo': modelo,
      'color': color,
      'material': material,
      'precio': precio,
      'talla': talla,
      'sku': sku,
      'cu': cu,
      'fechaCreacion': fechaCreacion,
      'temporada': temporada,
      'imageUrl': imageUrl,
      'abrev': abrev,
      'marca': marca,
      'numberOfPrints': numberOfPrints,
    };
  }

  factory EtiquetaModel.fromJson(Map<String, dynamic> json) {
    return EtiquetaModel(
      id: json['id'],
      nombre: json['nombre'],
      marcaAbrev: json['marcaAbrev'],
      tipoArticulo: json['tipoArticulo'],
      modelo: json['modelo'],
      color: json['color'],
      material: json['material'],
      precio: json['precio'],
      talla: json['talla'],
      sku: json['sku'],
      cu: json['cu'],
      fechaCreacion: json['fechaCreacion'],
      temporada: json['temporada'],
      imageUrl: json['imageUrl'],
      abrev: json['abrev'],
      marca: json['marca'],
      numberOfPrints: json['numberOfPrints'],
    );
  }

  // Método copyWith
  EtiquetaModel copyWith({
    String? id,
    String? marcaAbrev,
    String? tipoArticulo,
    String? modelo,
    String? color,
    String? material,
    String? precio,
    String? talla,
    String? sku,
    String? cu,
    String? fechaCreacion,
    String? temporada,
    int? numberOfPrints,
    String? imageUrl,
    String? abrev,
    String? marca,
    String? nombre,
  }) {
    return EtiquetaModel(
      id: id ?? this.id,
      marca: marca ?? this.marca,
      abrev: abrev ?? this.abrev,
      imageUrl: imageUrl ?? this.imageUrl,
      nombre: nombre ?? this.nombre,
      marcaAbrev: marcaAbrev ?? this.marcaAbrev,
      tipoArticulo: tipoArticulo ?? this.tipoArticulo,
      modelo: modelo ?? this.modelo,
      color: color ?? this.color,
      material: material ?? this.material,
      precio: precio ?? this.precio,
      talla: talla ?? this.talla,
      sku: sku ?? this.sku,
      cu: cu ?? this.cu,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      temporada: temporada ?? this.temporada,
      numberOfPrints: numberOfPrints ?? this.numberOfPrints,
    );
  }

  factory EtiquetaModel.empty() {
    return EtiquetaModel(
      id: '', // ID vacío
      nombre: '', // Campos vacíos
      marcaAbrev: '',
      tipoArticulo: '',
      modelo: '',
      color: '',
      material: '',
      precio: '',
      talla: '',
      sku: '',
      cu: '',
      fechaCreacion: '',
      temporada: '',
      imageUrl: '',
      abrev: '',
      marca: '',
      numberOfPrints: 0,
    );
  }
}
