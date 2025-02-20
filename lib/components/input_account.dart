import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class InputAccount extends StatefulWidget {
  final String hintText;
  final bool isPass;
  final TextInputType inputType;
  const InputAccount(
      {super.key,
      required TextEditingController inputController,
      required this.hintText,
      required this.isPass,
      required this.inputType})
      : _inputController = inputController;

  final TextEditingController _inputController;

  @override
  State<InputAccount> createState() => _InputAccountState();
}

class _InputAccountState extends State<InputAccount> {
  bool _obscureText =
      true; // Estado para controlar la visibilidad de la contraseña

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText =
          !_obscureText; // Alternar entre mostrar y ocultar la contraseña
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(49, 92, 54, 9),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: TextField(
        controller: widget._inputController,
        keyboardType: widget.inputType,
        obscureText: widget.isPass ? _obscureText : false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black45),
          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(0, 255, 255, 255)),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(0, 255, 255, 255)),
            borderRadius: BorderRadius.circular(25.7),
          ),
          suffixIcon: widget.isPass
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility, // Alternar íconos
                    color: AppColors.chocolateNewDark,
                  ),
                  onPressed: _togglePasswordVisibility, // Alternar visibilidad
                )
              : null,
        ),
      ),
    );
  }
}
