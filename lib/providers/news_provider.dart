import 'package:flutter/foundation.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';
import 'package:news_app/models/enums.dart';

class NewsProvider extends ChangeNotifier {
  NewsLanguage _currentLanguage = NewsLanguage.english; // Default language

  NewsLanguage get currentLanguage =>
      _currentLanguage; // Getter for currentLanguage
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
    fetchNews(_currentLanguage); // Fetch news on initialization
  }

  @override
  void dispose() {
    _newsService.dispose(); // Dispose the NewsService
    super.dispose();
  }

  void changeCategory(String category) {
    _currentCategory = category; // Change the current category
    fetchNews(_currentLanguage); // Fetch news for the new category
  }

  void refreshNews() {
    fetchNews(_currentLanguage); // Fetch news for the current category
  }

  // Setter methods
  void setLanguage(String language) {
    _language = language;
    fetchNews(_currentLanguage);
    notifyListeners();
  }

  void setSearchIn(String searchIn) {
    _searchIn = searchIn;
    fetchNews(_currentLanguage);
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    fetchNews(_currentLanguage);
  }

// Inside NewsProvider class
  void setLanguageAndFetchNews(NewsLanguage language) {
    _currentLanguage = language; // Make sure to update _currentLanguage
    _language = language.code; // Set the language code
    fetchNews(language); // Fetch news articles based on the new language
    notifyListeners(); // Notify listeners to rebuild UI
  }

  Future<void> fetchNews(NewsLanguage language) async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      final news = await _newsService.getLatestNews(_currentCategory,
          language: _language,
          searchIn: _searchIn,
          sortBy: _sortBy,
          url: language.url); // Pass category
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
