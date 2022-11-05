import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_ui/cubits/app_bar_cubit.dart';
import 'package:netflix_ui/screens/home_screen.dart';
import 'package:netflix_ui/widgets/responsive.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(key: PageStorageKey('homeScreen')),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
  ];
  final Map<String, IconData> _icons = {
    'Home': Icons.home_rounded,
    'Search': Icons.search_rounded,
    'Coming Soon': Icons.queue_play_next_rounded,
    'Downloads': Icons.file_download_rounded,
    'More': Icons.menu_rounded,
  };
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
        create: (_) => AppBarCubit(),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: !Responsive.isDesktop(context)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              items: _icons
                  .map(
                    (title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                        icon: Icon(icon, size: 30.0),
                        label: title,
                      ),
                    ),
                  )
                  .values
                  .toList(),
              currentIndex: _currentIndex,
              selectedFontSize: 11.0,
              selectedItemColor: Colors.grey.shade300,
              unselectedFontSize: 11.0,
              unselectedItemColor: Colors.grey,
              onTap: (index) => setState(() => _currentIndex = index),
            )
          : null,
    );
  }
}
