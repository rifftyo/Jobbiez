

import 'package:flutter/material.dart';
import 'package:jobbiez/presentation/provider/tab_job_type_provider.dart';
import 'package:provider/provider.dart';

class TabJobType extends StatelessWidget {
  const TabJobType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TabJobTypeProvider>(
      builder: (context, provider, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 4,
          ),
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final isSelected = provider.currentIndex == index;
    
            return GestureDetector(
              onTap: () {
                provider.changeTab(index);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.yellow : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    provider.jobTypes[index],
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}