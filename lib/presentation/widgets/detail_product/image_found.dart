import 'package:flutter/material.dart';

class ImageFound extends StatelessWidget {
  final String path;

  const ImageFound({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Image(image: NetworkImage(path));
  }
}
