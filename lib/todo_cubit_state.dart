

import 'package:todo_with_cubit/todo_model.dart';

abstract class TodoCubitState{}

class TodoIntialState extends TodoCubitState{}
class TodoLoadingState extends TodoCubitState{}
class TodoLoadedState extends TodoCubitState{
  List<TodoModel> mTodo;
  TodoLoadedState({required this.mTodo});
}
class TodoErrorState extends TodoCubitState{
  String errormsg;
  TodoErrorState({required this.errormsg});
}