import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/common/login/login_bloc.dart';
import 'package:hub008/blocs/common/login/login_event.dart';
import 'package:hub008/blocs/common/login/login_state.dart';
import 'package:hub008/config/constants.dart';
import 'package:hub008/config/environment.dart';
import 'package:hub008/enums/user_role.dart';
import 'package:hub008/models/user.dart';
import 'package:hub008/pages/admin/admin_home.dart';
import 'package:hub008/pages/super_admin/super_admin_home.dart';
import 'package:hub008/pages/user/user_home.dart';
import 'package:hub008/utils/globals.dart';
import 'package:hub008/widgets/app_loader.dart';
import 'package:hub008/widgets/toaster.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleLogin() {
    // if (formKey.currentState!.validate()) {
    context.read<LoginBloc>().add(const Login());
    // }
  }

  Widget _renderLoginForm() {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: userNameController,
              decoration: const InputDecoration(
                labelText: Constants.userName,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "${Constants.userName} shouldn't be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: Constants.password,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "${Constants.password} shouldn't be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 32.0),
            SizedBox(
                width: deviceWidth * 0.8,
                child: ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text(Constants.login)))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.login)),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
            if (state is LoginDone) {
              _handleNavigation(state.loggedUser);
            }
          }, child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state is LoginLoading) {
              return const AppLoader();
            }
            if (state is LoginError) {
              showToast(msg: "Error");
            }
            return _renderLoginForm();
          }))),
    );
  }

  void _handleNavigation(User? loggedUser) {
    Widget homePage = const UserHome();
    if (loggedUser?.userRole == "superAdmin") {
      homePage = const SuperAdminHome();
    } else if (loggedUser?.userRole == "admin") {
      homePage = const AdminHome();
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => homePage));
  }
}
