import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http_unit_test/src/data_provider/news_provider.dart';
import 'package:http_unit_test/src/model/article.dart';

void main() async {
  final newsProvider = NewsProvider();

  runApp(MyApp(newsProvider: newsProvider));
}

class MyApp extends StatelessWidget {
  final NewsProvider newsProvider;

  const MyApp({
    Key? key,
    required this.newsProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit testing https request',
      home: TopNews(newsProvider: newsProvider),
    );
  }
}

class TopNews extends StatelessWidget {
  final NewsProvider newsProvider;

  const TopNews({
    Key? key,
    required this.newsProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: FutureBuilder<List<Article>>(
        future: newsProvider.topHeadlines('us'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (snapshot.error is MissingApiKeyException) {
              return const Center(child: Text('Api key is missing'));
            } else if (snapshot.error is ApiKeyInvalidException) {
              return const Center(child: Text('Api key is not valid'));
            }
            return const Center(child: Text('Unknown error'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, int index) => _ListItem(article: snapshot.data![index]),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final Article article;

  const _ListItem({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          article.urlToImage == null
              ? Container(color: Colors.red, height: 250)
              : CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
          Text(
            '${article.title}',
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text('${article.description}', maxLines: 3),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
