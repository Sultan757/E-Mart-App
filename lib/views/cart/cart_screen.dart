import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controllers.dart';
import 'package:emart_app/services/firebase_service.dart';
import 'package:emart_app/widgets_common/custom_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: 'Shopping Cart'
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            stream: FireStoreService.getCart(currentUser!.uid),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor)),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: "Cart is Empty"
                        .text
                        .size(16)
                        .color(darkFontGrey)
                        .make());
              } else {
                var data = snapshot.data!.docs;
                cartController.calculate(data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((BuildContext context, int index) {
                              return ListTile(
                                  leading: Image.network(
                                      "${snapshot.data!.docs[index]['img']}"),
                                  title:
                                      "${snapshot.data!.docs[index]['title']} x${snapshot.data!.docs[index]['qty']}"
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                  subtitle:
                                      "${snapshot.data!.docs[index]['tprice']}"
                                          .numCurrency
                                          .text
                                          .size(14)
                                          .fontFamily(semibold)
                                          .make(),
                                  trailing:
                                      const Icon(Icons.delete, color: redColor)
                                          .onTap(() {
                                    FireStoreService.deleteDocument(
                                        data[index].id);
                                  }));
                            }))),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            "Total Price"
                                .text
                                .color(darkFontGrey)
                                .size(14)
                                .make(),
                            Obx(
                              () => "${cartController.totalP.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(14)
                                  .make(),
                            ),
                          ])
                          .box
                          .padding(const EdgeInsets.all(12))
                          .roundedSM
                          .color(golden)
                          .make(),
                    ),
                    10.heightBox,
                    SizedBox(
                      width: context.screenWidth - 60,
                      child: customButton(
                          title: 'Proceed to shipping',
                          color: redColor,
                          textColor: whiteColor,
                          onPress: () {}),
                    ),
                  ]),
                );
              }
            })));
  }
}
