import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

class ModalProcessProduct extends StatelessWidget {
  const ModalProcessProduct({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 150.0,
        width: 100.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidgetInput(
                text: message,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 50.0,
                width: 50.0,
                child: Center(
                  child: CircularProgressIndicator(color: AppTheme.backgroundColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
