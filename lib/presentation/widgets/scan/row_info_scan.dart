import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

class RowInfoScan extends StatelessWidget {
  final String pathIcon;
  final String textInfo;

  const RowInfoScan({
    required this.pathIcon,
    required this.textInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(pathIcon),
          ),
          SizedBox(
            width: 250,
            child: TextWidgetInput(
              text: textInfo,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
