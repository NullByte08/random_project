
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:random_project/models/random_api_response_model.dart';
import 'package:http/http.dart' as http;

class ApplicationModel extends ChangeNotifier{

  Future<List<OneJSONModel>> getResponse() async{
    print("application_model.dart: getReposne() called");
    var response =  await http.get(Uri.https("jsonplaceholder.typicode.com", "/albums/1/photos"));

    print("application_model.dart: response body: ${response.body} response code: ${response.statusCode}");
    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      List<OneJSONModel> listOfOJM = [];
      for (var element in list) {
        listOfOJM.add(OneJSONModel.fromJson(element));
      }
      print("application_model.dart: listOfOJM: ${listOfOJM}");
      return listOfOJM;
    }
    else{
      throw Exception("Couldnt fetch");
    }
  }
}