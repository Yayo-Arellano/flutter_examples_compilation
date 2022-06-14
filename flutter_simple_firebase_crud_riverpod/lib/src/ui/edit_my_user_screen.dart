import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/notifiers/edit_my_user_notifier.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/ui/widgets/custom_image.dart';
import 'package:image_picker/image_picker.dart';

final editMyUserProvider =
    ChangeNotifierProvider.family<EditMyUserNotifier, MyUser?>((ref, myUser) {
  return EditMyUserNotifier(myUser);
});

class EditMyUserScreen extends ConsumerWidget {
  const EditMyUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToEdit = ModalRoute.of(context)?.settings.arguments as MyUser?;

    final homeScreen = ref.watch(editMyUserProvider(userToEdit));
    ref.listen<EditMyUserNotifier>(editMyUserProvider(userToEdit),
        (previous, next) {
      if (next.isDone) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit or create user'),
        actions: [
          Builder(builder: (context) {
            return Visibility(
              visible: userToEdit != null,
              child: IconButton(
                key: const Key('Delete'),
                icon: const Icon(Icons.delete),
                onPressed: () {
                  homeScreen.deleteMyUser();
                },
              ),
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          _MyUserSection(
            user: userToEdit,
            pickedImage: homeScreen.pickedImage,
            isSaving: homeScreen.isLoading,
          ),
          if (homeScreen.isLoading)
            Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _MyUserSection extends ConsumerStatefulWidget {
  final MyUser? user;
  final File? pickedImage;
  final bool isSaving;

  const _MyUserSection({this.user, this.pickedImage, this.isSaving = false});

  @override
  _MyUserSectionState createState() => _MyUserSectionState();
}

class _MyUserSectionState extends ConsumerState<_MyUserSection> {
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
                final editMyUser = ref.read(editMyUserProvider(widget.user));
                final pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  editMyUser.setImage(File(pickedImage.path));
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
              key: const Key('Name'),
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('Last Name'),
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('Age'),
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: widget.isSaving
                  ? null
                  : () {
                      ref.read(editMyUserProvider(widget.user)).saveMyUser(
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
