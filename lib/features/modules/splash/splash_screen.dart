import 'package:amritha_ayurveda/core/constants/app_constants.dart';
import 'package:amritha_ayurveda/core/constants/image_constants.dart';
import 'package:amritha_ayurveda/core/utils/shared_preference_utils.dart';
import 'package:amritha_ayurveda/features/modules/auth/login_screen.dart';
import 'package:amritha_ayurveda/features/modules/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.splashScreenWallpaper),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
          child: Center(
            child: Image.asset(
              ImageConstants.logoBig,
              width: 120,
            ),
          ),
        ),
      ),
    );
  }

  checkLogin() async {
    bool logStatus = await SharedPreferencesUtils.getBoolValue(
          key: AppConstants.isUserLogged,
        ) ??
        false;

    await Future.delayed(
      const Duration(seconds: 3),
      () {
        if (logStatus) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        }
      },
    );
  }
}
