import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

class InputDefault {
  static BoxDecoration decoration = BoxDecoration(
    color: AppColors.textLight,
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: AppColors.textDark.withOpacity(0.3), width: 1.0),
  );
}
