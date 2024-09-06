
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/todo_cubit.dart';
import 'package:todo_with_cubit/todo_model.dart';

class AddEditPage extends StatelessWidget{
  bool isupdate;
  int sno;
  String title,desc;
  AddEditPage({this.isupdate=false,this.title="",this.desc="",this.sno=0});
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(isupdate){
      titleController.text=title;
      descController.text=desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isupdate?"Update Todo":"Add Todo"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter the title "
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: descController,
            decoration: InputDecoration(
              hintText: "Enter the description"
            ),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                isupdate?context.read<TodoCubit>().updateTodo(TodoModel(title: titleController.text, desc: descController.text, created: DateTime.now().millisecondsSinceEpoch.toString()), sno):context.read<TodoCubit>().addTodo(TodoModel(title: titleController.text, desc: descController.text, created: DateTime.now().millisecondsSinceEpoch.toString()));
              }, child: Text(isupdate?"Update":"Add")),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("cancel"))
            ],
          )
        ],
      ),
    );
  }

}