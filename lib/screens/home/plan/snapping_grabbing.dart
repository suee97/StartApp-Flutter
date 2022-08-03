import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultGrabbing extends StatelessWidget {

  final Color color;
  final bool reverse;

  const DefaultGrabbing({Key? key, this.color = Colors.white, this.reverse = false}) : super(key: key);

  BorderRadius _getBorderRadius(){
    var radius = Radius.circular(30);
    return BorderRadius.only(
      topLeft: radius,
      topRight: radius,
      // bottomLeft: reverse ? radius : Radius.zero,
      // bottomRight: reverse ? Radius.zero : Radius.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 10,
            color: Colors.black.withOpacity(0.15)
          )
        ],
        borderRadius: _getBorderRadius(),
        color: this.color
      ),
      child: Stack(children: [
        Align(
          alignment: Alignment(0, -0.5),
          child: _GrabbingIndicator(),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(height: 2, color: Colors.green[300],),
        // )
      ],),
    );
  }
}

//snapping sheet 그랩바 손잡이
class _GrabbingIndicator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: HexColor("#92AEAC"),),
        height: 10,
        width: 100
    );
  }

}