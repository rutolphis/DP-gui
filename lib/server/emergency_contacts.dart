import 'package:dio/dio.dart';
import 'package:gui_flutter/models/contact.dart';
import 'package:gui_flutter/server/server.dart';

import '../models/emergency_contacts.dart';

class EmergencyContactsApi extends ApiService {
  Future<List<Contact>?> fetchEmergencyContacts(String? vin) async {
    try {
      var results = await dio.get('$baseUrl/emergency-contacts/$vin');
      print(results.data["contacts"]);  // This prints correctly

      List<Contact> contacts = [];
      if (results.data["contacts"] != null) {
          contacts = (results.data["contacts"] as List).map((i) => Contact.fromJson(i)).toList();
      } else {
        print("No contacts found");
      }
      return contacts;
    } on DioException catch (e) {
      print('Dio Error: ${e.response?.statusCode} ${e.response?.data}');
    } catch (e) {
      print('Error occurred: $e');
    }
    return [];
  }

  Future<bool> updateEmergencyContacts(String vin, List<Contact> contacts) async {
    try {
      await dio.post('$baseUrl/emergency-contacts', data: {
        'vin': vin,
        'contacts': contacts.map((contact) => contact.toJson()).toList(),
      });
      return true;
    } on DioException catch (e) {
      print('Error updating contacts: ${e.response?.statusCode} ${e.response?.data}');
      return false;
    }
  }
}
