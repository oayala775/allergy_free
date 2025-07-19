import 'package:allergy_free/config/utils/custom_colors.dart';
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

    OutlineInputBorder normalBorder = OutlineInputBorder(
      // borde normal
      borderRadius: BorderRadius.circular(70.0),
      borderSide: BorderSide(color: CustomColors.primary, width: 3.0),
    );

    OutlineInputBorder focusBorder = OutlineInputBorder(
      // borde con focus
      borderRadius: BorderRadius.circular(70.0),
      borderSide: BorderSide(color: CustomColors.focus, width: 3.0),
    );

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        keyboardType: widget.inputType,
        obscureText:
            // Oculta o muestra el texto ingresado, solo en campos de password
            isPasswordField ? _obscureText : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          hintText: widget.text,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: CustomColors.greyLetters,
            fontSize: 20,
          ),
          suffixIcon:
              // Ícono para mostrar/ocultar contraseña, solo en campos de password
              isPasswordField
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
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
