import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopJobShimmer extends StatelessWidget {
  const TopJobShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}
