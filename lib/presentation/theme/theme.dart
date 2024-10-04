import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary Colors
  static const primaryDarken = Color(0xFF3D1D56);
  static const primaryMain = Color(0xFF6F359C);
  static const primaryLight = Color(0xFFBDA2D1);
  static const primaryDarkButton = Color(0xFF3A2050);
  static const primaryDarkCard = Color(0xFF2F1642);

  // Secondary Colors
  static const secondaryDarken = Color(0xFFD1742F);
  static const secondaryMain = Color(0xFFF53240);
  static const secondaryLight = Color(0xFFFFAA53);

  // Tertiary Colors
  static const tertiaryDarken = Color(0xFF7E0A7B);
  static const tertiaryMain = Color(0xFFFFB547);
  static const tertiaryLight = Color(0xFFBD61BB);

  // Quarter Colors
  static const quarterDarken = Color(0xFF24A3B1);
  static const quarterMain = Color(0xFF3FBABF);
  static const quarterLight = Color(0xFF74E9EE);

  // BlueGray Colors
  static const blueGray100 = Color(0xFF34465B);
  static const blueGray90 = Color(0xFF425873);
  static const blueGray80 = Color(0xFF4F698A);
  static const blueGray70 = Color(0xFF5C7BA1);
  static const blueGray60 = Color(0xFFB4B4A8);
  static const blueGray50 = Color(0xFFC1C1B5);
  static const blueGray40 = Color(0xFFA2B4CA);
  static const blueGray30 = Color(0xFFB9C7D7);
  static const blueGray20 = Color(0xFFE0E0DA);
  static const blueGray10 = Color(0xFFEFEFED);

  // Text Colors
  static const textPrimary = Color(0xFF3C3E3A);
  static const textSecondary = Color(0xFF535551);
  static const textDisabled = Color(0xFFA0A0A0);
  static const textLight = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF000000);
  static const textBasic = Color(0xFF1E1D20);
  static const textTitle = Color(0xFF4F266F);
  static const textGray = Color(0xFF585858);
  static const textSubtitleInfoProduct = Color(0xFF666666);
  static const textTitleModalPais = Color(0xFF29282B);
  static const textSubtitleModalPais = Color(0xFF353337);
  static var textSubtitle = const Color(0xFF7C7979).withOpacity(0.8);

  // Success Colors
  static const successDarken = Color(0xFF00B887);
  static const successDark = Color(0xFF2CE59B);
  static const successLight = Color(0xFFCCFCE3);

  // Info Colors
  static const infoDarken = Color(0xFF33489B);
  static const infoDark = Color(0xFF1FB6FF);
  static const infoLight = Color(0xFFA4E1FF);

  // Warning Colors
  static const warningDarken = Color(0xFFD39110);
  static const warningDark = Color(0xFFFFC82C);
  static const warningLight = Color(0xFFFFE69F);

  // Danger Colors
  static const dangerDarken = Color(0xFFCC0000);
  static const dangerDark = Color(0xFFFF4949);
  static const dangerLight = Color(0xFFFFEDED);

  // Body Colors
  static const bodyLight = Color(0xFFFFFFFF);
  static const bodyGray = Color(0xFFF2F2F7);
  static const bodyDark = Color(0xFF1F2D3D);
  static const bodySecondaryButton = Color(0xFFC7C8C8);

  // Gray Colors
  static const borderOption = Color(0xFFD9D9D9);
}

class AppTextStyles {
  // Display
  static var displayTitle1Bold = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 32 * 1.1,
    letterSpacing: 1.5,
    // height: 0.24, // line-height 110%
    color: AppColors.textBasic,
  );

  static var displayTitle2Bold = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 22.78 * 1.1,
    letterSpacing: 1.5,
    // height: 1.19, // line-height 110%
    color: AppColors.textTitle,
  );

  static var displaySubtitle = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14.22 * 1.1,
    letterSpacing: 1.5,
    // height: 0.21, // line-height 110%
    color: AppColors.textSubtitle,
  );

  static var displayTextButtonPrimary = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 4,
    color: AppColors.textLight,
  );

  static var displayTextButtonSecondary = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 4,
    color: AppColors.textDark,
  );

  static var displayTextCardPromotion = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 14.22 * 1.1,
    letterSpacing: 0.15,
    // height: 0.21, // line-height 110%
    color: AppColors.textDark,
  );

  static var displayTitleAppBar = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 18 * 1.1,
    letterSpacing: 1.5,
    // height: 1.19, // line-height 119%
    color: AppColors.textLight,
  );

  static var displayTextBasicCardLigth = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16 * 1.1,
    letterSpacing: 0.5,
    // height: 0.28, // line-height 119%
    color: AppColors.textBasic,
  );

  static var displayTextInfoProduct = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16 * 1.1,
    letterSpacing: 0.15,
    // height: 0.24, // line-height 119%
    color: AppColors.textBasic,
  );

  static var displayTextBoldInfoProduct = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 16 * 1.1,
    letterSpacing: 0.15,
    // height: 0.24, // line-height 119%
    color: AppColors.textBasic,
  );

  static var displayTextCaptionInfoProduct = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12.64 * 1.1,
    letterSpacing: 0.15,
    // height: 0.21, // line-height 119%
    color: AppColors.textBasic,
  );

  static var displayTextSubcaptionInfoProduct = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12.64 * 1.1,
    letterSpacing: 0.15,
    // height: 0.21, // line-height 119%
    color: AppColors.textSubtitleInfoProduct,
  );

  static var displayTextSubcaptionReduceInfoProduct = AppTextStyles.displayTextSubcaptionInfoProduct.copyWith(fontSize: 12 * 1.1);

  static var displayTextPriceInfoProduct = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 20.25 * 1.1,
    letterSpacing: 0.15,
    // height: 1.19, // line-height 119%
    color: AppColors.primaryMain,
  );

  static var displayTextButtonOutlineWhite = AppTextStyles.displayTextBasicCardLigth.copyWith(
    fontSize: 18 * 1.1,
    color: AppColors.textGray,
  );

  static var displayTitleModalPais = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 16 * 1.1,
    letterSpacing: 0.15,
    // height: 0.24, // line-height 119%
    color: AppColors.textTitleModalPais,
  );

  static var displaySubtitleModalPais = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 12.64 * 1.1,
    letterSpacing: 0.15,
    height: 0.21, // line-height 119%
    color: AppColors.textSubtitleModalPais,
  );

  static var displayInput = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16 * 1.1,
    letterSpacing: 0,
    height: 0.23, // line-height 119%
    color: AppColors.textDark,
  );
  static var displayInputPlaceholder = displayInput.copyWith(color: AppColors.textDark.withOpacity(0.8));

  static var displayInputRecoveryPassword = displayInput.copyWith(fontSize: 14);
}
