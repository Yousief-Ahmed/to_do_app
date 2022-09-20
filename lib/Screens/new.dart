import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/component/component.dart';
import 'package:to_do_app/cubit/cubit.dart';
import 'package:to_do_app/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/home_page.dart';

class newtasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<toDoCubit,toDoStates>(
      listener: (BuildContext context,toDoStates state) {},
      builder:(BuildContext context,toDoStates state) {
        var task=toDoCubit.get(context).newTasks;
        var cIndex=toDoCubit.get(context).currentIndex;
        return screenBuilder(task: task,cIndex: cIndex);

      } ,
    ) ;
  }
}

// Row(
//   children:[
//     CircleAvatar(
//       radius: 25,
//       child: Text(
//           '10:00'
//       ),
//     ),
//     Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           " GYM",
//           overflow: TextOverflow.ellipsis,
//           maxLines: 1,
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10,),
//         Text(
//           "April",
//           overflow: TextOverflow.ellipsis,
//           maxLines: 1,
//         ),
//       ],
//     ),
//   ],
// );
