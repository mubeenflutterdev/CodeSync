// ignore_for_file: avoid_print

import 'package:codesync/model/api_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  List<ApiModel> dataList = [];
  bool isLoading = false;
  Future getApiData() async {
    try {
      isLoading = true;
      notifyListeners();
      final request = await http.get(
        Uri.parse('https://6838ac636561b8d882ade978.mockapi.io/social/todo'),
      );
      if (request.statusCode == 200) {
        print('Api Called Sucessfully');
        dataList.clear();
        List<dynamic> jsonData = jsonDecode(request.body);
        dataList = jsonData.map((e) => ApiModel.fromJson(e)).toList();
        notifyListeners();
      } else {
        print(
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        );
        print(request.statusCode.toString());
      }
    } catch (e) {
      print('eror is here form api calling');
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
