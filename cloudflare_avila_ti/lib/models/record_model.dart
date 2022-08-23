// To parse this JSON data, do
//
//     final dnsRecordsModel = dnsRecordsModelFromJson(jsonString);

import 'dart:convert';

DnsRecordsModel dnsRecordsModelFromJson(String str) => DnsRecordsModel.fromJson(json.decode(str));

String dnsRecordsModelToJson(DnsRecordsModel data) => json.encode(data.toJson());

class DnsRecordsModel {
    DnsRecordsModel({
        this.id = "",
        this.zoneId = "",
        this.zoneName = "",
        this.name = "",
        this.type = "A",
        this.content = "",
        this.proxiable = true,
        this.proxied = true,
        this.ttl = 1,
        this.createdOn = "",
        this.modifiedOn = "",
        this.priority = 10,
    });

    String id;
    String zoneId;
    String zoneName;
    String name;
    String type;
    String content;
    bool proxiable;
    bool proxied;
    int ttl;
    String createdOn;
    String modifiedOn;
    int priority;

    factory DnsRecordsModel.fromJson(Map<String, dynamic> json) => DnsRecordsModel(
        id: json["id"],
        zoneId: json["zone_id"],
        zoneName: json["zone_name"],
        name: json["name"],
        type: json["type"],
        content: json["content"],
        proxiable: json["proxiable"],
        proxied: json["proxied"],
        ttl: json["ttl"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
        priority: json["priority"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "zone_id": zoneId,
        "zone_name": zoneName,
        "name": name,
        "type": type,
        "content": content,
        "proxiable": proxiable,
        "proxied": proxied,
        "ttl": ttl,
        "created_on": createdOn,
        "modified_on": modifiedOn,
        "priority": priority,
    };
}
