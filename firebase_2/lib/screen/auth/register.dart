import 'package:flutter/material.dart';
import '../../servises/auth_servises.dart';
import '../../shared/constant.dart';
import '../../shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? error;
  bool loading = false;

  String userFio = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Регистрация'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.exit_to_app),
              label: const Text('exit'),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/');
              },
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
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Имя Фамилия',
                      ),
                      onChanged: (val) {
                        setState(() => userFio = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: ' Ваша электронная почта',
                      ),
                      validator: (val) =>
                          val?.isEmpty ?? false ? 'Введите email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: ' Придумайте пароль',
                      ),
                      obscureText: true,
                      validator: (val) => (val?.length ?? 7) < 6
                          ? 'Введите пароль длиной более 6 символов'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 12.0),
                      Text(
                        error!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 18.0),
                      ),
                    ],
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        style: buttonStyle,
                        child: const Text(
                          'Регистрация',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    userFio, email, password);

                            if (result == null || userFio == '') {
                              setState(() {
                                loading = false;
                                error =
                                    'Пожалуйста, укажите действительный адрес электронной почты, пароль, a также Ваше имя';
                              });
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
