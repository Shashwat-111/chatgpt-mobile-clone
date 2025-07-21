import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../models/chat.dart';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<String?> uploadImage(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Img = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('$baseURL/api/upload-image'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'base64': base64Img}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['url'];
      }
    } catch (e) {
      debugPrint('Image upload failed: $e');
    }
    return null;
  }



  // to get the chat preview to show in the navigation drawer
  static Future<List<ChatPreview>> fetchChats() async {
    final response = await http.get(Uri.parse('$baseURL/api/chats'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => ChatPreview.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch chats');
    }
  }

  //to fetch the full chat when clicked from the nav drawer
  static Future<Chat?> fetchChatById(String chatId) async {
    final response = await http.get(
      Uri.parse('$baseURL/api/chats/$chatId'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Chat.fromJson(json);
    } else {
      return null;
    }
  }

}