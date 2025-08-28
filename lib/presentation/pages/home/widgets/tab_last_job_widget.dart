import 'package:flutter/material.dart';
import 'package:jobbiez/presentation/provider/last_job_provider.dart';
import 'package:jobbiez/presentation/provider/tab_last_job_provider.dart';
import 'package:provider/provider.dart';

class TabLastJobWidget extends StatelessWidget {
  const TabLastJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabLastJobProvider(),
      child: Consumer<TabLastJobProvider>(
        builder: (context, provider, child) {
          return buildTabList(provider);
        },
      ),
    );
  }

  Widget buildTabList(TabLastJobProvider provider) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          final isSelected = provider.currentIndex == index;

          return GestureDetector(
            onTap: () {
              provider.changeTab(index);
                final type = provider.categories[index];
                context.read<LastJobProvider>().getLastJobs(type);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.yellow : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  provider.categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
