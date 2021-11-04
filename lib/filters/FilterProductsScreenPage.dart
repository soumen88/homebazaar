import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:homebazaar/productslisting/MyRadioOption.dart';
import 'package:homebazaar/productslisting/ProductListingNotifierBloc.dart';


class FilterProductsScreenPage extends StatefulWidget {

  @override
  State createState() => new _CustomRadioDemoState();
}


class _CustomRadioDemoState extends State<FilterProductsScreenPage> {
  ProductListingNotifierBloc productListingNotifierBloc = new ProductListingNotifierBloc();
  String? _groupValue;

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Custom Radio Button Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Choose your filter"),
          ),
          SizedBox(height: 10,),
          MyRadioOption<String>(
            value: '1',
            groupValue: _groupValue,
            onChanged: _valueChangedHandler(),
            label: '1',
            text: 'Low to High',
          ),
          MyRadioOption<String>(
            value: '2',
            groupValue: _groupValue,
            onChanged: _valueChangedHandler(),
            label: '2',
            text: 'High To Low',
          ),
          MyRadioOption<String>(
            value: '3',
            groupValue: _groupValue,
            onChanged: _valueChangedHandler(),
            label: '3',
            text: 'Sort By A-Z',
          ),
          MyRadioOption<String>(
            value: '4',
            groupValue: _groupValue,
            onChanged: _valueChangedHandler(),
            label: '4',
            text: 'Sort By Z-A',
          ),
          ElevatedButton(onPressed: (){
            productListingNotifierBloc.testingStreams();
            productListingNotifierBloc.filterOn = 9;
            context.router.pop(true);

          }, child: Text("Apply"))
        ],
      ),
    );
  }
}
