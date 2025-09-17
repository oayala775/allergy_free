import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/presentation/widgets/appbar.dart';
import 'package:allergy_free/presentation/widgets/custom_text_button.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go_router/go_router.dart';

class SelectAvatarScreen extends StatefulWidget {
  static const String screenName = "select_avatar_screen";
  const SelectAvatarScreen({super.key});

  @override
  State<SelectAvatarScreen> createState() => _SelectAvatarScreen();
}

class _SelectAvatarScreen extends State<SelectAvatarScreen> {
  String? _selectedAvatar;

  final List<String> avatars = [
    'assets/images/avatar/aguacate.jpg',
    'assets/images/avatar/cacahuate.jpg',
    'assets/images/avatar/huevo.jpg',
    'assets/images/avatar/fresa.jpg', 
    'assets/images/avatar/Nuez.jpg',
    'assets/images/avatar/leche.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: DefautlAvatar()),
                    const SizedBox(height: 10.0),

                    SizedBox(
                      height: 250, // controla la altura de la cuadrícula
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal, // 👈 desplazamiento horizontal
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // número de filas
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1, // cuadrado
                        ),
                        itemCount: avatars.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print("Seleccionaste: ${avatars[index]}");
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.primaries[index % Colors.primaries.length], // fondo variado
                              radius: 48,
                              backgroundImage: AssetImage(avatars[index]),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    CustomTextButton(
                      text: 'Select avatar',
                      width: double.infinity,
                      height: 56,
                      customTextStyle: CustomTextStyles.whiteText700,
                      onPressed: () {
                        // TODO: Implementar lógica de sign up. También hay que asegurarse de que se acepten los términos y condiciones
                      },
                    ),
                    
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DefautlAvatar extends StatelessWidget {
  const DefautlAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Dirigirse a la selección de avatar
      },
      child: DottedBorder(
        options: CircularDottedBorderOptions(
          color: CustomColors.primary,
          strokeWidth: 5,
          dashPattern: [20, 6],
          padding: const EdgeInsets.all(16.0),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Icon(Icons.add, size: 175 * 0.4, color: CustomColors.primary),
        ),
      ),
    );
  }
}