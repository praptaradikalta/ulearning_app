import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

AppBar buildAppbar() {
  return AppBar(
    title: Container(
      child: Container(
        child: Text(
          "Settings",
          style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        ),
      ),
    ),
  );
}

Widget settingsButton(BuildContext context, void Function()? func) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm logout"),
              content: Text("Confirm logout"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel")),
                TextButton(onPressed: func, child: const Text("Confirm")),
              ],
            );
          });
    },
    child: Container(
      height: 100.w,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage("assets/icons/Logout.png")),
      ),
    ),
  );
}
