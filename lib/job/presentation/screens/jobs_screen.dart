import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/presentation/widgets/buttons/floating_action_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/empty_list_placeholder.dart';
import 'package:dev_opportunity/base/presentation/widgets/loader.dart';
import 'package:dev_opportunity/base/presentation/widgets/page_refresher.dart';
import 'package:dev_opportunity/base/providers/user_provider.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:dev_opportunity/job/presentation/view_models/job_view_model.dart';
import 'package:dev_opportunity/job/presentation/widgets/job_card.dart';
import 'package:dev_opportunity/job/presentation/widgets/job_form.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final _viewModel = getIt<JobViewModel>();
  final _userProvider = getIt<UserProvider>();
  final _refreshController = RefreshController(initialRefresh: false);
  UserModel? _user;
  bool _isLoading = false;
  bool _isError = false;
  List<JobModel?> _jobs = [];

  void getJobs() async {
    List<JobModel?>? jobs;
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    jobs =  await _viewModel.getAllJobs();

    if(jobs != null) {
      setState(() {
        _jobs = jobs!;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  void getCurrentUser () {
    _userProvider.init();
    setState(() {
      _user = _userProvider.user;
      _isLoading = true;
      _isError = false;
    });
  }

  @override
  void initState() {
    getJobs();
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final jobCards = _jobs.map((job) => JobCard(
        job: job!,
    )).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          "Dev Opportunity",
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: _isLoading ? const Center(child: Loader(size: 30),) :
      _isError ? PageRefresher(onRefresh: getJobs) :
      SmartRefresher(
        controller: _refreshController,
        onRefresh: getJobs,
        header: MaterialClassicHeader(
          color: theme.colorScheme.primary,
          backgroundColor: theme.colorScheme.background,
        ),
        child: _jobs.isNotEmpty ? ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            itemCount: jobCards.length,
            itemBuilder: (context, index) {
              return jobCards[index];
            }
        ) : const EmptyListPlaceholder(
          icon: CupertinoIcons.bag_fill,
          message: "No jobs has been posted yet.",
        ),
      ),
      floatingActionButton: _user!.isCompany ? FloatActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => JobForm(getJobs: getJobs,)
          );
        },
        icon: CupertinoIcons.add
      ) : null
    );
  }
}
