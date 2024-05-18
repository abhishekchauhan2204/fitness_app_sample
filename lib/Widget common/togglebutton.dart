import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Togglebutton extends StatefulWidget {
  Togglebutton({super.key,required this.voidCallback});
  VoidCallback voidCallback;
  @override
  State<Togglebutton> createState() => _TogglebuttonState();
}
class _TogglebuttonState extends State<Togglebutton> {
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedToggleSwitch<bool>(
      current: positive,
      values: [false, true],
      dif: 0.0,
      indicatorSize: Size.square(30.0),
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.linear,
      onChanged: (b) => setState(() => positive = b),
      iconBuilder: (context, local, global) {
        return const SizedBox();
      },
      defaultCursor: SystemMouseCursors.click,
      onTap: () => setState(() => positive = !positive),
      iconsTappable: false,
      wrapperBuilder: (context, global, child) {

        Color backgroundColor = positive ? Colors.green : Colors.red;

        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 10.0,
              right: 10.0,
              height: 30.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
              ),
            ),
            child,
          ],
        );
      },
      foregroundIndicatorBuilder: (context, global) {
        return SizedBox.fromSize(
          size: const Size(10, 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: const BorderRadius.all(
                Radius.circular(50.0),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0.05,
                  blurRadius: 1.1,
                  offset: Offset(0.0, 0.8),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
