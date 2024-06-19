import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/login/button_login.dart';
import 'package:footloose_tickets/presentation/widgets/login/button_reset_password.dart';
import 'package:footloose_tickets/presentation/widgets/login/input_cod_login.dart';
import 'package:footloose_tickets/presentation/widgets/login/input_password.dart';
import 'package:footloose_tickets/presentation/widgets/logo_widget.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login-screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Stack(
          children: [
            const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80.0),
                    ElasticIn(child: const ImageLogoFootloose()),
                    const SizedBox(height: 20.0),
                    const InputCodLogin(),
                    const SizedBox(height: 13.0),
                    const InputPassword(),
                    const SizedBox(height: 30.0),
                    const ButtonInitLogin(),
                    const SizedBox(height: 35.0),
                    const ButtonResetPassword(),
                    const SizedBox(height: 70.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
