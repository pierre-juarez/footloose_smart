class EtiquetaModel {
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

  EtiquetaModel({
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
  });

  Map<String, dynamic> toJson() {
    return {
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
    };
  }

  factory EtiquetaModel.fromJson(Map<String, dynamic> json) {
    return EtiquetaModel(
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
    );
  }
}
