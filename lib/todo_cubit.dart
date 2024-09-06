import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/todo_cubit_state.dart';
import 'package:todo_with_cubit/todo_model.dart';

import 'data/dbhelper.dart';

class TodoCubit extends Cubit<TodoCubitState>{
  DBhelper dBhelperl;
  TodoCubit({required this.dBhelperl}):super(TodoIntialState());

  ///Events..
  //add events..
  void addTodo(TodoModel addtodo)async{
    emit(TodoLoadingState());
    bool isAdd = await dBhelperl.insertTodo(addtodo);
    if(isAdd){
      List<TodoModel> mTodos =await dBhelperl.fetchTodo();
      emit(TodoLoadedState(mTodo: mTodos));
    }
    else{
      emit(TodoErrorState(errormsg: "Todo is no add!!"));
    }
  }

  //update events..
  void updateTodo(TodoModel updatetodo,int sno)async{
    emit(TodoLoadingState());
    bool isupdate =await dBhelperl.updateTodo(updatetodo, sno);
    if(isupdate){
      List<TodoModel> mTodo =await dBhelperl.fetchTodo();
      emit(TodoLoadedState(mTodo: mTodo));
    }
    else{
      emit(TodoErrorState(errormsg: "Data is No Updated"));
    }
  }

  //checkBox update
  void checkBoxUpdate(TodoModel checkboxupdate,bool value,int sno)async{
    emit(TodoLoadingState());
   bool ischeck =await dBhelperl.checkBoxupdate(checkboxupdate, value, sno);
   if(ischeck){
     List<TodoModel> mTodo = await dBhelperl.fetchTodo();
     emit(TodoLoadedState(mTodo: mTodo));
   }
  }
  //delete events..
  void deleteTodo(int sno)async{
    emit(TodoLoadingState());
    bool isDelete =await dBhelperl.deleteTodo(sno);
    if(isDelete){
      var mTodo = await dBhelperl.fetchTodo();
      emit(TodoLoadedState(mTodo: mTodo));
    }
  }

  //getTodo
  void getTodo()async{
    var mTodo = await dBhelperl.fetchTodo();
    emit(TodoLoadedState(mTodo: mTodo));
  }
}