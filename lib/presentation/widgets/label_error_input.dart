import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

class LabelErrorInput extends StatelessWidget {
  const LabelErrorInput({
    super.key,
    required this.eval,
    required this.customError,
  });

  final bool eval;
  final String customError;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: !eval ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.circleExclamation,
            color: AppColors.secondaryMain,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            customError,
            style: robotoStyle(13, FontWeight.w500, AppColors.secondaryMain),
          )
        ],
      ),
    );
  }
}
