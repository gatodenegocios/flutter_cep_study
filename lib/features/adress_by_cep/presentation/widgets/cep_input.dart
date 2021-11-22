import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepInput extends StatelessWidget {
  const CepInput({ Key? key, required this.controller, required this.submit}) : super(key: key);

  final TextEditingController controller;
  final Function submit;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller,
              maxLength: 9,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
              ],
              decoration: InputDecoration(
                counterText: '',
              ),
            ),
            TextButton(
              onPressed: () => submit(context),
              child: Text("Search"),
            ),
          ],
        ),
      );
  }
}