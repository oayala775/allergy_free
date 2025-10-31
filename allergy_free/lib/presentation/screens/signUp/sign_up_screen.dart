import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/functions/functions.dart';
import 'package:allergy_free/database/database_operations.dart';
import 'package:allergy_free/models/allergy.dart';
import 'package:allergy_free/models/user.dart';
import 'package:allergy_free/presentation/providers/selected_allergens_provider.dart';
import 'package:allergy_free/presentation/providers/selected_avatar_provider.dart';
import 'package:allergy_free/presentation/providers/terms_and_conditions_provider.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:allergy_free/presentation/widgets/widgets.dart';

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
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _reenterPasswordController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  String? _validateUsername(String username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9]+$');
    if (username.isEmpty) {
      return 'Please enter a username.';
    }
    if (!usernameRegex.hasMatch(username)) {
      return 'Username must only contain letters and numbers.';
    }
    return null;
  }

  String? _validateAge(String age) {
    final RegExp ageRegex = RegExp(r'^[0-9]{1,2}$');
    if (age.isEmpty) {
      return 'Age must be included.';
    }
    if (!ageRegex.hasMatch(age)) {
      return 'Age must be a valid number.';
    }

    int? ageValue = int.tryParse(age);
    if (ageValue == null || ageValue < 5) {
      return 'Age must be 5 or older.';
    }
    return null;
  }

  Future<bool> _registerUser(
    String username,
    String password,
    String age,
    List<Allergy> selectedAllergens,
  ) async {
    try {
      // * Avatar verification
      final selectedAvatar = ref.read(selectedAvatarProvider);
      final avatarInstance = await DatabaseOperations().retrieveAvatarID(
        selectedAvatar,
      );
      if (avatarInstance == null || avatarInstance.id == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error retrieving avatar')));
        return false;
      }
      int avatarId = avatarInstance.id!;

      // * Checks if user already exists
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
        return false;
      }

      // * Hashing the password
      final String passwordHashed = hashPassword(password);

      final User user = User(
        username: username,
        password: passwordHashed,
        age: int.parse(age),
        avatarId: avatarId,
      );

      final newUserId = await DatabaseOperations().insertUser(user);
      if (newUserId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create user account.')),
        );
        return false;
      }
      for (final allergy in selectedAllergens) {
        int? allergyIdToLink;
        if (allergy.id != null) {
          allergyIdToLink = allergy.id;
        }
        await DatabaseOperations().insertUserAllergy(
          newUserId,
          allergyIdToLink!,
        );
      }

      ref.read(selectedAvatarProvider.notifier).state =
          'assets/images/avatar/0_Default.png';
      ref.read(selectedAllergensProvider.notifier).state = [];
      ref.read(termsAndConditionsProvider.notifier).state = false;
    } catch (e) {
      print('Error en login: $e');
    }
    return true;
  }

  void _signUp() async {
    final bool acceptedTerms = ref.read(termsAndConditionsProvider);
    final List<Allergy> selectedAllergens = ref.read(selectedAllergensProvider);
    final username = _usernameController.text;
    final password = _passwordController.text;
    final reenterPassword = _reenterPasswordController.text;
    final age = _ageController.text;

    final String? usernameError = _validateUsername(username);
    if (usernameError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(usernameError)));
      return;
    }

    final String? passwordError = validatePassword(password, reenterPassword);
    if (passwordError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(passwordError)));
      return;
    }

    final String? ageError = _validateAge(age);
    if (ageError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(ageError)));
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

    final registrationSuccess = await _registerUser(
      username,
      password,
      age,
      selectedAllergens,
    );
    if (registrationSuccess && mounted) {
      ref.read(selectedAvatarProvider.notifier).state =
          'assets/images/avatar/0_Default.png';
      ref.read(selectedAllergensProvider.notifier).state = [];
      ref.read(termsAndConditionsProvider.notifier).state = false;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (ctx) => CustomDialog(
              title: 'Registration successful',
              titleStyle: CustomTextStyles.greenLogin,
              message: 'Your account was created successfully',
              messageStyle: CustomTextStyles.inputText,
              buttonText: 'OK',
              buttonColor: Colors.grey,

              onButtonPressed:
                  () => GoRouter.of(context).goNamed("login_screen"),
            ),
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (ctx) => CustomDialog(
              title: 'Something went wrong',
              titleStyle: CustomTextStyles.greenLogin,
              message:
                  'There was an error while creating your account. Check your connection or try again later.',
              messageStyle: CustomTextStyles.inputText,
              buttonText: 'OK',
              buttonColor: Colors.grey,

              onButtonPressed:
                  () => GoRouter.of(context).goNamed("login_screen"),
            ),
      );
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
