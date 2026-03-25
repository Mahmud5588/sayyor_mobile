import 'package:flutter/material.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/storage/localstorage.dart';
import 'package:sayyor/features/ads_manager/banner_widget.dart';
import 'package:sayyor/features/chat/presentation/screen/chat_list_screen.dart';
import 'package:sayyor/features/profile/presentation/screen/profile_screen.dart';
import 'package:sayyor/features/search/presentation/screen/search_screen.dart';

import '../../../home/presentation/screen/home_screen.dart';
import '../../../posts/presentation/screen/create_request.dart';
// import 'package:sayyor/features/post/presentation/screen/create_request_screen.dart'; // Yangi oynani import qiling

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final bool _isMaster;

  @override
  void initState() {
    super.initState();
    _isMaster = sl<LocalStorage>().userSelection == 'master';
  }

  List<Widget> get _pages => [
    HomeScreen(isMasterMode: _isMaster),
    const SearchScreen(),
    CreateRequestScreen(isMasterMode: _isMaster),
    const ChatListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BannerWidget(),
          NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: theme.colorScheme.surface,
            indicatorColor: theme.colorScheme.primaryContainer,
            height: 65,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Asosiy',
              ),
              NavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: 'Qidiruv',
              ),
              // YANGI: O'rtadagi E'lon berish tugmasi
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline),
                selectedIcon: Icon(Icons.add_circle),
                label: _isMaster ? 'Portfolio' : "E'lon",
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: 'Chat',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
