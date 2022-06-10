import 'package:best_architecture_challenge/src/model/post.dart';
import 'package:best_architecture_challenge/src/provider/rest_provider.dart';

abstract class Repository {
  Future<List<Post>> getPostList();
}

class RepositoryImp extends Repository {
  final RestProvider _provider;

  RepositoryImp(this._provider);

  @override
  Future<List<Post>> getPostList() => _provider.getPostList();
}
