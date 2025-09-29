import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import '../../widgets/widgets.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static const String screenName = "terms_and_conditions_screen";

  const TermsAndConditionsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text("Terms and Conditions", style: CustomTextStyles.title),
            ),
            const SizedBox(height: 20),

            // Last update date
            _buildSectionText(
                "Last updated: September 25, 2025"),
            const SizedBox(height: 20),
            
            // 1. Acceptance of Terms
            _buildSectionTitle("1. Acceptance of Terms"),
            _buildSectionText(
                "By downloading, accessing, or using the AllergyFree mobile application (hereinafter, \"the Application\"), you (hereinafter, \"the User\") agree to be bound by these Terms and Conditions (hereinafter, \"the Terms\") and our Privacy Policy. If you do not agree with any of these terms, you must refrain from using the Application immediately."),
            const SizedBox(height: 20),

            // 2. Service Description
            _buildSectionTitle("2. Service Description"),
            _buildSectionText(
                "AllergyFree is a mobile application that provides an assistance service for identifying potentially allergenic ingredients. The Application uses Optical Character Recognition (OCR) technology to scan ingredient lists of food products and compares them with the allergies and intolerances previously configured by the User. The result is an informative recommendation about the possible presence of allergens."),
            const SizedBox(height: 20),

            // 3. Nature of Service
            _buildSectionTitle("3. Nature of Service and Critical Liability Exemption"),
            _buildWarningText("THE ALLERGYFREE APPLICATION IS AN INFORMATIONAL ASSISTANCE TOOL. IT DOES NOT CONSTITUTE MEDICAL ADVICE, A DIAGNOSIS, A GUARANTEE, OR A PROMISE OF ABSOLUTE SAFETY."),
            const SizedBox(height: 12),
            _buildSubsectionTitle("Not a substitute for professional judgment:"),
            _buildSectionText("The User understands and agrees that the information provided by AllergyFree should not under any circumstances replace consultation with a healthcare professional, the manufacturer's official labeling, or the User's own judgment."),
            const SizedBox(height: 8),
            _buildSubsectionTitle("User's Risk:"),
            _buildSectionText("The final decision to consume or not consume a product is solely and exclusively the User's responsibility. AllergyFree and its developers are not responsible for any damage, allergic reaction, health problem, or consequence resulting from the consumption of a product that the Application has marked as \"safe\" or \"unsafe\"."),
            const SizedBox(height: 8),
            _buildSubsectionTitle("Explicit warning:"),
            _buildSectionText("If the User has a severe allergy (e.g., anaphylaxis), they MUST always consult their doctor and personally verify the product labeling, regardless of the result shown by the Application."),
            const SizedBox(height: 20),

            // 4. Technology Limitations
            _buildSectionTitle("4. Technology Limitations"),
            _buildSectionText("The User acknowledges that the OCR technology and the Application's database have inherent limitations that may affect the accuracy of the results. These limitations include, but are not limited to:"),
            const SizedBox(height: 8),
            _buildBulletPoint("Image quality: Poor lighting, reflections, small typography, or damaged labels that hinder proper scanning."),
            _buildBulletPoint("OCR accuracy: Errors in character recognition that may lead to incorrect interpretation of ingredients."),
            _buildBulletPoint("Database updates: Product composition may change without prior notice from the manufacturer. The AllergyFree database may not reflect these changes immediately."),
            _buildBulletPoint("Unlisted ingredients: The presence of traces or allergens not explicitly declared in the scanned ingredient list."),
            _buildBulletPoint("Context interpretation: The Application analyzes the scanned text but may not understand the full context (e.g., \"may contain traces of...\")."),
            const SizedBox(height: 20),

            // 5. Warranty Disclaimer
            _buildSectionTitle("5. Warranty Disclaimer"),
            _buildSectionText("THE APPLICATION IS PROVIDED \"AS IS\" AND \"AS AVAILABLE\", WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. THE DEVELOPERS DO NOT WARRANT THAT THE APPLICATION WILL BE ERROR-FREE, THAT ITS OPERATION WILL BE UNINTERRUPTED, OR THAT THE INFORMATION PROVIDED WILL ALWAYS BE ACCURATE, COMPLETE, OR UP-TO-DATE."),
            const SizedBox(height: 20),

            // 6. Limitation of Liability
            _buildSectionTitle("6. Limitation of Liability"),
            _buildSectionText("TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, ALLERGYFREE, ITS DEVELOPERS, PARTNERS, AND EMPLOYEES SHALL NOT BE LIABLE TO THE USER OR THIRD PARTIES FOR:"),
            const SizedBox(height: 8),
            _buildBulletPoint("ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES."),
            _buildBulletPoint("LOSS OF PROFITS, DATA, USE, GOODWILL, OR OTHER INTANGIBLE LOSSES."),
            _buildBulletPoint("DAMAGES RESULTING FROM ALLERGIC REACTIONS, HEALTH PROBLEMS, OR ANY OTHER HARM ARISING FROM THE USE OR INABILITY TO USE THE APPLICATION."),
            _buildBulletPoint("THE ACCURACY, COMPLETENESS, OR USEFULNESS OF THE INFORMATION PROVIDED."),
            const SizedBox(height: 20),

            // 7. Intellectual Property
            _buildSectionTitle("7. Intellectual Property"),
            _buildSectionText("All intellectual property rights to the Application, including its source code, database, design, logos, and documentation, are the exclusive property of the developers of AllergyFree and are protected by international copyright and intellectual property laws. The User is granted a limited, non-exclusive, non-transferable, and revocable license to use the Application strictly in accordance with these Terms."),
            const SizedBox(height: 20),

            // 8. Acceptable Use
            _buildSectionTitle("8. Acceptable Use"),
            _buildSectionText("The User agrees to use the Application in a legal and ethical manner. It is prohibited to:"),
            const SizedBox(height: 8),
            _buildBulletPoint("Use the Application for fraudulent purposes or that infringe on third-party rights."),
            _buildBulletPoint("Reverse engineer, decompile, or attempt to extract the Application's source code."),
            _buildBulletPoint("Use automated systems or bots to access the Application's services."),
            const SizedBox(height: 20),

            // 9. Privacy Policy
            _buildSectionTitle("9. Privacy Policy"),
            _buildSectionText("The User's personal information, especially health data related to their allergies, is collected and processed in accordance with our Privacy Policy, which is an integral part of these Terms. The User must read and accept the Privacy Policy before using the Application."),
            const SizedBox(height: 20),

            // 10. Terms Modifications
            _buildSectionTitle("10. Terms Modifications"),
            _buildSectionText("The developers of AllergyFree reserve the right to modify these Terms at any time. Modifications will be effective once published in the Application. Continued use of the Application after such modifications will constitute acceptance of the new Terms."),
            const SizedBox(height: 20),

            // 11. Termination
            _buildSectionTitle("11. Termination"),
            _buildSectionText("The User's access to the Application may be suspended or terminated immediately, without prior notice or liability, if they violate any of these Terms."),
            const SizedBox(height: 20),

            // 12. Applicable Law and Jurisdiction
            _buildSectionTitle("12. Applicable Law and Jurisdiction"),
            _buildSectionText("These Terms shall be governed by and construed in accordance with the laws of Mexico. Any dispute relating to these Terms or the use of the Application shall be submitted to the exclusive jurisdiction of the courts of Guadalajara."),
            const SizedBox(height: 20),

            // 13. Contact
            _buildSectionTitle("13. Contact"),
            _buildSectionText("For any questions or concerns about these Terms and Conditions, you can contact us at: allergyfree@gmail.com."),
            const SizedBox(height: 32),

            // Accept Button
            Center(
              child: CustomTextButton(
                text: "Accept",
                width: 320,
                height: 64,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                customTextStyle: CustomTextStyles.whiteText700,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper methods using your CustomTextStyles
  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: CustomTextStyles.titlesTermsConditions,
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: CustomTextStyles.inputText,
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildSubsectionTitle(String text) {
    return Text(
      text,
      style: CustomTextStyles.subsectionTitle,
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildWarningText(String text) {
    return Text(
      text,
      style: CustomTextStyles.warningText,
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: CustomTextStyles.inputText),
          Expanded(
            child: Text(
              text,
              style: CustomTextStyles.inputText,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}