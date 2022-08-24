import 'package:best_architecture_challenge/main.dart';
import 'package:best_architecture_challenge/src/model/post.dart';
import 'package:best_architecture_challenge/src/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final Repository _repository;
  SortOptions _sortBy = SortOptions.id;

  List<Post> postList = [];

  PostCubit(this._repository) : super(PostLoading()) {
    _fetchData();
  }

  Future<void> _fetchData() async {
    emit(PostLoading());
    postList = await _repository.getPostList();
    sort(_sortBy);
  }

  void sort(SortOptions sortBy) {
    _sortBy = sortBy;
    switch (_sortBy) {
      case SortOptions.title:
        postList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOptions.id:
        postList.sort((a, b) => a.id.compareTo(b.id));
        break;
    }
    emit(PostReady(_sortBy, postList));
  }
}

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostReady extends PostState {
  final SortOptions _sortBy;
  final List<Post> postList;

  PostReady(this._sortBy, this.postList);

  @override
  List<Object> get props => [_sortBy, postList];
}
