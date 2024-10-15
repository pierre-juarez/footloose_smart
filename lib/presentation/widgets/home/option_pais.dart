import 'package:flutter/material.dart';

class OptionPais extends StatelessWidget {
  const OptionPais({
    super.key,
    required this.stringAsset,
  });

  final String stringAsset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      stringAsset,
      width: 32,
      height: 32,
    );
  }
}
