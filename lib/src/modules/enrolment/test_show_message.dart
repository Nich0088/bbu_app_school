import 'package:flutter/material.dart';

class TaskShowMessage extends StatefulWidget {
  const TaskShowMessage({super.key});

  @override
  State createState() => _TaskShowMessageState();
}

class _TaskShowMessageState extends State<TaskShowMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Show Message"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text("Show Message"),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.lightBlueAccent,
            ),
            child: const Text(
              'Show Message',
              style: TextStyle(fontSize: 30),
            ),
            onPressed: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          child: TextButton(
                        child: const Text("must_login"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ));
                    });
              });
            },
          )
        ],
      ),
    );
  }
}
