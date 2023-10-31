// import 'dart:convert';

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:driver_app/pages/orders_page.dart';
import 'package:geolocator/geolocator.dart';


class LandingPage extends StatefulWidget {
  final String token;

  const LandingPage({Key? key, required this.token}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {


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
            const SizedBox(height: 50),

            const Text('Welcome Back!', style: TextStyle(fontSize: 24)),


            const SizedBox(height: 50),
            const SizedBox(height: 50),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async{
                  if (await Geolocator.isLocationServiceEnabled()) {
                    final permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.denied) {
                      final status = await Geolocator.requestPermission();
                      if (status == LocationPermission.denied) {
                        // Handle permission denied
                      }
                    }
                    // Retrieve the user's location
                    final Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high,
                    );
                    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrdersPage(token: usertoken)),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Start Delivery'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:driver_app/pages/orders_page.dart';
// import 'package:driver_app/components/gpslocation.dart';


// class LandingPage extends StatefulWidget {
//   final String token;

//   const LandingPage({Key? key, required this.token}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _LandingPage createState() => _LandingPage();
// }

// class _LandingPage extends State<LandingPage> {


//   @override
//   Widget build(BuildContext context) {
//     String usertoken = widget.token;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Welcome to My App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 50),

//             const Text('Welcome Back!', style: TextStyle(fontSize: 24)),


//             const SizedBox(height: 50),
//             const SizedBox(height: 50),

//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: ElevatedButton(
//                 onPressed: () async{
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => OrdersPage(token: usertoken)),
//                   );
//                 },
//                 child: const ListTile(
//                   leading: Icon(Icons.shopping_cart),
//                   title: Text('Start Delivery'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
