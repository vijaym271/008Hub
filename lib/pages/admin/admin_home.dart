import 'package:flutter/material.dart';
import 'package:hub008/config/constants.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.homeTitle)),
      body: const Center(child: Text('admin home Page')),
    );
  }
}
