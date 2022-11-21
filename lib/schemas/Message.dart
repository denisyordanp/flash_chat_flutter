
class Message {

  Message._({required this.text, required this.sender});

  factory Message({String? text, String? sender}) {
    return Message._(text: text ?? "", sender: sender ?? "");
  }

  String text;
  String sender;

  Map<String, String> toMap() {
    return {
      'text': text,
      'sender': sender
    };
  }
}
