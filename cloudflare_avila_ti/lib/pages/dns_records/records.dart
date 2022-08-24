import 'package:flutter/material.dart';

import '../../models/record_model.dart';
import '../../services/services.dart';
import '../../utils.dart';
import '../drawer/drawer.dart';

class DnsRecord extends StatefulWidget {
  const DnsRecord({Key? key}) : super(key: key);

  @override
  State<DnsRecord> createState() => _DnsRecordState();
}

class _DnsRecordState extends State<DnsRecord> {
  String title = activeZoneModel.name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushReplacementNamed(context, pageRoutes.newDnsRecord);
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.pushReplacementNamed(context, pageRoutes.home );
                Navigator.popAndPushNamed(context, pageRoutes.home);
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        drawer: cloudflareDrawer(context),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<dynamic>(
              future: getProjectDetails(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> widgetList;

                if (snapshot.hasData) {
                  widgetList = dnsRecordTiles();

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


dnsRecordTiles() {
  List<Widget> widgetList = <Widget>[];

  for (DnsRecordsModel item in activeZoneModel.dnsRecords) {
    widgetList.add(
      ListTile(
        leading: Text(item.type),
        title: Text(item.name),
        subtitle: (item.type == 'MX')
            ? Text("${item.priority} ${item.content}")
            : Text(item.content),
        onTap: () async {},
      ),
    );
  }

  if (widgetList.isEmpty) {
    return [
      const Icon(
        Icons.forward,
        color: Colors.red,
        size: 60,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Not exist any Records for this DNS Zone'),
      )
    ];
  } else {
    return widgetList;
  }
}

Future getProjectDetails() async {
  if (await tokenDefined()) {
    return true;
  } else {
    // Return empty Dns Zone list
    return false;
  }
}
