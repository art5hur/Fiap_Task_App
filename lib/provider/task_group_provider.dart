import 'package:flutter/material.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/repository/task_group_repository.dart';

class TaskGroupProvider extends ChangeNotifier{
  final taskGroupRepository = TaskGroupRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading; // => Função
  // Mesma coisa de: 
  // bool get isLoading {return _isLoading;} 

  List<TaskGroup> _taskGroups = [];
  List<TaskGroup> get taskGroups => _taskGroups; 
  

  Future<void> listTaskGroups() async{
    _isLoading = true;
    notifyListeners();
    _taskGroups = await taskGroupRepository.listTaskGroups(); //indo no repositório buscar taskGroup
    _isLoading = false;
    notifyListeners();
  }

}