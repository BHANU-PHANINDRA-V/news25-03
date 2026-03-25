import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';
import '../utils/constants.dart';

class NewsService {
  static const String _baseUrl = AppConstants.baseUrl;
  static const String _apiKey = AppConstants.apiKey;

  /// Fetch top headlines by category (uses /top-headlines endpoint)
  /// Categories: general, world, nation, business, technology, entertainment, sports, science, health
  Future<NewsResponse> fetchTopHeadlines({
    String category = 'general',
    String lang = 'en',
    String country = 'in',
    int max = 10,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/top-headlines?category=$category&lang=$lang&country=$country&max=$max&apikey=$_apiKey',
    );

    return _fetchNews(uri);
  }

  /// Search news by district name (uses /search endpoint)
  Future<NewsResponse> fetchDistrictNews({
    required String district,
    String lang = 'en',
    int max = 10,
    String? from,
    String? to,
    String sortBy = 'publishedAt',
  }) async {
    final query = Uri.encodeComponent('"$district" "Andhra Pradesh"');
    String url =
        '$_baseUrl/search?q=$query&lang=$lang&max=$max&sortby=$sortBy&apikey=$_apiKey';
    if (from != null) url += '&from=$from';
    if (to != null) url += '&to=$to';

    return _fetchNews(Uri.parse(url));
  }

  /// Search news by district + topic (uses /search endpoint)
  Future<NewsResponse> fetchDistrictTopicNews({
    required String district,
    required String topic,
    String lang = 'en',
    int max = 10,
    String sortBy = 'publishedAt',
  }) async {
    final query = Uri.encodeComponent('"$district" $topic');
    final url =
        '$_baseUrl/search?q=$query&lang=$lang&max=$max&sortby=$sortBy&apikey=$_apiKey';

    return _fetchNews(Uri.parse(url));
  }

  /// Fetch top-headlines category + district context via search
  Future<NewsResponse> fetchCategoryNews({
    required String category,
    String lang = 'en',
    String country = 'in',
    int max = 10,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/top-headlines?category=$category&lang=$lang&country=$country&max=$max&apikey=$_apiKey',
    );
    return _fetchNews(uri);
  }

  /// Search any keyword (generic search endpoint)
  Future<NewsResponse> searchNews({
    required String query,
    String lang = 'en',
    int max = 10,
    String sortBy = 'relevance',
    String? from,
    String? to,
  }) async {
    final encodedQuery = Uri.encodeComponent(query);
    String url =
        '$_baseUrl/search?q=$encodedQuery&lang=$lang&max=$max&sortby=$sortBy&apikey=$_apiKey';
    if (from != null) url += '&from=$from';
    if (to != null) url += '&to=$to';

    return _fetchNews(Uri.parse(url));
  }

  Future<NewsResponse> _fetchNews(Uri uri) async {
    try {
      final response = await http.get(uri).timeout(
            const Duration(seconds: 15),
          );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return NewsResponse.fromJson(json);
      } else if (response.statusCode == 403) {
        throw Exception('Invalid API key or access denied.');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Try again later.');
      } else {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}