import 'package:flutter/material.dart';
import 'package:jobbiez/data/models/job_detail.dart';
import 'package:jobbiez/presentation/pages/about/about_page.dart';
import 'package:jobbiez/presentation/pages/overview/overview_page.dart';
import 'package:jobbiez/presentation/pages/review/review_page.dart';
import 'package:jobbiez/presentation/provider/tab_job_detail_provider.dart';
import 'package:provider/provider.dart';

class TabJobDetail extends StatelessWidget {
  const TabJobDetail({super.key, required this.job});

  final JobDetail? job;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabJobDetailProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(3, (index) {
                    final isSelected = provider.currentIndex == index;
                    return GestureDetector(
                      onTap: () => provider.changeTab(index),
                      child: Container(
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
                            provider.detailTabs[index],
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: IndexedStack(
                  index: provider.currentIndex,
                  children: [
                    OverviewPage(jobOverview: job!.jobOverview),
                    AboutPage(aboutCompany: job!.aboutCompany),
                    ReviewPage(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
