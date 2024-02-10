import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hub008/blocs/common/login/login_bloc.dart';
import 'package:hub008/blocs/common/login/login_event.dart';
import 'package:hub008/config/constants.dart';
import 'package:hub008/pages/common/login_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const DrawerHeader(
          child: Text(
            Constants.appName,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text(Constants.home),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(Constants.logout),
          onTap: () {
            context.read<LoginBloc>().add(const Logout());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ]),
    );
  }
}
