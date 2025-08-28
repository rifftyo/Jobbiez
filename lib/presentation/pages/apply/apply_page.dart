// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/routes/app_routes.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/provider/apply_job_provider.dart';
import 'package:provider/provider.dart';

class ApplyPage extends StatefulWidget {
  final String jobId;

  const ApplyPage({super.key, required this.jobId});

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ApplyJobProvider>(context, listen: false).resetData();
    });
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> _handleApply(BuildContext context) async {
    final provider = Provider.of<ApplyJobProvider>(context, listen: false);

    final firstname = firstnameController.text;
    final lastname = lastnameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final country = countryController.text;
    final message = messageController.text;

    if (firstname.isEmpty) {
      _showToast(context, "Please enter your first name", false);
      return;
    }

    if (lastname.isEmpty) {
      _showToast(context, "Please enter your last name", false);
      return;
    }

    if (email.isEmpty) {
      _showToast(context, "Please enter your email", false);
      return;
    }

    if (phone.isEmpty) {
      _showToast(context, "Please enter your phone number", false);
      return;
    }

    if (country.isEmpty) {
      _showToast(context, "Please enter your country", false);
      return;
    }

    if (provider.selectedSalary == null) {
      _showToast(context, "Please select a salary", false);
      return;
    }

    if (message.isEmpty) {
      _showToast(context, "Please enter a short message", false);
      return;
    }

    if (provider.cvFile == null) {
      _showToast(context, "Please upload your CV", false);
      return;
    }

    await provider.apply(
      widget.jobId,
      firstname,
      lastname,
      email,
      phone,
      country,
      message,
    );

    if (provider.state == RequestState.Loaded) {
      _showToast(context, 'Application submitted successfully', true);
      Navigator.pushReplacementNamed(context, AppRoutes.applications);
    } else if (provider.state == RequestState.Error) {
      _showToast(context, provider.message ?? 'Application failed', false);
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.grey[100],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kWhite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController? controllerInput, {
    TextInputType? type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: kManropeBodyText),
        const SizedBox(height: 8),
        TextField(
          keyboardType: type,
          decoration: _inputDecoration(hint),
          controller: controllerInput,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    "First Name",
                    "firstname",
                    firstnameController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    "Last Name",
                    "lastname",
                    lastnameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              "Email",
              "email",
              emailController,
              type: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone", style: kManropeBodyText),
                      const SizedBox(height: 8),
                      IntlPhoneField(
                        controller: phoneController,
                        initialCountryCode: 'US',
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration(
                          "phone",
                        ).copyWith(counterText: ""),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    "Country",
                    "country",
                    countryController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text("Expected Salary", style: kManropeBodyText),
            const SizedBox(height: 8),
            Consumer<ApplyJobProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Salary'),
                  items: List.generate(10, (index) {
                    final salary = (index + 1) * 500;
                    return DropdownMenuItem(
                      value: salary.toString(),
                      child: Text("\$$salary"),
                    );
                  }),
                  onChanged: (value) {
                    provider.setSelectedSalary(value!);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Text("Short Message", style: kManropeBodyText),
            const SizedBox(height: 8),
            TextField(
              controller: messageController,
              maxLines: 5,
              decoration: _inputDecoration("Write here a short message"),
            ),
            const SizedBox(height: 16),
            Text('Upload CV', style: kManropeBodyText),
            const SizedBox(height: 8),
            DottedBorder(
              options: RectDottedBorderOptions(
                color: Colors.grey,
                strokeWidth: 2,
                dashPattern: [6, 3],
              ),
              child: Consumer<ApplyJobProvider>(
                builder: (context, provider, child) {
                  return GestureDetector(
                    onTap: () {
                      provider.pickCV();
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit_document,
                            color: Colors.amber,
                            size: 50,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            provider.cvFileName ?? 'Browse your file here',
                            style: kManropeBodyText.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              width: double.infinity,
              height: 50,
              child: Consumer<ApplyJobProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: () {
                      provider.state == RequestState.Loading
                          ? null
                          : _handleApply(context);
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
                              'Apply',
                              style: kManropeHeading5.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
