import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat/chat_screens.dart';
import 'package:emart_app/widgets_common/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../controllers/home_controllers.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.title, this.data});
  final String? title;
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String currentUserId = _auth.currentUser!.uid;
   // String recipientUser = FirebaseFirestore.instance.collection('users').doc('recieverId');
   // String receiverId = recipientUser;
    var controller = Get.put(HomeController());
    ProductController pcontroller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        pcontroller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        //appbar
        appBar: AppBar(
            // backgroundColor: lightGrey,,
            leading: IconButton(
                onPressed: () {
                  pcontroller.resetValues();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back)),
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_outlined)),
            ]),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //product slider
                            VxSwiper.builder(
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                height: 350,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                itemCount: data['p_imgs'].length,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    data['p_imgs'][index],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  );
                                }),
                            10.heightBox,
                            //product price
                            title!.text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make(),
                            10.heightBox,
                            //product rating
                            VxRating(
                              isSelectable: false,
                              value: double.parse(data['p_rating']),
                              onRatingUpdate: ((value) {}),
                              normalColor: textfieldGrey,
                              selectionColor: golden,
                              count: 5,
                              maxRating: 5,
                              size: 25,
                            ),
                            10.heightBox,
                            //product price
                            "${data['p_price']}"
                                .numCurrency
                                .text
                                .fontFamily(bold)
                                .color(redColor)
                                .size(16)
                                .make(),
                            5.heightBox,
                            //seller details
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      "${data['p_seller']}"
                                          .text
                                          .fontFamily(semibold)
                                          .white
                                          .make(),
                                      5.heightBox,
                                      'in house product'
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .color(darkFontGrey)
                                          .make(),
                                    ],
                                  ),
                                ),
                                const CircleAvatar(
                                  backgroundColor: whiteColor,
                                  child: Icon(
                                    Icons.message_rounded,
                                    color: darkFontGrey,
                                  ),
                                ).onTap(() {
                                  Get.to(() => ChatScreen(
                                      currentUserId: currentUserId,
                                      receiverId: currentUserId));
                                })
                              ],
                            )
                                .box
                                .color(textfieldGrey)
                                .height(70)
                                .padding(
                                    const EdgeInsets.symmetric(horizontal: 16))
                                .make(),
                            20.heightBox,
                            Obx(
                              () => Column(
                                children: [
                                  //quatity row
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: "Colors"
                                            .text
                                            .color(textfieldGrey)
                                            .make(),
                                      ),
                                      Row(
                                          children: List.generate(
                                        data['p_colors'].length,
                                        (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(0.75))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 6))
                                                  .make()
                                                  .onTap(() {
                                                pcontroller
                                                    .changeColorIndex(index);
                                              }),
                                              Visibility(
                                                visible: index ==
                                                    pcontroller
                                                        .colorIndex.value,
                                                child: const Icon(Icons.done,
                                                    color: whiteColor),
                                              )
                                            ]),
                                      ))
                                    ],
                                  )
                                      .box
                                      .padding(const EdgeInsets.all(8.0))
                                      .make(),

                                  //quality row
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: "Quantity"
                                            .text
                                            .color(textfieldGrey)
                                            .make(),
                                      ),
                                      Obx(
                                        () => Row(children: [
                                          IconButton(
                                              onPressed: () {
                                                pcontroller.decreaseQuantity();
                                                pcontroller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: const Icon(
                                                  Icons.remove_outlined)),
                                          pcontroller.quantity.value.text
                                              .size(16)
                                              .fontFamily(bold)
                                              .color(darkFontGrey)
                                              .make(),
                                          5.widthBox,
                                          IconButton(
                                              onPressed: () {
                                                pcontroller.increaseQuantity(
                                                    int.parse(
                                                        data['p_quantity']));
                                                pcontroller.calculateTotalPrice(
                                                    int.parse(data['p_price']));
                                              },
                                              icon: const Icon(
                                                  Icons.add_outlined)),
                                          10.widthBox,
                                          "(${data['p_quantity']} available)"
                                              .text
                                              .color(textfieldGrey)
                                              .make(),
                                        ]),
                                      ),
                                    ],
                                  )
                                      .box
                                      .padding(const EdgeInsets.all(8.0))
                                      .make(),

                                  ///total price row
                                  Obx(
                                    () => Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: "Total Price"
                                              .text
                                              .color(textfieldGrey)
                                              .make(),
                                        ),
                                        Row(children: [
                                          "${pcontroller.totalPrice.value}"
                                              .numCurrency
                                              .text
                                              .fontFamily(bold)
                                              .color(redColor)
                                              .size(16)
                                              .make()
                                        ]),
                                      ],
                                    )
                                        .box
                                        .padding(const EdgeInsets.all(8.0))
                                        .make(),
                                  ),
                                ],
                              ).box.white.shadowSm.make(),
                            ),
                            10.heightBox,
                            "Description"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${data['p_descp']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(
                                  controller.itemDetailsButtonList.length,
                                  (index) => ListTile(
                                        title: controller
                                            .itemDetailsButtonList[index].text
                                            .color(darkFontGrey)
                                            .fontFamily(semibold)
                                            .make(),
                                        trailing:
                                            const Icon(Icons.arrow_forward),
                                      )),
                            ),
                            20.heightBox,
                            productyoumay.text
                                .fontFamily(bold)
                                .color(darkFontGrey)
                                .size(16)
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                6,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(imgP1,
                                        width: 150, fit: BoxFit.cover),
                                    10.heightBox,
                                    "Laptop 4GB/300GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$800"
                                        .text
                                        .fontFamily(bold)
                                        .color(redColor)
                                        .size(16)
                                        .make(),
                                    10.heightBox,
                                  ],
                                )
                                    .box
                                    .white
                                    .rounded
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(12))
                                    .make(),
                              )),
                            )
                          ]),
                    ))),
            //add to cart and buy now buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: (context.screenWidth * 0.4),
                    height: 60,
                    child: customButton(
                        onPress: () {
                          pcontroller.addToCart(
                            context: context,
                            title: data['p_name'],
                            sellername: data['p_seller'],
                            color: data['p_colors']
                                [pcontroller.colorIndex.value],
                            img: data['p_imgs'][0],
                            tprice: pcontroller.totalPrice.value,
                            qty: pcontroller.quantity.value,
                          );
                          VxToast.show(context, msg: "Added to the cart");
                        },
                        color: redColor,
                        textColor: whiteColor,
                        title: 'Add to Cart'),
                  ),
                  SizedBox(
                    width: (context.screenWidth * 0.4),
                    height: 60,
                    child: customButton(
                        onPress: () {},
                        color: golden,
                        textColor: whiteColor,
                        title: 'Buy Now'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
