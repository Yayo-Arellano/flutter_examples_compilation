import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_auth/src/bloc/auth_cubit.dart';
import 'package:flutter_simple_firebase_auth/src/bloc/my_user_cubit.dart';
import 'package:flutter_simple_firebase_auth/src/model/user.dart';
import 'package:flutter_simple_firebase_auth/src/repository/implementations/my_user_repository.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => MyUserCubit(MyUserRepository())..getMyUser(),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => context.read<AuthCubit>().signOut(),
          )
        ],
      ),
      body: BlocBuilder<MyUserCubit, MyUserState>(
        builder: (_, state) {
          if (state is MyUserReadyState) {
            return _MyUserSection(
              user: state.user,
              pickedImage: state.pickedImage,
              isSaving: state.isSaving,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _MyUserSection extends StatefulWidget {
  final MyUser? user;
  final File? pickedImage;
  final bool isSaving;

  const _MyUserSection({this.user, this.pickedImage, this.isSaving = false});

  @override
  _MyUserSectionState createState() => _MyUserSectionState();
}

class _MyUserSectionState extends State<_MyUserSection> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    _nameController.text = widget.user?.name ?? '';
    _lastNameController.text = widget.user?.lastName ?? '';
    _ageController.text = widget.user?.age.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/intro_3.png',
      fit: BoxFit.fill,
    );

    if (widget.pickedImage != null) {
      image = Image.file(
        widget.pickedImage!,
        fit: BoxFit.fill,
      );
    } else if (widget.user?.image != null && widget.user!.image!.isNotEmpty) {
      image = CachedNetworkImage(
        imageUrl: widget.user!.image!,
        progressIndicatorBuilder: (_, __, progress) => CircularProgressIndicator(value: progress.progress),
        errorWidget: (_, __, ___) => Icon(Icons.error),
        fit: BoxFit.fill,
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final pickedImage = await picker.getImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  context.read<MyUserCubit>().setImage(File(pickedImage.path));
                }
              },
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: 150,
                    height: 150,
                    child: image,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (_, current) => current is AuthSignedIn,
              builder: (_, state) {
                return Center(
                  child: Text('UID: ${(state as AuthSignedIn).user.uid}'),
                );
              },
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: widget.isSaving
                      ? null
                      : () {
                          context.read<MyUserCubit>().saveMyUser(
                                (context.read<AuthCubit>().state
                                        as AuthSignedIn)
                                    .user
                                    .uid,
                                _nameController.text,
                                _lastNameController.text,
                                int.tryParse(_ageController.text) ?? 0,
                              );
                        },
                ),
                if (widget.isSaving) CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
