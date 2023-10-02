import 'package:dev_opportunity/base/presentation/widgets/buttons/floating_action_button.dart';
import 'package:dev_opportunity/user/presentation/widgets/experience_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmploymentHistoryScreen extends StatefulWidget {
  const EmploymentHistoryScreen({super.key});

  @override
  State<EmploymentHistoryScreen> createState() => _EmploymentHistoryScreenState();
}

class _EmploymentHistoryScreenState extends State<EmploymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          "Employment History",
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Text(data)
            ]
          ),
        ),
      ),
      floatingActionButton: FloatActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const ExperienceForm()
          );
        },
        icon: CupertinoIcons.add
      )
    );
  }
}
