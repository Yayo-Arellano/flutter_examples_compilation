import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/app.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/cubit/home_screen_cubit.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/navigation/routes.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/ui/widgets/custom_image.dart';

final homeScreenProvider = ChangeNotifierProvider((ref) => HomeScreenCubit()..init());

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreen = ref.watch(homeScreenProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider);
              final authNotifier = ref.read(authProvider.notifier);
              authNotifier.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.editUser);
        },
      ),
      body: ListView.builder(
        itemCount: homeScreen.myUsers.length,
        itemBuilder: (context, index) {
          final myUser = homeScreen.myUsers.elementAt(index);
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, Routes.editUser,
                    arguments: myUser);
              },
              leading: SizedBox(
                height: 45,
                width: 45,
                child: CustomImage(imageUrl: myUser.image),
              ),
              title: Text('${myUser.name} ${myUser.lastName}'),
              subtitle: Text('Age: ${myUser.age}'),
            ),
          );
        },
      ),
    );
  }
}
