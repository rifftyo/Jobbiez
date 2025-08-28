// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/routes/app_routes.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/widgets/job_item.dart';
import 'package:jobbiez/presentation/provider/search_job_provider.dart';
import 'package:jobbiez/presentation/widgets/job_shimmer.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final String query;
  final String category;
  final String type;

  const SearchPage({
    super.key,
    required this.query,
    required this.category,
    required this.type,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category == '' && widget.type == '' && widget.query != '') {
      searchController.text = widget.query;
    } else if (widget.category == '' &&
        widget.type == '' &&
        widget.query == '') {
      searchController.text = 'All Job';
    } else if (widget.type != '' && widget.category != '') {
      searchController.text = '${widget.category} ${widget.type}';
    } else if (widget.category != '') {
      searchController.text = widget.category;
    } else {
      searchController.text = widget.type;
    }
    Future.microtask(
      () => Provider.of<SearchJobProvider>(
        context,
        listen: false,
      ).getSearchJobs(widget.query, widget.category, widget.type),
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Search Result', style: kManropeHeading1),
            Consumer<SearchJobProvider>(
              builder: (context, value, child) {
                final jobLength = value.jobs.length;

                if (jobLength > 0) {
                  return Text(
                    "$jobLength result found",
                    style: kManropeBodyText,
                  );
                } else {
                  return Text("no job", style: kManropeBodyText);
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: kDarkGray, size: 24),
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
                  Provider.of<SearchJobProvider>(
                    context,
                    listen: false,
                  ).getSearchJobs(value, null, null);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<SearchJobProvider>(
                  builder: (context, value, child) {
                    final jobs = value.jobs;
                    final state = value.state;

                    if (state == RequestState.Loading) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: jobs.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => const JobShimmer(),
                      );
                    } else {
                      if (jobs.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Image.asset("assets/images/no_job.png"),
                              Text('Job Not Found', style: kManropeHeading1),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
