import 'package:flutter/material.dart';
import 'package:allergy_free/presentation/widgets/widgets.dart';
import 'custom_text_button.dart'; // Asegúrate de importar CustomTextButton

class CustomDialog extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String message;
  final TextStyle? messageStyle;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final Color? buttonColor;
  final TextStyle? buttonTextStyle;
  final double? buttonWidth;
  final bool barrierDismissible;

  const CustomDialog({
    super.key,
    required this.title,
    this.titleStyle,
    required this.message,
    this.messageStyle,
    required this.buttonText,
    this.onButtonPressed,
    this.buttonColor,
    this.buttonTextStyle,
    this.buttonWidth,
    this.barrierDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      title: Text(
        title,
        style: titleStyle, // Valor por defecto
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: messageStyle,
            textAlign: TextAlign.center,
          ),
          CustomTextButton(
            text: buttonText,
            width: buttonWidth ?? screenWidth * 0.40,
            height: screenHeight * 0.07,
            customTextStyle: buttonTextStyle,
            backgroundColor: buttonColor,
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
              onButtonPressed?.call(); // Ejecutar acción personalizada
            },
          ),
        ],
      ),
    );
  }
}