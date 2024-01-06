import 'package:firebase_2/servises/auth_servises.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/user.dart';
import 'settings_form.dart';

class HomeWidgetModel extends ChangeNotifier {


  final AuthService auth = AuthService();
//----------
  final formKey = GlobalKey<FormState>();
  final List<String> chisburgerList = ['0', '1', '2', '3', '4'];
  //!по идее нужно на int, потом переделать надо
  final List<String> bigmakList = ['0', '1', '2'];
  final List<String> kartoshkaList = ['0', 'мал.', 'сред.', 'болш.'];
  final List<String> colaList = ['0', 'мал.', 'сред.', 'болш.'];

  String? currentName;
  String? currentChisburger;
  String? currentBigmak;
  String? currentKartoshka;
  String? currentCola;

  UserAppData? userData;


  //-----------------Home------------------------------
  //------------------------------------------------------------

  void showSettingsPanel(context, uid) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SettingsForm(uid: uid);
        });
  }

  //-----------------SettingsPanel------------------------------
  //------------------------------------------------------------
  void chekChangeUser(uid) {
    //-----временно
    if (uid != userData?.uid) {
      currentChisburger = null;
      currentBigmak = null;
      currentKartoshka = null;
      currentCola = null;
    } //-----временно
  }

  void cleanerUserName(userData) {
    var userName = '';
    for (int i = 0; i < (userData?.name.length ?? 0); i++) {
      if (userData?.name != null) {
        String x = userData!.name[i];
        if (x != '-') {
          userName = userName + x;
        } else {
          break;
        }
      }
    }
    currentName = userName.trim();
  }

  void closeSettingPanel(context){
    Navigator.pop(context);
  }

  //-----------------------------------------------------------
  String getNoun(int n, String one, String two, String five) {
    n %= 100;
    if (n >= 5 && n <= 20) {
      return five;
    }
    n %= 10;
    if (n == 1) {
      return one;
    }
    if (n >= 2 && n <= 4) {
      return two;
    }
    return five;
  }
}
