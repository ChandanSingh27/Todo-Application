import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_project/task_model.dart';
import 'hompepages.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  var dic = await getApplicationDocumentsDirectory();
  Hive.init(dic.path);
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>("task");
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    home: const HomePages(),
    );
  }
}

