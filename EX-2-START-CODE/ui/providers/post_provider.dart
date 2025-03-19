// post_provider.dart

import 'package:flutter/material.dart';
import '../../model/post.dart';
import '../../repository/http_posts_repository.dart';
import 'async_value.dart';

class PostProvider extends ChangeNotifier {
  final HttpPostsRepository _postsRepository = HttpPostsRepository();

  AsyncValue<Post>? postValue;
  AsyncValue<List<Post>>? allPostsValue; // Add this

  void fetchPost(int postId) async {
    postValue = AsyncValue.loading();
    notifyListeners();

    try {
      Post post = await _postsRepository.getPost(postId);
      postValue = AsyncValue.success(post);
    } catch (error) {
      postValue = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void fetchAllPosts() async {
    allPostsValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Post> posts = await _postsRepository.fetchPosts();
      allPostsValue = AsyncValue.success(posts);
    } catch (error) {
      allPostsValue = AsyncValue.error(error);
    }

    notifyListeners();
  }
}