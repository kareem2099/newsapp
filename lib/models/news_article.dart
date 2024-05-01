class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt; // Add this property
  final String content; // Add this property

  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt, // Add this parameter
    required this.content, // Add this parameter
  });

  // Factory constructor for creating a new NewsArticle instance from a map
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description available',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '', // Parse publishedAt from json
      content: json['content'] ?? '', // Parse content from json
    );
  }
}
