// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';

class DeleteStaffScreen extends GetWidget<AuthController> {
  const DeleteStaffScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Staff'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                if (controller.isLoading.value)
                 const LinearProgressIndicator(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                        radius: 26,
                        child: Text(
                          controller.staffs[index].name[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                    title: Text(controller.staffs[index].name),
                    trailing: ElevatedButton(
                      onPressed: () async => await controller
                          .deleteStaff(controller.staffs[index].userId),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ),
                  itemCount: controller.staffs.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
