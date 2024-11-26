import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../theme/base_colors.dart';
import '../../l10n/exchange_l10n.dart';
import 'list_tile_card.dart';

class ListCard extends StatelessWidget {
  const ListCard(
      {super.key,
      required this.color,
      required this.text,
      required this.open,
      required this.close,
      required this.high,
      required this.low,
      required this.date,
      this.percentageChange,
      required this.isPositive});

  final BaseColors color;
  final ExchangeL10n text;
  final double open;
  final double close;
  final double high;
  final double low;
  final String date;
  final double? percentageChange;
  final bool isPositive;

  String formatExchangeRate(double x) {
    NumberFormat formatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);

    String formattedRate = formatter.format(x);

    return formattedRate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 141,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                color: color.blueTheme,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTileCard(
                    color: color,
                    subtitle: formatExchangeRate(open),
                    title: text.open),
                const SizedBox(height: 4),
                ListTileCard(
                    color: color,
                    subtitle: formatExchangeRate(high),
                    title: text.hight),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTileCard(
                    color: color,
                    subtitle: formatExchangeRate(close),
                    title: text.close),
                const SizedBox(height: 4),
                ListTileCard(
                  color: color,
                  subtitle: formatExchangeRate(low),
                  title: text.low,
                ),
              ],
            ),
            const SizedBox(height: 4),
            ListTileCard(
                color: color,
                subtitle:
                    "${isPositive ? '+' : '-'}${percentageChange!.abs().toStringAsFixed(2)}%",
                title: text.diff,
                haveIcon: true,
                isPositive: isPositive),
          ],
        ),
      ),
    );
  }
}
