import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldView extends StatefulWidget {
  late final Function? onValidate;
  late final TextInputType? inputType;
  late final bool? obscureText;
  late final TextEditingController? controller;
  late final TextStyle? style;
  late final Widget? prefixIcon;
  late final String? hintText;
  late final Function? onTap;
  late final bool? readOnly;
  late final List<TextInputFormatter>? inputFormatter;
  late final int? maxLength;
  late final Widget? suffixIcon;
  late final Function? suffixIconTap;
  late final int? maxLines;

  TextFieldView(
      {this.onValidate,
      this.inputType,
      this.obscureText,
      this.controller,
      this.style,
      this.prefixIcon,
      this.hintText,
      this.onTap,
      this.readOnly,
      this.inputFormatter,
      this.maxLength,
      this.suffixIcon,
      this.suffixIconTap,
      this.maxLines});

  @override
  _TextFieldViewState createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType ?? TextInputType.text,
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      style: widget.style ??
          const TextStyle(
              color: Color(0xFF181818),
              fontSize: 15.0,
              fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.all(10),
          fillColor: Colors.transparent,
          filled: true,
          suffixIcon: widget.suffixIcon,
          /*suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    return widget.suffixIconTap!();
                  },
                  child: widget.suffixIcon,
                )
              : null,
          prefixIcon: widget.prefixIcon ??
              Image.asset(
                'images/user_blue.png',
                scale: 2.5,
              ),*/
          hintText: widget.hintText ?? '',
          border: const UnderlineInputBorder(
            //borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xffffffff), width: 2.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            //borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFDDDDDD), width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            //borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFDDDDDD), width: 2.0),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            //borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFDDDDDD), width: 2.0),
          ),
          enabledBorder: const UnderlineInputBorder(
            //borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFDDDDDD), width: 2.0),
          ),
          errorStyle: const TextStyle(
              color: Colors.red, fontSize: 12.0, fontWeight: FontWeight.w500)),
      maxLength: widget.maxLength ?? 50,
      maxLines: widget.maxLines ?? 1,
      inputFormatters: widget.inputFormatter ?? [],
      onTap: () {
        return widget.onTap != null ? widget.onTap!() : null;
      },
      validator: (String? value) {
        return widget.onValidate!(value);
      },
    );
  }
}
