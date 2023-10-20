import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/sign_in/Bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignin(String type) async {
    try {
      if (type == "email") {
        //BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        //pengujian email
        if (emailAddress.isEmpty) {
          toastInfo(msg: "You need to fill email address");
          return;
        }
        //pengujian password
        if (password.isEmpty) {
          toastInfo(msg: "You need to fill password");
          return;
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          // print("credential user : $credential");
          if (credential.user == null) {
            //print("user does not exist");
            toastInfo(msg: "You don't exist");
            return;
          }
          if (!credential.user!.emailVerified) {
            // print("not varified");
            toastInfo(msg: "You need to verify email account");
            return;
          }

          var user = credential.user;
          if (user != null) {
            //  we got verified user from firebase
            print("user exist");
            Global.storageService
                .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "12345678");
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/application", (route) => false);
          } else {
            //  we have error getting user from firebase
            // print("no user");
            toastInfo(msg: "Currently you are not a user of this app");
            return;
          }
        } on FirebaseAuthException catch (e) {
          print("tangkapan error code : ${e.code}");
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            toastInfo(msg: "No user found for that email");
            //  toastInfo(msg: "No user found for that email.");
            //   return;
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            toastInfo(msg: "Wrong password provided for that user");
            // return;
          } else if (e.code == 'invalid-email') {
            print("Your email format is wrong");
            toastInfo(msg: "Your email address format is wrong");
            // return;
          } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
            toastInfo(msg: "Login credentials are invalid.");
          } else {
            print("Error : ${e.code}");
            toastInfo(msg: " Error : ${e.code}");
            // return;
          }
        }
      }
      //  batas block if
    } catch (e) {
      print("Nyasar kemari...");
      print(e.toString());
      return;
    }
  }
}
