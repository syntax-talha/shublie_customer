// x_tab_bar.dart
import 'package:flutter/material.dart';

class XTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController controller;

  const XTabBar({
    required this.tabs,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabs,
      controller: controller,
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
  }
}
