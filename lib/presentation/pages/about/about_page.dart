import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';

class AboutPage extends StatelessWidget {
  final String aboutCompany;

  const AboutPage({super.key, required this.aboutCompany});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Company',
              style: kManropeHeading1.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(aboutCompany, style: kManropeBodyText.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
