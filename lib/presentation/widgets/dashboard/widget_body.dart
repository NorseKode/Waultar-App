import 'package:flutter/material.dart';

class WidgetBody extends StatefulWidget {
  final Widget child;
  final double? width;
  const WidgetBody({Key? key, required this.child, this.width})
      : super(key: key);

  @override
  _WidgetBodyState createState() => _WidgetBodyState();
}

class _WidgetBodyState extends State<WidgetBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: const Color(0xFF272837)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: widget.child,
            ),
            const SizedBox(width: 15),
            SizedBox(
              height: 15,
              width: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) => Container(
                    width: 3,
                    height: 3,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
