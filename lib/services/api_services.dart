import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chat_gpt_clone/models/chat_model.dart';
import 'package:chat_gpt_clone/models/models_model.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiService {
  static Future<List<ModelModels>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $OPENAI_API_KEY'});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse["error"] != null) {
        print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        log("temp $value");
      }
      return ModelModels.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // send message
  static Future<List<ChatModel>> sendMessage(
      {required String msg, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/completions"),
          headers: {
            'Authorization': 'Bearer $OPENAI_API_KEY',
            "Content-Type": "application/json"
          },
          body:
              jsonEncode({"model": modelId, "prompt": msg, "max-tokens": 100}));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse["error"] != null) {
        print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                msg: jsonResponse["choices"][index]["text"], chatIndex: 1));
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
