import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/home/home.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  //progress indicator
  // onLoading(context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //           backgroundColor: Colors.transparent,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Image.asset(icAppLogo, width: 40, height: 50).box.alignCenter.make(),
  //               const Text("Loading"),
  //             ],
  //           ));
  //     },
  //   );
  //   Future.delayed(const Duration(seconds: 1), () {
  //     Get.to(()=> const Home()); //pop dialog
  //   });
  // }

  //login text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  //login method
  Future<UserCredential?> loginMethed({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethed({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //user details store method
  storeUserData({
    name,
    password,
    email,
  }) async {
    DocumentReference store =
        await firestore.collection(userCollection).doc(currentUser!.uid);
     
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imgUrl': '',
      'id': currentUser!.uid,
      'cart_count': "00",
      'wishlist_count': "00",
      'orders_count': "00",
    });
   
  }

//signout method
  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
