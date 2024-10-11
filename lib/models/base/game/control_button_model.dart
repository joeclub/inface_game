// To parse this JSON data, do
//
//     final controlButtonModel = controlButtonModelFromJson(jsonString);

import 'dart:convert';

List<ControlButtonModel> controlButtonModelFromJson(String str) => List<ControlButtonModel>.from(json.decode(str).map((x) => ControlButtonModel.fromJson(x)));

String controlButtonModelToJson(List<ControlButtonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ControlButtonModel {
    String modelName;
    List<int> onOff;
    int gage;

    ControlButtonModel({
        required this.modelName,
        required this.onOff,
        required this.gage,
    });

    factory ControlButtonModel.fromJson(Map<String, dynamic> json) => ControlButtonModel(
        modelName: json["modelName"],
        onOff: List<int>.from(json["on_off"].map((x) => x)),
        gage: json["gage"],
    );

    Map<String, dynamic> toJson() => {
        "modelName": modelName,
        "on_off": List<dynamic>.from(onOff.map((x) => x)),
        "gage": gage,
    };
}
