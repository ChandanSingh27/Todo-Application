import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_project/task_model.dart';


class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final TextEditingController _title = TextEditingController();
  final TextEditingController _task = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Box box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<TaskModel>("task");
  }

  void addTask(){
    if(_formKey.currentState!.validate()){
      
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);
      String day = date.day.toString();
      String month = date.month.toString();
      String year = date.year.toString();
      String hour = date.hour.toString();
      String min = date.minute.toString();
      String toDaysDate = "$day/$month/$year";
      String currentTime = "$hour:$min";
      
      TaskModel model = TaskModel(_title.text, _task.text, _duration.text, toDaysDate, currentTime);
      box.add(model);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 1),content: Text("Successfully Added.")));
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading:false,backgroundColor: Colors.white,title: Text("Add Task",style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.black,fontSize: 20,fontWeight: FontWeight.normal),),centerTitle: true,),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: _title,
                    decoration: const InputDecoration(
                      label:Text("Title",style: TextStyle(fontSize: 20),),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Title should not be Empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _task,
                    decoration: const InputDecoration(
                      label:Text("What is the Task.",style: TextStyle(fontSize: 20),),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Task should not be Empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _duration,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label:Text("Duration ",style: TextStyle(fontSize: 20),),
                      hintText: "Durations in the days format.",
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Durations should not be Empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel",style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.deepOrange,fontSize: 18),)),
                  const SizedBox(width: 15,),
                  ElevatedButton(onPressed: addTask , child: Text("ADD",style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
