import 'package:dev_opportunity/base/di/get_it.dart';
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
  final _viewModel = getIt<ExperienceViewModel>();

  void getExperiences() async {
    List<ExperienceModel?>? experiences = await _viewModel.getUserExperiences(widget.user.uid);
    setState(() {_experiences = experiences;});
  }

  @override
  void initState() {
    super.initState();
    getExperiences();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
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
              Text("Experience", style: theme.textTheme.headlineLarge),
              SizedBox(height: MediaQuery.of(context).size.width * 0.0,),
              _experiences != null ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._experiences!.map((e) => ProfileExperienceCard(
                    experience: e!,
                  ))
                ],
              ) : SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: Text("No Experience"))
              ),
            ],
          )
        )
      )
    );
  }
}
