import 'package:drivers_app/tabPages/earning_tab.dart';
import 'package:drivers_app/tabPages/home_tab.dart';
import 'package:drivers_app/tabPages/profile_tab.dart';
import 'package:drivers_app/tabPages/ratings_tab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  onItemClicked(int index) {
    setState(() {
      selectedTabIndex = index;
      tabController!.index = selectedTabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            HomeTab(),
            EarningTab(),
            RatingsTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Earnings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Ratings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 14),
          showUnselectedLabels: true,
          currentIndex: selectedTabIndex,
          onTap: onItemClicked,
        ));
  }
}
