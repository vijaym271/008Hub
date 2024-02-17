import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hub008/blocs/common/login/login_bloc.dart';
import 'package:hub008/blocs/super_admin/base_image/base_image_bloc.dart';
import 'package:hub008/config/app_theme.dart';
import 'package:hub008/injection_container.dart';
import 'package:hub008/pages/common/login_page.dart';
import 'package:hub008/utils/common_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  initializeDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(
        create: (context) => sl<LoginBloc>(),
      ),
      BlocProvider<BaseImageBloc>(
        create: (context) => sl<BaseImageBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    setDeviceDimensions(context);
    return MaterialApp(
      title: '008Hub',
      theme: AppTheme.getLightTheme(),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
