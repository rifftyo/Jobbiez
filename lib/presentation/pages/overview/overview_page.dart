import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';

class OverviewPage extends StatelessWidget {
  final String jobOverview;

  const OverviewPage({super.key, required this.jobOverview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Overview', style: kManropeHeading1.copyWith(fontSize: 18)),
          const SizedBox(height: 16),
          Text(jobOverview, style: kManropeBodyText.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}
