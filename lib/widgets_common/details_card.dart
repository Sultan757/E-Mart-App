import 'package:emart_app/consts/consts.dart';

Widget detailsCard(width, String? title, String? count) {
  return Column(  
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.color(darkFontGrey).color(darkFontGrey).bold.make(),
      5.heightBox,
      title!.text.color(darkFontGrey).color(darkFontGrey).bold.make(),
    ],
  )
      .box
      .rounded
      .width(width)
      .padding(const EdgeInsets.all(4))
      .height(70)
      .white
      .make();
}
