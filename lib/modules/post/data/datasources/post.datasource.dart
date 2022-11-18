import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';

abstract class IPostDatasource {
  Future<List<Post>> getPosts();
  Future<List<Repost>> getReposts();
  Future<List<QuotePost>> getQuotePosts();
  Future<bool> createPost(Post post);
  Future<bool> createRepost(Repost post);
  Future<bool> createQuotePost(QuotePost quotePost);
}

class PostDatasource implements IPostDatasource {
  Box<Post> postsBox;
  Box<Repost> repostBox;
  Box<QuotePost> quotePostsBox;
  PostDatasource(this.postsBox, this.repostBox, this.quotePostsBox);

  @override
  Future<List<Post>> getPosts() async {
    try {
      await Future.delayed(const Duration(microseconds: 300));
      List<Post> posts = [];
      final result = postsBox.values;
      posts.addAll(result);
      return posts;
    } catch (e) {
      throw PostException(message: e.toString());
    }
  }

  @override
  Future<bool> createPost(Post post) async {
    try {
      postsBox.add(post);
      return true;
    } catch (e) {
      throw PostException(message: e.toString());
    }
  }

  @override
  Future<bool> createRepost(Repost repost) async {
    try {
      repostBox.add(repost);
      return true;
    } catch (e) {
      throw RepostException(message: e.toString());
    }
  }

  @override
  Future<bool> createQuotePost(QuotePost quotePost) async {
    try {
      quotePostsBox.add(quotePost);
      return true;
    } catch (e) {
      throw RepostException(message: e.toString());
    }
  }

  @override
  Future<List<Repost>> getReposts() async {
    try {
      await Future.delayed(const Duration(microseconds: 300));
      final List<Repost> result = repostBox.values.toList();
      return result;
    } catch (e) {
      throw PostException(message: e.toString());
    }
  }

  @override
  Future<List<QuotePost>> getQuotePosts() async {
    try {
      await Future.delayed(const Duration(microseconds: 300));
      final List<QuotePost> result = quotePostsBox.values.toList();
      return result;
    } catch (e) {
      throw QuotePostException(message: e.toString());
    }
  }
}
