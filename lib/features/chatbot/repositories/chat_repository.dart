import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartguide_app/constants/api_paths.dart';
import 'package:smartguide_app/features/chatbot/models/models.dart';

class ChatRepository {
  final http.Client httpClient;

  const ChatRepository({
    required this.httpClient,
  });

  Future<String> sendMessage(List<Message> messages, String token) async {
    final response = await httpClient.post(
      Uri.parse(ApiPaths.momiAIApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': messages.map((message) => message.toMap()).toList(),
        'max_tokens': 200,
      }),
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body)['choices'][0]['message']['content'];
    }

    throw Exception('Failed to send your message');
  }
}
