import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp1());

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  // final screens = const [
  //   Center(
  //     child: Text(
  //       'Home',
  //       style: TextStyle(fontSize: 72),
  //     ),
  //   ),
  //   Center(
  //     child: Text(
  //       'Oefeningen',
  //       style: TextStyle(fontSize: 72),
  //     ),
  //   ),
  //   Center(
  //     child: Text(
  //       'Inloggen',
  //       style: TextStyle(fontSize: 72),
  //     ),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
              print(index);
              if (index > 0) {
                return;
              } else if (currentIndex == 0) {
                MaterialPageRoute(builder: (context) => const MyApp1());
              } else if (currentIndex == 1) {
                MaterialPageRoute(builder: (context) => const OefeningenPage());
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
      ),
    );
  }
}

class OefeningenPage extends StatefulWidget {
  const OefeningenPage({super.key});

  @override
  State<OefeningenPage> createState() => OefeningenPageState();
}

class OefeningenPageState extends State<OefeningenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("./images/homescreen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text(
                    "SUMMA  ",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                      color: Colors.white,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text(
                    "MOVE",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                      color: const Color(0xFF40D876),
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
