import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class DefaultButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? color;
  final IconData? icon;
  final BoxConstraints? constraints;
  final Color? textColor;

  const DefaultButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.color,
      this.icon,
      this.constraints,
      this.textColor})
      : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    TextStyle textStyle = TextStyle(
        color: widget.textColor ?? Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w500);

    return Container(
      constraints: widget.constraints ?? const BoxConstraints(),
      decoration: BoxDecoration(
          color: widget.onPressed != null
              ? (widget.color ?? themeProvider.themeMode().themeColor)
              : const Color.fromARGB(255, 114, 130, 161),
          borderRadius: widget.icon != null && widget.text == null
              ? BorderRadius.circular(100)
              : BorderRadius.circular(5)),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: widget.icon != null && widget.text == null
                ? const EdgeInsets.symmetric(horizontal: 5, vertical: 13)
                : const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            minimumSize: const Size(0, 0)),
        onPressed: widget.onPressed,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          widget.icon != null
              ? Icon(widget.icon!,
                  color: widget.textColor ?? Colors.white, size: 13)
              : Container(),
          widget.icon != null && widget.text != null
              ? const SizedBox(width: 10)
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
        ]),
      ),
    );
  }
}
