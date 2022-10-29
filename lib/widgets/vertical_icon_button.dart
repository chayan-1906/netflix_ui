import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;

  const VerticalIconButton({
    Key key,
    this.iconData,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(iconData, color: Colors.white),
          const SizedBox(height: 2.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
