import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_with_cubit/todo_model.dart';

class DBhelper{
  ///Singleton Instance..
  DBhelper._();
  static DBhelper getInstance()=>DBhelper._();

  static final String TODO_TABLE_NAME ="todo";
  static final String COLUMN_SNO ="sno";
  static final String COLUMN_TITLE ="title";
  static final String COLUMN_DESCC ="desc";
  static final String COLUMN_ISCOMPLETED ="iscompleted";
  static final String COLUMN_CREATE_AT ="create_at";
  ///globalDB
  Database? mdb;

  ///getDb and openDB
  Future<Database> getDB()async{
    if(mdb!=null){
      return mdb!;
    }
    else{
      //openDB
      mdb =await openDB();
      return mdb!;
    }
  }
  ///openDB..
  Future<Database> openDB()async{
    Directory appDirec =await getApplicationDocumentsDirectory();
    String dbpPath = join(appDirec.path,"todo.DB");
   return openDatabase(dbpPath,version: 1,onCreate: (db,version){
      db.execute("create table $TODO_TABLE_NAME ($COLUMN_SNO integer primary key autoincrement,$COLUMN_TITLE text,$COLUMN_DESCC text,$COLUMN_ISCOMPLETED integer,$COLUMN_CREATE_AT text)");
    });
  }

  ///All queries..
  ///add queries..
  Future<bool> insertTodo(TodoModel addtodo)async{
    var mDB =await getDB();
  int rowEffected =await  mDB.insert(TODO_TABLE_NAME, addtodo.toMap());
  return rowEffected>0;
  }
  ///fetch Notes..
  Future<List<TodoModel>> fetchTodo()async{
    var mDB =await getDB();
    var data = await mDB.query(TODO_TABLE_NAME);
    List<TodoModel> mNotes =[];
    for(Map<String,dynamic> eachdata in data){
      mNotes.add(TodoModel.fromMap(eachdata));
    }
    return mNotes;
  }

  ///update Notes..
  Future<bool> updateTodo(TodoModel updatetodo,int sno)async{
    Database mDB =await getDB();
  int rowEffected =await  mDB.update(TODO_TABLE_NAME, updatetodo.toMap(),where: "$COLUMN_SNO=$sno");
  return rowEffected>0;
  }
  ///checkbox Update
  Future<bool> checkBoxupdate(TodoModel checkboxupdate,bool value, int sno)async{
    var mDB =await getDB();
    int rowEfffected =await mDB.update(TODO_TABLE_NAME, checkboxupdate.toMap(),where: "$COLUMN_SNO=$sno");
    return rowEfffected>0;
  }

  ///deleteTodo..
  Future<bool> deleteTodo(int sno)async{
    Database mDB =await getDB();
   int rowEffected =await mDB.delete(TODO_TABLE_NAME,where: '$COLUMN_SNO=$sno');
   return rowEffected>0;
  }
}