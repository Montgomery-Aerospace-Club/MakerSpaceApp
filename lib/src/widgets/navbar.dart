import 'package:flutter/material.dart';
import 'package:themakerspace/src/screens/borrow_and_returns.dart';
import 'package:themakerspace/src/screens/components.dart';
import 'package:themakerspace/src/screens/home.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;
  // ignore: use_key_in_widget_constructors
  const Navbar({Key? key, required this.selectedIndex});

  @override
  State<StatefulWidget> createState() => NavBarState();
}

class NavBarState extends State<Navbar> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
  }

  void _onItemTapped(int index) async {
    if (!mounted) return;
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ComponentsPage()));
      case 1:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()));
      case 2:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BRs()));
    }

    // if selectedIndex == indexof a page
    // nav push
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.construction),
          label: 'Components',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more),
          label: 'Borrow and Returns',
        ),
      ],
      currentIndex: _selectedIndex,
      // backgroundColor: _isbday ? Colors.amber[700] : null,
      // selectedItemColor: _isbday ? Colors.white : primaryColorColor,
      onTap: _onItemTapped,
    );
  }
}
