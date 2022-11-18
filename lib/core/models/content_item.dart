class ContentItem<T> {
  T content;
  ContentType type;
  DateTime publishDate;
  ContentItem({required this.content, required this.type, required this.publishDate});
}

enum ContentType { post, repost, quotePost }
