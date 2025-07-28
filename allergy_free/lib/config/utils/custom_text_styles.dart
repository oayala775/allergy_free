import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';

class CustomTextStyles {
  static const TextStyle greyedText = TextStyle(
    color: CustomColors.greyLetters,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    fontFamily: "Inter",
  );
  static const TextStyle whiteText600 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    fontFamily: "Inter",
  );
  static const TextStyle title = TextStyle(
    color: CustomColors.subtitle,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    fontFamily: "Inter",
  );
  static const TextStyle titleLogin = TextStyle(
    color: CustomColors.primary,
    fontWeight: FontWeight.w700,
    fontSize: 50,
    fontFamily: "Inter",
  );
  static const TextStyle signaling = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 32,
    fontFamily: "Inter",
  );
  static const TextStyle greenLogin = TextStyle(
    color: CustomColors.primary,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    fontFamily: "Inter",
  );
  static const TextStyle whiteTextChip = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    fontFamily: "Inter",
  );
}
