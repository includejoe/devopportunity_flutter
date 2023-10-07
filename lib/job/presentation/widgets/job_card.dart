import 'package:dev_opportunity/base/presentation/widgets/buttons/dialog_button.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job});
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: theme.colorScheme.background
              )
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),  // Shadow color
                spreadRadius: 1,  // Spread radius
                blurRadius: 5,    // Blur radius
                offset: const Offset(0, 3),  // Offset
              ),
            ],
          ),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: Row(
                          children: [
                            job.userProfilePic != null && job.userProfilePic != "" ? CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(job.userProfilePic!),
                            ) : const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage("assets/avatar.jpg"),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              children: [
                                Text(
                                  job.companyName,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  timeago.format(DateFormat('yyyy-MM-dd').parse(job.datePosted)),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onBackground.withOpacity(0.5)
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: const DialogButton(
                          btnText: "Apply",
                          width: 75,
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    job.jobTitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    job.description,
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    "Skills Required: ${job.skillsRequired}",
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Type: ${job.type}",
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Experience Level: ${job.experienceLevel}",
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Location: ${job.location}",
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    job.opened ? "Opened: Yes" : "Opened: No",
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ),
        ),
        const SizedBox(height: 6,)
      ],
    );
  }
}
