import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:dev_opportunity/base/presentation/widgets/list_item.dart';
import 'package:dev_opportunity/base/providers/user_provider.dart';
import 'package:dev_opportunity/user/presentation/screens/edit_profile_screen.dart';
import 'package:dev_opportunity/user/presentation/screens/employment_history_screen.dart';
import 'package:dev_opportunity/user/presentation/screens/login_screen.dart';
import 'package:dev_opportunity/user/presentation/view_models/user_view_model.dart';
import 'package:dev_opportunity/user/presentation/widgets/theme_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _userViewModel = getIt<UserViewModel>();
  final _userProvider = getIt<UserProvider>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items =[
      ListItem(
        icon: CupertinoIcons.person_fill,
        text: "Edit Profile",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()
              )
          );
        },
      ),
      ListItem(
        icon: CupertinoIcons.doc_append,
        text: "Employment History",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmploymentHistoryScreen()
              )
          );
        },
      ),
      const ListItem(
        icon: CupertinoIcons.sun_max_fill,
        text: "Dark Theme",
        suffixWidget: ThemeSwitch(),
      ),
      ListItem(
        icon: CupertinoIcons.power,
        text: "Sign Out",
        onTap: () {
          confirmationDialog(
              context: context,
              title: "Are you sure you want to sign out?",
              yesAction: () {
                _userViewModel.signOut();
                _userProvider.clearUser();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()
                    )
                );
              }
          );
        },
      )
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          "Settings",
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        }
      )
    );
  }
}
