import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsappui/Methods/chatview.dart';
import 'package:whatsappui/Methods/messagesmodel.dart';
import 'package:whatsappui/Methods/samplemessage.dart';
import 'package:whatsappui/main.dart';
import 'package:image_picker/image_picker.dart';

import 'Methods/viewcontact.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  const ChatScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _istextfieldempty = ValueNotifier(true);
    final _controller = TextEditingController();
    return ValueListenableBuilder(
        valueListenable: messageList,
        builder: (context, newlist, _) {
          return Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
                leadingWidth: 20.0,
                titleSpacing: 0,
                leading: IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                    )),
                backgroundColor: colour,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        autofocus: true,
                        minWidth: 15.0,
                        padding: EdgeInsets.zero,
                        shape: const CircleBorder(),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/images.jfif'),
                        ),
                      ),
                      MaterialButton(
                          padding: const EdgeInsets.only(right: 8.0),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewContact(name: name))),
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white),
                            textAlign: TextAlign.left,
                            softWrap: true,
                          )),
                    ]),
                actions: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                  PopupMenuButton(
                      itemBuilder: (context) => <PopupMenuEntry<PopupMenuItem>>[
                            PopupMenuItem(
                              child: const Text("View contact"),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => ViewContact(
                                          name: name,
                                        ))));
                              },
                            ),
                            const PopupMenuItem(
                                child: Text("Media, links, and docs")),
                            const PopupMenuItem(child: Text("Search")),
                            const PopupMenuItem(
                                child: Text("Mute notifications")),
                            const PopupMenuItem(
                                child: Text("Disappearing messages")),
                            const PopupMenuItem(child: Text("Wallpaper")),
                            PopupMenuItem(
                                onTap: () {
                                  PopupMenuButton(
                                    itemBuilder: (context) =>
                                        <PopupMenuEntry<PopupMenuItem>>[
                                      const PopupMenuItem(
                                          child: Text("Report")),
                                      const PopupMenuItem(child: Text("Block")),
                                      const PopupMenuItem(
                                          child: Text("Clear chat")),
                                      const PopupMenuItem(
                                          child: Text("Export chat")),
                                      const PopupMenuItem(
                                          child: Text("Add shortcut"))
                                    ],
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("More"),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.grey,
                                    )
                                  ],
                                ))
                          ]),
                ],
              ),
              body: Container(
                decoration: const BoxDecoration(
                    /* color: Colors.grey */
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/8c98994518b575bfd8c949e91d20548b.jpg'),
                        fit: BoxFit.fill)),
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                          child: Chatview(
                        value: messageList,
                      )),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 56.0,
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 2.0, right: 2.0, bottom: 8.0, top: 8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: ValueListenableBuilder(
                                  valueListenable: _istextfieldempty,
                                  builder: (context, _isempty, _) {
                                    return TextField(
                                      onChanged: (value) {
                                        if (_controller.text.isNotEmpty) {
                                          _istextfieldempty.value = false;
                                        } else {
                                          _istextfieldempty.value = true;
                                        }
                                      },
                                      controller: _controller,
                                      minLines: 1,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: const TextStyle(fontSize: 20.0),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                        hintText: "Message",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        prefixIcon: IconButton(
                                          color: Colors.grey[600],
                                          iconSize: 30.0,
                                          icon: const Icon(
                                              Icons.mood_bad_outlined),
                                          onPressed: () {},
                                        ),
                                        suffixIcon: _istextfieldempty.value
                                            ? const BeforeType()
                                            : const AfterType(),
                                        suffixIconColor: Colors.grey[600],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: _istextfieldempty,
                              builder: (context, isempty, _) {
                                return FloatingActionButton(
                                  backgroundColor: colour,
                                  onPressed: () {
                                    addToMessage(_controller.text);
                                    _controller.clear();
                                    _istextfieldempty.value = true;
                                    _istextfieldempty.notifyListeners();
                                  },
                                  child: (_istextfieldempty.value)
                                      ? const Icon(Icons.mic)
                                      : const Icon(Icons.send),
                                );
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked);
        });
  }
}

class BeforeType extends StatefulWidget {
  const BeforeType({Key? key}) : super(key: key);

  @override
  State<BeforeType> createState() => _BeforeTypeState();
}

class _BeforeTypeState extends State<BeforeType> {
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final tempimage = File(image.path);
    setState(() {
      this.image = tempimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            color: Colors.grey[600],
            padding: EdgeInsets.zero,
            onPressed: () => pickImage(),
            icon: const Icon(Icons.attach_file)),
        IconButton(
            color: Colors.grey[600],
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.currency_rupee_rounded)),
        IconButton(
            color: Colors.grey[600],
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined))
      ],
    );
  }
}

class AfterType extends StatefulWidget {
  const AfterType({Key? key}) : super(key: key);

  @override
  State<AfterType> createState() => _AfterTypeState();
}

class _AfterTypeState extends State<AfterType> {
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final tempimage = File(image.path);
    setState(() {
      this.image = tempimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.grey[600],
        padding: EdgeInsets.zero,
        onPressed: () => pickImage(),
        icon: const Icon(Icons.attach_file));
  }
}

void addToMessage(String message) {
  final messages =
      Message(DateTime.now().toLocal(), message, Messagetype.sender);

  messageList.value.add(messages);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  messageList.notifyListeners();
}
