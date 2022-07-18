import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/cubit/edit_my_user_cubit.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/widgets/custom_image.dart';
import 'package:image_picker/image_picker.dart';

class EditMyUserScreen extends StatelessWidget {
  const EditMyUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If userToEdit is not null it means we are editing
    final userToEdit = ModalRoute.of(context)?.settings.arguments as MyUser?;

    return BlocProvider(
      create: (context) => EditMyUserCubit(userToEdit),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit or create user'),
          actions: [
            Builder(builder: (context) {
              // If we are creating a new myUser do not show the
              // delete button
              return Visibility(
                visible: userToEdit != null,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<EditMyUserCubit>().deleteMyUser();
                  },
                ),
              );
            }),
          ],
        ),
        body: BlocConsumer<EditMyUserCubit, EditMyUserState>(
          listener: (context, state) {
            if (state.isDone) {
              // When isDone is true we navigate to the previous screen/route
              Navigator.of(context).pop();
            }
          },
          builder: (_, state) {
            return Stack(
              children: [
                _MyUserSection(
                  user: userToEdit,
                  pickedImage: state.pickedImage,
                  isSaving: state.isLoading,
                ),
                if (state.isLoading)
                  Container(
                    color: Colors.black12,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final editCubit = context.read<EditMyUserCubit>();
                final pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  editCubit.setImage(File(pickedImage.path));
                }
              },
              child: Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CustomImage(
                      imageFile: widget.pickedImage,
                      imageUrl: widget.user?.image,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 8),

            // When isSaving is true we disable the button
            ElevatedButton(
              onPressed: widget.isSaving
                  ? null
                  : () {
                      context.read<EditMyUserCubit>().saveMyUser(
                            _nameController.text,
                            _lastNameController.text,
                            int.tryParse(_ageController.text) ?? 0,
                          );
                    },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
