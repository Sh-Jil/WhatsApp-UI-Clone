import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsappui/main.dart';

import 'widgets/util/statuspage.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ListView(
          children: [
            ListTile(
              leading: SizedBox(
                  height: 52.0,
                  width: 52.0,
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 25.0,
                        backgroundImage:
                            AssetImage('assets/images/images.jfif'),
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          height: 28.0,
                          width: 28.0,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              shape: BoxShape.circle),
                          child: Center(
                            child: FloatingActionButton(
                              elevation: 0.0,
                              backgroundColor: colour,
                              onPressed: () {},
                              child: const Icon(
                                Icons.add,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              title: const Text(
                "My status",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              subtitle: const Text(
                "Tap to add status update",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Recent updates",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            ListView.separated(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final hour = 1 + Random().nextInt(12 - 1);
                  final minute = 10 + Random().nextInt(59 - 10);

                  return ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewStatusPage(
                              name: "Person $index",
                              time: "Today, $hour:$minute am",
                            ))),
                    leading: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 3.0, color: Colors.greenAccent),
                          shape: BoxShape.circle),
                      child: const CircleAvatar(
                        radius: 25.0,
                        backgroundImage:
                            AssetImage('assets/images/images.jfif'),
                      ),
                    ),
                    title: Text("Person $index",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.0,
                        )),
                    subtitle: Text("Today, $hour:$minute am"),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.white,
                    ),
                itemCount: 50),
          ],
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Column(
            children: [
              FloatingActionButton.small(
                heroTag: "smallbutton",
                backgroundColor: Colors.grey[500],
                elevation: 16.0,
                onPressed: () {},
                child: const Icon(
                  Icons.edit,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                child: FloatingActionButton(
                  heroTag: "mainbuttton",
                  backgroundColor: colour,
                  elevation: 16.0,
                  onPressed: () {},
                  child: const Icon(Icons.photo_camera),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
