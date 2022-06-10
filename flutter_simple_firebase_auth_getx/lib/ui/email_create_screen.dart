import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_auth/controllers/email_create_controller.dart';
import 'package:get/get.dart';

class EmailCreate extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  EmailCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = Get.put(EmailCreateController());

    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Visibility(
                  visible: emailController.isLoading.value,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: emailController.error.value?.isNotEmpty == true,
                  child: Text(
                    emailController.error.value ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: emailController.emailValidator,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: emailController.passwordValidator,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController.repeatPasswordController,
                decoration: const InputDecoration(labelText: 'Repeat Password'),
                validator: emailController.passwordValidator,
              ),
              Center(
                child: ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      Get.find<EmailCreateController>()
                          .createUserWithEmailAndPassword();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
