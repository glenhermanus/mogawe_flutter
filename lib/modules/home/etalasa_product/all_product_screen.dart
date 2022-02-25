import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/home_content/product_etalasa_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/home/widgets/build_product_item.dart';

class AllProductScreen extends StatefulWidget {
  final List<ProductModel> products;

  const AllProductScreen({Key? key, required this.products}) : super(key: key);

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.secondaryColor,
            iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
            automaticallyImplyLeading: true,
            title: Text(
              'Etalase',
              style: FlutterFlowTheme.subtitle1.override(
                fontFamily: 'Poppins',
              ),
            ),
            centerTitle: false,
            elevation: 0,
          ),
          body: _buildProductList(widget.products)),
    );
  }

  Widget _buildProductList(List<ProductModel> products) {
    return GridView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 230,
      ),
      itemBuilder: (ctx, index) {
        return BuildProductItem(productModel: products[index]);
      },
    );
  }
}
