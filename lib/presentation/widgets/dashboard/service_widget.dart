import 'package:flutter/material.dart';

class ServiceWidget extends StatefulWidget {
  final Color color;
  final IconData logo;
  final String service;
  const ServiceWidget(
      {Key? key,
      required this.color,
      required this.logo,
      required this.service})
      : super(key: key);

  @override
  _ServiceWidgetState createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFF272837)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(widget.logo, size: 25),
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.service,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 15),
                  Row(children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFF4D4F68),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          )),
                    )
                  ]),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "251 Files",
                        style:
                            TextStyle(color: Color(0xFFABAAB8), fontSize: 12),
                      ),
                      Text("2.9 GB", style: TextStyle(fontSize: 12))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 15),
            Container(height: 20, width: 5, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
