import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart' show rootBundle; // <-- Import rootBundle';

class MaproutePage extends StatefulWidget {
  const MaproutePage({Key? key}) : super(key: key);

  @override
  _MaprouteState createState() => _MaprouteState();
}

class _MaprouteState extends State<MaproutePage> {
  String htmlContent = "";

  @override
  void initState() {
    super.initState();
    loadFileContent();
  }

  Future<String?> readFile() async {
    try {
      // Get the directory for the app's documents
      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${appDocumentsDirectory.path}/content.txt';

      // Read the file
      File file = File(filePath);
      String fileContent = await file.readAsString();

      return fileContent;
    } catch (e) {
      print('Error reading file: $e');
      return null;
    }
  }

  Future<String?> loadFileContent() async {
  try {
    String fileContent = await rootBundle.loadString('assets/content.txt');
    return fileContent;
  } catch (e) {
    print('Error loading file from assets: $e');
    return null;
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTML Viewer'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Html(data: htmlContent),

          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart' show rootBundle; // <-- Import rootBundle';

// class MaproutePage extends StatefulWidget {
//   const MaproutePage({Key? key}) : super(key: key);

//   @override
//   _MaprouteState createState() => _MaprouteState();
// }

// class _MaprouteState extends State<MaproutePage> {
//   String htmlContent = "";

//   @override
//   void initState() {
//     super.initState();
//     loadFileContent();
//   }

//   Future<String?> readFile() async {
//     try {
//       // Get the directory for the app's documents
//       Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
//       String filePath = '${appDocumentsDirectory.path}/content.txt';

//       // Read the file
//       File file = File(filePath);
//       String fileContent = await file.readAsString();

//       return fileContent;
//     } catch (e) {
//       print('Error reading file: $e');
//       return null;
//     }
//   }

//   Future<String?> loadFileContent() async {
//   try {
//     String fileContent = await rootBundle.loadString('assets/content.txt');
//     return fileContent;
//   } catch (e) {
//     print('Error loading file from assets: $e');
//     return null;
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('HTML Viewer'),
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Html(data: htmlContent),

//           ),
//         ),
//       ),
//     );
//   }
// }



  




































//  htmlContent.isEmpty
//               ? CircularProgressIndicator() // Display a loading indicator
//               : Html(data: htmlContent), // Display HTML content on the screen




  




































//  htmlContent.isEmpty
//               ? CircularProgressIndicator() // Display a loading indicator
//               : Html(data: htmlContent), // Display HTML content on the screen
