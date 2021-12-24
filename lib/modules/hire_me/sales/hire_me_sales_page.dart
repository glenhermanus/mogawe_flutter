
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_object.dart';
import 'package:mogawe/core/data/response/hire_me/category_list_response.dart';
import 'package:mogawe/core/data/response/hire_me/hire_me_sales_response.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/hire_me/sales/favorite_page.dart';
import 'package:mogawe/modules/hire_me/sales/working/sales_detail/sales_detail_page.dart';

class HireMeSalesPage extends StatefulWidget {
  HireMeSalesPage({Key? key}) : super(key: key);

  @override
  _HireMeSalesPageState createState() => _HireMeSalesPageState();
}

class _HireMeSalesPageState extends State<HireMeSalesPage> {
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
    hireMeSalesResponses = await AuthRepository().hiremeSalesdata(token);

    setState(() {
      loading = false;
    });
  }

  Future getCategory()async{
    setState(() {
      loading_category = true;

    });

    token = await AuthRepository().readSecureData('token');
    category = await AuthRepository().getCategorydata(token);

    setState(() {
      loading_category = false;
      listcategory_ = [
        {
          'name' : 'Semua Kategori',
          'uuid' : 'abc',
        },
      ];

      for(var i=0; i <category!.object!.length; i++){

        var listbaru = {
          'name' : category?.object?[i].name as String,
          'uuid' : category?.object?[i].uuid as String,
        };
        listcategory_.add(listbaru);

      }
    });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getdata();
    getCategory();
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
          'Gawean Jualan',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 40,
              icon: Icon(
                Icons.favorite,
                color: FlutterFlowTheme.primaryColor,
                size: 24,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteHireMeSalesPage(),
                  ),
                );
              },
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
                          hireMeSalesResponses = await AuthRepository().SearchCategorydata(token, search);
                          setState(() {
                            loading = false;
                          });
                      },
                    ),
                  ),
                  loading ? Container() : Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.fieldColor,
                          borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:  Color(0x00515151),
                          width: 0
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        child: DropdownButtonHideUnderline(

                          child: DropdownButton<Map<String,String>>(
                            dropdownColor: FlutterFlowTheme.fieldColor,
                            value: value,
                            isExpanded: true,
                            elevation: 2,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            hint: Text('Semua Kategori', style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),),
                            onChanged: (newValue) async{
                              setState(() {
                                value = newValue;
                                name = value['name'];

                                uuidCategory = value['uuid'];

                                loading = true;
                              });
                              name == 'Semua Kategori' ? hireMeSalesResponses= await AuthRepository().hiremeSalesdata(token) :
                              hireMeSalesResponses= await AuthRepository().CategoryhiremeSalesdata(token, uuidCategory);
                              setState(() {
                                loading = false;
                              });
                            },
                            items: listcategory_.map<DropdownMenuItem<Map<String, String>>>((value) {
                              nameCategory = value['name'];
                              return DropdownMenuItem<Map<String, String>>(
                                value: value,
                                child: Text(nameCategory),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
           loading ? CircularProgressIndicator() : Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: GridView.builder(
                  itemCount: hireMeSalesResponses?.object.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.55,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, snap){
                    final lista = hireMeSalesResponses?.object[snap];
                    var currencyFormatter = NumberFormat.currency(locale: 'ID');
                    var price = currencyFormatter.format(lista?.price);
                    var komisi = currencyFormatter.format(lista?.commission);
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SalesDetailPage(uuid: lista?.uuidobj as String,),
                          ),
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional(1, -1),
                              children: [
                                Image.network(
                                  '${lista?.imageUrl}',
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                                  child: InkWell(
                                    onTap:()async{

                                      if(lista?.isFavorite != true){
                                        var res = await AuthRepository().postfavhiremeSalesdata(lista?.isFavorite, token, lista?.uuidobj);
                                        setState(() {
                                          lista?.isFavorite = true;
                                        });
                                      }else{
                                        var del = await AuthRepository().deletefavhiremeSalesdata(lista?.isFavorite, token, lista?.uuidobj);
                                        setState(() {
                                          lista?.isFavorite = false;
                                        });
                                      }

                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.secondaryColor,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: lista?.isFavorite != true ? Icon(
                                        Icons.favorite,
                                        color: Color(0xFF737373),
                                        size: 24,
                                      ) : Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${lista?.name}',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Text(
                                      'Harga Produk',
                                      style: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Rp${price.replaceAll('IDR', '').replaceAll(',00', '')}',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Text(
                                      'Komisi',
                                      style: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Rp${komisi.replaceAll('IDR', '').replaceAll(',00', '')}',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.moGaweGreen,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),

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
