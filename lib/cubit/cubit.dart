
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Screens/arch.dart';
import 'package:to_do_app/component/component.dart';
import 'package:to_do_app/cubit/states.dart';
import 'package:to_do_app/Screens/done.dart';
import 'package:to_do_app/Screens/new.dart';
import 'package:to_do_app/home_page.dart';


class toDoCubit extends Cubit<toDoStates>{
toDoCubit() : super(toDoInitialState());

static toDoCubit get(context) => BlocProvider.of(context);

int currentIndex=0;

bool isShown = false;
Icon icon=Icon(Icons.add);



List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> archivedTasks = [];

List<Widget>Screens=[
newtasks(),
done(),
archive(),
];
Database database;
void changeIcon({bool isShown,Icon icon,TextEditingController title,TextEditingController time,TextEditingController date}){
this.isShown=isShown;
this.icon=icon;
title.clear();
time.clear();
date.clear();
emit(toDoFABIconState());
}

bool isPressed=false;
Icon icont=Icon(Icons.check_box_outline_blank);
void changeTaskIcon({bool isPressed,Icon icont}){
this.isPressed=isPressed;
this.icont=icont;
emit(toDoTaskIconState());
}


void createDatabase() async{
openDatabase (
'todo.db',
version: 1,
onCreate: (database,version) async{
print('Database Created');
await database.execute(
'CREATE TABLE tasks ('
'id INTEGER  PRIMARY KEY,'
'title TEXT,'
'date TEXT,'
'time TEXT,'
'status TEXT ) '
).then((value) {
print("Database created");
}).catchError((error){
print('Error in $error');
});
},
onOpen: (database){
showDatabase(database);
print("Database opened");
},
).then((value) {
database=value;
emit(toDoCreateDatabaseState());
});
}

insertToDatabase ({@required title,@required time ,@required date})async{
await database.transaction((txn) {
txn.rawInsert('INSERT INTO tasks (title,time,date,status)'
'VALUES ( "${title}", "${time} ","${date}", "New") ').then((value){
print("$value inserted successfully");
emit(toDoInsertDatabaseState());
showDatabase(database);
}).catchError((error){
print("Error when inserting ${error.toString()}");
});
return null;
});
}


void showDatabase(database) {
emit(toDoLoadingState());
database.rawQuery('SELECT * FROM tasks').then((value) {
newTasks=[];
doneTasks=[];
archivedTasks=[];

value.forEach((element) {
if (element['status']=='New') {
newTasks.add(element);
}else if (element['status']=='done') {
doneTasks.add(element);
}else {
archivedTasks.add(element);
}
});

emit(toDoShowDatabaseState());
});
}

void  updateDatabase( status, id)  {
database.rawUpdate(
"UPDATE tasks SET status = ? WHERE id = ?",
["$status", id],
).then((value) {
showDatabase(database);
emit(toDoUpdateDatabaseState());
});
}


void  deleteDatabase(id)  {
database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
showDatabase(database);
emit(toDoDeleteDatabaseState());
});
}

void changeBottomNav(int index){
currentIndex=index;
emit(toDoBottomNavBarState());
}


}