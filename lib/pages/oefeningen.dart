import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/main.dart';
import 'package:my_app/pages/inloggen.dart';

// ignore_for_file: avoid_print
class Oefening {
  final int id;
  final String name;
  final String description_nl;
  final String description_en;

  Oefening({
    required this.id,
    required this.name,
    required this.description_nl,
    required this.description_en,
  });

  factory Oefening.fromJson(Map<String, dynamic> json) {
    return Oefening(
      id: json['id'],
      name: json['name'],
      description_nl: json['description_nl'],
      description_en: json['description_en'],
    );
  }
}

List<Oefening> oefeningen = [];

class OefeningenPage extends StatefulWidget {
  const OefeningenPage({Key? key});

  @override
  State<OefeningenPage> createState() => _OefeningenPageState();
}

class _OefeningenPageState extends State<OefeningenPage> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchOefeningen();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: oefeningen.length,
        itemBuilder: (context, index) {
          final oefening = oefeningen[index];
          return ListTile(
            title: Text(oefening.name),
            subtitle: Text(oefening.description_nl),
          );
        },
      ),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
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

  void fetchOefeningen() async {
    final url = 'http://10.59.178.38:8000/api/oefeningen';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final jsonData = jsonDecode(body)["data"];
        print(body);
        if (jsonData is List) {
          setState(() {
            oefeningen = jsonData.map((e) => Oefening.fromJson(e)).toList();
          });
          print('Ja, het werkt!');
        } else {
          print('Geen oefeningen gevonden in de API-response.');
        }
      } else {
        print(
            'Fout bij het ophalen van de API-response: ${response.statusCode}');
      }
    } catch (e) {
      print('Er is een fout opgetreden tijdens het verbinden met de API: $e');
    }
  }
}
