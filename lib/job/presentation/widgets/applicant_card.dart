import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/presentation/widgets/buttons/dialog_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/loader.dart';
import 'package:dev_opportunity/base/presentation/widgets/snackbar.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:dev_opportunity/job/presentation/view_models/job_view_model.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:dev_opportunity/user/presentation/screens/profile_screen.dart';
import 'package:dev_opportunity/user/presentation/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ApplicantCard extends StatelessWidget {
  const ApplicantCard({super.key, required this.applicant});
  final UserModel applicant;

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
                  builder: (context) => ProfileScreen(
                    user: applicant,
                    myProfile: false,
                  )
                )
              );
            },
            child: Row(
              children: [
                applicant.profilePic != null && applicant.profilePic != "" ? CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(applicant.profilePic!),
                ) : const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/avatar.jpg"),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicant.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      applicant.headline,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.visible,
                    ),
                  ]
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 18,)
      ],
    );
  }
}
