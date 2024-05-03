import 'package:news_app/services/const.dart';
import 'package:news_app/services/news_service.dart';

// const String _baseUrl =
//     'https://newsapi.org/v2/everything'; // Ensure this is defined

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
        return 'https://newsapi.org/v2/top-headlines?country=eg&language=ar&apiKey=6111b98cef8d4f0bb16e78d0628641db';
      case NewsLanguage.english:
        return 'https://newsapi.org/v2/top-headlines?country=us&language=en&apiKey=6111b98cef8d4f0bb16e78d0628641db';
      case NewsLanguage.russian:
        return 'https://newsapi.org/v2/top-headlines?country=ru&language=ru&apiKey=6111b98cef8d4f0bb16e78d0628641db';
      case NewsLanguage.french:
        return 'https://newsapi.org/v2/top-headlines?country=fr&language=fr&apiKey=6111b98cef8d4f0bb16e78d0628641db';
    }
  }
}
