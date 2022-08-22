// To parse this JSON data, do
//
//     final zonesModel = zonesModelFromJson(jsonString);

import 'dart:convert';

ZonesModel zonesModelFromJson(String str) => ZonesModel.fromJson(json.decode(str));

String zonesModelToJson(ZonesModel data) => json.encode(data.toJson());

class ZonesModel {
    ZonesModel({
        this.id = "",
        this.name = "",
        this.status = "",
        this.nameServers = const [""],
    });

    String id;
    String name;
    String status;
    List<dynamic> nameServers;

    factory ZonesModel.fromJson(Map<String, dynamic> json) => ZonesModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        nameServers: List<String>.from(json["name_servers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "name_servers": List<dynamic>.from(nameServers.map((x) => x)),
    };
}
