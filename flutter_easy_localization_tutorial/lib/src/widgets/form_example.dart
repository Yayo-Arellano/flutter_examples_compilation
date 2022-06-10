import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FormExample extends StatefulWidget {
  static Widget create(BuildContext context) => FormExample();

  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'required_field'.tr() : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'required_field'.tr();
    if (value.length < 6) return 'password_length'.tr();
    if (_passwordController.text != _repeatPasswordController.text) return 'password_match'.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('form'.tr())),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'email'.tr()),
                validator: emailValidator,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'password'.tr()),
                validator: passwordValidator,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _repeatPasswordController,
                decoration: InputDecoration(labelText: 'repeat_password'.tr()),
                validator: passwordValidator,
              ),
              Center(
                child: ElevatedButton(
                  child: Text('submit'.tr()),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      final snackBar = SnackBar(content: Text('submit_success'.tr()));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }
}
