import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tekko/styles/app_colors.dart';

class InputAnimation extends StatefulWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController inputController;
  final bool isAgeInput;

  const InputAnimation({
    super.key,
    required this.inputController,
    required this.hintText,
    required this.inputType,
    this.isAgeInput = false,
  });

  @override
  State<InputAnimation> createState() => _InputAnimationState();
}

class _InputAnimationState extends State<InputAnimation> {
  @override
  void initState() {
    super.initState();
    widget.inputController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.inputController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.inputController.text;
    if (widget.isAgeInput && text.length > 2) {
      // Limita la longitud a 2 caracteres para la edad
      widget.inputController.text = text.substring(0, 2);
      widget.inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.inputController.text.length),
      );
    } else if (!widget.isAgeInput && text.length > 10) {
      // Limita la longitud a 10 caracteres para otros casos
      widget.inputController.text = text.substring(0, 10);
      widget.inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.inputController.text.length),
      );
    }
    setState(() {}); // Actualiza la UI cuando el texto cambia
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCharacterDisplay(),
          _buildTextField(),
        ],
      ),
    );
  }

  Widget _buildCharacterDisplay() {
    final maxLength = widget.isAgeInput ? 2 : 10; // Límite de caracteres
    final text = widget.inputController.text;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          maxLength,
          (index) {
            final letter = index < text.length ? text[index] : "";
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.chocolateDark,
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 20,
                    color: index < text.length
                        ? AppColors.chocolateDark
                        : Colors.grey[400],
                    margin: const EdgeInsets.only(top: 4.0),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Opacity(
      opacity: 0.0,
      child: TextField(
        controller: widget.inputController,
        keyboardType:
            widget.isAgeInput ? TextInputType.number : widget.inputType,
        maxLength: widget.isAgeInput ? 2 : 10,
        inputFormatters: [
          if (widget.isAgeInput) FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
        cursorColor: Colors.transparent,
      ),
    );
  }
}
