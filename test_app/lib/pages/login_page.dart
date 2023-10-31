import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_app/components/my_button.dart';
import 'package:test_app/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/pages/landing_page.dart';
import 'package:test_app/pages/new_account.dart';

// import 'package:test_app/pages/new_account.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  Future<http.Response> insertrecord() async {
    //final response = await http.Response;
    if (usernameController.text != "" || passwordController.text != "") {
      try {
        String apiUrl = "http://localhost:3001/users/login";

        final Map<String, dynamic> data = {
          'email': usernameController.text,
          'password': passwordController.text,
        };
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );
        return response;
      } catch (e) {
        if (kDebugMode) {
          print(e);
          return http.Response("Error", 500);
        }
      }
    } else {
      if (kDebugMode) {
        return http.Response("Please provide all the required fields", 400);
      }
    }
    return http.Response("Error", 500);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),

              //logo
              const Icon(
                Icons.ac_unit_rounded,
                size: 100,
              ),

              const SizedBox(height: 50),

              //Welcome
              Text(
                "Welcome back you've been miseed!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              //Username textfield
              MyTextfield(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              //Password textfield
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //Sign In
              // ...

              // Text("Response: ${response.body}"),

              GestureDetector(
                onTap: () async {
                  final response = await insertrecord();
                  if (response.statusCode == 200) {
                    final Map<String, dynamic> data =
                        json.decode(response.body);
                    final String token = data['token'];

                    print("Response: ${response.body} ${response.statusCode}");
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LandingPage(token: token)),
                    );
                  } else {
                    if (kDebugMode) {
                      // print(
                      //     "Response: ${response.body} ${response.statusCode}");
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // MyButton(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const HomePage()),
              //     );
              //   },
              //   page: LoginPage(), // You can remove this line
              //   buttontext: 'Sign In',
              // ),

// ...

              const SizedBox(height: 50),

              // Inside the MyButton widget that corresponds to "Create new account"
              MyButton(
                onTap: () {},
                page: const RegistrationForm(), // You can remove this line
                buttontext: 'Create new account',
              ),

              //New Member

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
