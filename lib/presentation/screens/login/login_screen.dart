import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
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
        backgroundColor: AppColors.bodyGray,
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
                    const SizedBox(height: 45.0),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(color: AppColors.textLight, borderRadius: BorderRadius.circular(30)),
                      child: const Icon(Icons.print, color: AppColors.textDark, size: 80),
                    ),
                    const SizedBox(height: 45.0),
                    const InputCodLogin(),
                    const SizedBox(height: 15.0),
                    const InputPassword(),
                    const SizedBox(height: 30.0),
                    const ButtonInitLogin(),
                    const SizedBox(height: 32.0),
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
