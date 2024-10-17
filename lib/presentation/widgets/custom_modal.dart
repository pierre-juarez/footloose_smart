import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

Future<void> showCustomModal(
  BuildContext context,
  String titleText,
  String descriptionText,
  String actionText,
  Function action, {
  String? cancelText,
  double? paddingHorizontal,
}) async {
  bool stateLoading = false;
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                                color: const Color(0xffFAFAFA),
                                border: Border.all(color: AppColors.bodySecondaryButton, width: 0.6),
                              ),
                              child: Center(
                                child: Text(
                                  titleText,
                                  style: AppTextStyles.displayTitleModalPais,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                right: paddingHorizontal ?? 30,
                                left: paddingHorizontal ?? 30,
                                top: 16,
                                bottom: 16,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    descriptionText,
                                    style: AppTextStyles.displaySubtitleModalPais,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                                color: const Color(0xffFAFAFA),
                                border: Border.all(color: const Color(0xffC7C6C8), width: 0.7),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () async => await action(),
                                    child: ButtonPrimary(
                                      title: actionText,
                                      validator: stateLoading,
                                    ),
                                  ),
                                  if (cancelText != null) const SizedBox(height: 10),
                                  if (cancelText != null)
                                    InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: ButtonPrimary(
                                        title: cancelText,
                                        validator: stateLoading,
                                        secondary: true,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
