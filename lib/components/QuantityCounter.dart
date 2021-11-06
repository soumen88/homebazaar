import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/AppConfig.dart';
import 'package:homebazaar/providers/Providers.dart';


class QuantityCounter extends ConsumerWidget {

  QuantityCounter({
    Key? key,
    this.incrementCountSelected,
    this.decrementCountSelected,
  }) : super(key: key);

  final Function(int?)? incrementCountSelected;
  final Function(int?)? decrementCountSelected;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final count = watch(counterProvider).count;
    return Row(
      children: [
        QtyButton(
          tap: () {
            context.read(counterProvider.notifier).decrement();
            decrementCountSelected!(context.read(counterProvider.notifier).count);
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
            context.read(counterProvider.notifier).increment();
            incrementCountSelected!(context.read(counterProvider.notifier).count);
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