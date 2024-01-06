import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../servises/auth_servises.dart';
import '../../shared/constant.dart';
import '../../shared/loading.dart';
import 'auth_model.dart';

class Register extends StatelessWidget {
  const Register({
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
        title: const Text('Регистрация'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.exit_to_app),
              label: const Text('exit'),
              onPressed: () => read.toggleView(),
            ),
          ),
        ],
      ),
      body: watch.loading //!read??
          ? const Loading()
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: read.formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    //!необьяснимое явление автозаполнения форм из предыдущей страницы
                    const SizedBox(height: 10.0),
                    //-------------------
                    TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Имя Фамилия',
                        ),
                        //obscureText: true,
                        onChanged: (val) => read.userFio = val),
                    const SizedBox(height: 20.0),
                    //-------------------
                    TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ваша электронная почта',
                        ),
                        validator: (val) =>
                            val?.isEmpty ?? false ? 'Введите email' : null,
                        onChanged: (val) => read.email = val),
                    const SizedBox(height: 20.0),
                    //-------------------
                    TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: ' Придумайте пароль',
                        ),
                        obscureText: true,
                        validator: (val) => (val?.length ?? 7) < 6
                            ? 'Введите пароль длиной более 6 символов'
                            : null,
                        onChanged: (val) => read.password = val),
                    //-------------------
                    if (read.error != null) ...[
                      const SizedBox(height: 12.0),
                      Text(
                        read.error!,
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
                        onPressed: () => read.register()),
                  ],
                ),
              ),
            ),
    );
  }
}
