import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controllers.dart';
import 'package:emart_app/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Obx(() => Container(
            child:
                controller.navBody.elementAt(controller.currentIndex.value))),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            backgroundColor: whiteColor,
            items: controller.navBarItem,
            onTap: ((newValue) {
              controller.currentIndex.value = newValue;
            }),
          ),
        ),
      ),
    );
  }
}
