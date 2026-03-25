import 'package:flutter/foundation.dart';
import '../../models/article_model.dart';
import '../../services/news_service.dart';
import '../../utils/constants.dart';

enum NewsMode { districtOnly, categoryOnly, districtAndTopic }

class NewsProvider extends ChangeNotifier {
  final NewsService _service = NewsService();

  // State
  List<Article> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Filters
  String _selectedDistrict = AppConstants.andhraDistricts.first;
  String _selectedCategory = AppConstants.topHeadlineCategories.first['id']!;
  String _selectedTopic = AppConstants.searchTopics.first['id']!;
  NewsMode _mode = NewsMode.districtOnly;
  int _maxResults = 10;

  // Getters
  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedDistrict => _selectedDistrict;
  String get selectedCategory => _selectedCategory;
  String get selectedTopic => _selectedTopic;
  NewsMode get mode => _mode;
  int get maxResults => _maxResults;

  void setDistrict(String district) {
    _selectedDistrict = district;
    notifyListeners();
    fetchNews();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
    fetchNews();
  }

  void setTopic(String topic) {
    _selectedTopic = topic;
    notifyListeners();
    fetchNews();
  }

  void setMode(NewsMode mode) {
    _mode = mode;
    notifyListeners();
    fetchNews();
  }

  void setMaxResults(int max) {
    _maxResults = max;
    notifyListeners();
    fetchNews();
  }

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      NewsResponse response;

      switch (_mode) {
        case NewsMode.districtOnly:
          response = await _service.fetchDistrictNews(
            district: _selectedDistrict,
            max: _maxResults,
          );
          break;

        case NewsMode.categoryOnly:
          response = await _service.fetchCategoryNews(
            category: _selectedCategory,
            max: _maxResults,
          );
          break;

        case NewsMode.districtAndTopic:
          response = await _service.fetchDistrictTopicNews(
            district: _selectedDistrict,
            topic: _selectedTopic,
            max: _maxResults,
          );
          break;
      }

      _articles = response.articles;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCustom(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.searchNews(query: query, max: _maxResults);
      _articles = response.articles;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => fetchNews();
}