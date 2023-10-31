import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/pages/orders_page.dart';
import 'package:http/http.dart' as http;

class LandingPage extends StatefulWidget {
  final String token;

  const LandingPage({Key? key, required this.token}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String>? userName; // Replace Order with your order model class

  @override
  void initState() {
    super.initState();

    userName = getUserName(widget.token);
  }

//get userId using token
  Future<String> getUserName(String token) async {
    const apiUrl = 'http://localhost:3001/users/current';
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      try {
        // Parse the JSON response
        Map<String, dynamic> responseMap = json.decode(response.body);

        // Check if "success" is true and "User" is a non-empty list
        if (responseMap['success'] == true &&
            responseMap['User'] is List &&
            responseMap['User'].isNotEmpty) {
          // Get the first user in the list (assuming there is only one user in the list)
          Map<String, dynamic> user = responseMap['User'][0];

          // Extract the "name" field
          String name = user['name'] + " " + user['surname'];

          print("Name: $name");
          return name;
        } else {
          print("Invalid response format or no user data found.");
          return 'Error';
        }
      } catch (e) {
        print("Error parsing JSON: $e");
        return 'Error';
      }
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    String usertoken = widget.token;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
              future: userName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator while fetching the user name.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final username = snapshot.data ?? 'User';
                  return Text(
                    'Welcome Back! $username',
                    style: const TextStyle(fontSize: 24),
                  );
                }
              },
            ),
            const SizedBox(height: 50),
            const SizedBox(height: 50),
            

            FutureBuilder<String>(
              future: userName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator while fetching the user name.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final username = snapshot.data ?? 'User';
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                  token: usertoken, name: "$username")),
                        );
                      },
                      child: const ListTile(
                        leading: Icon(Icons.add_shopping_cart),
                        title: Text('Create an Order'),
                      ),
                    ),
                  );
                }
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => HomePage(
            //                 token: usertoken, name: userName.toString())),
            //       );
            //     },
            //     child: const ListTile(
            //       leading: Icon(Icons.add_shopping_cart),
            //       title: Text('Create an Order'),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrdersPage(token: usertoken)),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('View Orders'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
