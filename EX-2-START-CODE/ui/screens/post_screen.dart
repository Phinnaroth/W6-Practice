import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostProvider postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts'), // Change title
        actions: [
          IconButton(
            onPressed: () => {postProvider.fetchAllPosts()}, // Fetch all posts
            icon: const Icon(Icons.refresh), // Change icon
          ),
        ],
      ),
      body: Center(child: _buildBody(postProvider)),
    );
  }

  Widget _buildBody(PostProvider courseProvider) {
    final allPostsValue = courseProvider.allPostsValue; // Use allPostsValue

    if (allPostsValue == null) {
      return Text('Tap refresh to display posts');
    }

    switch (allPostsValue.state) {
      case AsyncValueState.loading:
        return CircularProgressIndicator();

      case AsyncValueState.error:
        return Text('Error: ${allPostsValue.error}');

      case AsyncValueState.success:
        return ListView.builder( // Display list
          itemCount: allPostsValue.data!.length,
          itemBuilder: (context, index) {
            return PostCard(post: allPostsValue.data![index]);
          },
        );
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(post.title), subtitle: Text(post.description));
  }
}