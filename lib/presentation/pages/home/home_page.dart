// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/routes/app_routes.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/pages/home/widgets/filter_bottom_sheet.dart';
import 'package:jobbiez/presentation/pages/home/widgets/top_job_shimmer.dart';
import 'package:jobbiez/presentation/provider/job_category_provider.dart';
import 'package:jobbiez/presentation/widgets/job_item.dart';
import 'package:jobbiez/presentation/pages/home/widgets/tab_last_job_widget.dart';
import 'package:jobbiez/presentation/pages/home/widgets/top_job_item.dart';
import 'package:jobbiez/presentation/widgets/job_shimmer.dart';
import 'package:jobbiez/presentation/widgets/user_avatar.dart';
import 'package:jobbiez/presentation/provider/last_job_provider.dart';
import 'package:jobbiez/presentation/provider/profile_user_provider.dart';
import 'package:jobbiez/presentation/provider/top_job_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<ProfileUserProvider>(
            context,
            listen: false,
          ).getProfileUser(),
    );
    Future.microtask(
      () => Provider.of<TopJobProvider>(context, listen: false).getTopJobs(),
    );
    Future.microtask(
      () => context.read<LastJobProvider>().getLastJobs('Remote'),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<ProfileUserProvider>(
                      builder: (context, value, child) {
                        final user = value.user;
                        final state = value.state;

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.profile);
                          },
                          child: UserAvatar(
                            username: user?.username,
                            fotoProfile: user?.fotoProfile,
                            radius: 30,
                            state: state,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('HELLO', style: kManropeHeading5),
                        Consumer<ProfileUserProvider>(
                          builder: (context, value, child) {
                            final user = value.user;

                            return Text(
                              user?.username ?? '',
                              style: kManropeHeading1,
                            );
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.message_outlined),
                      iconSize: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: kDarkGray,
                            size: 24,
                          ),
                          hintText: 'What job are you looking for?',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kLightGray),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.search,
                            arguments: {
                              'query': value,
                              'category': null,
                              'type': null,
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: kLightGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Future.microtask(
                            () =>
                                context
                                    .read<JobCategoryProvider>()
                                    .getCategories(),
                          );
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return FilterBottomSheet();
                            },
                          );
                        },
                        icon: Icon(Icons.format_list_bulleted_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Top Job Post', style: kManropeHeading1),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        'See More',
                        style: kManropeBodyText.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Consumer<TopJobProvider>(
                  builder: (context, value, child) {
                    if (value.state == RequestState.Loading) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const TopJobShimmer();
                          },
                        ),
                      );
                    }

                    final topJobs = value.jobs;

                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topJobs.length,
                        itemBuilder: (context, index) {
                          final job = topJobs[index];

                          return TopJobItem(
                            job: job,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.detail,
                                arguments: job.id,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Last Job Post', style: kManropeHeading1),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        'See More',
                        style: kManropeBodyText.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TabLastJobWidget(),
                const SizedBox(height: 20),
                Consumer<LastJobProvider>(
                  builder: (context, value, child) {
                    if (value.state == RequestState.Loading) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => JobShimmer(),
                      );
                    } else {
                      final lastJobs = value.jobs;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: lastJobs.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final job = lastJobs[index];
                          return JobItem(
                            job: job,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.detail,
                                arguments: job.id,
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
