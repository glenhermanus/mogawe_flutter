import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';

class AddProductMerchant extends StatefulWidget {
  const AddProductMerchant({Key? key}) : super(key: key);

  @override
  _AddProductMerchantState createState() => _AddProductMerchantState();
}

class _AddProductMerchantState extends State<AddProductMerchant> {
  bool _loadingButton = false;
  TextEditingController textController = new TextEditingController();
  TextEditingController hargactrl = new TextEditingController();

  CategoryListResponse? category;
  int?  indexSelect;
  var listcategory_, valuelist =
  {
    'name' : 'Semua Kategori',
    'uuid' : 'abc',
  };
  var token;
  bool loading_category = false;
  var nameCategory, uuidCategory, nameCategoryValue, uuidCategoryValue, name;
  var value;
  bool loading = false;
  var categoryValue;
  String? harga;


  Future getCategory()async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');
    category = await AuthRepository().getCategorydata(token);

    setState(() {
      loading = false;
      listcategory_ = [];

      for(var i=0; i <category!.object!.length; i++){

        var listbaru = {
          'name' : category?.object?[i].name as String,
          'uuid' : category?.object?[i].uuid as String,
        };
        listcategory_.add(listbaru);
      }
    });
  }

  openAlertBoxKategori() {
    final node = FocusScope.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Kategori Produk", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                            fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Container(
                            width: 300,
                            height:  MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                                itemCount: category?.object?.length,
                                itemBuilder: (context, snap){
                                  final listValue = category?.object?[snap];


                                  return InkWell(
                                    onTap: (){
                                      stateSetter(() {
                                        categoryValue = category?.object?[snap];
                                        indexSelect = snap;
                                        node.nextFocus();
                                        Navigator.pop(context);
                                      });

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Container(
                                          width: 300,
                                          child: Text('${listValue?.name}')
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              );
            }));
  }

  openAlertBoxProdukBerbahaya() {
    final node = FocusScope.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Kategori Produk", style: FlutterFlowTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,
                            fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Container(
                            width: 300,
                            height:  MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                                itemCount: category?.object?.length,
                                itemBuilder: (context, snap){
                                  final listValue = category?.object?[snap];


                                  return InkWell(
                                    onTap: (){
                                      stateSetter(() {
                                        categoryValue = category?.object?[snap];
                                        indexSelect = snap;
                                        node.nextFocus();
                                        Navigator.pop(context);
                                      });

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Container(
                                          width: 300,
                                          child: Text('${listValue?.name}')
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              );
            }));
  }

  void showEditDialog(BuildContext ctx,
      {String? title, Function(String v)? onChanged, TextInputType? type,
        String? value, bool isGender = false, String? field, TextEditingController? ctrl}) {
    showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? "", style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              )),
              SizedBox(height: 12),
             Container(
                height: 32,
                child: TextFormField(

                  onChanged: (v) {
                    value = v;
                    if (v.isEmpty) value = null;
                    setState(() {});
                  },
                  keyboardType: type ?? TextInputType.text,
                  controller: ctrl,
                ),
              )
            ],
          ),
            actions:  [
            TextButton(
              child: Text("BATAL"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                if (value != null) {
                  harga = hargactrl.text;
                  Navigator.pop(context);
                }
                else Fluttertoast.showToast(msg: "Harus diisi");
              },
            ),
            ]
        ),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Tambah Produk',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),

        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gambar Produk *'),
                  SizedBox(height: 10,),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    color: Colors.black54,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.add, color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gambar Produk *'),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.fieldColor,

                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                      onChanged: (s)async{
                        setState(() {

                        });

                        setState(() {

                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deskripsi *'),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.fieldColor,

                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                      minLines: 2,
                      maxLines: 4,
                      onChanged: (s)async{
                        setState(() {

                        });

                        setState(() {

                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Youtube Url'),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.fieldColor,

                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                      onChanged: (s)async{
                        setState(() {

                        });

                        setState(() {

                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Brand *'),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.fieldColor,

                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                      onChanged: (s)async{
                        setState(() {

                        });

                        setState(() {

                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.home_outlined),
                          SizedBox(width: 10,),
                          Text('Alamat PickUp*'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list),
                          SizedBox(width: 10,),
                          Text('Kategori *'),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                              openAlertBoxKategori();
                          },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: categoryValue == null ? Text('') : Text('${categoryValue.name}'),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward_ios, size: 14,),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(width: 10,),
                          Text('Produk Berbahaya *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  InkWell(
                    onTap: ()=> showEditDialog(
                        context,
                        title: "Rekomendasi Harga Produk ",
                        type: TextInputType.number,
                        value: harga,
                        field: "phone",
                        ctrl: hargactrl,
                        onChanged: (v) {
                          // phone = v;
                          // if (v.isEmpty) phone = null;
                          setState(() {});
                        }
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.attach_money_sharp),
                            SizedBox(width: 10,),
                            Text('Harga *'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('$harga'),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward_ios, size: 14,),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  InkWell(
                    onTap: ()=> showEditDialog(
                        context,
                        title: "Komisi Produk ",
                        type: TextInputType.number,
                        value: harga,
                        field: "phone",
                        ctrl: hargactrl,
                        onChanged: (v) {
                          // phone = v;
                          // if (v.isEmpty) phone = null;
                          setState(() {});
                        }
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.money_sharp),
                            SizedBox(width: 10,),
                            Text('Komisi *'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios, size: 14,)
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.category),
                          SizedBox(width: 10,),
                          Text('Stok *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.inbox),
                          SizedBox(width: 10,),
                          Text('Pengiriman *'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14,)
                    ],
                  ),
                  SizedBox(height: 16,),

                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
            child: FFButtonWidget(
              onPressed: () {

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
                borderRadius: 20,
              ),
              loading: _loadingButton,
            ),
          )
        ],
      ),
    );
  }


}
