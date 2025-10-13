import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/database/database_operations.dart';
import 'package:allergy_free/models/user.dart';
import 'package:allergy_free/presentation/providers/selected_allergens_provider.dart';
import 'package:allergy_free/presentation/providers/selected_avatar_provider.dart';
import 'package:allergy_free/presentation/providers/terms_and_conditions_provider.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String screenName = "sign_up_screen";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _reenterPasswordController;
  late final TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    // Step 3: Initialize the controllers in initState.
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _reenterPasswordController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    // Step 4: Dispose of the controllers to prevent memory leaks.
    _usernameController.dispose();
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  bool _isPasswordValid(String password) {
    final reenterPassword = _reenterPasswordController.text;
    if (password.isEmpty || reenterPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return false; // Stop the function
    }
    if (password != reenterPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match.')));
      return false; // Stop the function
    }
    return true;
  }

  bool _isAgeValid(String age) {
    final RegExp ageRegex = RegExp(r'^[0-9]{1,2}$');
    if (age.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Age must be included.')));
      return false; // Stop the function
    }
    if (!ageRegex.hasMatch(age)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Age must be valid.')));
      return false;
    }

    int ageValue = int.parse(age);
    if (ageValue < 5) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Age must be valid.')));
      return false;
    }
    return true;
  }

  bool _isUsernameValid(String username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!usernameRegex.hasMatch(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Username must not contain special characters or spaces, just letters and numbers.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  Future<bool> _insertToDatabase(
    String username,
    String password,
    String age,
  ) async {
    try {
      final selectedAvatar = ref.watch(selectedAvatarProvider);
      final avatarInstance = await DatabaseOperations().retrieveAvatarID(
        selectedAvatar,
      );
      if (avatarInstance == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred accessing the avatar ID.')),
        );
        return false;
      }
      int avatarId = avatarInstance.id ?? 0;
      final existingUser = await DatabaseOperations().verifyIfUserExist(
        username,
      );
      if (existingUser != null) {
        // Register successful, navigate to home screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$username is already taken, please change it.'),
          ),
        );
        return false; // Stop the function
      }
      final User user = User(
        username: username,
        password: password,
        age: int.parse(age),
        avatarId: avatarId,
      );

      final wasRegistered = await DatabaseOperations().register(user);
      print(wasRegistered);
    } catch (e) {
      print('Error en login: $e');
    }
    return true;
  }

  void _signUp() async {
    final bool acceptedTerms = ref.read(termsAndConditionsProvider);
    final List<String> selectedAllergens = ref.read(selectedAllergensProvider);
    final username = _usernameController.text;
    final password = _passwordController.text;
    final age = _ageController.text;

    if (!_isUsernameValid(username)) {
      return;
    }

    if (!_isPasswordValid(password)) {
      return;
    }

    if (!_isAgeValid(age)) {
      return;
    }

    // Basic validation example
    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions.'),
        ),
      );
      return;
    }

    if (selectedAllergens.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must first select an allergen')),
      );
      return;
    }

    final return_value = await _insertToDatabase(username, password, age);
    if (return_value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully inserted to database')),
      );
      GoRouter.of(context).goNamed("login_screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    const Center(child: AvatarSelectButton()),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      text: 'Enter your username',
                      inputType: TextInputType.text,
                      controller: _usernameController,
                    ),
                    CustomTextField(
                      text: 'Enter your password',
                      inputType: TextInputType.visiblePassword,
                      controller: _passwordController,
                    ),
                    CustomTextField(
                      text: 'Re-enter your password',
                      inputType: TextInputType.visiblePassword,
                      controller: _reenterPasswordController,
                    ),
                    CustomTextField(
                      text: 'Enter your age',
                      inputType: TextInputType.number,
                      controller: _ageController,
                    ),
                    const AllergenDropdownMenu(
                      width: double.infinity,
                      height: 66,
                    ),
                    TermsAndConditionsBox(
                      // accepted: _acceptedTerms,
                      onChanged: (value) {
                        ref.read(termsAndConditionsProvider.notifier).state =
                            value;
                      },
                    ),
                    CustomTextButton(
                      text: 'Sign Up',
                      width: double.infinity,
                      height: 60,
                      customTextStyle: CustomTextStyles.whiteText700,
                      onPressed: _signUp,
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

class AvatarSelectButton extends ConsumerWidget {
  const AvatarSelectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final selectedAvatar = ref.watch(selectedAvatarProvider);

    return DefaultAvatar(
      imagePath: selectedAvatar,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      onTap: () {
        GoRouter.of(context).pushNamed('select_avatar_screen');
      },
    );
  }
}

class TermsAndConditionsBox extends ConsumerWidget {
  // final bool accepted;
  final ValueChanged<bool> onChanged;

  const TermsAndConditionsBox({
    super.key,
    // required this.accepted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termsAndConditionsAccepted = ref.watch(termsAndConditionsProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary, width: 4.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 10.0),
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).push('/terms_and_conditions');
                  },
                  child: const Text(
                    "I accept the terms and conditions",
                    style: CustomTextStyles.inputText,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Checkbox(
                value: termsAndConditionsAccepted,
                activeColor: CustomColors.primary,
                onChanged: (value) {
                  onChanged(value ?? false);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  side: const BorderSide(width: 8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
