import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_rest_api_getx/bloc/user_cubit.dart';
import 'package:flutter_simple_rest_api_getx/repository/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

import 'data_source/db_data_source.dart';
import 'data_source/rest_data_source.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbDataSource = await DbDataSource.init();
  final userDataSource = RestDataSource();
  final userRepository = UserRepository(userDataSource, dbDataSource);

  getIt.registerLazySingleton(() => userRepository);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => UserCubit()..loadInitialData(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Rest + Sqflite'),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await context.read<UserCubit>().getUser();
                } on Exception catch (e) {
                  final snackBar = SnackBar(
                    content: Text('Error: ${e.toString()}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: BlocBuilder<UserCubit, UserCubitState>(
        builder: (context, state) {
          var itemCount = state.users.length;
          final isLoading = state.isLoading;
          if (isLoading) itemCount++;

          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (_, index) {
              if (isLoading) {
                if (index == 0) return _LoadingCard();
                index--;
              }
              final user = state.users[index];
              return Card(
                child: ListTile(
                  leading: SizedBox(
                    height: 70,
                    width: 70,
                    child: user.thumbnail == null
                        ? const Icon(Icons.image)
                        : CachedNetworkImage(
                            imageUrl: user.thumbnail!,
                            progressIndicatorBuilder: (_, __, ___) =>
                                _ImageLoading(),
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                  title: Text('${user.name} ${user.lastName}'),
                  subtitle: Text(user.city),
                  trailing: IconButton(
                    onPressed: () => context.read<UserCubit>().deleteUser(user),
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        enabled: true,
        child: ListTile(
          leading: _ImageLoading(),
          title: Container(
            height: 15,
            color: Colors.white,
          ),
          subtitle: Container(
            height: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ImageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      enabled: true,
      child: Container(
        height: 70,
        width: 70,
        color: Colors.white,
      ),
    );
  }
}
