import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/auth_controllers.dart';
import 'package:emart_app/views/auth/signup_screen.dart';
import 'package:emart_app/views/home/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_button.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

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
                  "Login to $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  .10.heightBox,
                  const SizedBox(height: 15),
                  Obx(
                    () => Column(
                      children: [
                        customTextField(
                            title: email,
                            hint: emailHint,
                            controller: controller.emailController,
                            isPass: false),
                        customTextField(
                            title: password,
                            hint: passwordHint,
                            controller: controller.passwordController,
                            isPass: true),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: forgetPass.text.make())),
                        .5.heightBox,
                        // customButton().box.width(context.screenWidth - 50).make()
                        //Login Button
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor))
                            : customButton(
                                title: login,
                                textColor: whiteColor,
                                color: redColor,
                                onPress: () async {
                                  controller.isLoading(true);

                                  await controller
                                      .loginMethed(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedIn);
                                      Get.offAll(() => const Home());
                                    } else {
                                      controller.isLoading(false);
                                    }
                                  });
                                }).box.width(context.screenWidth - 50).make(),
                        .5.heightBox,
                        newAccount.text.color(fontGrey).make(),
                        5.heightBox,
                        //Signup Button
                        customButton(
                            title: signUp,
                            textColor: redColor,
                            color: lightRed,
                            onPress: () {
                              Get.to(() => const SignUpScreen());
                            }).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        loginWith.text.color(fontGrey).make(),
                        .5.heightBox,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                3,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: lightGrey,
                                        child: Image.asset(
                                            socialIconList[index],
                                            width: 30),
                                      ),
                                    )))
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .shadowSm
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .make(),
                  ),
                ],
              ),
            )));
  }
}
