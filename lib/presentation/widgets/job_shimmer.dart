import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:shimmer/shimmer.dart';

class JobShimmer extends StatelessWidget {
  const JobShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 300,
        height: 75,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: kLightGray,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
