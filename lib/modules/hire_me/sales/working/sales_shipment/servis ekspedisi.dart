import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/servis_ekspedisi_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';

class ServiceEKspedisi extends StatefulWidget {
  double? weight;
  int? supCityId;
  String? buyerCityId, ekspedisi;

  ServiceEKspedisi({this.weight, this.buyerCityId, this.supCityId, this.ekspedisi});

  @override
  _ServiceEKspedisiState createState() => _ServiceEKspedisiState();

}

class _ServiceEKspedisiState extends State<ServiceEKspedisi> {

  ServisEkspedisiResponse? servisEkspedisiResponse;
  var token;
  bool loading = false;
  var listekspedisi, listCosts, listeksCost;

  getData()async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    servisEkspedisiResponse = await AuthRepository().getServisEkspedisi(token, widget.buyerCityId, widget.supCityId, widget.weight, widget.ekspedisi);

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Servis Ekspedisi',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          loading ? CircularProgressIndicator()  : Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: servisEkspedisiResponse?.object.length,
                itemBuilder: (context, snap){
                  listekspedisi = servisEkspedisiResponse?.object[snap];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listekspedisi?.costs.length,
                        itemBuilder: (context, snaps){
                           listCosts = listekspedisi?.costs[snaps];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${listekspedisi?.name}', style: FlutterFlowTheme.bodyText1.copyWith(
                                color: Colors.black
                            ),),
                            Text('${listCosts?.service}'),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listCosts?.cost.length,
                              itemBuilder: (context, snapsh){
                               listeksCost = listCosts?.cost[snapsh];
                                 var currencyFormatter = NumberFormat.currency(locale: 'ID');
                                var price = currencyFormatter.format(listeksCost?.value);

                                return InkWell(
                                  onTap: (){print('press');},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${listeksCost?.etd?.replaceAll('HARI', '')} hari sampai'),
                                      Text('${price.replaceAll('IDR', 'Rp ').replaceAll(',00', '')}'),
                                    ],
                                  ),
                                );

                              },
                            )
                          ],
                        ),
                      );
                    })
                  ],
                ),
              );
            }),
          ),
        ],
      )
    );
  }
}
