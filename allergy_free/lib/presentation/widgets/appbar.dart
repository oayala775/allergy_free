import 'package:allergy_free/presentation/widgets/app_name_widget.dart';
import 'package:allergy_free/presentation/widgets/back_arrow_button.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackArrowButton(),
      actions: const [AppNameWidget()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
