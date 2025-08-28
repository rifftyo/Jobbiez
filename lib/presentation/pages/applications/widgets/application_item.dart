import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/data/models/application_response.dart';

class ApplicationItem extends StatelessWidget {
  const ApplicationItem({super.key, required this.application});

  final Applications application;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: kLightGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Image.network(application.companyImage, fit: BoxFit.contain),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(application.companyName, style: kManropeBodyText),
                const SizedBox(height: 4),
                Text(
                  application.jobTitle,
                  style: kManropeHeading1.copyWith(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  application.status.isNotEmpty
                      ? "${application.status[0].toUpperCase()}${application.status.substring(1)}"
                      : "",
                  style: kManropeHeading5.copyWith(
                    fontSize: 12,
                    color:
                        application.status == 'pending'
                            ? Colors.orange
                            : Colors.green,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
