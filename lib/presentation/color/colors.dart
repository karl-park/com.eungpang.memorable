import 'package:flutter/material.dart';

class AppColors {
  static final primaryColor = HexColor('29323c');

  static final black = HexColor('000000');
  static final white = HexColor('ffffff');

  static final blue = HexColor('21d4fd');
  static final blue2 = HexColor('92fe9d');

  static final purple = HexColor('b721ff');
  static final purple2 = HexColor('f7418c');

  static final lightGrey = HexColor('313543');
  static final whiteGrey = HexColor('d8d8d8');

  static final yellow = HexColor('fa709a');

  static final green = HexColor('00c9ff');

  static final lightRed = HexColor('ff719a');

  static final orange = HexColor('fee140');
  static final lightOrange = HexColor('ffe29f');
  static final lightOrange2 = HexColor('fbab66');

}



class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
