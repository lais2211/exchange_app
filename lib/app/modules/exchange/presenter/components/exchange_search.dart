import 'package:exchange_app/app/modules/exchange/presenter/components/spacer_32.dart';
import 'package:flutter/material.dart';

import '../../../../theme/base_colors.dart';
import '../../l10n/exchange_l10n.dart';

class ExchangeSearch extends StatelessWidget {
  ExchangeSearch({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  final BaseColors color;
  final ExchangeL10n text;
  final Function(String) onPressed;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text.title,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: color.blueTheme,
              fontSize: 24),
        ),
        const Spacer32(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: text.label,
              labelStyle: TextStyle(
                  color: color.blueTheme,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              filled: true,
              fillColor: color.neutralGreyTheme,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color.blueTheme, width: 2.0),
              ),
            ),
          ),
        ),
        const Spacer32(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 48,
          child: ElevatedButton(
            onPressed: () => onPressed(controller.text),
            style: ElevatedButton.styleFrom(backgroundColor: color.blueTheme),
            child:
                Text(text.button, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
