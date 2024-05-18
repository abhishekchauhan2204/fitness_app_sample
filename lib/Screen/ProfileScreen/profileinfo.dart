import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;

  ProfileInfo({
    required this.title,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
    );
  }
}

