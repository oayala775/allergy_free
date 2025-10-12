import 'package:allergy_free/presentation/providers/selected_avatar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import '../../widgets/widgets.dart';

// Step 2: Convert your StatefulWidget to a ConsumerWidget.
class SelectAvatarScreen extends ConsumerWidget {
  static const String screenName = "select_avatar_screen";
  const SelectAvatarScreen({super.key});

  final List<String> avatars = const [
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
  // Step 3: Add WidgetRef to the build method.
  Widget build(BuildContext context, WidgetRef ref) {
    // Step 4: Use ref.watch() to listen to the provider.
    // This will rebuild the widget automatically when the avatar changes.
    final selectedAvatar = ref.watch(selectedAvatarProvider);
    
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
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Select your avatar",
                      style: CustomTextStyles.title,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: DefaultAvatar(
                        // Use the value from the provider
                        imagePath: selectedAvatar, 
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
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
                          final avatarPath = avatars[index];
                          final bool isSelected = selectedAvatar == avatarPath;
                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedAvatarProvider.notifier).state = avatarPath;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: isSelected
                                    ? Border.all(color: CustomColors.focus, width: 3.0)
                                    : null,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(avatarPath),
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
                        final finalSelection = ref.read(selectedAvatarProvider);
                        
                        if (context.canPop()) {
                           GoRouter.of(context).pop(finalSelection);
                        }
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
