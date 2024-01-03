import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/task.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru-RU'); //!
    final now = DateTime.now();
    String formatter = DateFormat.yMd('ru-RU').format(now);

    final tasks = Provider.of<List<Task>>(context);
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 55),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskTile(task: tasks[index]);
          },
        ),

//1
//? movie_date_parser
// DateTime? parseMovieDateFromString(String? rewDate) {
//     //!обязательно static
//     if (rewDate == null || rewDate.isEmpty) return null;
//     return DateTime.tryParse(rewDate);
//   }

//?--------

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Список заказов на доставку еды из Мака в офис на  - $formatter:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 3,
            ),
          ],
        ),
      ],
    );
  }
}
