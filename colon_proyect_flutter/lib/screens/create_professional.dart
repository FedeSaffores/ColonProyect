import 'package:colon_proyect_flutter/models/professional_model.dart';
import 'package:colon_proyect_flutter/screens/professional_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

class RegisterProfessionalForm extends StatefulWidget {
  @override
  _RegisterProfessionalFormState createState() =>
      _RegisterProfessionalFormState();
}

class _RegisterProfessionalFormState extends State<RegisterProfessionalForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? profilePicture;
  String? address;
  String? profession;
  int? yearsOfExperience;
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> registerProfessional() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = {
        'name': name!,
        'email': email!,
        'password': password!,
        'password_confirmation': confirmPassword!,
      };

      final professional = {
        'address': address,
        'profession': profession,
        'yearsOfExperience': yearsOfExperience,
      };

      String? base64Image;
      if (_profileImage != null) {
        List<int> imageBytes = await _profileImage!.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      final response = await http.post(
        Uri.parse('http://192.168.1.15:8000/api/create_professional'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user': user,
          'professional': professional,
          'profilePicture': base64Image,
        }),
      );

      if (response.statusCode == 201) {
        // Registro exitoso
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registro exitoso')));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfessionalProfile(
                  professional:
                      Professional.fromJson(jsonDecode(response.body)))),
        );
      } else {
        // Error en el registro
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error en el registro')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Profesionales'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? Icon(Icons.add_a_photo, size: 50)
                      : null,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
                onSaved: (value) {
                  confirmPassword = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Profesión'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su profesion por favor';
                  }
                  return null;
                },
                onSaved: (value) {
                  profession = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la direccion';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Años de experiencia'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los años que lleva desarrollando la profesión';
                  }
                  final int? yearsOfExperience = int.tryParse(value);
                  if (yearsOfExperience == null ||
                      yearsOfExperience < 1 ||
                      yearsOfExperience > 99) {
                    return 'Ingrese una edad válida (1-99)';
                  }
                  return null;
                },
                onSaved: (value) {
                  yearsOfExperience = int.tryParse(value!);
                },
              ),
              ElevatedButton(
                onPressed: registerProfessional,
                child: const Text('Register Professional'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
