import 'package:exchange_app/app/modules/exchange/presenter/components/list_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../theme/base_colors.dart';
import '../../domain/entities/daily_exchange_rate_entity.dart';
import '../../l10n/exchange_l10n.dart';

class DailyExchangeList extends StatefulWidget {
  const DailyExchangeList({
    super.key,
    required this.color,
    required this.text,
    required this.dailyExchangeRates,
  });

  final BaseColors color;
  final ExchangeL10n text;
  final List<DailyExchangeRateEntity> dailyExchangeRates;

  @override
  State<DailyExchangeList> createState() => _DailyExchangeListState();
}

class _DailyExchangeListState extends State<DailyExchangeList> {
  bool _isListVisible = false;

  void _toggleList() {
    setState(() {
      _isListVisible = !_isListVisible;
    });
  }

  double calculatePercentageChange(double newValue, double oldValue) {
    if (oldValue == 0) return 0; // Evita divisão por zero
    return ((newValue - oldValue) / oldValue) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text.titleDaily,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.color.blackTheme,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: Icon(
                  _isListVisible ? Icons.remove : Icons.add,
                ),
                onPressed: _toggleList,
                tooltip: _isListVisible ? 'Ocultar Lista' : 'Mostrar Lista',
              ),
            ],
          ),
        ),
        if (_isListVisible)
          Container(
            color: widget.color.neutralGreyTheme,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.dailyExchangeRates.length,
              itemBuilder: (context, index) {
                final exchangeRate = widget.dailyExchangeRates[index];
                DateTime dateTime = DateTime.parse(exchangeRate.date);
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(dateTime);

                double? percentageChange;
                bool isPositive = true;
                if (index == 0) {
                  percentageChange = 0;
                  isPositive = true;
                } else if (index > 0) {
                  percentageChange = calculatePercentageChange(
                    exchangeRate.close,
                    widget.dailyExchangeRates[index - 1].close,
                  );
                  isPositive = percentageChange >= 0;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 16.0),
                  child: ListCard(
                    color: widget.color,
                    text: widget.text,
                    close: exchangeRate.close,
                    open: exchangeRate.open,
                    high: exchangeRate.high,
                    low: exchangeRate.low,
                    date: formattedDate,
                    percentageChange: percentageChange,
                    isPositive: isPositive,
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
        Divider(
          color: widget.color.blueTheme,
          thickness: 2,
          indent: 15,
          endIndent: 15,
        ),
      ],
    );
  }
}
