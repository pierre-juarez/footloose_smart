import 'package:flutter/material.dart';

class LoadingCamera extends StatelessWidget {
  const LoadingCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 480, child: Center(child: CircularProgressIndicator()));
  }
}
