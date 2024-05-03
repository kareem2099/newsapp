class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String content;

  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.publishedAt,
    required this.content,
  });

  // Factory constructor for creating a new NewsArticle instance from a map
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description available',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      publishedAt:
          json['publishedAt'] ?? 'Unknown date', // Parse publishedAt from json
      content:
          json['content'] ?? 'Content not available', // Parse content from json
    );
  }
}
