// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:test_app/components/my_button.dart';
import 'package:test_app/components/my_textform.dart';
// import 'package:test_app/pages/home_page.dart';
import 'package:test_app/pages/login_page.dart';
// import 'package:mysql1/mysql1.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('User Registration'),
//         ),
//         body: const Form(),
//       ),
//     );
//   }
// // }

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<void> _submitForm() async {
  if (_formKey.currentState!.validate()) {
    const String apiUrl =
        'http://localhost:3001/users/create'; // Replace with your Node.js server URL
    final Map<String, dynamic> data = {
      'name': _nameController.text,
      'surname': _surnameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      // 'location': _locationController.text,
      'phoneNumber': _phoneNumberController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        // Successful submission
        // You can display a success message or navigate to a success page
        print('Data submitted successfully: ${response.body}');

        // Navigate to the login page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        
      } else {
        // Handle errors, e.g., display an error message to the user
        print('Error submitting data: ${response.body}');
      }
    } catch (e) {
      print('Error submitting data: $e');
    }
  }

  }
  // void _navigateToLoginPage() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => LoginPage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('User Registration'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MyTextForm(
                    controller: _nameController,
                    hintText: 'Name',
                    obscureText: false),

                const SizedBox(height: 10),

                MyTextForm(
                    controller: _surnameController,
                    hintText: 'Surname',
                    obscureText: false),

                const SizedBox(height: 10),

                MyTextForm(
                    controller: _emailController,
                    hintText: 'Email address',
                    obscureText: false),

                const SizedBox(height: 10),

                MyTextForm(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: false),

                const SizedBox(height: 10),

                // MyTextForm(
                //     controller: _locationController,
                //     hintText: 'Location',
                //     obscureText: false),

                // const SizedBox(height: 10),

                MyTextForm(
                    controller: _phoneNumberController,
                    hintText: 'Phone number',
                    obscureText: false),

                const SizedBox(height: 50),
                // Repeat similar TextFormField widgets for other field
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Submit Form"),
                ),

                const SizedBox(height: 50),

                // MyButton(
                //     onTap: () {}, page: const HomePage(), buttontext: 'Next'),

                const SizedBox(height: 50),

                // Button to navigate to the login page
                // ElevatedButton(
                //   onPressed: _navigateToLoginPage,
                //   child: const Text('Go to Login Page'),
                // ),
              ],
            ),
          ),
        ));
  }
}
