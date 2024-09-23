import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';

class ImageNotFound extends StatelessWidget {
  const ImageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(213, 81, 91, 235),
        border: Border.all(
          color: AppTheme.colorPrimary,
          width: 2.0,
        ),
      ),
      child: const Center(
        child: Text(
          'Imagen no disponible',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
