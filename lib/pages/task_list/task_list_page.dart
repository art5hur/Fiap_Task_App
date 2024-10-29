import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/task_create/task_create_page.dart';
import 'package:todo_app/pages/task_list/widgets/delete_task.dart';
import 'package:todo_app/pages/task_list/widgets/task_widget.dart';
import 'package:todo_app/providers/task_group_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late final TaskGroupProvider taskGroupProvider;

  @override
  void initState() {
    final taskProvider = context.read<TaskProvider>();
    taskGroupProvider = context.read<TaskGroupProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskProvider.listTasksByGroup(taskGroupProvider.selectedTaskGroup!.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(builder: (context, taskProvider, _) {
        if (taskProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(taskGroupProvider.selectedTaskGroup!.color),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.tasks[index];
                      return Dismissible(
                        key: Key(task.id),
                        background: const DeleteTask(),
                        onDismissed: (direction){
                          taskProvider
                                  .deleteTask(task.id);
                        },
                        // confirmDismiss: (direction) {
                        //   return showDialog(context: context, builder: (context))
                        // },
                        child: TaskWidget(
                          task: task,
                          color:
                              Color(taskGroupProvider.selectedTaskGroup!.color),
                        ),
                      );
                    })),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (BuildContext context) {
              return TaskCreatePage(
                groupId: taskGroupProvider.selectedTaskGroup!.id,
              );
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
