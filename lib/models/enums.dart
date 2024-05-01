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
}
