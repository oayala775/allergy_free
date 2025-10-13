import 'package:flutter/material.dart';

class DefaultAvatar extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  final double screenWidth; // Nuevo parámetro
  final double screenHeight; // Nuevo parámetro

  const DefaultAvatar({
    super.key,
    required this.imagePath,
    this.onTap,
    required this.screenWidth, // Hacer obligatorio en el constructor
    required this.screenHeight, // Hacer obligatorio en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius:
            screenWidth * 0.20, // Usar el ancho de la pantalla para el tamaño
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}
