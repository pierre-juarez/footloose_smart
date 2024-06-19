import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
// import 'package:footloose_puntodeventa/src/ui/common/textStyle.dart';

class ImageLogoFootloose extends StatelessWidget {
  const ImageLogoFootloose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              image: AssetImage("lib/assets/logo_shopper.png"),
              height: 100,
            ),
          ),
          Positioned(
            top: 5.0,
            left: 10.0,
            child: TextWidgetInput(
              text: "Ver.1.0.0",
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: AppTheme.colorStyleText,
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
