class Message {

  Message._({required this.text, required this.sender, required this.time});

  factory Message({String? text, String? sender, int? time}) {
    return Message._(text: text ?? "", sender: sender ?? "", time: time ?? DateTime.now().millisecondsSinceEpoch);
  }

  String text;
  String sender;
  int time;

  Map<String, String> toMap() {
    return {
      'text': text,
      'sender': sender,
      'time' : time.toString()
    };
  }
}
