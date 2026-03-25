import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secrets.dart';

class NewsService {
  Future<List<Map<String, dynamic>>> fetchNews(String country, String domain) async {
    final url =
        "https://newsapi.org/v2/top-headlines?country=$country&category=$domain&apiKey=$newsApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data["articles"] as List).cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load news");
    }
  }
}
