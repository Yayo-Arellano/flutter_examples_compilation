import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_auth/src/bloc/auth_cubit.dart';

class EmailCreate extends StatefulWidget {
  const EmailCreate({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const EmailCreate();

  @override
  EmailCreateState createState() => EmailCreateState();
}

class EmailCreateState extends State<EmailCreate> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'This is a required field' : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'This is a required field';
    if (value.length < 6) return 'Password should be at least 6 letters';
    if (_passwordController.text != _repeatPasswordController.text) return 'Password do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create account')),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is AuthSigningIn) const Center(child: CircularProgressIndicator()),
                    if (state is AuthError)
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 24),
                      ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: emailValidator,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _repeatPasswordController,
                      decoration: const InputDecoration(labelText: 'Repeat Password'),
                      validator: passwordValidator,
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('Create'),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthCubit>().createUserWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
