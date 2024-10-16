import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/widgets/scan/onscreen_keyboard/button_delete_number.dart';
import 'package:footloose_tickets/presentation/widgets/scan/onscreen_keyboard/custom_key.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomKey(label: '1'),
            CustomKey(label: '2'),
            CustomKey(label: '3'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomKey(label: '4'),
            CustomKey(label: '5'),
            CustomKey(label: '6'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomKey(label: '7'),
            CustomKey(label: '8'),
            CustomKey(label: '9'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomKey(label: 'c'),
            CustomKey(label: '0'),
            ButtonDeleteNumber(),
          ],
        ),
      ],
    );
  }
}
