import 'package:flutter/material.dart';

class UnknownWidget extends StatelessWidget {
  const UnknownWidget({super.key, this.type});

  final String? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Text('Undefined UI Component $type'),
    );
  }
}