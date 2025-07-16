import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () => context.pop(),
        backgroundColor: Color.fromRGBO(44, 128, 38, 1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
