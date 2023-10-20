import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';
import 'package:ulearning_app/pages/sign_in/Bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_bloc.dart';

// import '../app_blocs.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(lazy: false, create: (context) => WelcomeBloc()),
        // BlocProvider(lazy: false, create: (context) => AppBlocs()),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => RegisterBlocs()),
      ];
}
