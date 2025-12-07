import 'package:flutter/material.dart';

class SignInSection extends StatelessWidget {
  const SignInSection({
    super.key,
    this.onRegisterPressed,
    this.onForgotPasswordPressed,
  });

  final VoidCallback? onRegisterPressed;
  final VoidCallback? onForgotPasswordPressed;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
