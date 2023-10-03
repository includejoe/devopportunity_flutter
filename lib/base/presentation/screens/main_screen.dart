import 'dart:io';
import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/providers/user_provider.dart';
import 'package:dev_opportunity/job/presentation/screens/jobs_screen.dart';
import 'package:dev_opportunity/job/presentation/screens/post_job_screen.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:dev_opportunity/user/presentation/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreen = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final _userProvider = getIt<UserProvider>();
  UserModel? _user;

  @override
  void initState() {
    _userProvider.init();
    _user = _userProvider.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              _currentScreen = index;
            });
          },
        children:  <Widget> [
          const JobsScreen(),
          const PostJobScreen(),
          ProfileScreen(user: _user!, myProfile: true,),
        ]
      ),
    bottomNavigationBar: SizedBox(
      height: Platform.isIOS ? 90 : 60,
        child: BottomNavigationBar(
          currentIndex: _currentScreen,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int index) {
            _pageController.jumpToPage(index);
          },
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(_currentScreen == 0 ?
              CupertinoIcons.bag_fill :
              CupertinoIcons.bag
              ),
              label: 'Jobs'
            ),
            BottomNavigationBarItem(
              icon: Icon(_currentScreen == 1 ?
              CupertinoIcons.add_circled_solid :
              CupertinoIcons.add_circled
              ),
              label: 'Post Job'
            ),
            BottomNavigationBarItem(
              icon: Icon(_currentScreen == 2 ?
              CupertinoIcons.person_fill :
              CupertinoIcons.person
              ),
              label: 'Profile'
            ),
          ],
        ),
      ),
    );
  }
}
