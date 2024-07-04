import 'package:colon_proyect_flutter/models/professional_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String token;

  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Professional>> _professionals;

  @override
  void initState() {
    super.initState();
    _professionals = fetchAllProfessionals();
  }

  Future<List<Professional>> fetchAllProfessionals() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.15:8000/api/professionals'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Professional.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar los profesionales');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Professionales'),
      ),
      body: FutureBuilder<List<Professional>>(
        future: _professionals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay profesionales disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final professional = snapshot.data![index];
                return ListTile(
                  title: Text(professional.user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${professional.user.email}'),
                      Text(
                          'Profesión: ${professional.profession ?? 'Sin profesión'}'),
                    ],
                  ),
                  onTap: () {
                    // Manejar la acción de tap aquí
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
