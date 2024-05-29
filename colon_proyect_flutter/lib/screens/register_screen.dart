import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _csrfToken = '';

  @override
  void initState() {
    super.initState();
    _fetchCsrfToken();
  }

  Future<void> _fetchCsrfToken() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:8000/register"));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        var csrfMeta = document.querySelector('meta[name="csrf-token"]');
        if (csrfMeta != null) {
          setState(() {
            _csrfToken = csrfMeta.attributes['content'] ?? '';
            print(_csrfToken);
          });
        } else {
          print('CSRF token meta tag not found');
        }
      } else {
        print('Failed to fetch CSRF token');
      }
    } catch (e) {
      print('Failed to fetch CSRF token: $e');
    }
  }

  Future<void> _register() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        final response = await http.post(
            Uri.parse("http://10.0.2.2:8000/register"),
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-TOKEN': _csrfToken
            },
            body: jsonEncode({
              'name': _nameController.text,
              'email': _emailController.text,
              'password': _passwordController.text,
              'password_confirmation': _confirmPasswordController.text,
            }));
        print(response.statusCode);
        if (response.statusCode == 200) {
          print('Registration successful');
        } else {
          print('Registration failed: ${response.body}');
        }
      } catch (e) {
        print('Registration failed: $e');
      }
    } else {
      print('Passwords do not match');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _register,
              //_csrfToken.isNotEmpty ?
              child: const Text('Registro'),
            ),
          ],
        ),
      ),
    );
  }
}
