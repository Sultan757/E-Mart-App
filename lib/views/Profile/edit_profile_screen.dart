import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_button.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    var controller2 = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //if data url and controller path is empty
                  data['imgUrl'] == '' && controller2.profileImgPath.isEmpty
                      ? Image.asset(imgProfile2,
                              width: 85, height: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      //if data url is not empty but controller path is empty
                      : data['imgUrl'] != '' &&
                              controller2.profileImgPath.isEmpty
                          //show network image
                          ? Image.network(data['imgUrl'],
                                  width: 85, height: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                          //if both are empty
                          : Image.file(File(controller2.profileImgPath.value),
                                  width: 85, height: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                  10.heightBox,
                  customButton(
                      title: 'Change',
                      textColor: whiteColor,
                      color: redColor,
                      onPress: () {
                        controller2.changeImage(context);
                      }),
                  20.heightBox,
                  customTextField(
                      hint: nameHint,
                      title: name,
                      isPass: false,
                      controller: controller2.nameController),
                  10.heightBox,
                  customTextField(
                      hint: passwordHint,
                      title: oldpass,
                      isPass: true,
                      controller: controller2.oldPassController),
                  10.heightBox,
                  customTextField(
                      hint: passwordHint,
                      title: newpass,
                      isPass: true,
                      controller: controller2.newPassController),
                  20.heightBox,
                  controller2.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : SizedBox(
                          width: context.screenWidth - 60,
                          child: customButton(
                              title: 'Save',
                              textColor: whiteColor,
                              color: redColor,
                              onPress: () async {
                                controller2.isLoading(true);
                                if (controller2
                                    .profileImgPath.value.isNotEmpty) {
                                  await controller2.uploadImage();
                                } else {
                                  controller2.profileImgLink = data['imgUrl'];
                                }
                                //if entered password equal to old password
                                if (data['password'] ==
                                    controller2.oldPassController.text) {
                                  //update credentials
                                  await controller2.changeAuthPassword(
                                      email: data['email'],
                                      password:
                                          controller2.oldPassController.text,
                                      newpassword:
                                          controller2.newPassController.text);
                                  //profile update
                                  await controller2.updateProfile(
                                    imgUrl: controller2.profileImgLink,
                                    name: controller2.nameController.text,
                                    password:
                                        controller2.newPassController.text,
                                  );
                                  VxToast.show(context, msg: 'Profile Updated');
                                } else {
                                  VxToast.show(context,
                                      msg: "Wrong old password");
                                  controller2.isLoading(false);
                                }
                              }),
                        ),
                ],
              )
                  .box
                  .rounded
                  .shadowSm
                  .white
                  .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                  .padding(const EdgeInsets.all(16))
                  .make(),
            )));
  }
}
