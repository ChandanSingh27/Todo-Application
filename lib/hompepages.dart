import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_project/add_task.dart';
import 'package:todo_project/task_model.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  late Box openbox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openbox = Hive.box<TaskModel>("task");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task",
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddTask())),
        child: const Icon(CupertinoIcons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: openbox.listenable(),
        builder: (context, Box openbox, _) {
          List<int> keys = openbox.keys.cast<int>().toList();
          if (openbox.isEmpty) {
            return const Center(
              child: Text("Empty"),
            );
          } else {
            return ListView.builder(
              itemBuilder: (_, index) {
                final key = keys[index];
                TaskModel model = openbox.get(key);
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Are you really want delete."),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancel")),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          openbox.delete(key);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete"))
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child:Expanded(
                          flex: 1,
                          child: ListTile(
                            title: Text(model.title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            subtitle: Text(model.task),
                            trailing: Text(model.date),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: keys.length,
            );
          }
        },
      ),
    );
  }
}
