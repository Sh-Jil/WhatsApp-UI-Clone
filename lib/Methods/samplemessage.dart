import 'package:flutter/widgets.dart';

import 'messagesmodel.dart';

ValueNotifier<List<Message>> messageList = ValueNotifier([
  Message(DateTime.parse('2022-05-16 213939.333741'), "hello",
      Messagetype.receiver),
  Message(
      DateTime.parse('2022-05-17 214039.333741'), "poda", Messagetype.receiver),
  Message(
      DateTime.parse('2022-05-17 214039.33855'), "nothind", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(DateTime.parse('2022-05-16 213939.333741'), "Where are you now?",
      Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
  Message(DateTime.parse('2022-05-16 213939.333741'),
      "what are you doing right now?", Messagetype.sender),
  Message(
      DateTime.parse('2022-05-16 213939.333741'), "hello", Messagetype.sender),
].toList());
