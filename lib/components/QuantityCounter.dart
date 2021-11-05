import 'package:flutter/material.dart';
import 'package:homebazaar/AppConfig.dart';


class QuantityCounter extends StatelessWidget {

  QuantityCounter({
    Key? key,
    this.incrementCountSelected,
    this.decrementCountSelected,
  }) : super(key: key);

  final VoidCallback? incrementCountSelected;
  final VoidCallback? decrementCountSelected;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QtyButton(
          tap: () {
            if(counter <= 0){
              counter = 0;
            }
            decrementCountSelected!();
          },
          text: '-',
        ),

        SizedBox(width: 10),

        Text(
          '1',
          style: TextStyle(
            fontSize: 38
          ),
        ),

        SizedBox(width: 10),

        QtyButton(
          tap: () {
            counter++;
            incrementCountSelected!();
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
        width: 30.0,
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConfig.kDefaultPadding * 0.5),
          color: Colors.white
        ),
        child: Text(
          text!,
          style: TextStyle(
            color: AppConfig.kRedColor,
            fontSize: 40
          ),
        ),
      ),
    );
  }
}