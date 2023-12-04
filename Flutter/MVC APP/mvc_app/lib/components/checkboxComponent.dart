import 'package:flutter/material.dart';

class CustomCheckboxComponent extends StatefulWidget {
  final String title;
  final int maxValue;
  final TextEditingController controller;
  final List<Map<String, dynamic>> selectedCheckboxes;
  final Function(List<Map<String, dynamic>>)
      onCheckboxChanged; // Callback function

  const CustomCheckboxComponent({
    required this.title,
    required this.maxValue,
    required this.controller,
    required this.selectedCheckboxes,
    required this.onCheckboxChanged, // Receive the callback function
  });

  @override
  _CustomCheckboxComponentState createState() =>
      _CustomCheckboxComponentState();
}

class _CustomCheckboxComponentState extends State<CustomCheckboxComponent> {
  bool isChecked = false;

  @override
  void dispose() {
    widget.controller.removeListener(handleTextChange);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(handleTextChange);
  }

  void handleTextChange() {
    final enteredValue = int.tryParse(widget.controller.text) ?? 0;
    final checkboxIndex = widget.selectedCheckboxes.indexWhere(
      (checkbox) => checkbox['title'] == widget.title,
    );

    if (isChecked) {
      if (enteredValue > widget.maxValue) {
        widget.controller.text = widget.maxValue.toString();
      }

      if (checkboxIndex != -1) {
        widget.selectedCheckboxes[checkboxIndex]['value'] =
            int.parse(widget.controller.text);
      } else {
        final checkbox = {
          'title': widget.title,
          'value': int.parse(widget.controller.text),
        };
        widget.selectedCheckboxes.add(checkbox);
      }
    } else {
      if (checkboxIndex != -1) {
        widget.selectedCheckboxes.removeAt(checkboxIndex);
      }
    }

    widget.onCheckboxChanged(widget.selectedCheckboxes);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
              if (!isChecked) {
                widget.controller.text = '';
              }
            });

            handleTextChange();
          },
        ),
        Text(widget.title),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            enabled: isChecked,
            keyboardType: TextInputType.number,
            controller: widget.controller,
            onChanged: (value) {
              // No need to handle the logic here
            },
            onFieldSubmitted: (value) {
              // Handle the logic when the user submits the text field
              handleTextChange();
            },
            decoration: InputDecoration(
              hintText: 'Enter value (Max: ${widget.maxValue})',
            ),
            validator: (value) {
              if (isChecked && (value == null || value.isEmpty)) {
                return 'Please enter a value';
              }
              final enteredValue = int.tryParse(value!) ?? 0;
              if (isChecked && enteredValue > widget.maxValue) {
                return 'Value exceeds maximum';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
