import 'package:emart_app/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller, bool ? isPass }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      .5.heightBox,
      TextFormField(
        obscureText: isPass != null ? isPass:false,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: hint,
            fillColor: lightGrey,
            filled: true,
            isDense: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      10.heightBox,
    ],
  );
}
