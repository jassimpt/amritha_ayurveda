import 'package:amritha_ayurveda/core/constants/image_constants.dart';
import 'package:amritha_ayurveda/core/utils/custom_snackbar.dart';
import 'package:amritha_ayurveda/core/utils/enums.dart';
import 'package:amritha_ayurveda/core/utils/field_validation_utils.dart';
import 'package:amritha_ayurveda/core/utils/loader_utils.dart';
import 'package:amritha_ayurveda/features/modules/auth/controller/auth_controller.dart';
import 'package:amritha_ayurveda/features/modules/auth/widgets/custom_universal_button.dart';
import 'package:amritha_ayurveda/features/modules/auth/widgets/custom_universal_textfield.dart';
import 'package:amritha_ayurveda/features/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final bool isFromGuestSection;

  const LoginScreen({
    super.key,
    this.isFromGuestSection = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authController = Provider.of<AuthController>(context, listen: false);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.warning,
        content: "Your email or password is empty",
      );
      return;
    }

    LoaderUtils.showLoader(context: context);

    try {
      final result = await authController.login(email, password);

      if (mounted) {
        LoaderUtils.hideLoader(context);

        if (result.success) {
          showCustomSnackBar(
            context: context,
            type: SnackBarType.success,
            content: result.message,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          showCustomSnackBar(
            context: context,
            type: SnackBarType.error,
            content: result.message,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        LoaderUtils.hideLoader(context);
        showCustomSnackBar(
          context: context,
          type: SnackBarType.error,
          content: "Failed login Please try again after sometime",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.3,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageConstants.loginPageFullBanner),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      ImageConstants.logoSmall,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login Or Register To Book\nYour Appointments',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomUniversalTextfield(
                        label: 'Email',
                        controller: _emailController,
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      Consumer<AuthController>(
                        builder: (context, authController, child) =>
                            CustomUniversalTextfield(
                          label: 'Password',
                          controller: _passwordController,
                          hintText: 'Enter password',
                          obscureText: authController.obscurePassword,
                          validator: FieldValidationUtils.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              authController.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              authController.setObscurePassword();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Consumer<AuthController>(
                        builder: (context, authController, child) {
                          return CustomUniversalButton(
                            text: 'Login',
                            onPressed:
                                authController.isLoading ? null : _handleLogin,
                            isLoading: authController.isLoading,
                            backgroundColor: Colors.green,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'By creating or logging into an account you are agreeing with our ',
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                color: Colors.blue[600],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Colors.blue[600],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
