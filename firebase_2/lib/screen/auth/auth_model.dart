import 'package:flutter/material.dart';

import '../../domain/entity/user.dart';
import '../../servises/auth_servises.dart';

class AuthenticateModel extends ChangeNotifier {
  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>();
  bool showSingInPage = true;

  String? error;
  bool loading = false;
  String email = '';
  String password = '';
//------
  String userFio = '';

//----------------------singIn-----------------------
//---------------------------------------------------

  void toggleView() {
    showSingInPage = !showSingInPage;
    error = null;

    notifyListeners();
  }

//-----------
  Future<void> singIn() async {
    if (formKey.currentState?.validate() ?? false) {
      loading = true;
      dynamic result = await auth.signInWithEmailAndPassword(email, password);
      //print('result - $result');
      loading = false;
      if (result == null) {
        {
          loading = false;
          //print('modelLoading - $loading');
          error = 'Не удалось войти с этими учетными данными.'; //!

          notifyListeners();
        }
        notifyListeners();
      }
    }
  }

//-----------
  Future<void> singInAnonim() async {
    UserApp? userAnonim = await auth.signInAnon();
    if (userAnonim == null) {
      print('Ошибка входа в систему');
    } else {
      print('userAnonim(user).id - ${userAnonim.uid}');
    }
  }

//----------------------register-----------------------
//---------------------------------------------------
//---------------------------------------------------
  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      loading = true;
      dynamic result =
          await auth.registerWithEmailAndPassword(userFio, email, password);
      loading = false; //!------?-----
      showSingInPage = true;
      error = null;
      if (result == null || userFio == '') {
        loading = false;
        error =
            'Пожалуйста, укажите действительный адрес электронной почты, пароль, a также Ваше имя';
      }
    }
  }
}
