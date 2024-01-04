import 'package:firebase_2/screen/home/task_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/task.dart';
import '../../domain/entity/user.dart';
import '../../servises/auth_servises.dart';
import '../../servises/data_base.dart';
import 'settings_form.dart';
//
class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    void showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: const SettingsForm(),
            );
          });
    }

    final user = Provider.of<UserApp?>(context);
    return StreamProvider<List<Task>>.value(
      value: DatabaseService(uid: user?.uid ?? 'null').tasks,
      initialData: [
        Task(name: '', chisburger: '0', bigMac: '0', kartoshka: '0', cola: '0')
      ],
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: const Center(child: Text('Лист заказов')),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.settings),
                  label: const Text('заказ'),
                  onPressed: () => showSettingsPanel(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text(''),
                  onPressed: () async {
                    await auth.signOut();
                  },
                ),
              ),
            ],
          ),
          body: const TaskList()),
    );
  }
}
