import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'custom_text_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final String? message;
  final TextStyle? messageStyle;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String confirmText;
  final String cancelText;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.titleStyle,
    this.message,
    this.messageStyle,
    required this.onConfirm,
    required this.onCancel,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
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
        style: titleStyle,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (message != null) ...[
            Text(
              message!,
              style: messageStyle ?? CustomTextStyles.inputText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botón Cancelar - Estilo FIJO
              CustomTextButton(
                text: cancelText,
                width: screenWidth * 0.25,
                height: screenHeight * 0.07,
                customTextStyle: CustomTextStyles.blackText700, // FIJO
                backgroundColor: Colors.grey, // FIJO
                onPressed: () {
              
                  onCancel();
                },
              ),
              // Botón Confirmar - Estilo FIJO
              CustomTextButton(
                text: confirmText,
                width: screenWidth * 0.25,
                height: screenHeight * 0.07,
                customTextStyle: CustomTextStyles.whiteText700, // FIJO
                backgroundColor: CustomColors.primary, // FIJO
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Método estático para mostrar fácilmente
  static void show({
    required BuildContext context,
    required String title,
    required TextStyle titleStyle,
    String? message,
    TextStyle? messageStyle,
    required VoidCallback onConfirm,
    required onCancel,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        titleStyle: titleStyle,
        message: message,
        messageStyle: messageStyle,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
  }
}