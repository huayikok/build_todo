import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopLabelInput extends StatelessWidget {
  final double height;
  final EdgeInsets margin;
  final String inputName;
  final String initValue;
  final String hintText;
  final List<TextInputFormatter> inputFormatter;
  final bool isPassword; // True = Password Input, False = Normal Input
  final bool isEnabled; // True = Enabled, False = Disabled
  final TextEditingController controller;
  final minLines;
  final TextInputType keyboardType;
  final maxLines;
  final Function(String text) onChanged;

  const TopLabelInput({
    Key key,
    this.height,
    this.margin,
    this.inputName,
    this.initValue,
    this.hintText,
    this.inputFormatter,
    @required this.isPassword,
    @required this.isEnabled,
    this.controller,
    this.minLines,
    this.keyboardType,
    this.maxLines,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          inputName,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xff939393),
          ),
        ),
        Container(
          height: (height == null) ? 44 : height,
          margin: margin,
          child: (minLines != null && keyboardType != null)
              ? TextFormField(
                  initialValue: initValue,
                  // ignore: deprecated_member_use
                  inputFormatters: inputFormatter,
                  enabled: isEnabled,
                  // True = Enabled, False = Disabled
                  obscureText: isPassword,
                  controller: controller,
                  minLines: minLines,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff939393),
                    ),
                    fillColor: isEnabled ? Colors.white : Color(0xffF5F5F5),
                    // True = Enabled, False = Disabled
                    focusColor: Colors.orange,
                    // border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0xff3BB8C3), width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0x26329D9C)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // errorBorder: InputBorder.none,
                    disabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0x26329D9C), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // labelText: 'Test',
                  ),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff939393),
                  ),
                  onChanged: onChanged,
                )
              : TextFormField(
                  initialValue: initValue,
                  // ignore: deprecated_member_use
                  inputFormatters: inputFormatter,
                  enabled: isEnabled,
                  // True = Enabled, False = Disabled
                  obscureText: isPassword,
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff939393),
                    ),
                    fillColor: isEnabled ? Colors.white : Color(0xffF5F5F5),
                    // True = Enabled, False = Disabled
                    focusColor: Colors.orange,
                    // border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0xff3BB8C3), width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0x26329D9C)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // errorBorder: InputBorder.none,
                    disabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0x26329D9C), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // labelText: 'Test',
                  ),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff939393),
                  ),
                  onChanged: onChanged,
                ),
        ),
      ],
    );
  }
}
