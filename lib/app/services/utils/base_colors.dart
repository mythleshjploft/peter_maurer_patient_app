import 'package:flutter/material.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';

class BaseColors {
  static const Color scaffoldBlurColor = Color(0xffA5C348);
  static const Color scaffoldBlurColor2 = Color(0xff449843);
  static const Color primaryColorLight = Color(0xffD1DF6E);
  static const Color primaryColorDark = Color(0xff7AA821);
  static const Color primaryColorExtraDark = Color(0xff449843);
  static const Color btnColor = Color(0xff80AC26);
  static const Color blueGreenColor = Color(0xff00A873);
  static const Color primaryColorExtraLight = Color(0xffF0F9D6);
  static const Color secondaryColor = Color(0xff0066B2);
  static const Color greyColorLight = Color(0xffB4B4B4);
  static const Color greyColorExtraLight = Color(0xffEEEEEE);
  static const Color greyColorDark = Color(0xff888888);
  static const Color tertiaryColor = Color(0xffFFDAC6);
  static const Color borderGrey = Color(0xffDFDFDF);
  static const Color oldGreenColor = Color(0xff217E50);
  static const Color middleCardColor = Color(0xff609747);
  static const Color backCardColor = Color(0xffe8eed0);
  static const Color drawerIconColor = Color(0xff217E50);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color darkGreenColor = Color(0xff65762D);
  static const Color popUpGreen = Color(0xff313C0B);
  static const Color chatContainerBgColor = Color(0xffF2F7FB);
  static const Color chatTextFieldColor = Color(0xffF3F6F6);
  static const Color dialogueBehindColor = Color(0xffc7e0c7);
  static const Color starGreenColor = Color(0xff92B736);
  static const Color purpleColor = Color(0xffA02B93);
  static const Color seenStoryColor = Color(0xffD4E7D3);
  static const Color errorColor = Colors.red;

// Gradient
  static LinearGradient gradient = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primaryColor,
      AppColors.primaryColor,
    ],
  );
  static LinearGradient verticalGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColorLight,
      primaryColorExtraLight,
    ],
  );
  static LinearGradient verticalLightGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryColorLight, white],
  );
  static LinearGradient verticalLightGreenGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      white,
      primaryColorLight,
    ],
  );

  static LinearGradient diagonalGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColorDark,
      primaryColorLight,
      primaryColorDark,
    ],
  );

  // static LinearGradient reverseGradient = const LinearGradient(
  //   begin: Alignment.centerLeft,
  //   end: Alignment.centerRight,
  //   colors: [
  //     primaryColorDark,
  //     primaryColorLight,
  //   ],
  // );

  //blakishOverlay

  // Gradient
  static LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Colors.black.withOpacity(0.1),
      Colors.black.withOpacity(0.5),
      Colors.black
    ],
  );
}
