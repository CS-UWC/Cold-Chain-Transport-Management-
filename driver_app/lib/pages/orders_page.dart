// import 'package:driver_app/pages/get_location.dart';
import 'package:driver_app/pages/get_location.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/model/order_model.dart';
import 'package:driver_app/components/my_button.dart';
import 'package:driver_app/pages/tomtom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {
  final String token;

  const OrdersPage({super.key, required this.token});

  @override
  // ignore: library_private_types_in_public_api
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<List<Order>>? orders; // Replace Order with your order model class

  @override
  void initState() {
    super.initState();
    // Fetch orders using the user's token
    orders = fetchOrders(widget.token);
  }

  Future<List<Order>> fetchOrders(String token) async {
    // Make an API request to get orders using the token
    // You can use the http package or your preferred method
    // Parse the response and update the 'orders' list

    const apiUrl =
        'http://localhost:3001/orders/assign'; // Replace with your API endpoint
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token', // Include the user's token
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      final List<dynamic> data = json.decode(response.body)["orders"];
      final updatedOrders = data.map((order) => Order.fromJson(order)).toList();
      return updatedOrders;
    } else {
      print(response.statusCode);
      print(response.body);
      print(widget.token);
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    // String usertoken = widget.token;
    // List<Order> orders = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders using token: '),
      ),
      body: FutureBuilder<List<Order>>(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orderList = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: 
                ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Build and display your card with order data here
                      child: ExpansionTile(
                        title: Text(orderList[index].companyName ?? 'No Name'),
                        subtitle:
                            Text(orderList[index].productName ?? 'No Product'),
                        trailing: Text(
                          orderList[index].status ?? 'No Status',
                          style: const TextStyle(color: Colors.green),
                        ),
                        children: [
                          Container(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order ID: ${orderList[index].orderId}'),
                                  Text(
                                      'Driver ID: ${orderList[index].driverId ?? 'N/A'}'),
                                  Text(
                                      'Temperature: ${orderList[index].tempRange ?? 'N/A'}'),

                                  // Add other order details as needed
                                  // MyButton(
                                  //   onTap: () {}, page: GetLocation(token: usertoken), buttontext: "Get Routes")

                                  MyButton(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LocationStreamPage()),
                                      );
                                    },
                                    page: const LocationStreamPage(),
                                    buttontext: "Get Routes"),                                  
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                    );
                  },
                ),
              
                         
            );
          }
        },
      ),
    );
  }
}
