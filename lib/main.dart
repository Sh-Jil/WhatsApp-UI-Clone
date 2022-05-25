import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whatsappui/calls.dart';
import 'package:whatsappui/camera.dart';
import 'package:whatsappui/chats.dart';
import 'package:whatsappui/status.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

var colour = const Color(0xff075E54);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Helvetica'),
        themeMode: ThemeMode.light,
        home: DefaultTabController(
          initialIndex: 1,
          length: 4,
          child: Builder(builder: (context) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                    snap: true,
                    pinned: true,
                    floating: true,
                    title: const Text(
                      "WhatsApp",
                      style: TextStyle(letterSpacing: 1.0),
                    ),
                    backgroundColor: colour,
                    actions: [
                      MaterialButton(
                          minWidth: 1.0,
                          onPressed: () {},
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                      PopupMenuButton(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: const Icon(Icons.more_vert),
                          itemBuilder: (context) {
                            final currentindex =
                                DefaultTabController.of(context)?.index;
                            if (currentindex == 1) {
                              return <PopupMenuEntry>[
                                const PopupMenuItem(
                                    child: Text("New group",
                                        style: TextStyle(letterSpacing: 0.3))),
                                const PopupMenuItem(
                                    child: Text("New broadcast",
                                        style: TextStyle(letterSpacing: 0.3))),
                                const PopupMenuItem(
                                    child: Text("Linked devices",
                                        style: TextStyle(letterSpacing: 0.3))),
                                const PopupMenuItem(
                                    child: Text("Starred messages",
                                        style: TextStyle(letterSpacing: 0.3))),
                                const PopupMenuItem(
                                    child: Text("Payments",
                                        style: TextStyle(letterSpacing: 0.3))),
                                const PopupMenuItem(
                                    child: Text("Settings",
                                        style: TextStyle(letterSpacing: 0.3)))
                              ];
                            } else if (currentindex == 2) {
                              return <PopupMenuEntry<PopupMenuItem>>[
                                const PopupMenuItem(
                                    child: Text("Status privacy")),
                                const PopupMenuItem(child: Text("Settings")),
                              ];
                            } else {
                              return <PopupMenuEntry<PopupMenuItem>>[
                                const PopupMenuItem(
                                    child: Text("Clear call log")),
                                const PopupMenuItem(child: Text("Settings")),
                              ];
                            }
                          }),
                    ],
                    bottom: const TabBar(
                        dragStartBehavior: DragStartBehavior.start,
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(
                            iconMargin: EdgeInsets.only(left: 1.0, right: 1.0),
                            icon: Icon(Icons.photo_camera),
                          ),
                          Tab(child: Text("CHATS")),
                          Tab(child: Text("STATUS")),
                          Tab(child: Text("CALLS"))
                        ]))
              ],
              body: const TabBarView(
                  dragStartBehavior: DragStartBehavior.start,
                  children: [Camera(), Chats(), Status(), Calls()]),
            );
          }),
        ));
  }
}
