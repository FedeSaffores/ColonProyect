import 'package:colon_proyect_flutter/screens/create_professional.dart';
import 'package:colon_proyect_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';

// void fetchData() async {
//   final response = await http.get(Uri.parse("http://127.0.0.1:8000"));

//   if (response.statusCode == 200) {
//     var data = json.decode(response.body);
//   } else {
//     throw Exception('Error al cargar los datos');
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Colon Proyect')),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Log in'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterProfessionalForm()),
                );
              },
              child: const Text('Register Professional'),
            )
          ]),
        ),
      ),
    );
  }
}
