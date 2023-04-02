import 'package:chat_gpt_clone/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_gpt_clone/models/models_model.dart';

class ModelProvider with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo";

  // getter function
  String get getCurrentModel {
    return currentModel;
  }

  // setter function
  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelModels> modelsList = [];

  List<ModelModels> get getModelList {
    return modelsList;
  }

  Future<List<ModelModels>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
