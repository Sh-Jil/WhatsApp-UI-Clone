import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsappui/main.dart';

class ViewContact extends StatefulWidget {
  final String name;
  const ViewContact({Key? key, required this.name}) : super(key: key);

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  bool _toggle = true;
  late ScrollController _scrollController;
  bool lastStatus = true;
  var top = 0.0;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients && _scrollController.offset > 100;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int next(int min, int max) => min + Random().nextInt(max - min);
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
            pinned: true,
            floating: true,
            actions: [
              PopupMenuButton(
                  icon: Icon(Icons.more_vert,
                      color: isShrink ? Colors.white : Colors.grey),
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      const PopupMenuItem(child: Text("Share")),
                      const PopupMenuItem(child: Text("Edit")),
                      const PopupMenuItem(child: Text("View in address book")),
                      const PopupMenuItem(child: Text("Verify security code"))
                    ];
                  })
            ],
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: isShrink ? Colors.white : Colors.grey,
                )),
            backgroundColor: colour,
            expandedHeight: 150.0,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              top = constraints.biggest.height;

              return FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(
                    right: 100.0, left: 50.0, top: 8.0, bottom: 8.0),
                background: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: const Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/images.jfif'),
                    ),
                  ),
                ),
                title: AnimatedOpacity(
                  opacity: top <= 100 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                            AssetImage('assets/images/images.jfif'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          widget.name,
                        ),
                      )
                    ],
                  ),
                ),
                centerTitle: true,
              );
            })),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.name,
                        style: const TextStyle(color: Colors.black, fontSize: 22.0)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "+91 ${next(8700000000, 9999999999)}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.call,
                              size: 30.0,
                              color: Color(0xff128C7E),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Audio",
                              style: TextStyle(
                                  color: Color(0xff128C7E), fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.videocam,
                              size: 30.0,
                              color: Color(0xff128C7E),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Video",
                              style: TextStyle(
                                  color: Color(0xff128C7E), fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.search,
                              size: 30.0,
                              color: Color(0xff128C7E),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                  color: Color(0xff128C7E), fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.currency_rupee,
                              size: 30.0,
                              color: Color(0xff128C7E),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Pay",
                              style: TextStyle(
                                  color: Color(0xff128C7E), fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      Container(
                        color: Colors.white,
                        child: const Card(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          shape: ContinuousRectangleBorder(),
                          child: ListTile(
                              trailing: Icon(Icons.chevron_right),
                              title: Text("Media, links, and docs",
                                  style: TextStyle(fontSize: 17.0)),
                              tileColor: Colors.white),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffFFFFFF)),
                          color: Colors.white,
                        ),
                        child: Card(
                          shape: const ContinuousRectangleBorder(),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.notifications),
                                title: const Text(
                                  "Mute notifications",
                                  style: TextStyle(fontSize: 17.0),
                                ),
                                trailing: Switch(
                                    inactiveTrackColor: Colors.grey[200],
                                    inactiveThumbColor: Colors.grey,
                                    activeColor: const Color(0xff128C7E),
                                    value: _toggle,
                                    onChanged: (value) => setState(() {
                                          _toggle = value;
                                        })),
                              ),
                              const ListTile(
                                  leading: Icon(Icons.music_note),
                                  title: Text(
                                    "Custom notificaitons",
                                    style: TextStyle(fontSize: 17.0),
                                  )),
                              const ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text(
                                    "Media visibility",
                                    style: TextStyle(fontSize: 17.0),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffFFFFFF)),
                          color: Colors.white,
                        ),
                        child: Card(
                            shape: const ContinuousRectangleBorder(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                ListTile(
                                  isThreeLine: true,
                                  leading: Icon(Icons.lock),
                                  title: Text(
                                    "Encryption",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  subtitle: Text(
                                    "Messages and calls are end-to-end encrypted. Tap to verify.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.history_toggle_off),
                                  title: Text("Disappearing messages",
                                      style: TextStyle(fontSize: 17.0)),
                                  subtitle: Text("Off",
                                      style: TextStyle(fontSize: 16.0)),
                                )
                              ],
                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffFFFFFF)),
                            color: Colors.white,
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    Icons.block,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    'Block ${widget.name}',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 17.0),
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.thumb_down,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    'Report ${widget.name}',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 17.0),
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
