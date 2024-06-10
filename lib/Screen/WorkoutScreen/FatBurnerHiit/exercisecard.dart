import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/material.dart';




class WorkoutTile extends StatelessWidget {
  final String name;
  final String duration;

  WorkoutTile({required this.name,required this.duration});

  @override
  Widget build(BuildContext context) {
    return Card(color: Colors.white60,
      child: ListTile(titleTextStyle: tb20(),
        leading: Icon(Icons.fitness_center),
        title: Text(name),
        trailing: Text(duration),
      ),
    );
  }
}
