import 'package:colon_proyect_flutter/models/professional_model.dart';
import 'package:flutter/material.dart';

class ProfessionalProfile extends StatelessWidget {
  final Professional professional;

  ProfessionalProfile({required this.professional});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del Profesional'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Nombre: ${professional.user.name}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${professional.user.email}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Dirección: ${professional.address}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Profesión: ${professional.profession}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Años de Experiencia: ${professional.yearsOfExperience}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
