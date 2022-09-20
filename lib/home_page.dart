import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/component/component.dart';
import 'package:to_do_app/cubit/cubit.dart';
import 'package:to_do_app/cubit/states.dart';



class homepage extends StatelessWidget {

  var Scaffoldkey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  TextEditingController title = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();




  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => toDoCubit()..createDatabase(),
      child: BlocConsumer <toDoCubit,toDoStates>(
        listener:(BuildContext context,toDoStates state){
          if(state is toDoInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context,toDoStates state) {
          toDoCubit cubit = toDoCubit.get(context);
          return Scaffold(
            key: Scaffoldkey,
            appBar: AppBar(
              backgroundColor:cubit.currentIndex==0?taskc : cubit.currentIndex==1?donec : archc,
              centerTitle: true,
              title: Text(
                "To Do",
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: cubit.currentIndex,
              showUnselectedLabels: true,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.list_alt),label: "Tasks",backgroundColor:taskc),
                BottomNavigationBarItem(icon:Icon(Icons.check_box),label: "Done",backgroundColor: donec),
                BottomNavigationBarItem(icon:Icon(Icons.archive),label: "Archived",backgroundColor: archc),
              ],
            ),
            floatingActionButton:
            Container(
              child: FloatingActionButton.extended(
                backgroundColor:cubit.currentIndex==0?taskc : cubit.currentIndex==1?donec : archc,
                onPressed: (){
                  if(cubit.isShown){
                    if(formKey.currentState.validate()) {
                      cubit.insertToDatabase(title: title.text, time: time.text, date: date.text);
                    }
                  }else {
                    Scaffoldkey.currentState.showBottomSheet(
                          (context) => Container(
                            padding: EdgeInsets.all(15),
                            child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              field(
                                  currentIndex: cubit.currentIndex,
                                  controller: title,
                                  prefix: Icon(Icons.title),
                                  label: "Task title",
                                  texttype: TextInputType.text,
                                  valid: (String value){
                                    if(value.isEmpty){
                                      return "Title must not be Empty";
                                    }
                                    return null;
                                  }

                              ), //title
                              SizedBox(
                                height: 10,
                              ),
                              field(currentIndex: cubit.currentIndex, readOnly: true, controller: date, label: "Task Date", prefix: Icon(Icons.calendar_month_rounded),
                                  valid: (String value){
                                    if(value.isEmpty){
                                      return "Time must not be Empty";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                      builder: (context, child) => Theme(
                                          data: ThemeData().copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary:cubit.currentIndex==0?primary:cubit.currentIndex==1 ?primary2:primary3,
                                              onPrimary: Colors.white,
                                              onSurface: cubit.currentIndex==0?onSurface:cubit.currentIndex==1 ?onSurface2:onSurface3,
                                            ),
                                          ),
                                          child: child
                                      ),
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2035),
                                    ).then((value) {
                                      date.text =
                                          DateFormat.yMMMEd().format(value).toString();
                                    });
                                  }),
                              SizedBox(
                                height: 10,
                              ),//date
                              field(
                                currentIndex: cubit.currentIndex,
                                readOnly: true,
                                controller: time,
                                prefix: Icon(Icons.watch_later),
                                label: "Task Time",
                                texttype: TextInputType.datetime,
                                valid: (String value){
                                  if(value.isEmpty){
                                    return "Time must not be Empty";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                    builder: (context, child) => Theme(
                                        data: ThemeData().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: cubit.currentIndex==0?primary:cubit.currentIndex==1 ?primary2:primary3,
                                            onPrimary: cubit.currentIndex==0?onPrimary:cubit.currentIndex==1 ?onPrimary2:onPrimary3,
                                            onSurface: cubit.currentIndex==0?onSurface:cubit.currentIndex==1 ?onSurface2:onSurface3,
                                            onBackground: cubit.currentIndex==0?onBackground:cubit.currentIndex==1 ?primary2:onBackground3,

                                          ),
                                        ),
                                        child: child),
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    time.text = value.format(context).toString();
                                  });
                                },
                              ), //time
                            ],
                          ),
                        ),
                      ),
                    ).closed.then((value) {
                     cubit.changeIcon(isShown: false,icon: Icon(Icons.add),title: title,date: date,time: time);
                    });
                    cubit.changeIcon(isShown: true,icon: Icon(Icons.check),title: title,date: date,time: time);
                  }
                },
                icon: cubit.icon,
                label:Text(
                  cubit.isShown==true ? "Save" : "Add",
                ),
              ),
            ),
            body:ConditionalBuilder(
              condition: state is ! toDoLoadingState,
              builder: (context)=>cubit.Screens[cubit.currentIndex],
              fallback:(context)=> Center(
                child: CircularProgressIndicator(
                  color: cubit.currentIndex==0?Colors.red :cubit.currentIndex==1?Colors.green : Colors.brown,
                ),
              ),
            ),

          );
        },
      ),
    );
  }



}
