class ArticleRecord {
  int articleId;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;

  ArticleRecord(
      {required this.articleId,
      required this.author,
      required this.title,
      required this.url,
      required this.description,
      required this.content,
      required this.urlToImage,
      required this.publishedAt});

  Map<String, dynamic> mapArticles() {
    return {
      'articleId': articleId,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
      'publishedAt': publishedAt
    };
  }

  String toString() {
    return 'ArticleRecord{articleID: $articleId, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, content: $content, publishedAt: $publishedAt}';
  }
}
