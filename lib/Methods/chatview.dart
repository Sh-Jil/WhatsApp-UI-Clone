import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:whatsappui/Methods/messagesmodel.dart';

class Chatview extends StatelessWidget {
  final ValueNotifier value;
  const Chatview({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Message, DateTime>(
      floatingHeader: true,
      reverse: true,
      order: GroupedListOrder.DESC,
      itemComparator: (item1, item2) => item1.time.compareTo(item2.time),
      padding: const EdgeInsets.all(8.0),
      elements: value.value,
      groupBy: (element) => DateTime(element.time.year.toInt(),
          element.time.month.toInt(), element.time.day.toInt()),
      groupHeaderBuilder: (Message groupByvalue) {
        if (DateFormat("dd MMMM y")
                .format(DateTime.parse(groupByvalue.time.toString())) ==
            DateFormat("dd MMMM y").format(DateTime.now())) {
          return SizedBox(
              height: 40.0,
              child: Center(
                child: Card(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Today',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ));
        } else if (DateFormat("dd MMMM y")
                .format(DateTime.parse(groupByvalue.time.toString())) ==
            DateFormat("dd MMMM y")
                .format(DateTime.now().subtract(const Duration(days: 1)))) {
          return SizedBox(
              height: 40.0,
              child: Center(
                child: Card(
                    color: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Yesterday',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ));
        } else {
          return SizedBox(
            height: 40,
            child: Center(
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      DateFormat("dd MMMM y")
                          .format(DateTime.parse(groupByvalue.time.toString())),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
          );
        }
      },
      itemBuilder: (context, element) {
        final int length = element.message.length;
        return ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 100.0,
              minHeight: 40.0,
              maxWidth: MediaQuery.of(context).size.width * 0.80),
          child: Align(
            alignment: (element.messagetype == Messagetype.receiver)
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: Card(
                margin: const EdgeInsets.all(8.0),
                color: (element.messagetype == Messagetype.receiver)
                    ? Colors.white
                    : const Color(0xffdcf8c6),
                shape: (element.messagetype == Messagetype.receiver)
                    ? const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)))
                    : const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0))),
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: (length > 25)
                        ? Stack(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 5.0, 30.0, 20.0),
                                child: Text(
                                  element.message,
                                  style: const TextStyle(fontSize: 16.0),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat.jm()
                                          .format(element.time)
                                          .toLowerCase(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey[800]),
                                    ),
                                    if (element.messagetype ==
                                        Messagetype.receiver) ...[
                                      Container()
                                    ] else ...[
                                      const Icon(
                                        Icons.done_all_rounded,
                                        size: 16.0,
                                        color: Colors.blue,
                                      )
                                    ]
                                  ],
                                ),
                              )
                            ],
                          )
                        : Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 5.0, 70.0, 8.0),
                                child: Text(
                                  element.message,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 1.0,
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat.jm()
                                          .format(element.time)
                                          .toLowerCase(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey[800]),
                                    ),
                                    if (element.messagetype ==
                                        Messagetype.receiver) ...[
                                      Container()
                                    ] else ...[
                                      const Icon(
                                        Icons.done_all_rounded,
                                        size: 16.0,
                                        color: Colors.blue,
                                      )
                                    ]
                                  ],
                                ),
                              )
                            ],
                          ))),
          ),
        );
      },
    );
  }
}
