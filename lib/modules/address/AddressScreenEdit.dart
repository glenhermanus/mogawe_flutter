import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/response/hire_me/provinsi_response.dart';
import 'package:mogawe/core/data/response/hire_me/sales_detail_response.dart';
import 'package:mogawe/core/data/response/hire_me/shipment_city_response.dart';
import 'package:mogawe/core/data/response/merchant/address_pickup.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/address_repository.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/address/widgets/maps_location_picker.dart';
import 'package:mogawe/utils/ui/widgets/MogawePrimaryButton.dart';

class AddressScreenEdit extends StatefulWidget {
  final AddressPickup addressModel;

  AddressScreenEdit(this.addressModel);
  @override
  _AddressScreenEditState createState() => _AddressScreenEditState();
}

class _AddressScreenEditState extends State<AddressScreenEdit> {
  var logger = Logger(printer: PrettyPrinter());

  bool _loadingButton = false;
  bool loading = false;
  List listcategory = [];
  var nameProvince, idProvince, nameCity, idCity;
  var value, value_city;
  var name, token;
  String addressName = "";
  ProvinsiResponse? provinsiResponse;
  var listprovinsi, listcity;
  String address = "";
  late double addressLat, addressLng;

  ShipmentCityResponse? shipmentCityResponse;
  SalesDetailResponses? salesDetailResponses;
  final AddressRepository _addressRepository = AddressRepository.instance;
  TextEditingController _addressName = new TextEditingController();

  Future getdata() async {
    setState(() {
      loading = true;
    });

    token = await AuthRepository().readSecureData('token');
    provinsiResponse = await AuthRepository().getProvinsi(token);
    setState(() {
      loading = false;
      listprovinsi = [];
      for (var i = 0; i < provinsiResponse!.object.length; i++) {
        var listbaru = {
          'province': provinsiResponse?.object[i].province as String,
          'province_id': provinsiResponse?.object[i].province_id as String,
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
    address = widget.addressModel.address ?? "";
    addressLat = widget.addressModel.latitude;
    addressLng = widget.addressModel.longitude;
    nameProvince = widget.addressModel.shipmentProvinceName;
    nameCity = widget.addressModel.shipmentCityName;
    idProvince = widget.addressModel.shipmentProvinceId;
    idCity = widget.addressModel.shipmentCityId;
    _addressName.text = widget.addressModel.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_outlined,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Tambah Alamat',
          style: FlutterFlowTheme.title3
              .override(fontFamily: 'Poppins', fontSize: 16),
        ),
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
                    SizedBox(
                      height: 10,
                    ),
                    Text('Nama Alamat',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    _buildAddressNameTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildProvinceDropdown(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildCityDropdown(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildAlamatPickButton(),
                    address != ""
                        ? Padding(
                            padding: const EdgeInsets.only(left: 30, right: 20),
                            child: Text('$address',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                )),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Detail Lokasi (Optional)',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 16),
                      child: MogawePrimaryButton(
                        onTap: () {
                          _addPickupAddress();
                        },
                        buttonText: "Simpan",
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

  Future<void> _addPickupAddress() async {
    try {
      var response = await _addressRepository.addAddress(token, _addressName.value.text, address, addressLat, addressLng, 15, nameProvince, 15, nameCity);

      if(response.message == "Berhasil"){
        Navigator.of(context).pop();
      }
    } catch(ex) {
      logger.e(ex);
    }
  }

  Widget _buildProvinceDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
            ),
            SizedBox(
              width: 15,
            ),
            Text('Provinsi',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                )),
          ],
        ),
        Row(
          children: [
            loading
                ? Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  )
                : Container(
                    width: 170,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Map<String, String>>(
                          dropdownColor: FlutterFlowTheme.fieldColor,
                          value: value,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          isExpanded: true,
                          elevation: 0,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          onChanged: (newValue) async {
                            setState(() {
                              value = newValue;
                              name = value['province'];
                              idProvince = value['province_id'];
                              value_city = null;
                              loading = true;
                            });
                            shipmentCityResponse = await AuthRepository()
                                .getShipment(token, idProvince);
                            setState(() {
                              loading = false;
                              listcity = [];
                              for (var i = 0;
                                  i < shipmentCityResponse!.object.length;
                                  i++) {
                                var listbaru = {
                                  'city_name': shipmentCityResponse
                                      ?.object[i].city_name as String,
                                  'province_id': shipmentCityResponse
                                      ?.object[i].province_id as String,
                                  'city_id': shipmentCityResponse
                                      ?.object[i].city_id as String,
                                  'postal_code': shipmentCityResponse
                                      ?.object[i].postal_code as String,
                                };
                                listcity.add(listbaru);
                              }
                            });
                          },
                          items: listprovinsi
                              .map<DropdownMenuItem<Map<String, String>>>(
                                  (value) {
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
    );
  }

  Widget _buildCityDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_city_outlined,
            ),
            SizedBox(
              width: 15,
            ),
            Text('Kota/Kabupaten',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                )),
          ],
        ),
        Row(
          children: [
            listcity == null
                ? Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  )
                : Container(
                    width: 170,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Map<String, String>>(
                          dropdownColor: FlutterFlowTheme.fieldColor,
                          value: value_city,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          isExpanded: true,
                          elevation: 0,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          onChanged: (newValue) async {
                            setState(() {
                              value_city = newValue;
                              var name_city = value_city['city_name'];
                              var postal_code = value_city['postal_code'];
                              var city_id = value_city['city_id'];

                              loading = false;
                            });
                          },
                          items: listcity
                              .map<DropdownMenuItem<Map<String, String>>>(
                                  (value) {
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
    );
  }

  Widget _buildAddressNameTextField() {
    return SizedBox(
      height: 35,
      child: TextFormField(
        controller: _addressName,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xff898888),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xff898888),
            ),
          ),
        ),
        style: FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildAlamatPickButton() {
    return InkWell(
      onTap: () async {
        var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapsLocationPicker(),
            ));
        if (result != null || result != "") {
          setState(() {
            address = result['address'] as String;
            addressLat = result['latitude'] as double;
            addressLng = result['longitude'] as double;
            logger.d("addressnya adalah ${result['address']}");
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.home_outlined,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text('Alamat Lengkap',
                        style: FlutterFlowTheme.bodyText1.override(
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
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
