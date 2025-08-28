import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/routes/app_routes.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/pages/home/widgets/dropdown_job_category.dart';
import 'package:jobbiez/presentation/pages/home/widgets/tab_job_type.dart';
import 'package:jobbiez/presentation/provider/job_category_provider.dart';
import 'package:jobbiez/presentation/provider/search_job_provider.dart';
import 'package:jobbiez/presentation/provider/tab_job_type_provider.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Filter', style: kManropeHeading1),
          const SizedBox(height: 24),
          Text('Job Type', style: kManropeHeading5),
          const SizedBox(height: 16),
          TabJobType(),
          const SizedBox(height: 8),
          Text('Job Category', style: kManropeHeading5),
          const SizedBox(height: 16),
          DropdownJobCategory(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Consumer<SearchJobProvider>(
              builder: (context, searchProvider, child) {
                return ElevatedButton(
                  onPressed: () {
                    final jobCategoryProvider =
                        Provider.of<JobCategoryProvider>(
                          context,
                          listen: false,
                        );
                    final jobTypeProvider = Provider.of<TabJobTypeProvider>(
                      context,
                      listen: false,
                    );

                    final selectedJobCategory =
                        jobCategoryProvider.selectedCategory?.isNotEmpty == true
                            ? jobCategoryProvider.selectedCategory
                            : null;

                    final selectedJobType =
                        jobTypeProvider.currentIndex != null
                            ? jobTypeProvider.jobTypes[jobTypeProvider
                                .currentIndex!]
                            : null;

                    searchProvider.state == RequestState.Loading
                        ? null
                        : searchProvider.getSearchJobs(
                          '',
                          selectedJobCategory,
                          selectedJobType,
                        );

                    Navigator.pushNamed(
                      context,
                      AppRoutes.search,
                      arguments: {
                        'query': '',
                        'category': selectedJobCategory,
                        'type': selectedJobType,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child:
                      searchProvider.state == RequestState.Loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                            'Apply',
                            style: kManropeHeading5.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
