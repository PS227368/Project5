import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/pages/welcome_view.dart';

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
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => OefeningenPageState();
}

class OefeningenPageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            if (index < 0) {
              return;
            } else if (currentIndex == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WelcomeView()));
            } else if (currentIndex == 2) {
              MaterialPageRoute(builder: (context) => const HomePage());
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/homescreen.jpg"),
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
