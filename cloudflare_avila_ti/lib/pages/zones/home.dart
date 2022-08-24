import 'package:flutter/material.dart';

import '../../models/zone_model.dart';
import '../../requests/zones.dart';
import '../../services/services.dart';
import '../../utils.dart';
import '../drawer/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = 'DNS Zones';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: cloudflareDrawer(context),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<dynamic>(
              future: getProjectDetails(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> widgetList;

                if (snapshot.hasData) {
                  widgetList = dnsZoneTiles(snapshot, context);

                  widgetList.add(Container(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10)));
                } else if (snapshot.hasError) {
                  widgetList = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('- Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  widgetList = <Widget>[
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting DNS Zones results...'),
                    )
                  ];
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: widgetList,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

dnsZoneTiles(snapshot, BuildContext context) {
  List<Widget> widgetList = <Widget>[];

  for (var item in snapshot.data) {
    widgetList.add(
      ListTile(
        title: Text(item.name),
        leading: Icon(
          Icons.dns,
          size: 20.0,
          color: (item.status == "active")
              ? cloudflareColors.activeIcon
              : cloudflareColors.noActiveIcon,
        ),
        onTap: () async {
          activeZoneModel = item;
          await cloudflareDnsRecords.getDnsRecords();

          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, pageRoutes.dnsRecords);
        },
      ),
    );
  }

  if (widgetList.isEmpty) {
    return [
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Not exist any DNS Zone Records'),
      )
    ];
  } else {
    return widgetList;
  }
}

// SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         drawer: cloudflareDrawer(),
//         body: ,
//       ),
//     );

Future getProjectDetails() async {
  cloudflareZones.zones = [];
  if (await tokenDefined()) {
    List<ZonesModel> zones = await cloudflareZones.getZones();
    return zones;
  } else {
    // Return empty Dns Zone list
    return cloudflareZones.zones;
  }
}
