import 'package:flutter/material.dart';

class SalesAddress extends StatefulWidget {
  const SalesAddress({Key? key}) : super(key: key);

  @override
  _SalesAddressState createState() => _SalesAddressState();
}

class _SalesAddressState extends State<SalesAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Tambah Alamat'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.location_on_outlined,),
                Text('Provinsi'),
                TextFormField(
                  onChanged: (s){

                  },
                ),
                Icon(Icons.arrow_forward_ios, size: 14,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
