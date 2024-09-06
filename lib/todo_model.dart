import 'package:todo_with_cubit/data/dbhelper.dart';

class TodoModel{
  int?sno;
  String title,desc;
  String created;
  int isCompleted;
  TodoModel({this.sno,required this.title,required this.desc,this.isCompleted=0,required this.created});

  ///from map to model..
  factory TodoModel.fromMap(Map<String,dynamic> map){
    return TodoModel(
      sno: map[DBhelper.COLUMN_SNO],
        title: map[DBhelper.COLUMN_TITLE],
        desc: map[DBhelper.COLUMN_DESCC],
        isCompleted: map[DBhelper.COLUMN_ISCOMPLETED],
        created: map[DBhelper.COLUMN_CREATE_AT]
    );
  }
  ///from model to map..
  Map<String,dynamic> toMap(){
    return{
      DBhelper.COLUMN_TITLE:title,
      DBhelper.COLUMN_DESCC:desc,
      DBhelper.COLUMN_ISCOMPLETED:isCompleted,
      DBhelper.COLUMN_CREATE_AT:created
    };
  }
}