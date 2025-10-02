import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  static const String screenName = "profile_screen"; //ruta de la pantalla
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final String _username = 'Usuario_1';
  final String _avatar = 'assets/images/avatar/19_Celery.png'; // Avatar por defecto

  final List<String> alegias = [ // Lista de avatares disponibles
    'Gluten',
    'Chocolate',
    'Nuez',
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
              child: _ProfileScreenContents(screenWidth: screenWidth, screenHeight: screenHeight, username: _username, avatar: _avatar, alegias: alegias),
            ),
          );
        },
      ),
    bottomNavigationBar: const Navbar(),
    );
  }
}

class _ProfileScreenContents extends StatelessWidget {
  const _ProfileScreenContents({
    required this.screenWidth,
    required this.screenHeight,
    required String username,
    required String avatar,
    required this.alegias,
  }) : _username = username, _avatar = avatar;

  final double screenWidth;
  final double screenHeight;
  final String _username;
  final String _avatar;
  final List<String> alegias;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
        crossAxisAlignment: CrossAxisAlignment.stretch, // Estirar horizontalmente?
        children: [
          const Text("Your profile", style: CustomTextStyles.title, textAlign: TextAlign.center,),
          SizedBox(height: screenHeight * 0.02), // Espacio entre el título y el avatar
    
          _ProfileCard(context, _username, _avatar, screenWidth, screenHeight, alegias),
    
          SizedBox(height: screenHeight * 0.01), // Espacio entre el título y el avatar
    
          CustomTextButton(
            text: 'Edit Profile',
            width: double.infinity,
            height: screenHeight * 0.07,
            customTextStyle: CustomTextStyles.whiteText700,
            onPressed: () {
              //TODO: Navegar a la pantalla de edición de perfil
            },
          ),
    
          CustomTextButton(
            text: 'Change Password',
            width: double.infinity,
            height: screenHeight * 0.07,
            customTextStyle: CustomTextStyles.whiteText700,
            onPressed: () {
              context.pushNamed(ChangePasswordScreen.screenName);
            },
          ),
    
          CustomTextButton(
            text: 'Log Out',
            width: double.infinity,
            height: screenHeight * 0.07,
            customTextStyle: CustomTextStyles.whiteText700,
            onPressed: () {
              // TODO: pop up de confirmación
              context.pushNamed(LoginScreen.screenName);
            },
          ),
        ],
      ),
    );
  }
}

Widget _ProfileCard(BuildContext context, String username, String avatar, double screenWidth, double screenHeight, List<String> alergias) {
  // Calculamos el radio del avatar
  double avatarRadius = screenWidth * 0.20;
  
  return Center(
    child: SizedBox(
      width: screenWidth * 0.86, // Ancho del card
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Card verde (con margen superior para el avatar)
          Container(
            margin: EdgeInsets.only(top: avatarRadius), // Margen para el espacio del avatar
            child: Card(
              color: CustomColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: avatarRadius + screenHeight * 0.02, // Espacio adicional para el avatar
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenWidth * 0.05,
                ),
                child: Column(
                  children: [
                    // Nombre de usuario
                    Text(
                      username,
                      style: CustomTextStyles.whiteText700,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    
                    // Tarjeta para la lista de alergias (fondo blanco)
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          children: [
                            Text(
                              'Alergies', 
                              style: CustomTextStyles.blackBold,
                            ),
                            // Lista de alergias
                            for (int i = 0; i < alergias.length; i++)
                              Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      alergias[i],
                                      style: CustomTextStyles.inputText,
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
            ),
          ),
          
          // Avatar posicionado en la parte superior
          Positioned(
            top: 0, // Colocamos el avatar en la parte superior
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: CustomColors.primary, // Borde del mismo color que la card
                  width: 5.0,
                ),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage: AssetImage(avatar),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}