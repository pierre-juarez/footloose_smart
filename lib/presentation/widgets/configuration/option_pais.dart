import 'package:flutter/material.dart';

class OptionPais extends StatelessWidget {
  const OptionPais({
    super.key,
    required this.stringAsset,
    required this.select,
  });

  final String stringAsset;
  final bool select;

  @override
  Widget build(BuildContext context) {
    Decoration? optionalDecoration = (select)
        ? BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.yellow, width: 2))
        : null;

    return Container(
      decoration: optionalDecoration,
      child: Image.asset(
        stringAsset,
        width: 100,
        height: 100,
      ),
    );
  }
}
