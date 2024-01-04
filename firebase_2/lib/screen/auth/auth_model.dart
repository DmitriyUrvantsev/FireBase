import 'package:flutter/material.dart';

import '../../domain/entity/user.dart';
import '../../servises/auth_servises.dart';

class AuthenticateModel extends ChangeNotifier {
  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>();
  bool showSingInPage = true;

  String error = '';
  bool loading = false;
  String email = '';
  String password = '';

//----------------------singIn-----------------------
//---------------------------------------------------

void toggleView() {
     showSingInPage = !showSingInPage;
   }

  Future<void> singIn() async {
    if (formKey.currentState?.validate() ?? false) {
      loading = true;

      dynamic result = await auth.signInWithEmailAndPassword(email, password);
      print('result - $result');
      loading = false;
      if (result == null) {
        {
          loading = false;
          print('modelLoading - $loading');
          error = 'Не удалось войти с этими учетными данными.'; //!
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
}
