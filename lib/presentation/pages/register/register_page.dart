// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/provider/password_visibility_provider.dart';
import 'package:jobbiez/presentation/provider/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister(BuildContext context) async {
    final provider = Provider.of<RegisterProvider>(context, listen: false);

    final username = usernameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final password = passwordController.text;

    if (username.isEmpty) {
      _showToast(context, 'Username cannot be empty', false);
      return;
    }

    if (email.isEmpty) {
      _showToast(context, 'Email cannot be empty', false);
      return;
    }

    if (phone.isEmpty) {
      _showToast(context, 'Phone number cannot be empty', false);
      return;
    }

    if (password.isEmpty) {
      _showToast(context, 'Password cannot be empty', false);
      return;
    }

    await provider.register(username, email, phone, password);

    if (provider.state == RequestState.Loaded) {
      _showToast(context, 'Registration successful', true);
      Navigator.pushReplacementNamed(context, '/home');
    } else if (provider.state == RequestState.Error) {
      _showToast(context, provider.message ?? 'Registration failed', false);
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Sign up here',
                style: kManropeHeading1.copyWith(
                  fontSize: 32,
                  color: kDarkGray,
                ),
              ),
              SizedBox(height: 26),
              Text('User name', style: kManropeBodyText),
              SizedBox(height: 8),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'username',
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
                    borderSide: const BorderSide(color: kLightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Phone Number', style: kManropeBodyText),
              SizedBox(height: 8),
              IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'phone',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: kLightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: kWhite,
                ),
                initialCountryCode: 'ID',
              ),
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
                        hintText: '*********',
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
              SizedBox(height: 28),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Consumer<RegisterProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        onPressed:
                            provider.state == RequestState.Loading
                                ? null
                                : () {
                                  _handleRegister(context);
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
                                  'Sign Up',
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
                    'Already have an account?',
                    style: kManropeBodyText.copyWith(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      'SIGN IN',
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
