import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/task_group_list/widgets/task_group_item.dart';
import 'package:todo_app/providers/task_group_provider.dart';

class TaskGroupListPage extends StatelessWidget {
  const TaskGroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Groups'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.light_mode),
          ),
        ],
      ),
      body: Consumer<TaskGroupProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.taskGroupsWithCounts.length,
            itemBuilder: (context, index) {
              final taskGroupWithCount = provider.taskGroupsWithCounts[index];
              return TaskGroupItem(taskGroupWithCount: taskGroupWithCount);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
