import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Text(
          'JOBS SCREEN',
          style: theme.textTheme.headlineLarge,
        ),
      ),
    );
  }
}
