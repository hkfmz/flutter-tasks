import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:learn_2gether/pages/task_app/add_task/controller/add_task_ctrl.dart';
import 'package:learn_2gether/pages/task_app/display_task/controller/display_task_ctrl.dart';
import 'package:logger/logger.dart';

// ignore: unused_import
import '../task_model.dart';
import 'views/add_task_button.dart';
import 'views/task_list.dart';

class DisplayTask extends StatefulWidget {
  @override
  _DisplayTaskState createState() => _DisplayTaskState();
}

class _DisplayTaskState extends State<DisplayTask> {
  final displayTaskCtrl = Get.put<DisplayTaskCtrl>(DisplayTaskCtrl());
  Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          AddTaskButton(),
          Flexible(child: TaskList()),
        ],
      )),
    );
  }
}
