import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.textLight),
      backgroundColor: AppColors.primaryDarken,
      title: Text(
        title,
        style: AppTextStyles.displayTitleAppBar,
      ),
      toolbarHeight: 64,
    );
  }

  @override
  @override
  Size get preferredSize => const Size.fromHeight(62);
}
