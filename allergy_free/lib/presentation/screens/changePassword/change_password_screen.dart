import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/functions/hash_passwords.dart';
import 'package:allergy_free/config/utils/functions/validate_password.dart';
import 'package:allergy_free/database/database_operations.dart';
import 'package:allergy_free/models/user.dart';
import 'package:allergy_free/presentation/providers/providers.dart';
import 'package:allergy_free/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String screenName = "change_password_screen";
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: const _ChangePasswordContent(),
      bottomNavigationBar: const Navbar(),
    );
  }
}

class _ChangePasswordContent extends StatelessWidget {
  const _ChangePasswordContent();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: const IntrinsicHeight(child: ChangePasswordForm()),
          ),
        );
      },
    );
  }
}

class ChangePasswordForm extends ConsumerStatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  ConsumerState<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends ConsumerState<ChangePasswordForm> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _reenterNewPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _reenterNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _reenterNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    User user = ref.read(userProvider.notifier).state;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Create New\nPassword",
              style: CustomTextStyles.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              text: "Current Password",
              inputType: TextInputType.visiblePassword,
              controller: _currentPasswordController,
            ),
            CustomTextField(
              text: "New Password",
              inputType: TextInputType.visiblePassword,
              controller: _newPasswordController,
            ),
            CustomTextField(
              text: "Confirm New Password",
              inputType: TextInputType.visiblePassword,
              controller: _reenterNewPasswordController,
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              text: "Change Password",
              width: double.infinity,
              height: 64,
              onPressed: _changePassword,
              customTextStyle: CustomTextStyles.whiteText700,
            ),
            const Flexible(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  //En caso de que se cambie la contraseña correctamente, mostrar este pop-up
  void _success(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => CustomDialog(
            title: "Password changed successfully",
            titleStyle: CustomTextStyles.greenPopupTitle,
            message: "Your new password has been saved.",
            messageStyle: CustomTextStyles.inputText,
            buttonText: 'Accept',
            buttonTextStyle: CustomTextStyles.whiteText700,
            buttonColor: CustomColors.primary,
            onButtonPressed: () {
              // Ir a la pantalla anterior después de cerrar el diálogo
              GoRouter.of(context).pop();
            },
          ),
    );
  }

  //En caso de que no se pueda cambiar la contraseña, mostrar este pop-up
  void _error(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => CustomDialog(
            title: "Something went wrong",
            titleStyle: CustomTextStyles.greyPopupTitle,
            message:
                "We couldn't update your password. Please try again later.",
            messageStyle: CustomTextStyles.inputText,
            buttonText: 'Accept',
            buttonTextStyle: CustomTextStyles.whiteText700,
            buttonColor: CustomColors.primary,
            onButtonPressed: () {
              // Ir a la pantalla anterior después de cerrar el diálogo
              GoRouter.of(context).pop();
            },
          ),
    );
  }

  void _changePassword() async {
    // Hide keyboard when button is pressed
    FocusScope.of(context).unfocus();
    User user = ref.read(userProvider.notifier).state;
    String newPassword = _newPasswordController.text;
    String reenterPassword = _reenterNewPasswordController.text;

    String hashedCurrentPassword = hashPassword(
      _currentPasswordController.text,
    );

    if (hashedCurrentPassword != user.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The entered password does not match the current one.'),
        ),
      );
      return;
    }

    String? passwordValidationResult = validatePassword(
      newPassword,
      reenterPassword,
    );
    if (passwordValidationResult != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(passwordValidationResult)));
      return;
    }

    String newPasswordHashed = hashPassword(_newPasswordController.text);
    User updatedUser = User(
      id: user.id,
      username: user.username,
      password: newPasswordHashed,
      age: user.age,
      avatarId: user.avatarId,
    );
    int? result = await DatabaseOperations().updateUser(updatedUser);
    if ((result ?? 0) > 0) {
      ref.read(userProvider.notifier).state = updatedUser;
      _success(context);
    } else {
      _error(context);
    }
  }
}
