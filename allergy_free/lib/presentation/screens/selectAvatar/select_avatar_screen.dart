import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import '../../widgets/widgets.dart';

class SelectAvatarScreen extends StatefulWidget {
  static const String screenName = "select_avatar_screen"; //ruta de la pantalla
  const SelectAvatarScreen({super.key});

  @override
  State<SelectAvatarScreen> createState() => _SelectAvatarScreen();
}

class _SelectAvatarScreen extends State<SelectAvatarScreen> {
  String _selectedAvatar = 'assets/images/avatar/0_Default.png'; // Avatar por defecto

  final List<String> avatars = [ // Lista de avatares disponibles
    'assets/images/avatar/1_Mustard.png',
    'assets/images/avatar/2_Walnut.png',
    'assets/images/avatar/3_Chocolate.png',
    'assets/images/avatar/4_Tomato.png', 
    'assets/images/avatar/5_Apple.png',
    'assets/images/avatar/6_Cinnamon.png',
    'assets/images/avatar/7_Egg.png',
    'assets/images/avatar/8_Wheat.png',
    'assets/images/avatar/9_Milk.png',
    'assets/images/avatar/10_Peanut.png', 
    'assets/images/avatar/11_Avocado.png',
    'assets/images/avatar/12_Shrimp.png',
    'assets/images/avatar/13_Almond.png',
    'assets/images/avatar/14_Fish.png',
    'assets/images/avatar/15_Strawberry.png',
    'assets/images/avatar/16_Orange.png', 
    'assets/images/avatar/17_Lobster.png',
    'assets/images/avatar/18_Bread.png',
    'assets/images/avatar/19_Celery.png',
    'assets/images/avatar/20_Soy.png',
    'assets/images/avatar/21_Pistachio.png',
  ];

  @override
  Widget build(BuildContext context) {

    // Obtener el tamaño de la pantalla
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      appBar: const Appbar(), // Barra de navegación personalizada
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Estirar horizontalmente?
                  children: [
                    const Text("Select your avatar", style: CustomTextStyles.title, textAlign: TextAlign.center,),
                    SizedBox(height: screenHeight * 0.02), // Espacio entre el título y el avatar
                    Center(
                      child: DefaultAvatar(
                        imagePath: _selectedAvatar,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // Espacio entre el avatar y la cuadrícula
                    SizedBox(
                      height: screenHeight * 0.45, // Altura fija para la cuadrícula
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Número de columnas
                          crossAxisSpacing: 16, // Espacio entre columnas
                          mainAxisSpacing: 16, // Espacio entre filas
                          childAspectRatio: 1, // Relación de aspecto (ancho/alto)
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
                                backgroundImage: AssetImage(avatars[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    

                    CustomTextButton(
                      text: 'Select',
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
        radius: screenWidth * 0.20, // Usar el ancho de la pantalla para el tamaño
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}