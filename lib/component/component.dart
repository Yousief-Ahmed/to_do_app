import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/cubit/cubit.dart';
import 'package:to_do_app/home_page.dart';

//screens colors
Color taskc = Colors.red;
Color donec = Colors.green;
Color archc = Colors.brown;
//time and date color
Color primary = Colors.red;
Color onPrimary = Colors.white;
Color onSurface = Colors.deepOrangeAccent;
Color onBackground = Colors.deepOrangeAccent;

Color primary2 = Colors.green;
Color onPrimary2 = Colors.white;
Color onSurface2 = Colors.lightGreen;
Color onBackground2 = Colors.lightGreen;

Color primary3 = Colors.brown;
Color onPrimary3 = Colors.white;
Color onSurface3 = Colors.brown;
Color onBackground3 = Colors.brown;

Widget field({
  TextEditingController controller,
  TextInputType texttype,
  String hint,
  String label,
  Icon prefix,
  IconButton suffix,
  bool vis,
  Function valid,
  Function onTap,
  bool readOnly = false,
  int currentIndex = 0,
  Function onChanged,
}) {
  return TextFormField(
    controller: controller,
    validator: valid,
    textDirection: TextDirection.ltr,
    keyboardType: texttype,
    onTap: onTap,
    style: TextStyle(
      color: currentIndex == 0
          ? Colors.red
          : currentIndex == 1
              ? Colors.green
              : Colors.brown,
    ),
    readOnly: readOnly,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(5),
      prefixIcon: IconTheme(
          data: IconThemeData(
            color: currentIndex == 0
                ? Colors.red
                : currentIndex == 1
                    ? Colors.green
                    : Colors.brown,
          ),
          child: prefix),
      suffixIcon: suffix,
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle(
        color: currentIndex == 0 ? Colors.red : currentIndex == 1 ? Colors.green : Colors.brown,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          color: currentIndex == 0
              ? Colors.red
              : currentIndex == 1
                  ? Colors.green
                  : Colors.brown,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Widget buildTasksL(Map model,BuildContext play, {int currentIndex}) => Slidable(
      key: Key(model['id'].toString()),
      endActionPane: ActionPane(
          motion: StretchMotion(),
          children:[
            SlidableAction(onPressed: (context) {
              TextStyle(
                fontWeight: FontWeight.bold
              );
              showDialog(
                  context:context,
                  builder: (context) => AlertDialog(
                    title: Text("Delete"),
                    content:
                     Text("The \*${model['title']}\* event will be deleted, Are you sure ?",
                     ),
                    actions: [
                      TextButton(onPressed: (){
                        toDoCubit.get(play).deleteDatabase(model['id']);
                        Navigator.of(context).pop();
                      },child: Text("Yes",
                      style: TextStyle(
                        color: currentIndex == 0 ? Colors.red : currentIndex == 1 ? Colors.green : Colors.brown,
                      ),
                      ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text("Cancel",
                        style: TextStyle(
                          color: currentIndex == 0 ? Colors.red : currentIndex == 1 ? Colors.green : Colors.brown,
                        ),
                      ),
                      ),
                    ],
                  ),

              );
            },
              icon: Icons.delete_forever_outlined,
              backgroundColor: Colors.red,
              label: "Delete",
            ),
          ],

      ),
      child: ListTile(
        leading: IconButton(
          onPressed: (){
            toDoCubit.get(play).updateDatabase('archive', model['id']);
            if(currentIndex==2){
              toDoCubit.get(play).updateDatabase('New', model['id']);
            }
          },
          icon:currentIndex==2?Icon(Icons.archive, color: currentIndex == 0 ? Colors.red : currentIndex == 1 ? Colors.green: Colors.brown):Icon(Icons.archive_outlined, color: currentIndex == 0 ? Colors.red : currentIndex == 1 ? Colors.green : Colors.brown),

      ),
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model['title'][0].toString().toUpperCase()}${model['title'].toString().substring(1).toLowerCase()}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: currentIndex == 0
                      ? Colors.red
                      : currentIndex == 1
                          ? Colors.green
                          : Colors.brown,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 15,
                    color: currentIndex == 0
                        ? Colors.red
                        : currentIndex == 1
                            ? Colors.green
                            : Colors.brown,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${model['date']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: currentIndex == 0
                          ? Colors.red
                          : currentIndex == 1
                              ? Colors.green
                              : Colors.brown,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.watch_later,
                    size: 15,
                    color: currentIndex == 0
                        ? Colors.red
                        : currentIndex == 1
                            ? Colors.green
                            : Colors.brown,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${model['time']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: currentIndex == 0
                          ? Colors.red
                          : currentIndex == 1
                              ? Colors.green
                              : Colors.brown,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            toDoCubit.get(play).updateDatabase('done', model['id']);
            if(currentIndex==1){
              toDoCubit.get(play).updateDatabase('New', model['id']);
            }
          },
          icon: currentIndex==1?Icon(Icons.check_box, color: currentIndex == 0 ? Colors.red : currentIndex == 1 ? Colors.green: Colors.brown):Icon(Icons.check_box_outlined, color: currentIndex == 0 ? Colors.red : currentIndex == 1 ? Colors.green : Colors.brown),
           ),
        ),
    );

Widget screenBuilder({@required List<Map> task,int cIndex})=>Padding(
  padding: const EdgeInsetsDirectional.only(
    top: 10,
    bottom: 10,
  ),
  child: ConditionalBuilder(
    condition: task.length>0,
    builder: (context) => ListView.separated(
      itemBuilder:(context,index)=> buildTasksL(task[index],context ,currentIndex:cIndex),
      separatorBuilder: (context,index)=>Divider(
        color: Colors.grey,
        endIndent: 20,
        indent: 20,
        thickness: .8,
      ),
      itemCount: task.length,
    ),
    fallback: (context) =>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(cIndex==0?Icons.menu : cIndex==1 ? Icons.check_box : Icons.archive,
            size: 30,
            color: cIndex == 0 ? Colors.red : cIndex == 1 ? Colors.green : Colors.brown,
          ),
          Text(
            cIndex==0? "No new tasks" : cIndex==1 ? "No done tasks" : "No archived tasks",
            style: TextStyle(
              fontSize: 25,
              color: cIndex == 0 ? Colors.red : cIndex == 1 ? Colors.green : Colors.brown,
            ),
          ),
        ],
      ),
    ) ,
  ),
);
