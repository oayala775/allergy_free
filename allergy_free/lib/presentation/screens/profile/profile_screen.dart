import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  static const String screenName = "profile_screen"; //ruta de la pantalla
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String _username = 'Usuario_1';
  String _avatar = 'assets/images/avatar/8_Trigo.png'; // Avatar por defecto

  final List<String> alegias = [ // Lista de avatares disponibles
    'Gluten',
    'Lactosa',
    'Nueces',
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
                    const Text("Your profile", style: CustomTextStyles.title, textAlign: TextAlign.center,),
                    SizedBox(height: screenHeight * 0.01), // Espacio entre el título y el avatar

                    _ProfileCard(context, _username, _avatar, screenWidth, screenHeight, alegias),

                    SizedBox(height: screenHeight * 0.01), // Espacio entre el título y el avatar

                    CustomTextButton(
                      text: 'Edit Profile',
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      customTextStyle: CustomTextStyles.whiteText700,
                      onPressed: () {
                        // TODO: Guardar la selección (_selectedAvatar)
                      },
                    ),

                    CustomTextButton(
                      text: 'Change Password',
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      customTextStyle: CustomTextStyles.whiteText700,
                      onPressed: () {
                        // TODO: Guardar la selección (_selectedAvatar)
                      },
                    ),

                    CustomTextButton(
                      text: 'Log Out',
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

Widget _ProfileCard(BuildContext context, String username, String avatar, 
                      double screenWidth, double screenHeight, List<String> alergias) {
    return Card(
      color: CustomColors.primary, // Usando azul como color primario
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.20,
              backgroundImage: AssetImage(avatar),
              // Si no tienes la imagen, puedes usar un icono:
              // child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              username,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Allergies:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            
            // Tarjeta para la lista de alergias (fondo blanco)
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Column(
                  children: [
                    // Lista de alergias
                    for (int i = 0; i < alergias.length; i++)
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                              alergias[i],
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                          // Separador (excepto para el último elemento)
                          if (i < alergias.length - 1)
                            Divider(height: 1, color: Colors.grey[300]),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
