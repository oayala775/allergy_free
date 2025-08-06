import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool? whiteLogo;
  final double height;
  final double width;
  const Logo({
    super.key,
    this.whiteLogo,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    String path =
        whiteLogo == true
            ? 'assets/images/logo/Logo_AllergyFree_blanco.png'
            : 'assets/images/logo/Logo_AllergyFree.png';
    return Image.asset(path, height: height, width: width);
  }
}
