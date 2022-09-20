import 'package:bottom_picker/bottom_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:to_do_app/component/component.dart';
class test extends StatefulWidget {
  const test({Key key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  TextEditingController timec = TextEditingController();
  TextEditingController datec = TextEditingController();
  var datevalid= GlobalKey<FormState>();
  var timev= GlobalKey<FormState>();

  int currentIndex=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>showDialog(
          context: context,
          barrierDismissible: true,
          builder:(context) => AlertDialog(
            title: Text("New Task"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: field(label: "New",prefix: Icon(Icons.menu)),
            contentPadding: EdgeInsetsDirectional.all(20),
            actions: [
              TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Cancel")),
              TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Submit")),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          DateTimePicker(
            type: DateTimePickerType.date,
            controller: datec,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText:"Date",
            timeLabelText: "Time",
            calendarTitle: "Date",
            initialTime: TimeOfDay.now(),
            toolbarOptions: ToolbarOptions(
              paste: true,
            ),
            cursorColor: Colors.redAccent,
           onFieldSubmitted: (date){
              datec.text=date;
           },
          ),
          // DateTimePicker(
          //   key: timev,
          //   type: DateTimePickerType.time,
          //   controller: timec,
          //   icon: Icon(Icons.watch_later),
          //   timeLabelText: "Time",
          //   initialTime: TimeOfDay.now(),
          //   use24HourFormat: false,
          //   onSaved: (time){
          //     timec.text=time.toString();
          //   },
          //   validator: (timev){
          //     if(datec.text==DateTime.now()&&timec.hashCode<TimeOfDay.now().hour){
          //       return "Please Choose a future time";
          //     }
          //     return null;
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
          ),
          DateTimePicker(
            key: timev,
            type: DateTimePickerType.time,
            controller: timec,
            icon: Icon(Icons.watch_later),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialTime: TimeOfDay.now(),
            timeLabelText: "Time",
            onFieldSubmitted: (time){
              timec.text=TimeOfDay().format(context).toString();
            },
            validator: (value){
             if(value.isEmpty) return"asd";
              return null;
            },

          ),
          TextButton(onPressed: (){
            DatePicker.showDatePicker(
              context,
            currentTime: DateTime.now(),
              minTime: DateTime.now(),
              maxTime: DateTime(2100),
            );

          }, child: Text("press")),
          TextButton(onPressed: (){
            DatePicker.showTimePicker(
              context,
            currentTime: DateTime.now(),
              showSecondsColumn: false,
              onConfirm: (time) {
                timec.text=time.toString();
              },
            );

          }, child: Text("press")),
          TextButton(onPressed: (){
            showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              builder: (context, child) => Theme(
                  data: ThemeData().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: currentIndex==0?primary:currentIndex==1 ?primary2:Colors.blue,
                      onPrimary: currentIndex==0?onPrimary:currentIndex==1 ?onPrimary2:Colors.blue,
                      onSurface: currentIndex==0?onSurface:currentIndex==1 ?onSurface2:Colors.blue,
                      onBackground: currentIndex==0?onBackground:currentIndex==1 ?primary2:Colors.blue,
                    ),
                  ),
                  child: child),
            ).then((value) {
              timec.text=value.format(context).toString();

            });
          }, child: Text("press2")),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: timec,
              readOnly: true,
              onTap: (){
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) => Theme(
                      data: ThemeData().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                          onSurface: Colors.deepOrangeAccent,
                          onBackground: Colors.deepOrangeAccent,
                        ),
                      ),
                      child: child),
                ).then((value) {
                  timec.text=value.format(context).toString();

                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
