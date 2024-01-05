import 'package:firebase_2/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../servises/auth_servises.dart';
import '../../shared/constant.dart';
import '../../shared/loading.dart';
import 'auth_model.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AuthenticateModel>();
    final read = context.read<AuthenticateModel>();
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
              onPressed: () => read.toggleView(),
            ),
          ),
        ],
      ),
      body: watch.loading//!read?
          ? const Loading()
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: read.formKey,
                child: Column(
                  children: [
                    //-------------
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'электронная почта',
                      ),
                      onChanged: (val) => read.email = val,
                      //!упрощенная валидация
                      validator: (val) =>
                          val?.isEmpty ?? false ? 'Enter an email' : null,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'пароль',
                      ),
                      obscureText: true,
                      //!упрощенная валидация
                      validator: (val) => (val?.length ?? 7) < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) => read.password = val,
                    ),
                    const SizedBox(height: 20.0),
                    //---------------
                    ElevatedButton(
                        //color: Colors.pink[400],
                        style: buttonStyle,
                        child: const Text(
                          'Войти как Сотрудник',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => read.singIn()),
                    //---------------

                    ElevatedButton(
                      child: const Text('Зайти как Посыльный'),
                      onPressed: () => read.singInAnonim(),
                    ),
//-----------------------------------------------------------
                    const SizedBox(height: 12.0),
                    Text(
                      watch.error?? '',
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
