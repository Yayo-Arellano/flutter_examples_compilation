import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/cubit/auth_cubit.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/cubit/home_screen_cubit.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/navigation/routes.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/widgets/custom_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        actions: [
          IconButton(
            onPressed: () {
              final authCubit = context.read<AuthCubit>();
              authCubit.signOut();
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
      body: BlocProvider(
        create: (context) => HomeScreenCubit()..init(),
        child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.myUsers.length,
              itemBuilder: (context, index) {
                final myUser = state.myUsers.elementAt(index);
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.editUser, arguments: myUser);
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
            );
          },
        ),
      ),
    );
  }
}
