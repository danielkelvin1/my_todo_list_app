import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytodolist/model/task_model.dart';
import 'package:mytodolist/screen/add_task_screen.dart';
import 'package:mytodolist/screen/update_task_screen.dart';
import 'package:mytodolist/service/notification_service/notification_service.dart';
import 'package:mytodolist/utils/file_local.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool test = false;
  List<TaskModel> allTodoList = [];

  Future readAllNotes() async {
    final file = await localFile;
    if (await file.exists()) {
      final contents = await file.readAsString();
      final List allNotesJson = json.decode(contents);
      allTodoList = allNotesJson.map((e) => TaskModel.fromMap(e)).toList();
      setState(() {});
    }
  }

  Future updateNotes(int index, TaskModel taskModel) async {
    final file = await localFile;
    allTodoList[index] = taskModel;
    var toJson = json.encode(allTodoList.map((e) => e.toMap()).toList());
    file.writeAsString(toJson);
  }

  Future deleteNotes(int index) async {
    final file = await localFile;
    allTodoList.removeAt(index);
    var toJson = json.encode(allTodoList.map((e) => e.toMap()).toList());
    file.writeAsString(toJson);
    await readAllNotes();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 222,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/Header.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'October 20, 2022',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'My Todo List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width -
                  (MediaQuery.of(context).size.width * 0.1),
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  allTodoList
                          .where((element) => element.isComplete == false)
                          .isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: allTodoList
                                .where((element) => element.isComplete == false)
                                .toList()
                                .map((todo) {
                              var imageSrc = '';
                              var indexCategoryTask = CategoryTask.values
                                  .indexWhere((element) =>
                                      element.name == todo.category);

                              switch (CategoryTask.values[indexCategoryTask]) {
                                case CategoryTask.category1:
                                  imageSrc = "images/Category-1.png";
                                  break;
                                case CategoryTask.category2:
                                  imageSrc = "images/Category-2.png";
                                  break;
                                case CategoryTask.category3:
                                  imageSrc = "images/Category-3.png";
                                  break;
                              }

                              return Dismissible(
                                onDismissed: (direction) async {
                                  int searchIndex = allTodoList.indexWhere(
                                      (element) => element.id == todo.id);
                                  await deleteNotes(searchIndex);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Notes have been removed'),
                                      backgroundColor: Color(0xff4a3780),
                                    ),
                                  );
                                  setState(() {});
                                },
                                key: Key(todo.id),
                                child: ListTile(
                                  leading: Image.asset(imageSrc),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateTaskScreen(
                                            taskModel: todo,
                                          ),
                                        ));
                                  },
                                  title: Text(todo.title,
                                      overflow: TextOverflow.ellipsis),
                                  subtitle: Text("${todo.date} ${todo.time}"),
                                  trailing: Checkbox(
                                    value: todo.isComplete,
                                    onChanged: (value) async {
                                      var index = allTodoList.indexWhere(
                                          (element) => element.id == todo.id);
                                      TaskModel taskModel =
                                          todo.copyWith(isComplete: true);
                                      await updateNotes(index, taskModel);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 24,
                  ),
                  if (allTodoList
                      .where((element) => element.isComplete == true)
                      .isNotEmpty) ...[
                    const Text(
                      'Completed',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: allTodoList
                            .where((element) => element.isComplete == true)
                            .map((todo) {
                          var imageSrc = '';
                          var indexCategoryTask = CategoryTask.values
                              .indexWhere(
                                  (element) => element.name == todo.category);

                          switch (CategoryTask.values[indexCategoryTask]) {
                            case CategoryTask.category1:
                              imageSrc = "images/Category-1.png";
                              break;
                            case CategoryTask.category2:
                              imageSrc = "images/Category-2.png";
                              break;
                            case CategoryTask.category3:
                              imageSrc = "images/Category-3.png";
                              break;
                          }
                          return Dismissible(
                            key: Key(todo.id),
                            onDismissed: (direction) async {
                              int searchIndex = allTodoList.indexWhere(
                                  (element) => element.id == todo.id);
                              await deleteNotes(searchIndex);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Notes have been removed'),
                                  backgroundColor: Color(0xff4a3780),
                                ),
                              );
                              setState(() {});
                            },
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateTaskScreen(taskModel: todo),
                                  ),
                                );
                              },
                              leading: Image.asset(imageSrc),
                              title: RichText(
                                text: TextSpan(
                                  text: todo.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff49454e),
                                    overflow: TextOverflow.ellipsis,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  text: "${todo.date} ${todo.time}",
                                  style: const TextStyle(
                                    color: Color(0xff49454e),
                                    overflow: TextOverflow.ellipsis,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                              trailing: Checkbox(
                                value: todo.isComplete,
                                onChanged: (value) {
                                  var index = allTodoList.indexWhere(
                                      (element) => element.id == todo.id);
                                  TaskModel taskModel =
                                      todo.copyWith(isComplete: false);
                                  updateNotes(index, taskModel);
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4a3780),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTaskScreen(),
              ),
            );
          },
          child: const Text(
            'Add New Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
