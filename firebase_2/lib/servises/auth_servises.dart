import 'package:firebase_2/servises/data_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/entity/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userName;

  // создание нашего UseraApp на данных user FireBase
  UserApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

  // аутентификация, изменение пользовательского потока
  Stream<UserApp?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // ---------войти анонимно------------
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('ошибка при анонимном входе - ${e.toString()}');
      return null;
    }
  }

  // ---------войти с email и password---------
  Future signInWithEmailAndPassword(String email, String password) async {
        try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user;
    } catch (error) {
      print('error.toString() ${error.toString()}');
      return null;
    }
  }

  // ---------зарегистрироваться с email и password---------
  Future registerWithEmailAndPassword(
      String userFio, String email, String password) async {
    userName = userFio;
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(
          '$userName:\n  - чтобы оформить заказ \n - жми "заказ"');
      print('userName - $userName');
      print('user - $user');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print('error.toString() ${error.toString()}');
      return null;
    }
  }

  //--------- выйти ---------
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print('error.toString() ${error.toString()}');
      return null;
    }
  }
}
