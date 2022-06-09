import 'package:flutter/material.dart';

class ScreenButton extends StatelessWidget {
  final void Function()? onPressed;
  final String data;
  final double height;
  final double width;
  final double textSize;
  const ScreenButton(
      this.data,
      {Key? key,
      required this.onPressed,
      this.height = 50,
      this.width = 70,
      this.textSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            data,
            style: TextStyle(
              color: Colors.blue,
              fontSize: textSize,
            ),
          ),
        ),
        style: ButtonStyle(
          // shape: MaterialStateProperty.all<CircleBorder>(
          //   const CircleBorder(),
          // ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(width, height),
          ),
          elevation: MaterialStateProperty.all<double>(20),
          shadowColor: MaterialStateProperty.all<Color>(Colors.green),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
        ),
      );
}
