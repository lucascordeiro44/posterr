class ContentItem<T> {
  T content;
  ContentType type;
  ContentItem({required this.content, required this.type});
}

enum ContentType { post, repost, quotePost }
