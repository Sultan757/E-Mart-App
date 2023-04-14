import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controllers.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firebase_service.dart';
import 'package:emart_app/views/Profile/edit_profile_screen.dart';
import 'package:emart_app/views/auth/login_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/details_card.dart';
import 'package:get/get.dart';

import '../../controllers/home_controllers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    ProfileController controller3 = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreService.getUser(currentUser!.uid),
      builder: ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor)));
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: const Icon(Icons.edit, color: whiteColor).onTap(() {
                      controller3.nameController.text = data['name'];
                      controller3.newPassController.text = data['password'];
                      Get.to(() => EditProfileScreen(data: data));
                    }),
                  ),
                ),
                //10.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      data['imgUrl'] == ''
                          ? Image.asset(imgProfile2,
                                  width: 85, height: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                          : Image.network(data['imgUrl'],
                                  width: 85, height: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                      10.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .white
                                .fontFamily(bold)
                                .make(),
                            5.heightBox,
                            "${data['email']}"
                                .text
                                .white
                                .fontFamily(semibold)
                                .make(),
                          ],
                        ),
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: whiteColor),
                          ),
                          onPressed: () {
                            Get.put(AuthController()).signOutMethod(context);
                            Get.offAll(() => const LoginScreen());
                            VxToast.show(context, msg: loggedOut);
                          },
                          child: logout.text.white.fontFamily(semibold).make())
                    ],
                  ),
                ),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsCard(context.screenWidth / 3.4, 'in your count',
                        "${data['cart_count']}"),
                    detailsCard(context.screenWidth / 3.4, 'in your wishlist',
                        "${data['wishlist_count']}"),
                    detailsCard(context.screenWidth / 3.4, 'your orders',
                        "${data['orders_count']}"),
                  ],
                ),

                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(color: lightGrey);
                  },
                  itemCount: controller.profileDetailsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: Image.asset(
                            controller.profileDetailsButtons[index],
                            width: 22),
                        title: controller.profileDetailsList[index].text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make());
                  },
                )
                    .box
                    .rounded
                    .white
                    .margin(const EdgeInsets.all(12))
                    .shadowSm
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .make()
                    .box
                    .color(redColor)
                    .make()
              ],
            ),
          );
        }
      }),
    )));
  }
}
