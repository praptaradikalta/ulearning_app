import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/profile/settings/widgets/settings_widgets.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_states.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void removeUserData() {
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);

    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.SING_IN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBlocs, SettingStates>(
          builder: (context, state) {
            return Container(
              child: Column(
                children: [settingsButton(context, removeUserData)],
              ),
            );
          },
        ),
      ),
    );
  }
}
