import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageApi {
  Future<String> generateImage(String manifest) async {
    try {
      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_API_KEY',
        },
        body: jsonEncode({
          'model': "dall-e-3",
          'prompt': manifest,
          'n': 1,
          'size': '1024x1024',
          'quality': "standart"
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['data'][0]['url'];
      } else {
        throw Exception('Failed to generate image');
      }
    } catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
      throw Exception('Failed to generate image');
    }
  }
}
