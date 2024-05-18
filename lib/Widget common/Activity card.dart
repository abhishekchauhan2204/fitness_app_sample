import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/material.dart';

import '../Screen/ProfileScreen/ProfileScreen.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback voidCallback;

  const ActivityCard({
    Key? key,
    required this.title,
    required this.voidCallback,
    required this.subtitle,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF413D58),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF5C469),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            ),
            onPressed: voidCallback,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(buttonLabel,style: tb15(),),
            ),
          ),
        ],
      ),
    );
  }
}
