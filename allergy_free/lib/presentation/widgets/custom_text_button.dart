import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text; // texto del botón
  final double width; // ancho del botón
  final double height; // alto del botón
  // Debido a que hay un color por default, las propiedades relacionadas al
  // color son nuleables
  final Color? backgroundColor; // color normal del botón
  final Color? pressedColor; // color del botón cuando se presiona
  final Color? hoverColor; // color del botón cuando se hace hover
  final VoidCallback?
  onPressed; // callback que será llamado cuando el botón sea presionado
  final String? route; // ruta a la que redirige el botón
  const CustomTextButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    this.backgroundColor,
    this.pressedColor,
    this.hoverColor,
    this.onPressed,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          ).copyWith(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered)) {
                return hoverColor ?? CustomColors.focus; // cuando se hace hover
              }
              if (states.contains(WidgetState.pressed)) {
                return pressedColor ?? CustomColors.focus; // cuando se presiona
              }
              return backgroundColor ?? CustomColors.primary;
            }),
          ),
          onPressed: () {
            // El callback puede ser nulable, por lo que hay que asegurarse que
            // sí se pasó un callback para poder llamarlo
            if (onPressed != null) {
              onPressed!();
            }
            // La ruta a la que hay que redirigir puede ser nulable, por lo que
            // hay que asegurarse que sí se pasó una ruta para redirigirse hacia
            // ella
            if (route != null) {
              context.pushNamed(route!);
            }
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
