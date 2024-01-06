import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/user.dart';
import '../../servises/data_base.dart';
import '../../shared/constant.dart';
import 'home_model.dart';

class SettingsForm extends StatefulWidget {
  final String uid;

  const SettingsForm({super.key, required this.uid});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   // print('user?.uid DID - ${widget.uid}');
    final read = context.read<HomeWidgetModel>();
    read.chekChangeUser(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    UserApp user = Provider.of<UserApp>(context);
    final read = context.read<HomeWidgetModel>();

    return StreamBuilder<UserAppData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserAppData? userData = snapshot.data;
            read.cleanerUserName(
                userData); //!сомнения конечно//такто можно сделать лучше

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Form(
                key: read.formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Оформить заказ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Для - ${read.currentName ?? 'null'}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10.0),

                    //--------------------------------------
                    DropdownButtonFormField(
                      value: userData?.chisburger ?? '0',
                      decoration: textInputDecoration,
                      items: read.chisburgerList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('$e - ${read.getNoun(
                            int.tryParse(e) as int,
                            'чизбургер',
                            'чизбургера',
                            'чизбургеров',
                          )}'),
                        );
                      }).toList(),
                      onChanged: (val) => read.currentChisburger = val,
                    ),
                    //--------------------------------------
                    DropdownButtonFormField(
                      value: read.currentBigmak ?? userData?.bigMac ?? '0',
                      decoration: textInputDecoration,
                      items: read.bigmakList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('$e - ${read.getNoun(
                            int.tryParse(e) as int,
                            'БигМак',
                            'БигМака',
                            'БигМаков',
                          )}'),
                        );
                      }).toList(),
                      onChanged: (val) => read.currentBigmak = val,
                    ),
                    //--------------------------------------
                    DropdownButtonFormField(
                      value:
                          read.currentKartoshka ?? userData?.kartoshka ?? '0',
                      decoration: textInputDecoration,
                      items: read.kartoshkaList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('$e - картошка'),
                        );
                      }).toList(),
                      onChanged: (val) => read.currentKartoshka = val,
                    ),
                    //--------------------------------------
                    DropdownButtonFormField(
                      value: read.currentCola ?? userData?.cola ?? '0',
                      decoration: textInputDecoration,
                      items: read.colaList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text('$e - кола'),
                        );
                      }).toList(),
                      onChanged: (val) => read.currentCola = val,
                    ),
                    //--------------------------------------

                    const SizedBox(height: 10.0),
                    ElevatedButton(
                        child: const Text(
                          'Обновить',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (read.formKey.currentState?.validate() ?? false) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                read.currentName ?? snapshot.data!.name,
                                read.currentChisburger ??
                                    snapshot.data!.chisburger ??
                                    '0',
                                read.currentBigmak ??
                                    snapshot.data!.bigMac ??
                                    '0',
                                read.currentKartoshka ??
                                    snapshot.data!.kartoshka ??
                                    '0',
                                read.currentCola ?? snapshot.data!.cola ?? '0');
                            read.closeSettingPanel(context); //! потом подумать
                          }
                        }),
                  ],
                ),
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
