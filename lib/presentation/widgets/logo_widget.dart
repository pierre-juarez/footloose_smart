import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
// import 'package:footloose_puntodeventa/src/ui/common/textStyle.dart';

class ImageLogoFootloose extends StatelessWidget {
  const ImageLogoFootloose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset('lib/assets/logo.svg', height: 25),
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
    );
  }
}
