import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architecture/src/dependency_injection/dependency_injection.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  await injectDependencies();

  runApp(
    MaterialApp(
      home: TopNews(),
    ),
  );
}

class TopNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..loadTopNews(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top news'),
        ),
        body: BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
          if (state is NewsLoadCompleteState) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, int index) {
                return _ListItem(article: state.news[index]);
              },
            );
          } else if (state is NewsErrorState) {
            return Text(state.message);
          }
          return Center(child: CircularProgressIndicator());
        }),
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
    return GestureDetector(
      onTap: () => launch(article.url),
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            article.urlToImage == null
                ? Container(color: Colors.red, height: 250)
                : CachedNetworkImage(
                    imageUrl: article.urlToImage!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
            Text(
              '${article.title}',
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('${article.description}', maxLines: 3),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
