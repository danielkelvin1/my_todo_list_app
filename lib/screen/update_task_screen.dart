// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mytodolist/model/task_model.dart';
import 'package:mytodolist/screen/add_task_screen.dart';
import 'package:mytodolist/screen/main_screen.dart';
import 'package:mytodolist/utils/date_time_extension.dart';
import 'package:mytodolist/utils/file_local.dart';
import 'package:mytodolist/utils/validaton_mixin.dart';
import 'package:mytodolist/widgets/q_radio_circle_image.dart';
import 'package:mytodolist/widgets/q_text_field.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({
    Key? key,
    required this.taskModel,
  }) : super(key: key);
  final TaskModel taskModel;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen>
    with validationMixin {
  CategoryTask _groupImageCircle = CategoryTask.category1;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var searchCategory = CategoryTask.values
        .indexWhere((element) => element.name == widget.taskModel.category);
    _groupImageCircle = CategoryTask.values[searchCategory];
    _taskTitleController.text = widget.taskModel.title;
    _dateController.text = widget.taskModel.date;
    _timeController.text = widget.taskModel.time;
    _notesController.text = widget.taskModel.notes;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _taskTitleController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future saveNotes() async {
    final file = await localFile;
    String title = _taskTitleController.text;
    String category = _groupImageCircle.name;
    String date = _dateController.text;
    String time = _timeController.text;
    String notes = _notesController.text;
    final TaskModel newTaskModel = widget.taskModel.copyWith(
      title: title,
      category: category,
      date: date,
      time: time,
      notes: notes,
    );
    final contents = await file.readAsString();
    List allNotesJosn = json.decode(contents);
    List<TaskModel> allNotes =
        allNotesJosn.map((e) => TaskModel.fromMap(e)).toList();
    int searchIndexTask =
        allNotes.indexWhere((element) => element.id == newTaskModel.id);
    allNotes[searchIndexTask] = newTaskModel;
    var toJson = json.encode(allNotes.map((e) => e.toMap()).toList());
    file.writeAsString(toJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(96),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Header-Add-Task.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16.0,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    'images/Back Button.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.taskModel.isComplete ? 'Task' : 'Update Task',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task Title',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                QTextField(
                  label: 'Task Title',
                  controller: _taskTitleController,
                  validator: emptyValidation,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 24.0,
                    ),
                    QRadioCircleImage(
                      groupValue: _groupImageCircle,
                      value: CategoryTask.category1,
                      imageAssetSrc: 'images/Category-1.png',
                      onTapButton: (value) {
                        setState(() {
                          _groupImageCircle = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    QRadioCircleImage(
                      groupValue: _groupImageCircle,
                      value: CategoryTask.category2,
                      imageAssetSrc: 'images/Category-2.png',
                      onTapButton: (value) {
                        setState(() {
                          _groupImageCircle = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    QRadioCircleImage(
                      groupValue: _groupImageCircle,
                      value: CategoryTask.category3,
                      imageAssetSrc: 'images/Category-3.png',
                      onTapButton: (value) {
                        setState(() {
                          _groupImageCircle = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime firstDate = DateTime(2023);
                              DateTime inital = DateTime.now();
                              if (_dateController.text.trim().isNotEmpty) {
                                inital = _dateController.text.convertToDate();
                              }
                              DateTime lastDate = firstDate.add(
                                const Duration(days: 365 * 20),
                              );
                              var result = await showDatePicker(
                                context: context,
                                initialDate: inital,
                                firstDate: firstDate,
                                lastDate: lastDate,
                              );
                              if (result != null) {
                                _dateController.text =
                                    DateFormat('yyyy-MM-dd').format(result);
                              }
                            },
                            child: QTextField(
                              label: 'Date',
                              controller: _dateController,
                              validator: emptyValidation,
                              enabled: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              suffixIcon: Icons.calendar_today_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Time',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              TimeOfDay initial = TimeOfDay.now();
                              if (_timeController.text.trim().isNotEmpty) {
                                initial =
                                    _timeController.text.convertToTimeOfDay();
                              }
                              var result = await showTimePicker(
                                context: context,
                                initialTime: initial,
                              );
                              if (result != null) {
                                _timeController.text =
                                    "${result.hour < 10 ? 0 : ''}${result.hour}:${result.minute < 10 ? 0 : ''}${result.minute}";
                              }
                            },
                            child: QTextField(
                              label: 'Time',
                              controller: _timeController,
                              enabled: false,
                              validator: emptyValidation,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              suffixIcon: Icons.access_time,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                QTextField(
                  label: 'Notes',
                  controller: _notesController,
                  validator: emptyValidation,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  minLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.taskModel.isComplete
          ? const SizedBox()
          : Container(
              height: 56,
              margin: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 12, top: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4a3780),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _dateController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty) {
                    await saveNotes();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (route) => false);
                  } else {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      text: 'Isi semua form termasuk Date dan Time',
                    );
                  }
                },
                child: const Text(
                  'Save',
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
