import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/navigation/routes.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';

class NewsScreen extends StatelessWidget {
  static Widget create(BuildContext context) {
    /// Inyectamos el Cubit al Widget NewsScreen
    return BlocProvider<NewsCubit>(
      /// Inicializamos el cubit y cargamos las noticias
      create: (_) => NewsCubit(context.read<NewsRepositoryBase>())..loadTopNews(),
      child: NewsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadCompleteState) {
            /// Cuando las noticias cargaron exitosamente
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (_, int index) => _ListItem(article: state.news[index]),
            );
          } else if (state is NewsErrorState) {
            /// Cuando hubo un error al cargas las noticias
            return Text(state.message);
          } else {
            /// Cuando estamos cargando las noticias
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.newsDetails, arguments: article),
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
