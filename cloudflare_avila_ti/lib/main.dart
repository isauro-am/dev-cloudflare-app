import 'package:cloudflare_avila_ti/pages/dns_records/records.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/dns_records/new_record.dart';
import 'pages/settings/account.dart';
import 'pages/zones/home.dart';
import 'services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloudflare App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: pageRoutes.account,
      routes: {
        pageRoutes.home: (context) => const Home(),
        pageRoutes.account: (context) => const CreateAccount(),
        pageRoutes.dnsRecords: (context) => const DnsRecord(),
        pageRoutes.newDnsRecord: (context) => const NewDnsRecord()
      },


      // home: const MyHomePage(title: 'Cloudflare App'),
    );
  }
}
