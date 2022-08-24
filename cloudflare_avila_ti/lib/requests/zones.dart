import '../models/record_model.dart';
import '../models/zone_model.dart';
import '../services/services.dart';

CloudflareZones cloudflareZones = CloudflareZones();

class CloudflareZones {
  List<ZonesModel> zones = [];

  getZones() async {
    zones = [];
    dynamic response = await httpRequest.getList(cloudflareUrls.zones);

    if (response.containsKey('result')) {
      for (var element in response['result']) {
        ZonesModel tmpZoneModel = ZonesModel();
        tmpZoneModel.id = element['id'];
        tmpZoneModel.name = element['name'];
        tmpZoneModel.status = element['status'];
        tmpZoneModel.nameServers = element['name_servers'];
        zones.add(tmpZoneModel);
      }
    }
    return zones;
  }
}


CloudflareDnsRecords cloudflareDnsRecords = CloudflareDnsRecords();

class CloudflareDnsRecords {
  List<DnsRecordsModel> dnsRecords = [];

  getDnsRecords() async {
    activeZoneModel.dnsRecords = [];
    dynamic response = await httpRequest.getList(cloudflareUrls.dnsRecords(activeZoneModel.id));

    if (response.containsKey('result')) {
      for (var element in response['result']) {
        DnsRecordsModel tmpZoneModel = DnsRecordsModel();
        tmpZoneModel.id = element['id'];
        tmpZoneModel.zoneId = element['zone_id'];
        tmpZoneModel.zoneName = element['zone_name'];
        tmpZoneModel.name = element['name'];
        tmpZoneModel.type = element['type'];
        tmpZoneModel.content = element['content'];
        tmpZoneModel.proxiable = element['proxiable'];
        tmpZoneModel.proxied = element['proxied'];
        tmpZoneModel.ttl = element['ttl'];
        tmpZoneModel.createdOn = element['created_on'];
        tmpZoneModel.modifiedOn = element['modified_on'];
        activeZoneModel.dnsRecords.add(tmpZoneModel);
      }
    }
  }
}
