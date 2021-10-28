import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginController extends GetxController{

  var _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount>(null);

  login() async {
    googleAccount.value = await _googleSignIn.signIn();
  }
  logOut() async {
    googleAccount.value = await _googleSignIn.signOut();
  }

}
