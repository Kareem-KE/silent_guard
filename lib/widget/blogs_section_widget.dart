import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/article_service.dart';
import 'article_list_widget.dart';

class BlogsSection extends StatelessWidget {
  const BlogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: ArticleService.fetchArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF006a4e),
                strokeWidth: 4.0,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error loading articles: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No articles available at the moment.'),
          );
        } else {
          return ArticleListWidget(articles: snapshot.data!);
        }
      },
    );
  }
}
