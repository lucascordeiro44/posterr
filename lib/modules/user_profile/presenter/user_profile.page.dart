import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UserProfile')),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      shrinkWrap: true,
      children: const [
        Text('Nome', style: TextStyle(fontSize: 18, color: Colors.black)),
        Text('Joined Date', style: TextStyle(fontSize: 14))
      ],
    );
  }
}
