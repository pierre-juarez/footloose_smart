import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppTheme.backgroundColor,
      title: Text(
        title,
        style: robotoStyle(19, FontWeight.w400, Colors.white),
      ),
      toolbarHeight: 62,
    );
  }

  @override
  @override
  Size get preferredSize => const Size.fromHeight(62);
}
