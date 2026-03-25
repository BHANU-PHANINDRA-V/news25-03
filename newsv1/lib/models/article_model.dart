class Article {
  final String title;
  final String description;
  final String content;
  final String url;
  final String image;
  final String publishedAt;
  final Source source;

  Article({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      source: Source.fromJson(json['source'] ?? {}),
    );
  }
}

class Source {
  final String name;
  final String url;

  Source({required this.name, required this.url});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class NewsResponse {
  final int totalArticles;
  final List<Article> articles;

  NewsResponse({required this.totalArticles, required this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      totalArticles: json['totalArticles'] ?? 0,
      articles: (json['articles'] as List<dynamic>? ?? [])
          .map((a) => Article.fromJson(a))
          .toList(),
    );
  }
}