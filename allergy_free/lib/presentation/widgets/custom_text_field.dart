import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text; // Texto que se usará como hint del TextField
  final TextInputType inputType; // KeyboardType del TextField
  const CustomTextField({
    super.key,
    required this.text,
    required this.inputType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Controla si el texto ingresado se oculta o se muestra
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final bool isPasswordField =
        // Comprueba si el Widget es para leer un password
        widget.inputType == TextInputType.visiblePassword;

    final OutlineInputBorder normalBorder = OutlineInputBorder(
      // borde normal
      borderRadius: BorderRadius.circular(70.0),
      borderSide: BorderSide(color: CustomColors.primary, width: 4.0),
    );

    final OutlineInputBorder focusBorder = OutlineInputBorder(
      // borde con focus
      borderRadius: BorderRadius.circular(70.0),
      borderSide: BorderSide(color: CustomColors.focus, width: 4.0),
    );

    void toggleObscureText() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: CustomTextStyles.inputText,
        keyboardType: widget.inputType,
        obscureText:
            // Oculta o muestra el texto ingresado, solo en campos de password
            isPasswordField ? _obscureText : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          hintText: widget.text,
          hintStyle: CustomTextStyles.greyedText,
          suffixIcon:
              // Ícono para mostrar/ocultar contraseña, solo en campos de password
              isPasswordField
                  ? _PasswordVisibilityIcon(
                    obscureText: _obscureText,
                    onPressed: toggleObscureText,
                  )
                  : null,
          border: normalBorder,
          enabledBorder: normalBorder,
          focusedBorder: focusBorder,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class _PasswordVisibilityIcon extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onPressed;

  const _PasswordVisibilityIcon({
    required this.obscureText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }
}
