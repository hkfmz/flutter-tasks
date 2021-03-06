import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_2gether/pages/task_app/task_model.dart';
import 'package:logger/logger.dart';

class AddTaskCtrl extends GetxController {
  TextEditingController taskNameCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  List<TaskModel> taskList = List();
  Dio dio = new Dio();
  String baseUrl = "https://<api public>";
  final logger = Logger();
  TaskModel taskModel = TaskModel();
  final isTaskUploading = false.obs;
  // RxBool uploading=false.obs;

  // void postDataToDb() {
  // TaskModel taskModel = TaskModel(
  //   taskTitle: taskNameCtrl.text,
  //   // taskDetail: taskDetailCtrl
  // );

  // taskList.add(taskModel);
  // }

  void addTaskInList() {
    TaskModel taskModel = TaskModel(
      // taskTitle: addTaskCtrl?.taskNameCtrl?.text,
      taskTitle: taskNameCtrl?.text,
    );
    // print('taskname: ${addTaskCtrl?.taskNameCtrl?.text} ');

    taskList.add(taskModel);
    taskList.forEach((task) {
      print('${task.taskTitle}');
    });

    update();
    // addTaskCtrl.taskList.add(taskModel);
  }

  bool isUploading = false;

  void postTaskToDb() {
    print('inside postTaskToDb()');
    isUploading = true;
    update();
    print('isUploading: $isUploading');
    postingTaskToDb();
  }

  void postingTaskToDb() {
    print('inside postingTaskToDb');
    TaskModel taskModel = TaskModel(
      // taskTitle: addTaskCtrl?.taskNameCtrl?.text,
      taskTitle: taskNameCtrl?.text,
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      taskList.add(taskModel);
      taskList.forEach((task) {
        print('${task.taskTitle}');
      });

      isUploading = false;
      showSnackBar();
      update();
      print('isUploading: $isUploading');
      resetUi();
    });
  }


  void showSnackBar() {
    Get.snackbar(
      'Task posted!',
      '',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  resetUi() {
    taskNameCtrl.text = '';
    descriptionCtrl.text = '';
  }

  postTaskToMongoDB() async {
    isTaskUploading(true);
    // isTaskUploading.value=true;
    String apiUrl = "$baseUrl/userTask/createUserTask";
    logger.d("apiUrl is: $apiUrl");
    taskModel.taskTitle = taskNameCtrl.text;
    taskModel.taskDescription = descriptionCtrl.text;
    try {
      Response response = await dio.post(
        apiUrl,
        data: taskModel.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.d("response is : ${response.data.toString()}");
        resetUi();
        showSnackBar();
        return response;
      }
    } catch (e) {
      logger.e("catch error : ${e.message}");
    } finally {
      isTaskUploading(false);
    }
  }
}
