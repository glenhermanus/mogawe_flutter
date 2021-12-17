import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/hire_me/maps_shipment.dart';
import 'package:mogawe/core/data/response/hire_me/provinsi_response.dart';
import 'package:mogawe/core/data/response/hire_me/shipment_city_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/auth/repositories/auth_repository.dart';

class SalesAddress extends StatefulWidget {
  const SalesAddress({Key? key}) : super(key: key);

  @override
  _SalesAddressState createState() => _SalesAddressState();
}

class _SalesAddressState extends State<SalesAddress> {
  bool _loadingButton = false;
  bool loading = false;
  List listcategory = [];
  var nameProvince, idProvince, nameCity, idCity;
  var value, value_city;
  var name, token;
  ProvinsiResponse? provinsiResponse;
  var listprovinsi, listcity;
  ShipmentCityResponse? shipmentCityResponse;

  Future getdata() async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    provinsiResponse = await AuthRepository().getProvinsi(token);

    setState(() {
      loading = false;
      listprovinsi = [
      ];
      for(var i=0; i <provinsiResponse!.object.length; i++){

        var listbaru = {
          'province' : provinsiResponse?.object[i].province as String,
          'province_id' : provinsiResponse?.object[i].province_id as String,
        };
        listprovinsi.add(listbaru);

      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_outlined, color: Colors.black,),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Tambah Alamat', style: FlutterFlowTheme.title3.override(
          fontFamily: 'Poppins',
          fontSize: 16
        ),),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,),
                            SizedBox(width: 15,),
                            Text('Provinsi',  style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            loading? Icon(Icons.arrow_forward_ios, size: 14,) : Container(
                              width: 170,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Map<String,String>>(
                                    dropdownColor: FlutterFlowTheme.fieldColor,
                                    value: value,
                                    icon: Icon(Icons.arrow_forward_ios, size: 14,),
                                    isExpanded: true,
                                    elevation: 0,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    onChanged: (newValue) async{
                                      setState(() {
                                        value = newValue;
                                        name = value['province'];
                                        idProvince = value['province_id'];
                                        value_city = null;
                                        loading = true;
                                      });
                                      shipmentCityResponse = await AuthRepository().getShipment(token, idProvince);
                                      setState(() {
                                        loading = false;
                                        listcity = [
                                        ];
                                        for(var i=0; i <shipmentCityResponse!.object.length; i++){

                                          var listbaru = {
                                            'city_name' : shipmentCityResponse?.object[i].city_name as String,
                                            'province_id' : shipmentCityResponse?.object[i].province_id as String,
                                            'city_id' : shipmentCityResponse?.object[i].city_id as String,
                                            'postal_code' : shipmentCityResponse?.object[i].postal_code as String,
                                          };
                                          listcity.add(listbaru);

                                        }
                                      });
                                    },
                                    items: listprovinsi.map<DropdownMenuItem<Map<String, String>>>((value) {
                                      nameProvince = value['province'];
                                      return DropdownMenuItem<Map<String, String>>(
                                        value: value,
                                        child: Text(nameProvince),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_city_outlined,),
                            SizedBox(width: 15,),
                            Text('Kota/Kabupaten',  style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            listcity == null ? Icon(Icons.arrow_forward_ios, size: 14,) : Container(
                              width: 170,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Map<String,String>>(
                                    dropdownColor: FlutterFlowTheme.fieldColor,
                                    value: value_city,
                                    icon: Icon(Icons.arrow_forward_ios, size: 14,),
                                    isExpanded: true,
                                    elevation: 0,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                    onChanged: (newValue) async{
                                      setState(() {
                                        value_city = newValue;
                                        loading = true;
                                      });

                                      setState(() {
                                        loading = false;

                                      });
                                    },
                                    items: listcity.map<DropdownMenuItem<Map<String, String>>>((value) {
                                      nameCity = value['city_name'];
                                      return DropdownMenuItem<Map<String, String>>(
                                        value: value,
                                        child: Text(nameCity),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationShipment(),
                          ),
                        );
                      },
                      child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.home_outlined,),
                                SizedBox(width: 15,),
                                Expanded(child: Text('Alamat Lengkap',  style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ))),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, size: 14,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Detail Lokasi (Optional)',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextFormField(

                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xffbfbfbf),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 16),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Simpan',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56,
                          color: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                        loading: _loadingButton,
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
