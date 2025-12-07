import 'package:flutter/material.dart';
import 'package:just_chat/authentication/presentation/widgets/forgot_password_section.dart';
import 'package:just_chat/authentication/presentation/widgets/register_section.dart';
import 'package:just_chat/authentication/presentation/widgets/signin_section.dart';

enum AuthScreenState { signIn, register, forgotPassword }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthScreenState state = AuthScreenState.signIn;

  late Map<AuthScreenState, Widget> sections;

  @override
  void initState() {
    super.initState();

    sections = {
      AuthScreenState.register: RegisterSection(
        onSignInPressed: _onSignInPressed,
      ),
      AuthScreenState.signIn: SignInSection(
        onRegisterPressed: _onRegisterPressed,
        onForgotPasswordPressed: _onForgotPasswordPressed,
      ),
      AuthScreenState.forgotPassword: ForgotPasswordSection(
        onRenewPassword: _onRenewPassword,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TmpBentoColor.neutral_11,
      body: Center(child: sections[state]),
    );
  }

  void _setNewState(AuthScreenState newState) => setState(() {
    state = newState;
  });

  void _onForgotPasswordPressed() {
    _setNewState(AuthScreenState.forgotPassword);
  }

  void _onRegisterPressed() {
    _setNewState(AuthScreenState.register);
  }

  void _onRenewPassword() {
    debugPrint('Password renewed.');
  }

  void _onSignInPressed() {
    _setNewState(AuthScreenState.signIn);
  }
}

class TmpBentoColor {
  static const neutral_11 = Color.fromRGBO(255, 255, 255, 0.01);
}
