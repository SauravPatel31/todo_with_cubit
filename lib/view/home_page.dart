import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_with_cubit/todo_cubit.dart';
import 'package:todo_with_cubit/todo_cubit_state.dart';
import 'package:todo_with_cubit/todo_model.dart';
import 'package:todo_with_cubit/view/add_edit_page.dart';

class HomePage extends StatelessWidget{
  DateFormat mFormart =DateFormat.yMMMd();
  @override
  Widget build(BuildContext context) {
     context.read<TodoCubit>().getTodo();
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: BlocBuilder<TodoCubit,TodoCubitState>(
       builder:  (ctx, state){
         if(state is TodoLoadingState){
           return Center(
             child: CircularProgressIndicator(),
           );
         }
         else if(state is TodoErrorState){
           return Center(child: Text("Error ${state.errormsg}"),);
         }
         else if(state is TodoLoadedState){
           return state.mTodo.isNotEmpty?ListView.builder(
               itemCount: state.mTodo.length,
               itemBuilder: (_,index){
                 var myTodo =state.mTodo[index];
                 return CheckboxListTile(
                   value: myTodo.isCompleted==1,
                   onChanged: (value){
                     var update = TodoModel(title: myTodo.title, desc: myTodo.desc, isCompleted: value!?1:0,created: myTodo.created);
                     ctx.read<TodoCubit>().checkBoxUpdate(update, value, myTodo.sno!);
                   },
                   title: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(myTodo.title),
                       Row(
                         children: [
                           IconButton(onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(isupdate: true,title: myTodo.title,desc: myTodo.desc,sno: myTodo.sno!),));
                           }, icon: Icon(Icons.edit)),
                           IconButton(onPressed: (){
                             ctx.read<TodoCubit>().deleteTodo(myTodo.sno!);
                           }, icon: Icon(Icons.delete,color: Colors.red,))
                         ],
                       )
                     ],
                   ),
                   subtitle: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(myTodo.desc),
                       Text(mFormart.format(DateTime.fromMillisecondsSinceEpoch(int.parse(myTodo.created))))
                     ],
                   ),
                   controlAffinity: ListTileControlAffinity.leading,

                 );
               }):Center(child: Text("No Todo Yet"),);
         }
          return Container();

       },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

}