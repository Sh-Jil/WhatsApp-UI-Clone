import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsappui/main.dart';

class Calls extends StatefulWidget {
  const Calls({Key? key}) : super(key: key);

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  List newlist = [
    'Today',
    'Today',
    'Today',
    'Yesterday',
    'Yesterday',
    'Yesterday',
    '16 May',
    '16 May',
    '16 May',
    '11 May',
    '11 May',
    '11 May',
    '8 May',
    '8 May',
    '8 May',
    '7 May',
    '7 May',
    '7 May',
    '6 May',
    '6 May',
    '6 May',
    '30 April',
    '30 April',
    '30 April',
    '21 April',
    '21 April',
    '21 April',
    '14 April',
    '14 April',
    '14 April'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) {
            List<String> calldata = ["↗ ", "↙ "];
            List<IconData> icons = [Icons.call, Icons.videocam];
            final hour = 1 + Random().nextInt(12 - 1);
            final minute = 10 + Random().nextInt(59 - 10);
            final number = 0 + Random().nextInt(50 - 0);
            var date = newlist[Random().nextInt(newlist.length)];
            var no = Random().nextInt(icons.length);

            return ListTile(
              leading: const CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('assets/images/images.jfif'),
              ),
              title: Text(
                "Person $number",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    calldata[no],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: (number % 2 == 0) ? Colors.red : Colors.green),
                  ),
                  Text("$date, $hour:$minute pm")
                ],
              ),
              trailing: Icon(
                icons[no],
                color: colour,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.white,
            );
          },
          itemCount: 30),
    );
  }
}
