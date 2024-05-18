import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleItem extends StatefulWidget {
  final String time;
  final String title;
  final String description;
  final Color backgroundColor;
  late final bool? isCompleted;

  ScheduleItem({
    required this.time,
    required this.title,
    required this.description,
    required this.backgroundColor,
    this.isCompleted,
  });

  @override
  _ScheduleItemState createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backgroundColor,
      child: ListTile(
        leading: Text(widget.time),
        title: Text(widget.title),
        subtitle: Text(widget.description),
        trailing: widget.isCompleted != null
            ? Text(
          widget.isCompleted! ? 'Completed' : 'Pending',
          style: TextStyle(
            fontSize: 20,
            color: widget.isCompleted! ? Colors.green.shade900 : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        )
            : SizedBox(),
      ),
    );
  }
}
