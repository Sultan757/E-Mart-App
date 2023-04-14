import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/custom_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure to want exit?"
            .text
            .fontFamily(bold)
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
                color: redColor,
                textColor: whiteColor,
                title: 'Yes',
                onPress: () {
                  SystemNavigator.pop();
                }),
            customButton(
                color: redColor,
                textColor: whiteColor,
                title: 'No',
                onPress: () {
                  Navigator.pop(context);
                })
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
