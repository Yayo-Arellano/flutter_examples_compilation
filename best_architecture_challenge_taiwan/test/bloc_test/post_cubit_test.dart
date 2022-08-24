import 'package:best_architecture_challenge/main.dart';
import 'package:best_architecture_challenge/src/bloc/post_cubit.dart';
import 'package:best_architecture_challenge/src/model/post.dart';
import 'package:best_architecture_challenge/src/repository/repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRepoImp extends Repository {
  @override
  Future<List<Post>> getPostList() async => [
        const Post(1, 'Yayo title', 'This is the body'),
        const Post(2, 'Jonh title', 'This is the body 2'),
      ];
}

void main() {
  group('Post Cubit Test', () {
    blocTest<PostCubit, PostState>(
      'News are loaded correctly',
      build: () => PostCubit(MockRepoImp()),
      expect: () => [
        // isA<PostLoading>(),// Initial state is not emitted. Check documentation
        isA<PostReady>(),
      ],
    );

    blocTest<PostCubit, PostState>(
      'Default sorted by id',
      build: () => PostCubit(MockRepoImp()),
      expect: () => [
        // isA<PostLoading>(),// Initial state is not emitted. Check documentation
        isA<PostReady>(),
      ],
      verify: (cubit) {
        final readyState = cubit.state as PostReady;

        expect(readyState.postList.length, 2);
        expect(readyState.postList[0].id, 1);
        expect(readyState.postList[1].id, 2);
      },
    );

    blocTest<PostCubit, PostState>(
      'Sorted by title',
      build: () => PostCubit(MockRepoImp()),
      act: (cubit) => cubit.sort(SortOptions.title),
      expect: () => [
        // isA<PostLoading>(),// Initial state is not emitted. Check documentation
        isA<PostReady>(),
        isA<PostReady>(),
      ],
      verify: (cubit) {
        final readyState = cubit.state as PostReady;

        expect(readyState.postList.length, 2);
        expect(readyState.postList[0].id, 2);
        expect(readyState.postList[1].id, 1);
      },
    );
  });
}
