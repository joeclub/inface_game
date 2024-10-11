// To parse this JSON data, do
//
//     final sortBallModel = sortBallModelFromJson(jsonString);

import 'dart:convert';

List<SortBallModel> sortBallModelFromJson(String str) => List<SortBallModel>.from(json.decode(str).map((x) => SortBallModel.fromJson(x)));

String sortBallModelToJson(List<SortBallModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SortBallModel {
    String spriteName;
    String objectName;
    String weight;

    SortBallModel({
        required this.spriteName,
        required this.objectName,
        required this.weight,
    });

    factory SortBallModel.fromJson(Map<String, dynamic> json) => SortBallModel(
        spriteName: json["SpriteName"],
        objectName: json["ObjectName"],
        weight: json["Weight"],
    );

    Map<String, dynamic> toJson() => {
        "SpriteName": spriteName,
        "ObjectName": objectName,
        "Weight": weight,
    };
}
