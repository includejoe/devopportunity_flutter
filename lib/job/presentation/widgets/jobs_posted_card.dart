import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/providers/user_provider.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:dev_opportunity/job/presentation/screens/job_detail_screen.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobsPostedCard extends StatefulWidget {
  const JobsPostedCard({
    super.key,
    required this.job,
    required this.user,
  });

  final JobModel job;
  final UserModel user;

  @override
  State<JobsPostedCard> createState() => _JobsPostedCardState();
}

class _JobsPostedCardState extends State<JobsPostedCard> {
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JobDetailScreen(job: widget.job)
                )
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job.jobTitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary
                  ),
                  overflow: TextOverflow.visible,
                ),
                Text(
                  widget.job.description,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  timeago.format(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(widget.job.datePosted)),
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
