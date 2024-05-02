import 'package:news_app/services/const.dart';
import 'package:news_app/services/news_service.dart';

const String _baseUrl =
    'https://newsapi.org/v2/everything'; // Ensure this is defined

enum NewsLanguage {
  arabic,
  english,
  russian,
  french,
}

extension NewsLanguageExtension on NewsLanguage {
  String get code {
    switch (this) {
      case NewsLanguage.arabic:
        return 'ar';
      case NewsLanguage.english:
        return 'en';
      case NewsLanguage.russian:
        return 'ru';
      case NewsLanguage.french:
        return 'fr';
    }
  }

  String get url {
    switch (this) {
      case NewsLanguage.arabic:
        return '$_baseUrl?language=ar&apiKey=$NEWS_API_KEY';
      case NewsLanguage.english:
        return '$_baseUrl?language=en&apiKey=$NEWS_API_KEY';
      case NewsLanguage.russian:
        return '$_baseUrl?language=ru&apiKey=$NEWS_API_KEY';
      case NewsLanguage.french:
        return '$_baseUrl?language=fr&apiKey=$NEWS_API_KEY';
    }
  }
}
