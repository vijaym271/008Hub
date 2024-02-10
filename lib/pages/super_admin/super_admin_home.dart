import 'package:flutter/material.dart';
import 'package:hub008/config/constants.dart';
import 'package:hub008/pages/super_admin/design_page.dart';
import 'package:hub008/widgets/app_drawer.dart';

class SuperAdminHome extends StatefulWidget {
  const SuperAdminHome({super.key});

  @override
  State<SuperAdminHome> createState() => _SuperAdminHomeState();
}

class _SuperAdminHomeState extends State<SuperAdminHome> {
  Widget _renderAddBtn() {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DesignPage()));
        },
        icon: const Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.homeTitle),
        actions: [_renderAddBtn()],
      ),
      drawer: const AppDrawer(),
      body: const Center(child: Text('super home Page')),
    );
  }
}
