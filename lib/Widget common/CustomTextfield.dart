import 'package:fitness_app_sample/Widget%20common/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Gesturetextfield extends StatefulWidget {
  final bool tohide;
  final TextEditingController controller;
  final String text;
  final IconData? iconData;

  const Gesturetextfield(
      {super.key,
      required this.tohide,
      required this.controller,
      required this.text,
       this.iconData});

  @override
  State<Gesturetextfield> createState() => GesturetextfieldState();
}

class GesturetextfieldState extends State<Gesturetextfield> {
  late bool obsecuretext;

  @override
  void initState() {
    super.initState();
    obsecuretext = widget.tohide; //
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: TextField(
          controller: widget.controller,
          obscureText: obsecuretext,
          style: tb20(),
          decoration: InputDecoration(
            fillColor: Colors.white30,filled: true,
            hintStyle: TextStyle(color: Colors.white54),
            hintText: widget.text,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obsecuretext = !obsecuretext;
                });
              },
              child: Icon(
                widget.iconData,
              ),
            ),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ));
  }
}
