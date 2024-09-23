import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';

Future<void> showTopSnackBar(
  BuildContext context,
  String message,
  IconData icon, {
  Duration duration = const Duration(seconds: 4),
  VoidCallback? function,
}) async {
  final overlay = Overlay.of(context);

  late final OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 90,
      left: 10,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppTheme.colorPrimary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                // Icono de advertencia o información
                icon,
                color: Colors.white,
                size: 30.0, // Puedes ajustar el tamaño del ícono
              ),
              const SizedBox(width: 10.0), // Espacio entre el ícono y el texto
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  if (overlayEntry.mounted) {
                    overlayEntry.remove();
                    if (function != null) {
                      function();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(duration, () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
      if (function != null) {
        function();
      }
    }
  });
}
