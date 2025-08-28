// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/routes/app_routes.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/pages/detail/widgets/tab_job_detail_widget.dart';
import 'package:jobbiez/presentation/provider/job_detail_provider.dart';
import 'package:jobbiez/presentation/provider/tab_job_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String idJob;

  const DetailPage({super.key, required this.idJob});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<JobDetailProvider>(
        context,
        listen: false,
      ).getJobDetail(widget.idJob);

      Provider.of<TabJobDetailProvider>(context, listen: false).resetTab();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<JobDetailProvider>(
            builder: (context, provider, child) {
              final job = provider.jobDetail;

              if (provider.state == RequestState.Loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (job != null && provider.state == RequestState.Loaded) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        job.companyImage,
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        job.jobTitle,
                        style: kManropeHeading1.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        const SizedBox(width: 8),
                        Text(job.jobLocation, style: kManropeHeading5),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TabJobDetail(job: job),
                  ],
                );
              } else {
                return const Center(child: Text('Job detail not found'));
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.apply,
              arguments: widget.idJob,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'Apply',
            style: kManropeHeading5.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
