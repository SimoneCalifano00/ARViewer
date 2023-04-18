import 'package:ar_testing/ar_panorama.dart';
import 'package:ar_testing/localobjectdisplay.dart';
import 'package:ar_testing/screens/ModelsListScreen.dart';
import 'package:ar_testing/screens/PanoramaListScreen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();

  static final String routhPath = '/';
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': ModelsListScreen(), 'title': '3D Models List'},
    {'page': PanoramaListScreen(), 'title': 'Panorama List'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            title: Text('${_pages[_selectedPageIndex]['title']}',
                style: Theme.of(context).textTheme.headline6),
            leading: Padding(
              padding: EdgeInsets.all(_displayWidth * 0.02),
              child: Image.asset('lib/assets/icon/ar-icon.png'),
            ),
            leadingWidth: _displayWidth * 0.2,
          ),
        ],
        body: _pages[_selectedPageIndex]['page'] as Widget,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).accentColor,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          elevation: 5,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.view_in_ar),
                label: '3D Models'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.vrpano_outlined),
                label: 'AR Panoramas'),
          ]),
    );
  }
}
