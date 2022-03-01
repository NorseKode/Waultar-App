import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? color;
  final IconData? icon;
  final double? size;
  final Color? textColor;

  const DefaultButton(
      {Key? key,
      this.text,
      required this.onPressed,
      this.color,
      this.icon,
      this.size,
      this.textColor})
      : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: widget.textColor ?? Colors.white,
        fontSize: widget.size ?? 11,
        fontWeight: FontWeight.w200);

    return TextButton(
        onPressed: widget.onPressed,
        child: Container(
            decoration: BoxDecoration(
                color: widget.color ?? const Color(0xFF806DFF),
                borderRadius: widget.icon != null && widget.text == null
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(5)),
            child: Padding(
              padding: widget.icon != null && widget.text == null
                  ? const EdgeInsets.fromLTRB(5, 5, 5, 5)
                  : const EdgeInsets.fromLTRB(10, 3, 10, 3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.icon != null
                      ? Icon(widget.icon!,
                          color: widget.textColor ?? Colors.white,
                          size: widget.size != null ? widget.size! + 2 : 13)
                      : Container(),
                  widget.icon != null && widget.text != null
                      ? SizedBox(width: 5)
                      : Container(),
                  widget.text != null
                      ? Text(
                          widget.text!,
                          style: textStyle,
                        )
                      : Container(),
                  widget.text == null && widget.icon == null
                      ? Text("Button", style: textStyle)
                      : Container()
                ],
              ),
            )));
  }
}
