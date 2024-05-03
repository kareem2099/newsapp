import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/news_article.dart';
import 'const.dart';

class NewsService {
  static const String _baseUrl =
      'https://newsapi.org/v2/everything'; // Updated endpoint
  final Dio _dio;

  // Define your API key directly
  static const String API_KEY =
      NEWS_API_KEY; // implement your api as const.dart file

  NewsService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: (const Duration(seconds: 10)), // 10 seconds
          receiveTimeout: (const Duration(seconds: 8)), // 8 seconds
          headers: {
            'Authorization': 'Bearer $API_KEY', // Use the API key directly
          },
        ));

  Future<List<NewsArticle>> getLatestNews(String category,
      {String language = 'en',
      String searchIn = '',
      String sortBy = 'publishedAt',
      String? url}) async {
    // Add url parameter
    if (url == null) {
      throw Exception('URL cannot be null');
    }
    try {
      final response = await _dio.get(url, queryParameters: {
        // Use url parameter
        'category': category,
        'language': language,
        'q': searchIn,
        'sortBy': sortBy,
        'country': 'us', // Example, you can adjust based on your needs
      });

      if (response.statusCode == 200) {
        final articles = response.data['articles'] as List;
        return articles.map((article) {
          return NewsArticle(
            title: article['title'] ?? 'Untitled',
            description: article['description'] ?? 'No description available',
            urlToImage: article['urlToImage'] ?? '',
            publishedAt:
                article['publishedAt'] ?? '', // Parse publishedAt from json
            content: article['content'] ?? '', // Parse content from json
          );
        }).toList();
      } else {
        throw Exception(
            'Failed to load news: HTTP status ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            throw Exception('Connection timeout');
          case DioExceptionType.badResponse:
            throw Exception(
                'Received invalid status code: ${e.response?.statusCode}');
          case DioExceptionType.cancel:
            throw Exception('Request to API was cancelled');
          case DioExceptionType.unknown:
            throw Exception(e.message);
          case DioExceptionType.badCertificate:
            throw Exception('SSL/TLS certificate validation failed');
          case DioExceptionType.connectionError:
            throw Exception('Network connection error');
        }
      } else {
        throw Exception('An unexpected error occurred: $e');
      }
    }
  }

  void dispose() {
    _dio.close(); // Cancel ongoing Dio requests
  }
}
