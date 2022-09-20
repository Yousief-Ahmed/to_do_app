import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/component/component.dart';
import 'package:to_do_app/cubit/cubit.dart';
import 'package:to_do_app/cubit/states.dart';

class archive extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<toDoCubit,toDoStates>(
      listener: (BuildContext context,toDoStates state) {},
      builder:(BuildContext context,toDoStates state) {
        var task=toDoCubit.get(context).archivedTasks;
        var cIndex=toDoCubit.get(context).currentIndex;
        return screenBuilder(task: task,cIndex: cIndex);
      } ,
    ) ;
  }
}


