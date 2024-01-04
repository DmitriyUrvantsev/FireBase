import 'package:flutter/material.dart';
import '../../domain/entity/task.dart';
import '../../shared/constant.dart';
//
class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.grey,
          ),
          title: Text(task.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              task.chisburger != '0'
                  ? Text('${task.chisburger} - ${getNoun(
                      int.tryParse(task.chisburger?? '0') as int,
                      'чизбургер',
                      'чизбургера',
                      'чизбургеров',
                    )}')
                  : const SizedBox.shrink(),
              task.bigMac != '0'
                  ? Text('${task.bigMac} - ${getNoun(
                      int.tryParse(task.bigMac?? '0') as int,
                      'БигМак',
                      'БигМака',
                      'БигМаков',
                    )}')
                  : const SizedBox.shrink(),
              task.kartoshka != '0' && task.kartoshka != null
                  ? Text('${task.kartoshka} - картошка')
                  : const SizedBox.shrink(),
              task.cola != '0' && task.cola != null
                  ? Text('${task.cola} - кола')
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
