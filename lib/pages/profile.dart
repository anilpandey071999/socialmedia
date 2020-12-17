import 'package:flutter/material.dart';
import 'package:socalnetwork/widgets/header.dart';
import 'package:socalnetwork/widgets/progress.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        titleText: "Profile",
      ),
      body: linearProgress(),
    );
  }
}