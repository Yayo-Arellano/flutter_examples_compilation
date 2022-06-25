import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_getx/src/controller/edit_my_user_controller.dart';
import 'package:flutter_simple_firebase_crud_getx/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/widgets/custom_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditMyUserScreen extends StatelessWidget {
  const EditMyUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userToEdit = Get.arguments as MyUser?;
    final editController = Get.put(EditMyUserController(userToEdit));

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
                  editController.deleteMyUser();
                },
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            _MyUserSection(
              user: userToEdit,
              pickedImage: editController.pickedImage.value,
              isSaving: editController.isLoading.value,
            ),
            if (editController.isLoading.value)
              Container(
                color: Colors.black12,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
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
                final editController = Get.find<EditMyUserController>();
                final pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  editController.setImage(File(pickedImage.path));
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
                      final editController = Get.find<EditMyUserController>();
                      editController.saveMyUser(
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
