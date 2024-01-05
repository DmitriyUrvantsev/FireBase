import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_model.dart';
import 'register.dart';
import 'sign_in.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AuthenticateModel>();
   // final read = context.read<AuthenticateModel>();
    bool showSignIn = watch.showSingInPage;
    if (showSignIn) {
      return const SignIn();
    } else {
      return const Register();
    }
  }
}
