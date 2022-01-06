
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_object.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_response.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_response.dart';
import 'package:mogawe/core/data/response/merchant/supplier_product.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/hire_me/sales/favorite_page.dart';
import 'package:mogawe/modules/hire_me/sales/working/sales_detail/sales_detail_page.dart';
import 'package:mogawe/modules/profile/page_merchant/add_product_merchant.dart';

class ProductMerchantPage extends StatefulWidget {
  SupplierProduct? supplierProduct;
  ProductMerchantPage({this.supplierProduct});

  @override
  _ProductMerchantPageState createState() => _ProductMerchantPageState();
}

class _ProductMerchantPageState extends State<ProductMerchantPage> {
  String? dropDownValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading =false;
  bool loading_category = false;
  var token;
  HireMeSalesResponses? hireMeSalesResponses;
  CategoryListResponse? category;
  List<String> stringCategory =[];
  List listcategory = [];
  var nameCategory, uuidCategory, nameCategoryValue, uuidCategoryValue;
  var value;
  CategoryListObject? categoryListObject;
  var listcategory_, valuelist =
  {
    'name' : 'Semua Kategori',
    'uuid' : 'abc',
  };
  var name;
  String? search;

  Future getdata() async{
    setState(() {
      loading = true;

    });

    token = await AuthRepository().readSecureData('token');


    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'List Produk',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: InkWell(
              onTap: (){ Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductMerchant(),
                ),
              );},
              child: Row(
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.primaryColor,
                      size: 24,
                    ),

                  ),
                  Text('Tambah Produk', style: FlutterFlowTheme.bodyText2.copyWith(color: Colors.red),)
                ],
              ),
            ),
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.fieldColor,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 16,
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                      onChanged: (s)async{
                        setState(() {
                          search = s;
                          loading = true;
                        });
                        widget.supplierProduct = await AuthRepository().SearchProductMerchants(token, search);
                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ),

                ],
              ),
            ),
            loading ? CircularProgressIndicator() : Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.supplierProduct?.objectDatas?.length,
                    itemBuilder: (context, snap){

                      final card = widget.supplierProduct?.objectDatas?[snap];
                      var currencyFormatter = NumberFormat.currency(locale: 'ID');
                      var price = currencyFormatter.format(card?.price);
                      var komisi = currencyFormatter.format(card?.commission);

                      return InkWell(
                        onTap: (){

                        },
                        child: Card(
                          clipBehavior:
                          Clip.antiAliasWithSaveLayer,
                          color: Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                alignment:
                                AlignmentDirectional(0, 1),
                                children: [
                                  Image.network(
                                    '${card?.imageUrl}',
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),

                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional
                                    .fromSTEB(8, 8, 8, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${card?.name}',
                                      style: FlutterFlowTheme
                                          .bodyText1
                                          .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional
                                          .fromSTEB(
                                          0, 4, 0, 0),
                                      child: Row(
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            'Rp${price.replaceAll('IDR', '').replaceAll(',00', '')}',
                                            style:
                                            FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily:
                                              'Poppins',
                                              fontSize: 11,
                                            ),
                                          ),
                                          Text(
                                            'Rp${komisi.replaceAll('IDR', '').replaceAll(',00', '')}',
                                            style:
                                            FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily:
                                              'Poppins',
                                              fontSize: 11,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
