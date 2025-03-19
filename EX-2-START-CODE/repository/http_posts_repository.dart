// http_posts_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart'; // Adjust path as needed

class HttpPostsRepository {
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> getPost(int postId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post with ID $postId');
    }
  }
}