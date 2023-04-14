import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firebase_service.dart';
import 'package:emart_app/views/category/item_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key, required this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: redColor,
              shadowColor: Colors.transparent,
              title: title!.text.fontFamily(bold).white.make(),
            ),
            body: StreamBuilder(
                stream: FireStoreService.getproducts(title),
                builder: ((BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor)),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: "Products not found"
                            .text
                            .color(darkFontGrey)
                            .make());
                  } else {
                    //var data = snapshot.data!.docs;
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: List.generate(
                                    controller.subCat.length,
                                    (index) => "${controller.subCat[index]}"
                                        .text
                                        .size(12)
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .makeCentered()
                                        .box
                                        .size(120, 60)
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .rounded
                                        .white
                                        .make())),
                          ),
                          20.heightBox,
                          //all products view
                          Expanded(
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 240,
                                ),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                          snapshot.data!.docs[index]['p_imgs']
                                              [index],
                                          width: 200,
                                          height: 160,
                                          fit: BoxFit.cover),
                                      //const Spacer(),
                                      .5.heightBox,
                                      "${snapshot.data!.docs[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      .10.heightBox,
                                      "${snapshot.data!.docs[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .fontFamily(bold)
                                          .color(redColor)
                                          .size(16)
                                          .make(),
                                      .10.heightBox,
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .padding(const EdgeInsets.all(8))
                                      .roundedSM
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                        title: snapshot.data!.docs[index]
                                            ['p_name'],
                                        data: snapshot.data!.docs[index]));
                                  });
                                }),
                          )
                        ],
                      ),
                    );
                  }
                }))));
  }
}
