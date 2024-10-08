import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task_group.dart';

class TaskGroupRepository{

  Future<List<TaskGroup>> listTaskGroups() async{
      final client = Supabase.instance.client;
      final response = await client.from('task_groups').select();
      //Transformar lista de Maps em TaksGroup
      final taskGroups = response.map((m) => TaskGroup.fromMap(m)).toList();
      return taskGroups;
  }
}