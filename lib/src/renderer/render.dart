import 'package:flutter/material.dart';
import 'package:freeflow_flutter/src/renderer/property.dart';
import 'package:freeflow_flutter/src/renderer/unknown_widget.dart';

class WidgetEngine {
  Widget renderJSON(Map<String, dynamic> data) {
    final type = data["type"];
    if (type == "Scaffold") {
      return _renderScaffold(data);
    }
    if (type == "Text") {
      return _renderText(data);
    }
    if (type == "AppBar") {
      return _renderAppBar(data);
    }
    if(type == "Container") {
      return _renderContainer(data);
    }
    if(type == "SizedBox") {
      return renderSizedBox(data);
    }
    if(type == "Row") {
      return renderRow(data);
    }
    if(type == "Column") {
      return renderColumn(data);
    }
    if(type == "ListView") {
      return renderListView(data);
    }
    if(type == "Image") {
      return renderImage(data);
    }
    return UnknownWidget(
      type: type,
    );
  }

  Widget _renderScaffold(Map<String, dynamic> data) {
    return Scaffold(
      appBar: _renderAppBar(data['appBar']),
      body: renderJSON(data['body']),
    );
  }

  Widget _renderText(Map<String, dynamic> data) {
    final String value = data['value'] ?? "Unknown";
    return Text(
      value,
      style: PropertyEngine.generateTextStyle(data["textStyle"]),
    );
  }

  Widget _renderContainer(Map<String, dynamic> data) {
    return Container(
      padding: data["padding"] == null ? data["padding"] : PropertyEngine.generateEdgeInsets(data["padding"]),
      margin: data["margin"] == null ? data["margin"] : PropertyEngine.generateEdgeInsets(data["margin"]),
      decoration: data["decoration"] == null ? data["decoration"] : PropertyEngine.generateBoxDecoration(data['decoration']),
      width: data['width'] == null ? null : data['width'] * 1.0,
      height: data['height'] == null ? null : data['height'] * 1.0,
      child: data["child"] == null? null : renderJSON(data["child"]),
    );
  }

  AppBar _renderAppBar(dynamic data) {
    if(data==null){
      return AppBar();
    }
    return AppBar(
      title: renderJSON(data["child"]),
      backgroundColor: PropertyEngine.generateColor(data['backgroundColor']),
    );
  }

  SizedBox renderSizedBox(dynamic data){
    return SizedBox(
      height: data["height"] * 1.0,
      width: data["width"] * 1.0,
    );
  }

  Row renderRow(dynamic data){
    final List childrenList = data['children'];
    return Row(
      mainAxisAlignment: PropertyEngine.generateMainAxisAlignment(data['mainAxisAlignment']),
      crossAxisAlignment: PropertyEngine.generateCrossAxisAlignment(data['crossAxisAlignment']),
      children: childrenList.map((data) => renderJSON(data)).toList(),
    );
  }

  Column renderColumn(dynamic data){
    final List childrenList = data['children'];
    return Column(
      mainAxisAlignment: PropertyEngine.generateMainAxisAlignment(data['mainAxisAlignment']),
      crossAxisAlignment: PropertyEngine.generateCrossAxisAlignment(data['crossAxisAlignment']),
      children: childrenList.map((data) => renderJSON(data)).toList(),
    );
  }

  ListView renderListView(dynamic data){
    final List childrenJSON = data['children'];
    final children = childrenJSON.map((data) => renderJSON(data),).toList();
    return ListView(
      scrollDirection: PropertyEngine.generateScrollDirection(data["scrollDirection"]),
      reverse: data['reverse'],
      primary: data['primary'],
      shrinkWrap: true,
      children: children,
    );
  }

  Widget renderImage(dynamic data){
    final url = data['url'];
    final asset = data['asset'];

    if(url!=null){
      return Image.network(
        url,
        fit: PropertyEngine.generateBoxFit(data['fit']),
      );
    }

    if(asset!=null){
      return Image.network(
        asset,
        fit: PropertyEngine.generateBoxFit(data['fit']),
      );
    }

    return const Text("Property url or asset required");
  }
}