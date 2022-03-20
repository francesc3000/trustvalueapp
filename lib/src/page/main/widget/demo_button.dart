import 'package:flutter/material.dart';

class DemoButton extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  final double textSize;
  const DemoButton(
      {Key? key, required this.onPressed, this.size = 70, this.textSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "PISTIS\nDEMO",
            style: TextStyle(
              color: Colors.blue,
              fontSize: textSize,
            ),
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<CircleBorder>(
            const CircleBorder(),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(size, size),
          ),
          elevation: MaterialStateProperty.all<double>(20),
          shadowColor: MaterialStateProperty.all<Color>(Colors.green),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
        ),
      );
}
