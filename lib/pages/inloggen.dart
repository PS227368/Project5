import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/main.dart';
import 'package:my_app/pages/oefeningen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int currentIndex = 2;
  var loginsucces = false;
  List<dynamic> exercises = [];
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Login page',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-mail',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  attemptLogin(
                    emailController.text,
                    passwordController.text,
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  attemptLogout();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String token = "";

  Future<bool> login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
      Uri.parse('http://10.59.176.104:8000/api/login'),
      headers: <String, String>{
        'Accept': 'application/json',
      },
      body: data,
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      token = json['access_token'];
    }

    return response.statusCode == 200;
  }

  Future<bool> logout() async {
    final response = await http.post(
      Uri.parse('http://10.59.176.104:8000/api/logout'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // TOKEN WORDT HIER GEBRUIKT!!!
      },
    );

    return response.statusCode == 200;
  }

  void attemptLogin(String email, String password) async {
    bool loggedin = await login(email, password);
    loginsucces = loggedin;
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: loggedin
          ? const Text("Succesfully logged in")
          : const Text("Login failed"),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    setState(() {});
  }

  void attemptLogout() async {
    bool loggedout = await logout();

    if (loginsucces && loggedout) {
      AlertDialog alert = const AlertDialog(
        title: Text("Alert"),
        content: Text("Logged out"),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      loginsucces = false;
    }

    setState(() {});
  }
}
