import 'dart:convert';
import 'package:comfort_confy/config.dart';
import 'package:http/http.dart' as http;

class SearchUserService{
  Future<List<dynamic>> searchUsers(String nickname) async{
    final response = await http.get(
      Uri.parse('$API_BASE_URL/search?nickname=$nickname')
    );

    if (response.statusCode == 200){
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}