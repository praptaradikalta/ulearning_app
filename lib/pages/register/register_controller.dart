import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBlocs>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (userName.isEmpty) {
      toastInfo(msg: "User name can not be empty");
      return;
    }

    if (email.isEmpty) {
      toastInfo(msg: "Email name can not be empty");
      return;
    }

    if (password.isEmpty) {
      toastInfo(msg: "Password name can not be empty");
      return;
    }

    if (rePassword.isEmpty) {
      toastInfo(msg: "Your password confirmation is wrong");
      return;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(userName);
        toastInfo(
            msg:
                "An email has been sent to your register email. To activate it please check your email box and click on the link above");
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: "The email is already in use");
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: "your email id is invalid");
      }
    }
  }
}
