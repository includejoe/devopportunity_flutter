import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobsPostedCard extends StatelessWidget {
  const JobsPostedCard({super.key, required this.job});
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: theme.colorScheme.background
              )
            ),
          ),
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.jobTitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary
                  ),
                  overflow: TextOverflow.visible,
                ),
                Text(
                  job.description,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  timeago.format(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(job.datePosted)),
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.5)
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}
