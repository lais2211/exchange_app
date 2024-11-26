import 'package:exchange_app/app/modules/exchange/l10n/exchange_l10n.dart';
import 'package:exchange_app/app/modules/exchange/presenter/components/current_exchange.dart';
import 'package:exchange_app/app/modules/exchange/presenter/components/daily_exchange_list.dart';
import 'package:exchange_app/app/modules/exchange/presenter/components/exchange_search.dart';
import 'package:exchange_app/app/modules/exchange/presenter/controllers/state/daily/daily_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../theme/base_colors.dart';
import '../components/spacer_32.dart';
import '../controllers/state/current/current_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ExchangeL10n text = ExchangeL10n();
  final BaseColors color = BaseColors();
  final CurrentCubit currentCubit = CurrentCubit();
  final DailyCubit dailyCubit = DailyCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: SvgPicture.asset('assets/images/logo.svg')),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 16),
                Divider(
                  color: color.greyTheme,
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                const Spacer32(),
                ExchangeSearch(
                    color: color,
                    text: text,
                    onPressed: (String fromSymbol) {
                      currentCubit.getCurrentExchange(fromSymbol);
                      dailyCubit.getDailyExchange(fromSymbol);
                    }),
                const Spacer32(),
                Divider(
                  color: color.greyTheme,
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                const Spacer32(),
                BlocBuilder<CurrentCubit, CurrentState>(
                    bloc: currentCubit,
                    builder: (context, state) {
                      if (state is CurrentLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CurrentSucess) {
                        DateTime dateTime =
                            DateTime.parse(state.current.lastUpdatedAt);
                        String formattedDate =
                            DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
                        return CurrentExchange(
                            color: color,
                            text: text,
                            exchangeRate: state.current.exchangeRate,
                            lastUpdatedAt: formattedDate,
                            fromSymbol: state.current.fromSymbol);
                      } else if (state is CurrentError) {
                        return Text(text.error);
                      } else {
                        return Container();
                      }
                    }),
                const Spacer32(),
                BlocBuilder<DailyCubit, DailyState>(
                  bloc: dailyCubit,
                  builder: (context, state) {
                    if (state is DailySucess) {
                      return DailyExchangeList(
                        color: color,
                        text: text,
                        dailyExchangeRates: state.daily.dailyExchangeRateEntity,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 16,
                color: color.blueTheme,
                child: Center(
                    child: Text(
                  text.footer,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )),
              )),
        ],
      ),
    );
  }
}
