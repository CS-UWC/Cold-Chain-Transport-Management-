// ignore_for_file: avoid_print
import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/components/my_numberfield.dart';
import 'package:test_app/components/my_textform.dart';
import '../components/my_button.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/pages/orders_page.dart';

// import 'package:test_app/pages/orders_page.dart';

// import '../components/my_textfield.dart';

class HomePage extends StatefulWidget {
  final String token;
  final String name;

  const HomePage({super.key, required this.token, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

// {
//     "companyName":"Cooking.co",
//     "productType":"pasta",
//     "productName":"spaghetti meatballs",
//     "tempRange":"20",
//     "pickupLocation":"bestenbeir",
//     "dropoffLocation":"plettenberg",
//     "customersName": "matthew",
//     "customersNumber": "3254236"
// }

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _productType = TextEditingController();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _temperatureRange = TextEditingController();
  final TextEditingController _collectionLocation = TextEditingController();
  final TextEditingController _deliveryLocation = TextEditingController();
  final TextEditingController _customersName = TextEditingController();
  final TextEditingController _customersContact = TextEditingController();

  Future<void> _submitOrder(String token) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      const String apiUrl =
          'http://localhost:3001/orders/'; // Replace with your Node.js server URL
      final Map<String, dynamic> data = {
        'companyName': _companyName.text,
        'productType': _productType.text,
        'productName': _productName.text,
        'tempRange': _temperatureRange.text,
        'pickupLocation': _collectionLocation.text,
        'dropoffLocation': _deliveryLocation.text,
        'customersName': _customersName.text,
        'customersNumber': _customersContact.text,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Order submitted successfully.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrdersPage(
                          token: token,
                        ),
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        // Successful submission
        // You can display a success message or navigate to a success page
        print('Data submitted successfully');
        print('Response body: ${response.body}');
      } else {
        // Handle errors, e.g., display an error message to the user
        print('Error submitting data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Cant get user info');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String usertoken = widget.token;
    // use the name passes to the homepage from the login page
    String username = widget.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
      
                  const SizedBox(
                    height: 25,
                  ),
                  //Greeting with name
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text("Welcome Back! $username", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
      
                  const SizedBox(height: 4),
      
                  //Lets order
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text("Let's create your order", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
      
                  const SizedBox(height: 25),
      
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(thickness: 4),
                  ),
      
                  const SizedBox(height: 24),
      
                  //Business Name Textfield
                  MyTextForm(
                    controller: _companyName,
                    hintText: 'Company Name',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  //Product type Textfield
                  MyTextForm(
                    controller: _productType,
                    hintText: 'Product Type',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  //Product Textfield
                  MyTextForm(
                    controller: _productName,
                    hintText: 'Product Name',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  //Temperature range Textfield
                  MyNumberfield(
                    controller: _temperatureRange,
                    hintText: 'Temperature range',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  //Collection Location Textfield
                  MyTextForm(
                    controller: _collectionLocation,
                    hintText: 'Collection location',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  //Dropoff location Textfield
                  MyTextForm(
                    controller: _deliveryLocation,
                    hintText: 'Delivery Location',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  //Customers name
                  MyTextForm(
                    controller: _customersName,
                    hintText: 'Customers Name',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  //Customers contact Textfield
                  MyNumberfield(
                    controller: _customersContact,
                    hintText: 'Customers Contact',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  // ElevatedButton(
                  //     onPressed: _submitOrder,
      
                  //       child: const Center(
                  //         child: Text(
                  //           'Create Order',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //
      
                  MyButton(
                      onTap: () {},
                      page: LoginPage(),
                      buttontext: ("Return to Login")),
      
                  const SizedBox(height: 10),
      
                  GestureDetector(
                    onTap: () {
                      _submitOrder(usertoken);
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
                          "Create Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
      
                  const SizedBox(height: 10),
      
                  //Create order
                  MyButton(
                    onTap: () {
                      _submitOrder(usertoken);
                    },
                    page: OrdersPage(token: usertoken),
                    buttontext: 'Next',
                  ),
      
                  // ElevatedButton(
                  //   onPressed: _navigateToLoginPage,
      
                  //         child: Container(
      
                  //           padding: const EdgeInsets.all(5.0),
                  //           margin: const EdgeInsets.symmetric(horizontal: 25),
      
                  //           child: const Center(
                  //             child: Text('Go to Login Page',
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
