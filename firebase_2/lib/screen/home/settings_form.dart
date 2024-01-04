import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/user.dart';
import '../../servises/data_base.dart';
import '../../shared/constant.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> chisburgerList = ['0', '1', '2', '3', '4'];
  //!по идее нужно на int, потом переделать надо
  final List<String> bigmakList = ['0', '1', '2'];
  final List<String> kartoshkaList = ['0', 'мал.', 'сред.', 'болш.'];
  final List<String> colaList = ['0', 'мал.', 'сред.', 'болш.'];

  String? _currentName;
  String? _currentChisburger;
  String? _currentBigmak;
  String? _currentKartoshka;
  String? _currentCola;

  @override
  Widget build(BuildContext context) {
    UserApp user = Provider.of<UserApp>(context);

    return StreamBuilder<UserAppData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserAppData? userData = snapshot.data;

            var a =
                ''; // :) - костыль - вытаскиваю userName не от туда откуда нужно...:) sorry
            for (int i = 0; i < (userData?.name.length ?? 0); i++) {
              if (userData?.name != null) {
                String x = userData!.name[i];
                if (x != '-') {
                  a = a + x;
                } else {
                  break;
                }
              }
            }
            _currentName = a.trim();

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Оформить заказ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Имя - ${_currentName ?? 'null'}:',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 10.0),

                  //--------------------------------------
                  DropdownButtonFormField(
                    value: _currentChisburger ?? userData?.chisburger,
                    decoration: textInputDecoration,
                    items: chisburgerList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e - ${getNoun(
                          int.tryParse(e) as int,
                          'чизбургер',
                          'чизбургера',
                          'чизбургеров',
                        )}'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentChisburger = val),
                  ),
                  //--------------------------------------
                  DropdownButtonFormField(
                    value: _currentBigmak ?? userData?.bigMac,
                    decoration: textInputDecoration,
                    items: bigmakList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e - ${getNoun(
                          int.tryParse(e) as int,
                          'БигМак',
                          'БигМака',
                          'БигМаков',
                        )}'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentBigmak = val),
                  ),
                  //--------------------------------------
                  DropdownButtonFormField(
                    value: _currentKartoshka ?? userData?.kartoshka,
                    decoration: textInputDecoration,
                    items: kartoshkaList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e - картошка'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentKartoshka = val),
                  ),
                  //--------------------------------------
                  DropdownButtonFormField(
                    value: _currentCola ?? userData?.cola,
                    decoration: textInputDecoration,
                    items: colaList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e - кола'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentCola = val),
                  ),
                  //--------------------------------------

                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      child: const Text(
                        'Обновить',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? snapshot.data!.name,
                              _currentChisburger ?? snapshot.data!.chisburger?? '0',
                              _currentBigmak ?? snapshot.data!.bigMac?? '0',
                              _currentKartoshka ?? snapshot.data!.kartoshka?? '0',
                              _currentCola ?? snapshot.data!.cola?? '0');
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return const Column(
              children: [
                Text(
                  'Только зарегистрированные пользователи могут оформить заказ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            );
          }
        });
  }
}
