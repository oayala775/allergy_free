import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCheckbox extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool> onChanged;
  final String buttonText;
  const CustomCheckbox({
    super.key,
    required this.accepted,
    required this.onChanged, required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary, width: 4.0),
          borderRadius: BorderRadius.circular(70.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 14.0, 0.0, 14.0),
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).push('/terms_and_conditions');
                },
                child: Text(
                  buttonText,
                  style: CustomTextStyles.inputText,
                ),
              ),
            ),
            Checkbox(
              value: accepted,
              activeColor: CustomColors.primary,
              onChanged: (value) {
                onChanged(value ?? false);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
                side: const BorderSide(width: 8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
