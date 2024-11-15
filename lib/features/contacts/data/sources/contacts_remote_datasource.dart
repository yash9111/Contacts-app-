import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contacts_app/features/contacts/data/models/user_model.dart';

abstract class IContactsRemoteDatasource {
  Future<List<UserModel>> getAllContacts();
}

class ContactsRemoteDatasource implements IContactsRemoteDatasource {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  @override
  Future<List<UserModel>> getAllContacts() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/users"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        return jsonData.map((user) => UserModel.fromJson(user)).toList();
      } else {
        throw Exception(
            "Failed to fetch contacts. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred while fetching contacts: $e");
    }
  }
}
