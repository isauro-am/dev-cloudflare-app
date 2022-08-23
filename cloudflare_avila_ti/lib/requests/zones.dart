import '../models/zone_model.dart';
import '../services/services.dart';

CloudflareZones cloudflareZones = CloudflareZones();

class CloudflareZones {
  List<ZonesModel> zones = [];

  getZones() async {
    print("Clean Zone List");
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
