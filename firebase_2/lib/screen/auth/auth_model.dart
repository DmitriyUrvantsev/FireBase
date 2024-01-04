import 'package:flutter/material.dart';

import '../../servises/auth_servises.dart';

class AuthenticateModel extends ChangeNotifier {
  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  String email = '';
  String password = '';


//! ошика такто: error.toString() LateInitializationError: Field 'userName' has not been initialized. Надо будет поправить
  Future<void> singIn() async {
    if (formKey.currentState?.validate() ?? false) {
      loading = true;
      
       dynamic result = await auth.signInWithEmailAndPassword(email, password);
      if (result == null) {
        {
          loading = false;
          error = 'Не удалось войти с этими учетными данными.';//!
        }
        notifyListeners();
      }
    }
  }
}
