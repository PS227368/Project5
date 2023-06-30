import 'package:flutter/material.dart';

import 'package:my_app/main.dart';
import 'package:my_app/pages/inloggen.dart';

class OefeningenPage extends StatefulWidget {
  const OefeningenPage({super.key});

  @override
  State<OefeningenPage> createState() => _OefeningenPageState();
}

class _OefeningenPageState extends State<OefeningenPage> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp1()));
            } else if (currentIndex == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OefeningenPage()));
            } else if (currentIndex == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InloggenPage()));
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Oefeningen',
            icon: Icon(Icons.fitness_center),
          ),
          BottomNavigationBarItem(
            label: 'Inloggen',
            icon: Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}
