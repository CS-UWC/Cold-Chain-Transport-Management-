import 'package:flutter/material.dart';

class MessageButton extends StatelessWidget {
  final Function()? onTap;
  final String buttontext;


  const MessageButton({super.key, required this.onTap, required this.buttontext});

  void _showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message'),
          content: Text(buttontext),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showMessageDialog(context);
      },
      child: Text('Show Message'),
    );
  }


}
