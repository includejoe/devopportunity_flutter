import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/presentation/widgets/buttons/dialog_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/loader.dart';
import 'package:dev_opportunity/base/presentation/widgets/snackbar.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:dev_opportunity/job/presentation/view_models/job_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobCard extends StatefulWidget {
  const JobCard({
    super.key,
    required this.job,
    required this.isCompany,
    required this.userId
  });

  final JobModel job;
  final String userId;
  final bool isCompany;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  final _viewModel = getIt<JobViewModel>();
  bool _isLoading = false;

  void applyJob(context) async {
    setState(() {_isLoading = true;});

     String response = await _viewModel.applyJob(
       jobId: widget.job.id,
       userId: widget.userId
     );

     if(response == "success") {
       showSnackBar(context, "Your application has been submitted", Colors.green);
     } else if (response == "already-applied") {
       showSnackBar(context, "You have already applied for this job", Colors.redAccent);
     } else {
       showSnackBar(context, "Something went wrong", Colors.red);
     }
    setState(() {_isLoading = false;});
  }

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
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),  // Shadow color
                spreadRadius: 1,  // Spread radius
                blurRadius: 5,    // Blur radius
                offset: const Offset(0, 3),  // Offset
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
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
                          widget.job.userProfilePic != null && widget.job.userProfilePic != "" ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(widget.job.userProfilePic!),
                          ) : const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage("assets/avatar.jpg"),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            children: [
                              Text(
                                widget.job.companyName,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                timeago.format(DateFormat('yyyy-MM-dd').parse(widget.job.datePosted)),
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
                    !widget.isCompany & _isLoading ? const Padding(
                      padding: EdgeInsets.only(right: 32.0),
                      child: Loader (size: 20,),
                    ) :
                    !widget.isCompany ? InkWell(
                      onTap: () {applyJob(context);},
                      child: const DialogButton(
                        btnText: "Apply",
                        width: 75,
                      )
                    ) : Container()
                  ],
                ),
                const SizedBox(height: 8,),
                Text(
                  widget.job.jobTitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.visible,
                ),
                Text(
                  widget.job.description,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(height: 5,),
                Text(
                  "Skills Required: ${widget.job.skillsRequired}",
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                ),
                Text(
                  "Type: ${widget.job.type}",
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                ),
                Text(
                  "Experience Level: ${widget.job.experienceLevel}",
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                ),
                Text(
                  "Location: ${widget.job.location}",
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                ),
                Text(
                  widget.job.opened ? "Opened: Yes" : "Opened: No",
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6,)
      ],
    );
  }
}
