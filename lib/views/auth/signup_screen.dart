import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controllers.dart';
import 'package:emart_app/views/home/home.dart';
import 'package:get/get.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_button.dart';
import '../../widgets_common/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

bool isCheck = false;

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = Get.put(AuthController());
  //text controllers
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var reTypeController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  .10.heightBox,
                  const SizedBox(height: 10),
                  "Join the $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  .10.heightBox,
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      customTextField(
                          title: name,
                          hint: nameHint,
                          controller: nameController),
                      customTextField(
                          title: email,
                          hint: emailHint,
                          controller: emailController),
                      customTextField(
                          title: password,
                          isPass: true,
                          hint: passwordHint,
                          controller: passwordController),
                      customTextField(
                          title: retypePass,
                          hint: retypePassHint,
                          controller: reTypeController),

                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: forgetPass.text.make())),
                      .5.heightBox,
                      //check box for terms and conditions
                      Row(
                        children: [
                          Checkbox(
                              activeColor: redColor,
                              checkColor: whiteColor,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {
                                  isCheck = newValue!;
                                });
                              }),
                          .10.widthBox,
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(
                                  text: "I agree to the",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: termsAndConditions,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                              TextSpan(
                                  text: ' & ',
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  ))
                            ])),
                          ),
                          5.widthBox,
                        ],
                      ),
                      //SignUp Button
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor))
                          : customButton(
                              title: signUp,
                              textColor: whiteColor,
                              color: isCheck == true ? redColor : lightGrey,
                              onPress: () async {
                                try {
                                  if (isCheck != false) {
                                    await controller
                                        .signupMethed(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context)
                                        .then((value) {
                                      controller.storeUserData(
                                        password: passwordController.text,
                                        email: emailController.text,
                                        name: nameController.text,
                                      );
                                    }).then((value) {
                                      VxToast.show(context, msg: loggedIn);
                                      Get.offAll(() => const Home());
                                    });
                                  }
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                }
                              }).box.width(context.screenWidth - 50).make(),
                      .10.heightBox,
                      const SizedBox(height: 10),
                      //already have an account?
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: alreadyAcc,
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: login,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            )),
                      ])).onTap(() {
                        Get.back();
                      })
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .shadowSm
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .make(),
                ],
              ),
            )));
  }
}
