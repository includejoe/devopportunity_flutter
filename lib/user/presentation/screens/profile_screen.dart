import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/presentation/widgets/loader.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:dev_opportunity/job/presentation/view_models/job_view_model.dart';
import 'package:dev_opportunity/job/presentation/widgets/jobs_posted_card.dart';
import 'package:dev_opportunity/user/domain/models/experience.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:dev_opportunity/user/presentation/screens/settings_screen.dart';
import 'package:dev_opportunity/user/presentation/view_models/experience_view_model.dart';
import 'package:dev_opportunity/user/presentation/widgets/profile_experience_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user, required this.myProfile});
  final UserModel user;
  final bool myProfile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ExperienceModel?>? _experiences;
  List<JobModel?>? _jobs;
  final _experienceViewModel = getIt<ExperienceViewModel>();
  final _jobViewModel = getIt<JobViewModel>();
  bool _isLoading = true;

  void initialize() async {
    List<ExperienceModel?>? experiences = await _experienceViewModel.getUserExperiences(widget.user.uid);
    List<JobModel?>? jobs = await _jobViewModel.getUserJobsPosted(widget.user.uid);

    setState(() {
      _experiences = experiences;
      _jobs = jobs;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.myProfile,
        backgroundColor: theme.colorScheme.primary,
        actions: widget.myProfile ? [
          IconButton(
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen()
                )
              );
            },
          ),
        ] : [],
        title: Text(
          "Profile",
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: _isLoading ? const Center(child: Loader(size: 30)) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.user.profilePic != null && widget.user.profilePic != "" ? CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.user.profilePic!),
                  ) : const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/avatar.jpg"),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user.name, style: theme.textTheme.headlineLarge),
                      Text(widget.user.headline, style: theme.textTheme.headlineMedium),
                      Text(widget.user.email, style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold
                      )),
                    ]
                  )
                ]
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.07,),
              Text("Bio", style: theme.textTheme.headlineLarge),
              Text(widget.user.bio ?? "No bio.", style: theme.textTheme.bodyMedium),
              !widget.user.isCompany ? SizedBox(height: MediaQuery.of(context).size.width * 0.07,) : Container(),
              !widget.user.isCompany ? Text("Skills", style: theme.textTheme.headlineLarge) : Container(),
              !widget.user.isCompany ? Text(widget.user.skills ?? "No skills added yet.", style: theme.textTheme.bodyMedium) : Container(),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03,),
              Text(!widget.user.isCompany ? "Experience" : "Jobs Posted", style: theme.textTheme.headlineLarge),
              SizedBox(height: MediaQuery.of(context).size.width * 0.0,),
              !widget.user.isCompany && _experiences != null ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._experiences!.map((e) => ProfileExperienceCard(
                    experience: e!,
                  ))
                ],
              ) : widget.user.isCompany && _jobs != null ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._jobs!.map((job) => JobsPostedCard(
                    job: job!,
                    user: widget.user,
                  ))
                ],
              ) : SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Text(
                  widget.user.isCompany && _jobs == null ? "No Jobs Posted." :
                  !widget.user.isCompany && _experiences == null ? "No Experience." : "")
                )
              ),
            ],
          )
        )
      )
    );
  }
}
