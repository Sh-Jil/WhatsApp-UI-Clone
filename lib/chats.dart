import 'package:flutter/material.dart';
import 'package:whatsappui/Methods/samplemessage.dart';
import 'package:whatsappui/chatscreen.dart';
import 'dart:math';

import 'package:whatsappui/main.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

randomGen(min, max) {
  var x = Random().nextInt(max) + min;
  return x.floor();
}

var hr = randomGen(1, 12);
var mi = randomGen(01, 59);
var cl = ['am', 'pm'];
var ti = cl[Random().nextInt(cl.length)];

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            ChatScreen(name: "Person $index"))));
                  },
                  title: Text("Person $index",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      )),
                  subtitle: Text(
                      messageList.value[messageList.value.length - 1].message),
                  trailing: Text("$hr:$mi $ti",
                      style:
                          TextStyle(color: Colors.grey[700], fontSize: 14.0)),
                  leading: MaterialButton(
                    padding: const EdgeInsets.all(1.0),
                    height: 1.0,
                    minWidth: 1.0,
                    elevation: 0,
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage('assets/images/images.jfif'),
                    ),
                  ),
                ),
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
              );
            },
            itemCount: 50),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colour,
        onPressed: () {},
        child: const Icon(Icons.chat_rounded),
      ),
    );
  }
}
