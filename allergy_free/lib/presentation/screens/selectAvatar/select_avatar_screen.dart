import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/presentation/widgets/appbar.dart';
import 'package:allergy_free/presentation/widgets/custom_text_button.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:go_router/go_router.dart';


class SelectAvatarScreen extends StatefulWidget {
  static const String screenName = "select_avatar_screen";
  const SelectAvatarScreen({super.key});

  @override
  State<SelectAvatarScreen> createState() => _SelectAvatarScreen();
}

class _SelectAvatarScreen extends State<SelectAvatarScreen> {
  String _selectedAvatar = 'assets/images/avatar/0_Default.png';

  final List<String> avatars = [
    'assets/images/avatar/1_Mostaza.png',
    'assets/images/avatar/2_Nuez.png',
    'assets/images/avatar/3_Chocolate.png',
    'assets/images/avatar/4_Tomate.png', 
    'assets/images/avatar/5_Manzana.png',
    'assets/images/avatar/6_Canela.png',
    'assets/images/avatar/7_Huevo.png',
    'assets/images/avatar/8_Trigo.png',
    'assets/images/avatar/9_Leche.png',
    'assets/images/avatar/10_Cacahuate.png', 
    'assets/images/avatar/11_Aguacate.png',
    'assets/images/avatar/12_Camaron.png',
    'assets/images/avatar/13_Almendra.png',
    'assets/images/avatar/14_Pescado.png',
    'assets/images/avatar/15_Fresa.png',
    'assets/images/avatar/16_Naranja.png', 
    'assets/images/avatar/17_Langosta.png',
    'assets/images/avatar/18_Pan.png',
    'assets/images/avatar/19_Apio.png',
    'assets/images/avatar/20_Soja.png',
  ];

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;


    return Scaffold(
      appBar: const Appbar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  
                  children: [
                    const Text("Choose your avatar", style: CustomTextStyles.title, textAlign: TextAlign.center,),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: DefautlAvatar(
                        imagePath: _selectedAvatar,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    SizedBox(
                      height: screenHeight * 0.45,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                        ),
                        itemCount: avatars.length,
                        itemBuilder: (context, index) {
                          bool isSelected = _selectedAvatar == avatars[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedAvatar = avatars[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(
                                        color: CustomColors.focus, // Color del borde
                                        width: 3.0, // Grosor del borde
                                      )
                                    : null,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 48,
                                backgroundImage: AssetImage(avatars[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    

                    CustomTextButton(
                      text: 'Select avatar',
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      customTextStyle: CustomTextStyles.whiteText700,
                      onPressed: () {
                        // TODO: Guardar la selección (_selectedAvatar)
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
  final String imagePath;
  final VoidCallback? onTap;

  const DefautlAvatar({
    super.key, 
    required this.imagePath,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}