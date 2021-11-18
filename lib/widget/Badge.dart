import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  Widget widget;
  int itemCount;
  Badge({required this.widget, required this.itemCount});

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            child: Text(
              itemCount.toString(),
              style: TextStyle(
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange,
            ),
            constraints: BoxConstraints(minHeight: 16, minWidth: 16),
          ),
        ),
      ],
    );
  }
}
