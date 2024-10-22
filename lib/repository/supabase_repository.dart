import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/models/task_model.dart';

class SupabaseRepository {
  Future<List<TaskGroup>> listTaskGroups() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('task_groups').select();
    return response.map((task) => TaskGroup.fromMap(task)).toList();
  }

  Future<List<Task>> listTasksByGroup(String groupId) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('tasks')
                  .select().eq('task_group_id', groupId);
    
    return response.map((task) => Task.fromMap(task)).toList();
  }
}
