import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manifestation/api.dart';

class ImageApi {
  Future<String?> generateImage(String manifest) async {
    try {
      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Api.api}',
        },
        body: jsonEncode({
          'model': "dall-e-3",
          'prompt': manifest,
          'n': 1,
          'size': '1024x1024',
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body)['data'][0]['url'];
      } else {
        final error = json.decode(response.body);
        throw Exception(
            'Failed to generate image: ${error['error']['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
