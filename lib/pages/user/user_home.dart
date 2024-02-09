import 'package:flutter/material.dart';
import 'package:hub008/config/constants.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.homeTitle)),
      body: const Center(child: Text('user home Page')),
    );
  }
}
