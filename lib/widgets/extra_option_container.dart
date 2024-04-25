import 'package:flutter/material.dart';

class BottomExtraOption extends StatelessWidget {
  final String text;

  final String buttonText;

  final void Function()? onButtonClick;

  final Widget Function(BuildContext)? builder;

  const BottomExtraOption({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onButtonClick
  }) : builder = null;

  const BottomExtraOption.materialRoute({
    super.key,
    required this.text,
    required this.buttonText,
    required this.builder
  }) : onButtonClick = null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            Text(text),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: onButtonClick ?? _getBuilder(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
                child: Text(
                  buttonText,
                  style:const TextStyle(fontSize: 16)
                ),
              )
            )
        ],
      ),
    );
  }

  _getBuilder(BuildContext context) {
    if (builder == null) {
      return () {};
    }

    return () => Navigator.push(context, MaterialPageRoute(builder: builder!));
  }
}