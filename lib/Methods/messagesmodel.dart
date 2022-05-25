enum Messagetype { sender, receiver }

class Message {
  final DateTime time;
  final String message;
  final Messagetype messagetype;

  Message(this.time, this.message, this.messagetype);
}
