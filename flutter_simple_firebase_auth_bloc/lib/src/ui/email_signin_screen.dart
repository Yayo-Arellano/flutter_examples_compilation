import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_auth/src/bloc/auth_cubit.dart';

class EmailSignIn extends StatefulWidget {
  static Widget create(BuildContext context) => EmailSignIn();

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? emptyValidator(String? value) {
    return (value == null || value.isEmpty) ? 'This is a required field' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login with Email')),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is AuthSigningIn) Center(child: CircularProgressIndicator()),
                    if (state is AuthError)
                      Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: emptyValidator,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: emptyValidator,
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthCubit>().signInWithEmailAndPassword(
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
