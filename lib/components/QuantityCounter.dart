import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/components/QuantityBloc.dart';
import 'package:homebazaar/providers/Providers.dart';
import 'dart:developer' as developer;



class QuantityCounter extends ConsumerWidget {

  QuantityCounter({
    Key? key,
    this.incrementCountSelected,
    this.decrementCountSelected,
    @PathParam() required this.initialCount,
  }) : super(key: key);


  final Function(int?)? incrementCountSelected;
  final Function(int?)? decrementCountSelected;
  int initialCount;
  bool isValueSet = false;
  String currentScreen = "Quantity Counter";
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if(!isValueSet){
      isValueSet = true;
      watch(counterProvider).count = initialCount;
    }

    final count = watch(counterProvider).count;
    developer.log(currentScreen, name : "Found initial count $initialCount");

    return Row(
      children: [
        QtyButton(
          tap: () {
            //context.read(counterProvider.notifier).decrement();
            decrementCountSelected!(count);
          },
          text: '-',
        ),

        SizedBox(width: 10),

        Text(
          '$count',
          style: TextStyle(
            fontSize: 38
          ),
        ),

        SizedBox(width: 10),

        QtyButton(
          tap: () {
            //context.read(counterProvider.notifier).increment();
            incrementCountSelected!(count);
          },
          text: '+',
        )
      ],
    );
  }
}

class QtyButton extends StatelessWidget {
  const QtyButton({
    Key? key,
    @required this.tap,
    @required this.text,
  }) : super(key: key);

  final GestureTapCallback? tap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: 50.0,
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.kDefaultPadding * 0.5),
            color: Colors.blue
        ),
        child: Text(
          text!,
          style: TextStyle(
              color: AppConfig.whiteColor,
              fontSize: 40
          ),
        ),
      ),
    );
  }
}