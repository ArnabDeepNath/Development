import 'package:flutter/material.dart';

class QuantityController extends StatefulWidget {
  final ValueChanged<int>? onChanged;
  final ValueChanged<bool>? onItemSelected;
  final int initialValue;

  QuantityController(
      {Key? key, this.onChanged, this.onItemSelected, this.initialValue = 0})
      : super(key: key);

  @override
  _QuantityControllerState createState() => _QuantityControllerState();
}

class _QuantityControllerState extends State<QuantityController> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _value++;
      widget.onChanged?.call(_value);
      widget.onItemSelected?.call(_value > 0);
    });
  }

  void _decrement() {
    setState(() {
      _value--;
      if (_value < 1) {
        _value = 0;
        widget.onItemSelected?.call(false);
      } else {
        widget.onItemSelected?.call(true);
      }
      widget.onChanged?.call(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text('$_value'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
