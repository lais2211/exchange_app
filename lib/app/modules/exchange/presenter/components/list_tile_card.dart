import 'package:flutter/material.dart';
import '../../../../theme/base_colors.dart';

class ListTileCard extends StatelessWidget {
  const ListTileCard({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    this.haveIcon = false,
    this.isPositive,
  });

  final BaseColors color;
  final String title;
  final String subtitle;
  final bool haveIcon;
  final bool? isPositive;

  @override
  Widget build(BuildContext context) {
    Color subtitleColor = haveIcon && isPositive == true
        ? color.greenTheme
        : haveIcon && isPositive == false
            ? color.redTheme
            : color.blackTheme;

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color.blackTheme,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Visibility(
          visible: haveIcon,
          child: Icon(
            isPositive == true
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: haveIcon && isPositive == true
                ? color.greenTheme
                : color.redTheme,
            size: 24,
          ),
        ),
      ],
    );
  }
}
