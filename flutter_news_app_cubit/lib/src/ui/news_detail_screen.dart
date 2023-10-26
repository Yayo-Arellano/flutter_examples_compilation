import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/extension/context_extension.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:flutter_news_app_cubit/src/ui/molecules/details_widget.dart';

typedef NewsDetailScreenArgs = ({Article article});

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = context.args<NewsDetailScreenArgs>().article;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: DetailsWidget(article: article),
    );
  }
}
