import 'package:cloudflare_avila_ti/services/secure.dart';
import 'package:flutter/material.dart';

import '../models/zone_model.dart';
import '../requests/zones.dart';
import '../services/services.dart';
import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = 'Cloudflare App';

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
                  widgetList = dnsZoneTiles(snapshot);

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
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

tokenDefined() async {

  if (await sotoreSecureData.getData("token") != null) {
    return true;
  } else {
    return false;
  }
}

dnsZoneTiles(snapshot) {
  List<Widget> widgetList = <Widget>[];

  for (var item in snapshot.data) {
    widgetList.add(
      ListTile(
        title: Text(item.name),
        leading: Icon(
          Icons.dns,
          size: 20.0,
          color: iconColor(item.status),
        ),
        onTap: () async {
          // Navigator.pushReplacementNamed(
          //     context, pageRoutes.home);
          dynamic result =
              await httpRequest.getList(cloudflareUrls.dnsRecords(item.id));
          print(result);
          for (var element in result['result']) {
            print(element.toString());
          }
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

iconColor(text) {
  if (text == "active") {
    return Color.fromARGB(255, 223, 141, 49);
  } else {
    return Color.fromARGB(255, 156, 143, 127);
  }
}
