import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import '../../widgets/widgets.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static const String screenName = "terms_and_conditions_screen";

  const TermsAndConditionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Terms & Conditions", style: CustomTextStyles.title),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              // ! Change this text to future Terms and conditions
              child: const Text(
                """Velit ad occaecat cupidatat est elit nostrud sint sint in pariatur commodo pariatur in. Aliqua consectetur exercitation eiusmod est ut commodo irure ipsum exercitation. Ipsum aliqua in exercitation eiusmod est velit sunt commodo tempor quis ullamco officia.
                Ea enim incididunt laboris ad cupidatat eiusmod sint. Ad labore deserunt dolore cillum adipisicing. Incididunt Lorem elit velit ea velit. In do quis ad esse eu fugiat nostrud ad mollit eiusmod velit. Anim nostrud elit nulla voluptate deserunt adipisicing laborum duis magna. In occaecat consequat incididunt ex commodo dolore sint quis. Incididunt sunt ea sint ex laboris sit ex mollit esse est est occaecat in.
          
                Excepteur anim aliquip eiusmod nulla excepteur officia laboris ex laborum fugiat pariatur cupidatat. Cupidatat elit non nisi minim deserunt commodo nisi enim esse enim velit. Dolore ex tempor eiusmod laboris nostrud. Voluptate labore magna fugiat duis nisi duis deserunt laboris.
          
                Velit ad occaecat cupidatat est elit nostrud sint sint in pariatur commodo pariatur in. Aliqua consectetur exercitation eiusmod est ut commodo irure ipsum exercitation. Ipsum aliqua in exercitation eiusmod est velit sunt commodo tempor quis ullamco officia.
                Ea enim incididunt laboris ad cupidatat eiusmod sint. Ad labore deserunt dolore cillum adipisicing. Incididunt Lorem elit velit ea velit. In do quis ad esse eu fugiat nostrud ad mollit eiusmod velit. Anim nostrud elit nulla voluptate deserunt adipisicing laborum duis magna. In occaecat consequat incididunt ex commodo dolore sint quis. Incididunt sunt ea sint ex laboris sit ex mollit esse est est occaecat in.
          
                Excepteur anim aliquip eiusmod nulla excepteur officia laboris ex laborum fugiat pariatur cupidatat. Cupidatat elit non nisi minim deserunt commodo nisi enim esse enim velit. Dolore ex tempor eiusmod laboris nostrud. Voluptate labore magna fugiat duis nisi duis deserunt laboris.
                Velit ad occaecat cupidatat est elit nostrud sint sint in pariatur commodo pariatur in. Aliqua consectetur exercitation eiusmod est ut commodo irure ipsum exercitation. Ipsum aliqua in exercitation eiusmod est velit sunt commodo tempor quis ullamco officia.
                Ea enim incididunt laboris ad cupidatat eiusmod sint. Ad labore deserunt dolore cillum adipisicing. Incididunt Lorem elit velit ea velit. In do quis ad esse eu fugiat nostrud ad mollit eiusmod velit. Anim nostrud elit nulla voluptate deserunt adipisicing laborum duis magna. In occaecat consequat incididunt ex commodo dolore sint quis. Incididunt sunt ea sint ex laboris sit ex mollit esse est est occaecat in.
          
                Excepteur anim aliquip eiusmod nulla excepteur officia laboris ex laborum fugiat pariatur cupidatat. Cupidatat elit non nisi minim deserunt commodo nisi enim esse enim velit. Dolore ex tempor eiusmod laboris nostrud. Voluptate labore magna fugiat duis nisi duis deserunt laboris.
                """,
              ),
            ),
            CustomTextButton(
              text: "Aceptar",
              width: 320,
              height: 64,
              onPressed:
                  () {}, // TODO: Add function to show popup of confirmation
              customTextStyle: CustomTextStyles.whiteText700,
            ),
          ],
        ),
      ),
    );
  }
}
