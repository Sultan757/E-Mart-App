import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controllers.dart';
import 'package:emart_app/widgets_common/featured_button.dart';
import 'package:emart_app/widgets_common/home_buttons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     HomeController controller = Get.find();
    
    return Container(
        color: lightGrey,
        height: context.screenHeight,
        width: context.screenWidth,
        child: SafeArea(
            child: Column(
          children: [
            //search box
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: TextFormField(
                    decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textfieldGrey),
                )),
              ),
            ),
            //first slider
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: controller.sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          controller.sliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  //home buttons(2)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            title: index == 0 ? todayDeal : flashSale,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal),
                      )),
                  10.heightBox,
                  //second slider
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: controller.secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          controller.secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  .10.heightBox,
                  const SizedBox(height: 10),
                  //home buttons(3)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brands
                                    : topSellers,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller),
                      )),
                  10.heightBox,
                  //featured category text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategory.text
                          .fontFamily(semibold)
                          .size(18)
                          .color(darkFontGrey)
                          .make(),
                    ),
                  ),
                  20.heightBox,
                  //featured categories view
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      icon: controller.featuredImages1[index],
                                      title: controller.featuredTitles1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      icon: controller.featuredImages2[index],
                                      title: controller.featuredTitles2[index])
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: redColor),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text
                              .fontFamily(bold)
                              .color(whiteColor)
                              .size(18)
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
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(12))
                                  .make(),
                            )),
                          )
                        ],
                      )),
                  20.heightBox,
                  //third slider
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: controller.secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          controller.secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  20.heightBox,
                  //all products view
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP6,
                                width: 200, height: 200, fit: BoxFit.fill),
                            const Spacer(),
                            "Laptop 4GB/300GB"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            .10.heightBox,
                            "\$800"
                                .text
                                .fontFamily(bold)
                                .color(redColor)
                                .size(16)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(const EdgeInsets.all(8))
                            .roundedSM
                            .make();
                      })
                ]),
              ),
            )
          ],
        )));
  }
}
