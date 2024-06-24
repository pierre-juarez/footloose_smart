import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';

class NavbarHome extends StatelessWidget {
  const NavbarHome({
    super.key,
    required this.onTap,
    this.title,
  });

  final VoidCallback onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      decoration: BoxDecoration(color: AppTheme.backgroundColor),
      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onTap,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  (title != null) ? title! : "Impresión de Etiquetas",
                  style: robotoStyle(20, FontWeight.w400, Colors.white),
                ),
                Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
