class ChatModel {
  final String msg;
  final int chatIndex;

  //constructor
  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(msg: json["msg"], chatIndex: json["chatIndex"]);
}
