import 'package:firebase_2/domain/entity/user.dart';
import 'package:flutter/material.dart';
import '../../servises/auth_servises.dart';
import '../../shared/constant.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Аутентификация'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Регистр'),
              onPressed: () => widget.toggleView(),
            ),
          ),
        ],
      ),
      body: loading
          ? const Loading()
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //-------------
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'электронная почта',
                      ),
                      validator: (val) =>
                          val?.isEmpty ?? false ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'пароль',
                      ),
                      obscureText: true,
                      validator: (val) => (val?.length ?? 7) < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        //color: Colors.pink[400],
                        style: buttonStyle,
                        child: const Text(
                          'Войти как Сотрудник',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Не удалось войти с этими учетными данными.';
                              });
                            }
                          }
                        }),
                    //---------------

                    ElevatedButton(
                      child: const Text('Зайти как Посыльный'),
                      onPressed: () async {
                        UserApp? userAnonim = await _auth.signInAnon();
                        if (userAnonim == null) {
                          print('Ошибка входа в систему');
                        } else {
                          print('userAnonim(user).id - ${userAnonim.uid}');
                        }
                      },
                    ),

                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
