import 'package:flutter/foundation.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService; //declare _newsServices
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  String _language = 'en';
  String _searchIn = '';
  String _sortBy = 'publishedAt';
  List<NewsArticle> _newsArticles = [];
  String _currentCategory = 'general'; // Default category

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  String get language => _language;
  String get searchIn => _searchIn;
  String get sortBy => _sortBy;
  List<NewsArticle> get newsArticles => _newsArticles;

  NewsProvider() : _newsService = NewsService() {
    fetchNews(); // Fetch news on initialization
  }

  @override
  void dispose() {
    _newsService.dispose(); // Dispose the NewsService
    super.dispose();
  }

  void changeCategory(String category) {
    _currentCategory = category; // Change the current category
    fetchNews(); // Fetch news for the new category
  }

  void refreshNews() {
    fetchNews(); // Fetch news for the current category
  }

  // Setter methods
  void setLanguage(String language) {
    _language = language;
    fetchNews();
    notifyListeners();
  }

  void setSearchIn(String searchIn) {
    _searchIn = searchIn;
    fetchNews();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    fetchNews();
  }

  // Inside NewsProvider class
  void setLanguageAndFetchNews(String languageCode) {
    setLanguage(languageCode); // Set the language
    fetchNews(); // Fetch news articles based on the new language
    notifyListeners(); // Notify listeners to rebuild UI
  }

  Future<void> fetchNews() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      final news = await _newsService.getLatestNews(_currentCategory,
          language: _language,
          searchIn: _searchIn,
          sortBy: _sortBy); // Pass category
      _newsArticles = news;
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      _errorMessage = e.toString();
      debugPrint('Error fetching news: $e');
    }

    notifyListeners();
  }
}
