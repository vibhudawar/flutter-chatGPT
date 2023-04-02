import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];

  // getter function
  List<ChatModel> get getChatList {
    return chatList;
  }

  // setter function
  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswersFromBot(
      {required String msg, required String chosenModelId}) async {
    chatList.addAll(await ApiService.sendMessage(
      msg: msg,
      modelId: chosenModelId,
    ));
    notifyListeners();
  }
}
