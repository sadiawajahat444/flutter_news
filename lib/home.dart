
import 'package:flutter/material.dart';
import 'package:flutter_news/screens/login_screen.dart';
import 'package:flutter_news/tabbar.dart';

import 'bottom_nav_pages/bottom_nav_controller.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>  {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body://LoginScreen(),
        MainTabBar(),
    //BottomNavController(),
    );
}

}
