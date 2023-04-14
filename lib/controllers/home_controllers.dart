import 'package:emart_app/views/Profile/profile_screen.dart';
import 'package:emart_app/views/cart/cart_screen.dart';
import 'package:emart_app/views/category/category_screen.dart';
import 'package:emart_app/views/home/home_screen.dart';
import 'package:get/state_manager.dart';
import 'package:emart_app/consts/consts.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var username = '';
  getUsername() async {
    var name = await firestore
        .collection(userCollection)
        .where("id", isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = name;
    
  }

  var navBarItem = [
    BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
    BottomNavigationBarItem(
        icon: Image.asset(icCategories, width: 26), label: category),
    BottomNavigationBarItem(icon: Image.asset(icCart, width: 26), label: cart),
    BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 26), label: account),
  ];
  var navBody = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  var sliderList = [
    imgSlider1,
    imgSlider2,
    imgSlider3,
    imgSlider4,
  ];
  var secondSliderList = [
    imgSs1,
    imgSs2,
    imgSs3,
    imgSs4,
  ];
  //featured catgories
  var featuredImages1 = [
    imgS1,
    imgS2,
    imgS3,
  ];
  var featuredImages2 = [
    imgS4,
    imgS5,
    imgS6,
  ];
  var featuredTitles1 = [
    womenDress,
    girlsDress,
    girlsWatches,
  ];
  var featuredTitles2 = [
    boysGlasses,
    tshirts,
    mobilePhones,
  ];
  var categoryTitles = [
    menClothingFashion,
    compAccess,
    automobile,
    kidstoys,
    sports,
    cellphone,
    womenClothing,
    jewelery,
    furniture
  ];
  var categoryImages = [
    imgFc1,
    imgFc2,
    imgFc3,
    imgFc4,
    imgFc5,
    imgFc6,
    imgFc7,
    imgFc8,
    imgFc9,
  ];
  var itemDetailsButtonList = [
    videos,
    reviews,
    returnPolicy,
    supportPolicy,
    sellerPolicy
  ];
  var profileDetailsList = [
    myOrder,
    myWishlist,
    messages,
  ];
  var profileDetailsButtons = [icOrders, icOrder, icMessages];
}
