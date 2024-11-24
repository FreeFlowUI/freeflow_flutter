
import 'package:flutter/material.dart';

class PropertyEngine {
  dynamic generateProperty(Map<String, dynamic> data) {
    final String type = data['type'];

    switch (type) {
      case "BoxDecoration":
        {}
      case "Color":
        {}
      case "CrossAxisAlignment":
        {}
      case "MainAxisAlignment":
        {}
      case "Padding":
        {}
    }
  }

  static TextStyle? generateTextStyle(dynamic data){
    if(data == null) return null;
    return TextStyle(
      fontSize: data['fontSize'] * 1.0,
      color: generateColor(data['color']),
      fontWeight: data['fontWeight'] == null ? FontWeight.normal : FontWeight.values[data['fontWeight']],
    );
  }

  ///```json
  /// {
  ///     "decoration": {
  ///         "type": "BoxDecoration",
  ///         "borderRadius": 20,
  ///         "color": {
  ///             "type": "Color",
  ///             "value": "0xFFD9EDBF"
  ///         }
  ///     }
  /// }
  /// ```json
  static BoxDecoration generateBoxDecoration(dynamic value) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(value['borderRadius'] * 1.0),
      color: generateColor(value['color']),
    );
  }

  ///```json
  /// {
  ///     "padding": {
  ///         "type": "Padding",
  ///         "l": 10,
  ///         "t": 10,
  ///         "r": 10,
  ///         "b": 10
  ///     }
  /// }
  ///```json
  static EdgeInsets generateEdgeInsets(dynamic data) {
    if(data == null){
      return EdgeInsets.zero;
    }
    final edgeInsets = EdgeInsets.fromLTRB(
      data['l'] * 1.0,
      data['t'] * 1.0,
      data['r'] * 1.0,
      data['b'] * 1.0,
    );
    return edgeInsets;
  }

  static Color? generateColor(dynamic data) {
    if (data == null) return null;
    final value = data['value'];
    if (value == null) return null;
    try {
      final color = Color(int.parse(value));
      return color;
    } catch (e) {
      return null;
    }
  }

  static MainAxisAlignment generateMainAxisAlignment(dynamic data) {
    if (data == null) return MainAxisAlignment.start;
    final value = data['value'];
    switch (value) {
      case "end":
        return MainAxisAlignment.end;
      case "start":
        return MainAxisAlignment.start;
      case "center":
        return MainAxisAlignment.center;
      case "spaceBetween":
        return MainAxisAlignment.spaceBetween;
      case "spaceAround":
        return MainAxisAlignment.spaceAround;
      case "spaceEvenly":
        return MainAxisAlignment.spaceEvenly;
    }
    return MainAxisAlignment.start;
  }

  static CrossAxisAlignment generateCrossAxisAlignment(dynamic data) {
    if (data == null) return CrossAxisAlignment.start;
    final value = data['value'];
    switch (value) {
      case "end":
        return CrossAxisAlignment.end;
      case "start":
        return CrossAxisAlignment.start;
      case "center":
        return CrossAxisAlignment.center;
      case "stretch":
        return CrossAxisAlignment.stretch;
      case "baseline":
        return CrossAxisAlignment.baseline;
    }
    return CrossAxisAlignment.start;
  }

  static Axis generateScrollDirection(dynamic data){
    final String? value = data['value'];
    if(value == null) return Axis.vertical;
    switch(value){
      case "vertical": return Axis.vertical;
      case "horizontal": return Axis.horizontal;
    }
    return Axis.vertical;
  }
  
  static BoxFit? generateBoxFit(dynamic data){
    if (data == null){
      return null;
    } 
    for(final fit in BoxFit.values){
      if(fit.toString() == data['value']){
        return fit;
      }
    }
    return null;
  }
}
