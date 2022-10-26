import 'package:hive/hive.dart';

part 'task_model.g.dart';
@HiveType(typeId: 0)
class TaskModel{
 
  @HiveField(0)
  String title;
  @HiveField(1)
  String task;
  @HiveField(2)
  String durations;
  @HiveField(3)
  String date;
  @HiveField(4)
  String time;

  TaskModel(this.title, this.task, this.durations, this.date, this.time);
}