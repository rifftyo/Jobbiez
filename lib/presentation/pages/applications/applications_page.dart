// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/pages/applications/widgets/application_item.dart';
import 'package:jobbiez/presentation/provider/my_applications_provider.dart';
import 'package:jobbiez/presentation/widgets/job_shimmer.dart';
import 'package:provider/provider.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  void initState() {
    Future.microtask(
      () =>
          Provider.of<MyApplicationsProvider>(
            context,
            listen: false,
          ).fetchMyApplications(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Your Job Applications', style: kManropeHeading1),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: Consumer<MyApplicationsProvider>(
                builder: (context, provider, child) {
                  final applications = provider.applications;
                  final state = provider.state;

                  if (state == RequestState.Loading) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: applications.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => const JobShimmer(),
                    );
                  } else {
                    if (applications.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset("assets/images/no_job.png"),
                            Text('Job Not Found', style: kManropeHeading1),
                          ],
                        ),
                      );
                    }
                  }

                  return ListView.builder(
                    itemCount: applications.length,
                    itemBuilder: (context, index) {
                      final application = applications[index];

                      return ApplicationItem(application: application);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
