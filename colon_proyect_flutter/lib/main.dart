import 'package:colon_proyect_flutter/screens/create_professional.dart';
import 'package:colon_proyect_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.work)),
              ],
              unselectedLabelColor: Color.fromARGB(255, 108, 176, 232),
            ),
            title: const Text('Seleccione una opción'),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 232, 126, 126),
              fontSize: 20,
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text('Log in'),
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 182, 170, 202),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterProfessionalForm()),
                      );
                    },
                    child: const Text('Register Professional'),
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 182, 170, 202),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
