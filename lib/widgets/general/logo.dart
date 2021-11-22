import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class PawPainter extends CustomPainter {
  final Color color;

  PawPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6818415, size.height * 0.5776485);
    path_0.lineTo(size.width * 0.6135956, size.height * 0.4614091);
    path_0.cubicTo(
        size.width * 0.5575519,
        size.height * 0.3659588,
        size.width * 0.4315208,
        size.height * 0.3659582,
        size.width * 0.3754776,
        size.height * 0.4614085);
    path_0.lineTo(size.width * 0.3072279, size.height * 0.5776485);
    path_0.cubicTo(
        size.width * 0.2456831,
        size.height * 0.6824667,
        size.width * 0.3135033,
        size.height * 0.8212121,
        size.width * 0.4262863,
        size.height * 0.8212121);
    path_0.lineTo(size.width * 0.5627869, size.height * 0.8212121);
    path_0.cubicTo(
        size.width * 0.6755683,
        size.height * 0.8212121,
        size.width * 0.7433880,
        size.height * 0.6824667,
        size.width * 0.6818415,
        size.height * 0.5776485);
    path_0.moveTo(size.width * 0.5787760, size.height * 0.4631024);
    path_0.cubicTo(
        size.width * 0.6611148,
        size.height * 0.4759370,
        size.width * 0.7206667,
        size.height * 0.3973073,
        size.width * 0.7306557,
        size.height * 0.3184721);
    path_0.cubicTo(
        size.width * 0.7406448,
        size.height * 0.2396364,
        size.width * 0.7029454,
        size.height * 0.1458479,
        size.width * 0.6206066,
        size.height * 0.1330133);
    path_0.cubicTo(
        size.width * 0.5382639,
        size.height * 0.1201788,
        size.width * 0.4787142,
        size.height * 0.1988085,
        size.width * 0.4687240,
        size.height * 0.2776442);
    path_0.cubicTo(
        size.width * 0.4587344,
        size.height * 0.3564794,
        size.width * 0.4964361,
        size.height * 0.4502679,
        size.width * 0.5787760,
        size.height * 0.4631024);
    path_0.moveTo(size.width * 0.6525301, size.height * 0.6447576);
    path_0.cubicTo(
        size.width * 0.7218743,
        size.height * 0.6891636,
        size.width * 0.7999454,
        size.height * 0.6425697,
        size.width * 0.8339399,
        size.height * 0.5772673);
    path_0.cubicTo(
        size.width * 0.8679344,
        size.height * 0.5119661,
        size.width * 0.8652787,
        size.height * 0.4136806,
        size.width * 0.7959344,
        size.height * 0.3692782);
    path_0.cubicTo(
        size.width * 0.7265902,
        size.height * 0.3248752,
        size.width * 0.6485191,
        size.height * 0.3714679,
        size.width * 0.6145246,
        size.height * 0.4367691);
    path_0.cubicTo(
        size.width * 0.5805301,
        size.height * 0.5020703,
        size.width * 0.5831858,
        size.height * 0.6003558,
        size.width * 0.6525301,
        size.height * 0.6447576);
    path_0.moveTo(size.width * 0.3369355, size.height * 0.6447576);
    path_0.cubicTo(
        size.width * 0.4062787,
        size.height * 0.6003564,
        size.width * 0.4089333,
        size.height * 0.5020703,
        size.width * 0.3749399,
        size.height * 0.4367697);
    path_0.cubicTo(
        size.width * 0.3409470,
        size.height * 0.3714685,
        size.width * 0.2628738,
        size.height * 0.3248752,
        size.width * 0.1935306,
        size.height * 0.3692782);
    path_0.cubicTo(
        size.width * 0.1241874,
        size.height * 0.4136806,
        size.width * 0.1215328,
        size.height * 0.5119667,
        size.width * 0.1555262,
        size.height * 0.5772679);
    path_0.cubicTo(
        size.width * 0.1895191,
        size.height * 0.6425697,
        size.width * 0.2675923,
        size.height * 0.6891636,
        size.width * 0.3369355,
        size.height * 0.6447576);
    path_0.moveTo(size.width * 0.4116224, size.height * 0.4638703);
    path_0.cubicTo(
        size.width * 0.4939617,
        size.height * 0.4510358,
        size.width * 0.5316639,
        size.height * 0.3572473,
        size.width * 0.5216738,
        size.height * 0.2784115);
    path_0.cubicTo(
        size.width * 0.5116842,
        size.height * 0.1995764,
        size.width * 0.4521339,
        size.height * 0.1209467,
        size.width * 0.3697940,
        size.height * 0.1337812);
    path_0.cubicTo(
        size.width * 0.2874541,
        size.height * 0.1466158,
        size.width * 0.2497525,
        size.height * 0.2404042,
        size.width * 0.2597421,
        size.height * 0.3192394);
    path_0.cubicTo(
        size.width * 0.2697322,
        size.height * 0.3980752,
        size.width * 0.3292825,
        size.height * 0.4767048,
        size.width * 0.4116224,
        size.height * 0.4638703);
    path_0.moveTo(size.width * 0.4595350, size.height * 0.4533491);
    path_0.cubicTo(
        size.width * 0.4764158,
        size.height * 0.4213473,
        size.width * 0.5181197,
        size.height * 0.4213473,
        size.width * 0.5350005,
        size.height * 0.4533491);
    path_0.lineTo(size.width * 0.6386066, size.height * 0.6497576);
    path_0.cubicTo(
        size.width * 0.6556557,
        size.height * 0.6820788,
        size.width * 0.6346393,
        size.height * 0.7227273,
        size.width * 0.6008743,
        size.height * 0.7227273);
    path_0.lineTo(size.width * 0.3936612, size.height * 0.7227273);
    path_0.cubicTo(
        size.width * 0.3598967,
        size.height * 0.7227273,
        size.width * 0.3388781,
        size.height * 0.6820788,
        size.width * 0.3559284,
        size.height * 0.6497576);
    path_0.lineTo(size.width * 0.4595350, size.height * 0.4533491);
    path_0.close();

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1092896;
    paint_0_stroke.color = Colors.white.withOpacity(1.0);
    canvas.drawShadow(path_0, Colors.black, size.width * 0.06, false);
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4595350, size.height * 0.4533491);
    path_5.cubicTo(
        size.width * 0.4764158,
        size.height * 0.4213473,
        size.width * 0.5181197,
        size.height * 0.4213473,
        size.width * 0.5350005,
        size.height * 0.4533491);
    path_5.lineTo(size.width * 0.6386066, size.height * 0.6497576);
    path_5.cubicTo(
        size.width * 0.6556557,
        size.height * 0.6820788,
        size.width * 0.6346393,
        size.height * 0.7227273,
        size.width * 0.6008743,
        size.height * 0.7227273);
    path_5.lineTo(size.width * 0.3936612, size.height * 0.7227273);
    path_5.cubicTo(
        size.width * 0.3598967,
        size.height * 0.7227273,
        size.width * 0.3388781,
        size.height * 0.6820788,
        size.width * 0.3559284,
        size.height * 0.6497576);
    path_5.lineTo(size.width * 0.4595350, size.height * 0.4533491);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = color;
    canvas.drawPath(path_5, paint_5_fill);

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = color;
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.5996885, size.height * 0.2980582),
            width: size.width * 0.1552164,
            height: size.height * 0.2121212),
        paint_6_fill);

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = color;
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.7242350, size.height * 0.5070182),
            width: size.width * 0.1440678,
            height: size.height * 0.1968861),
        paint_7_fill);

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = color;
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.2652333, size.height * 0.5070188),
            width: size.width * 0.1440678,
            height: size.height * 0.1968861),
        paint_8_fill);

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = color;

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.3907082, size.height * 0.2988255),
            width: size.width * 0.1552164,
            height: size.height * 0.2121212),
        paint_9_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
