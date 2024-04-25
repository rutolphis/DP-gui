import 'dart:convert';

import 'package:gui_flutter/models/adress.dart';
import 'package:gui_flutter/models/personal_info.dart';
import 'package:dio/dio.dart';
import 'package:gui_flutter/server/server.dart';

class PersonalInfoApi extends ApiService {

  Future<PersonalInfo?> fetchPersonalInfo(String vin) async {
    try {
      final response = await dio.get('$baseUrl/personal-details/$vin');

      return PersonalInfo.fromJson(response.data);
    } on DioException catch (e) {
      print('Error fetching personal details: ${e.response?.statusCode} ${e.response?.data}');
      return null;
    }
  }

  Future<bool> updatePersonalInfo(PersonalInfo details, String vin) async {
    try {
      Map<String, dynamic> personJson = details.toJson();
      personJson["vin"] = vin;
      print(personJson);
      await dio.post('$baseUrl/personal-details', data: personJson);
      return true;
    } on DioException catch (e) {
      print('Error updating personal details: ${e.response?.statusCode} ${e.response?.data}');
      return false;
    }
  }
}
