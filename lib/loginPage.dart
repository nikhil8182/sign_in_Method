import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_example/loginController.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google sign In"),
      ),
      body: Container(
        child: Center(
            child:
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     CircleAvatar(
            //       //backgroundImage: Image.network(controller.googleAccount.value.photoUrl ?? " ").image,
            //       radius: 100,
            //     ),
            //     Text("controller.googleAccount.value.displayName ?? " ""),
            //     Text("controller.googleAccount.value.email ?? " ""),
            //     // ActionChip(label: Text("logout"), onPressed: (){
            //     //   controller.logOut();
            //     // })
            //   ],
            // )
        Obx(() {
          if (controller.googleAccount.value == null) {
            return buildSignInButton();
          } else {
            return buildProfileview();
          }
        })


        ),
      ),
    );
  }

  Column buildProfileview() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(controller.googleAccount.value.photoUrl ?? " ").image,
          radius: 100,
        ),
        Text(controller.googleAccount.value.displayName ?? " "),
        Text(controller.googleAccount.value.email ?? " "),
        ActionChip(label: Text("logout"), onPressed: (){
          controller.logOut();
        })
      ],
    );
  }

  FloatingActionButton buildSignInButton() {
    return FloatingActionButton.extended(
      onPressed: () {
       controller.login();
      },
      label: Text("Signin with google"),
    );
  }
}
