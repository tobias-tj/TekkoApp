import 'package:flutter/material.dart';

class InputAccount extends StatelessWidget {
  final String hintText;
  final bool isPass;
  const InputAccount(
      {super.key,
      required TextEditingController inputController,
      required this.hintText,
      required this.isPass})
      : _inputController = inputController;

  final TextEditingController _inputController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: TextField(
        controller: _inputController,
        obscureText: isPass ? true : false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
        ),
      ),
    );
  }
}
