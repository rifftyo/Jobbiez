// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/provider/login_provider.dart';
import 'package:jobbiez/presentation/provider/password_visibility_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    final provider = Provider.of<LoginProvider>(context, listen: false);

    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty) {
      _showToast(context, 'Email cannot be empty', false);
      return;
    }

    if (password.isEmpty) {
      _showToast(context, 'Password cannot be empty', false);
      return;
    }

    await provider.login(email, password);

    if (provider.state == RequestState.Loaded) {
      _showToast(context, 'Login successful', true);
      Navigator.pushReplacementNamed(context, '/home');
    } else if (provider.state == RequestState.Error) {
      _showToast(context, provider.message ?? 'Login failed', false);
    }
  }

  void _showToast(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Sign In',
                style: kManropeHeading1.copyWith(
                  fontSize: 32,
                  color: kDarkGray,
                ),
              ),
              SizedBox(height: 26),
              Text('Email', style: kManropeBodyText),
              SizedBox(height: 8),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'email',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: kWhite,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kWhite),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Password', style: kManropeBodyText),
              SizedBox(height: 8),
              ChangeNotifierProvider(
                create: (_) => PasswordVisibilityProvider(),
                child: Consumer<PasswordVisibilityProvider>(
                  builder: (context, provider, child) {
                    return TextField(
                      controller: passwordController,
                      obscureText: provider.isPasswordInvisible,
                      decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: kWhite,
                        suffixIcon: IconButton(
                          onPressed: () {
                            provider.togglePasswordVisibility();
                          },
                          icon: Icon(
                            provider.isPasswordInvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: kLightGray),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Consumer<LoginProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        onPressed:
                            provider.state == RequestState.Loading
                                ? null
                                : () {
                                  _handleLogin(context);
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child:
                            provider.state == RequestState.Loading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : Text(
                                  'Sign In',
                                  style: kManropeHeading5.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: kManropeBodyText.copyWith(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      'SIGN UP',
                      style: kManropeHeading5.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
