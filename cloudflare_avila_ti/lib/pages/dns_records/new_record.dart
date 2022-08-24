import 'package:flutter/material.dart';

import '../../models/record_model.dart';
import '../drawer/drawer.dart';

class NewDnsRecord extends StatefulWidget {
  const NewDnsRecord({Key? key}) : super(key: key);

  @override
  State<NewDnsRecord> createState() => _NewDnsRecordState();
}

class _NewDnsRecordState extends State<NewDnsRecord> {
  DnsRecordsModel newDnsRecord = DnsRecordsModel();
  //   this.zoneName = "",
  //   this.name = "",
  //   this.type = "A",
  //   this.content = "",
  //   this.proxiable = true,
  //   this.proxied = true,
  //   this.ttl = 1,
  //   this.createdOn = "",
  //   this.modifiedOn = "",
  //   this.priority = 10,

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("DNS Record"),
        ),
        drawer: cloudflareDrawer(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButton<String>(
              value: newDnsRecord.type,
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              style: const TextStyle(color: Colors.deepOrange),
              underline: Container(
                height: 2,
                color: Colors.deepOrangeAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  newDnsRecord.type = newValue!;
                });
              },
              items: <String>[
                'A',
                // 'AAAA',
                // 'CAA',
                // 'CERT',
                'CNAME',
                // 'DNSKEY',
                // 'DS',
                // 'HTTPS',
                // 'LOC',
                'MX',
                // 'NAPTR',
                'NS',
                'PTR',
                // 'SMIMEA',
                'SPF',
                // 'SRV',
                // 'SVCB',
                'TLSA',
                'TXT',
                // 'URI',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name [ Use @ for root ]',
                ),
                initialValue: newDnsRecord.name,
                onChanged: (value) {
                  newDnsRecord.name = value;
                },
              ),
            ),
            (newDnsRecord.type == "MX")
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name [ Use @ for root ]',
                      ),
                      initialValue: newDnsRecord.name,
                      onChanged: (value) {
                        newDnsRecord.name = value;
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
