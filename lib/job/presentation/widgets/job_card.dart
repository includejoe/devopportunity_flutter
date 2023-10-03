import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/presentation/widgets/buttons/round_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:dev_opportunity/base/presentation/widgets/snackbar.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:dev_opportunity/job/presentation/view_models/job_view_model.dart';
import 'package:dev_opportunity/user/domain/models/experience.dart';
import 'package:dev_opportunity/user/presentation/view_models/experience_view_model.dart';
import 'package:dev_opportunity/user/presentation/widgets/experience_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  JobCard({super.key, required this.job});
  final JobModel job;
  final _viewModel = getIt<JobViewModel>();

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
                  Text(
                    job.companyName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary
                    ),
                    overflow: TextOverflow.ellipsis,
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
                    job.opened ? "Is Opened: Yes" : "Is Opened: No",
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Date Posted: ${job.datePosted.substring(0, 10)}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.5)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "${experience.startDate} to ${experience.endDate}",
                  //       style: theme.textTheme.bodyMedium?.copyWith(
                  //         color: theme.colorScheme.primary,
                  //         fontWeight: FontWeight.bold
                  //       ),
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //     Row(
                  //       children: [
                  //         RoundButton(
                  //           icon: CupertinoIcons.pen,
                  //           backgroundColor: Colors.green,
                  //           onClick: (){
                  //             showDialog(
                  //               context: context,
                  //               builder: (BuildContext context) => ExperienceForm(
                  //                 experience: experience,
                  //                 getUserExperiences: getUserExperiences
                  //               )
                  //             );
                  //           },
                  //         ),
                  //         const SizedBox(width: 5,),
                  //         RoundButton(
                  //           icon: CupertinoIcons.trash,
                  //           backgroundColor: theme.colorScheme.error,
                  //           onClick: (){
                  //             confirmationDialog(
                  //               context: context,
                  //               title: "Are you sure you delete this?",
                  //               yesAction: () {
                  //                 _viewModel.deleteExperience(id: experience.id);
                  //                 showSnackBar(context, "Experience deleted successfully", Colors.green);
                  //                 getUserExperiences();
                  //               }
                  //             );
                  //           },
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ),
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
