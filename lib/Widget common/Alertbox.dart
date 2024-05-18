import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/material.dart';

customalertbox(BuildContext context,String text,Function onDismiss){
  return showDialog(context: context, builder: (context) {
    return AlertDialog(title: Text(text),actions: [ElevatedButton(onPressed: () {
      onDismiss();
      Navigator.pop(context);
    }, child: Text("OK",style: tb25(),))],);
  },);
}

