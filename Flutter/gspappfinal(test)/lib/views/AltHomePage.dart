// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AltHomePage extends StatefulWidget {
  const AltHomePage({super.key});

  @override
  State<AltHomePage> createState() => _AltHomePageState();
}

class _AltHomePageState extends State<AltHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expandable Scroll'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MyHeaderDelegate(),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text('Item $index')),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100.0;

  @override
  double get maxExtent => 300.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Header',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
