import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controllers.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category/category_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController productcontroller = Get.put(ProductController());

    HomeController homecontroller = Get.put(HomeController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: redColor,
          shadowColor: Colors.transparent,
          // leading: const Icon(Icons.arrow_back),
          title: categories.text.fontFamily(bold).white.make()),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200,
            ),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(homecontroller.categoryImages[index],
                      width: 200, height: 120, fit: BoxFit.cover),
                  10.heightBox,
                  homecontroller.categoryTitles[index].text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .make(),
                ],
              )
                  .box
                  .white
                  .padding(const EdgeInsets.all(8))
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadow
                  .make()
                  .onTap(() {
                productcontroller
                    .getSubCategories(homecontroller.categoryTitles[index]);
                Get.to(() => CategoryDetails(
                    title: homecontroller.categoryTitles[index]));
              });
            }),
      ),
    ));
  }
}
