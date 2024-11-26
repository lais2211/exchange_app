import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../theme/base_colors.dart';
import '../../l10n/exchange_l10n.dart';

class CurrentExchange extends StatelessWidget {
  const CurrentExchange({
    super.key,
    required this.color,
    required this.text,
    required this.fromSymbol,
    required this.exchangeRate,
    required this.lastUpdatedAt,
  });

  final BaseColors color;
  final ExchangeL10n text;
  final String fromSymbol;
  final double exchangeRate;
  final String lastUpdatedAt;

  String formatExchangeRate(double exchangeRate) {
    NumberFormat formatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);

    String formattedRate = formatter.format(exchangeRate);

    return formattedRate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.titleCurrency,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: color.blackTheme),
                  ),
                  Text(
                    lastUpdatedAt,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: color.blackTheme),
                  ),
                ],
              ),
              Text(
                "${fromSymbol.toUpperCase()}/BRL",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: color.blueTheme),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: color.blueTheme.withOpacity(0.2),
            height: 72,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Center(
              child: Text(
                formatExchangeRate(exchangeRate),
                style: TextStyle(
                  color: color.blueTheme,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
