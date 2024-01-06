import 'package:firebase_2/screen/home/task_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/task.dart';
import '../../domain/entity/user.dart';
import '../../servises/data_base.dart';
import 'home_model.dart';

//
class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final watch = context.watch<HomeWidgetModel>();
    final read = context.read<HomeWidgetModel>();
    final user = Provider.of<UserApp?>(context);
  

    return StreamProvider<List<Task>>.value(
      value: DatabaseService(uid: user?.uid ?? 'null').tasks,
      initialData: [Task(name: '')],
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: const Center(child: Text('Лист заказов')),
            backgroundColor: Colors.brown[400],
            elevation: 2.0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.settings),
                  label: const Text('заказ'),
                  onPressed: ()  {
                 read.showSettingsPanel(context, user?.uid) ;
                 print('user?.uid - ${user?.uid}');  
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text(''),
                  onPressed: () async {
                    await read.auth.signOut();
                  },
                ),
              ),
            ],
          ),
          body: const TaskList()),
    );
  }
}
