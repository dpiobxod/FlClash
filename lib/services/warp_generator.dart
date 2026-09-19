import 'package:http/http.dart' as http;
import 'dart:convert';

class WarpGenerator {
  static const String _regUrl = 'https://api.cloudflareclient.com/v0i190905000/reg';

  static Future<Map<String, dynamic>> _fetchWarpProfile() async {
    final response = await http.post(
      Uri.parse(_regUrl),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'okhttp/3.12.1',
      },
      body: jsonEncode({
        "install_id": "",
        "tos": DateTime.now().toIso8601String(),
        "model": "QUCI Tactical Client",
        "type": "Android",
        "locale": "ru_RU"
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final config = data['result']['config'];
      return {
        "private_key": config['private_key'],
        "ipv4": config['interface']['addresses']['v4'],
        "ipv6": config['interface']['addresses']['v6'],
      };
    } else {
      throw Exception('Ошибка регистрации WARP: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> generateWarpInWarp() async {
    final outer = await _fetchWarpProfile();
    final inner = await _fetchWarpProfile();
    return {
      "outer": outer,
      "inner": inner,
    };
  }
}

