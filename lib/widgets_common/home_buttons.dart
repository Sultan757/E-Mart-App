import 'package:emart_app/consts/consts.dart';

Widget homeButton({height, width, String? title, icon, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 26),
      .10.heightBox,
      const SizedBox(height: 10),
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.size(width, height).color(whiteColor).shadowSm.make();
}
