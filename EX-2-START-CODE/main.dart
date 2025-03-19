import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/providers/post_provider.dart';
import 'ui/screens/post_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: PostScreen()),
    ),
  );
}
