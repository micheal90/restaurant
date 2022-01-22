// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.white, KprimaryColor],
              begin: Alignment.center,
              end: Alignment.topCenter,
            )),
          ),
        GetBuilder<AuthController>(
          init: Get.find<AuthController>()  ,
          builder:(controller) =>  Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage('https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black54)),
                                onPressed: ()=>controller.signOut(),
                                child: const Text('Log Out'),
                              ))
                        ],
                      ),
                    ),
                    Text(
                      controller.userModel.value!.name,
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Text(controller.userModel.value!.role),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children:const [
                        PersonDetailsItem(
                          count: 140,
                          text: 'Order',
                        ),
                         SizedBox(
                          width: 15,
                        ),
                        PersonDetailsItem(
                          count: 2400,
                          text: 'Your eat',
                        ),
                         SizedBox(
                          width: 20,
                        ),
                        PersonDetailsItem(
                          count: 1.980,
                          text: 'Time spend',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const CustomContainer(
                      leadind: Icon(Icons.notifications),
                      title: 'Notifications',
                      traling: Text('All'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomContainer(
                      leadind: Icon(Icons.settings),
                      title: 'General',
                      traling: Text('Compress Photos'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomContainer(
                      leadind: Icon(Icons.help),
                      title: 'Help',
                      traling: Text('Questions?'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.title,
    required this.leadind,
    required this.traling,
  }) : super(key: key);
  final String title;
  final Widget leadind;
  final Widget traling;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: KprimaryColor,
      ),
      child: ListTile(
        leading: leadind,
        title: Text(title),
        trailing: traling,
      ),
    );
  }
}

class PersonDetailsItem extends StatelessWidget {
  const PersonDetailsItem({
    Key? key,
    required this.count,
    required this.text,
  }) : super(key: key);
  final double count;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: KprimaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
