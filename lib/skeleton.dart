import 'package:flutter/material.dart';
import 'package:podex/pages/get.dart';
import 'package:podex/pages/post.dart';

class Skeleton extends StatefulWidget {
  const new({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

int currentIndex = 0;
List pages = [Get(), Post()];

class _SkeletonState extends State<Skeleton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'GET'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'POST'),
        ],
      ),
    );
  }
}
