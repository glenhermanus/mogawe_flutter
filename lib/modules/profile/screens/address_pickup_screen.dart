import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mogawe/core/data/response/merchant/address_pickup.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/modules/address/AddressScreen.dart';
import 'package:mogawe/modules/address/AddressScreenEdit.dart';
import 'package:mogawe/modules/profile/blocs/address_bloc.dart';
import 'package:mogawe/modules/profile/blocs/address_event.dart';
import 'package:mogawe/modules/profile/blocs/address_state.dart';
import 'package:mogawe/modules/profile/widget/loading/build_pickup_address_loading.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';

class AddressPickupScreen extends StatefulWidget {
  const AddressPickupScreen({Key? key}) : super(key: key);

  @override
  _AddressPickupScreenState createState() => _AddressPickupScreenState();
}

class _AddressPickupScreenState extends State<AddressPickupScreen> {
  late AddressBloc bloc;
  late List<AddressPickup> listAddress;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = AddressBloc();
    bloc.add(GetAddressEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  Widget blocListener(Widget child) {
    return BlocListener(
      bloc: bloc,
      listener: (ctx, state) => print("State : $state"),
      child: child,
    );
  }

  Widget blocBuilder() {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        if (state is ShowLoadingAddressState) {
          print("State : $state");
          return buildPickUpAddressLoading();
        }
        if (state is ShowListAddressPickupState) {
          listAddress = state.data;

          return ListView.builder(
              itemCount: listAddress.length,
              itemBuilder: (context, index) {
                return _buildItemAddress(listAddress[index], index);
              });
        }
        if (state is ShowEmptyListAddressState) {
          return Container();
        }
        if (state is ShowErrorAddressPickupState) {
          print("error ads" + state.message);
          return Container();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
        automaticallyImplyLeading: true,
        title: Text(
          'Daftar Alamat',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: BounceTap(
              onTap: () async {
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressScreen(),
                    ));
                print('aa ${result['res]']}');
                if (result['res'] == "Berhasil") {
                  bloc.add(GetAddressEvent());
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: FlutterFlowTheme.primaryColor,
                    size: 20,
                  ),
                  Text(
                    "Alamat",
                    style: TextStyle(color: FlutterFlowTheme.primaryColor),
                  )
                ],
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: blocListener(blocBuilder()),
    );
  }

  Widget _buildItemAddress(AddressPickup address, int index) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 2),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
                color: _isAddressDefault(address, index)
                    ? Colors.red
                    : Colors.white,
                width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    address.name ?? "",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Visibility(
                      child: _defaultMarkerAddress(),
                      visible: _isAddressDefault(address, index)),
                  Spacer(),
                  _addressPickupActionMenu(index, address)
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Text(address.address ?? "")
            ],
          ),
        ),
      ),
    );
  }

  Widget _defaultMarkerAddress() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Text(
        "default",
        style: TextStyle(
            color: FlutterFlowTheme.primaryColor, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _addressPickupActionMenu(int index, AddressPickup addressPickup) {
    return PopupMenuButton<int>(
      child: FaIcon(
        FontAwesomeIcons.ellipsisV,
        color: Colors.black,
        size: 16,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("Jadikan Alamat Default"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Edit Alamat"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("Hapus Alamat"),
        ),
      ],
      onSelected: (value) => selectedMenuItem(
          value, index, addressPickup.uuid ?? "", addressPickup),
    );
  }

  void selectedMenuItem(
      int value, int index, String uuid, AddressPickup addressPickup) async {
    switch (value) {
      case 1:
        bloc.add(UpdateDefaultAddressEvent(uuid));
        break;
      case 2:
        var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddressScreenEdit(addressPickup),
            ));
        print('nn $result');
        if (result == "Berhasil") {
          bloc.add(GetAddressEvent());
        }
        break;
      case 3:
        bloc.add(DeletePickupAddressEvent(uuid));
        listAddress.removeAt(index);
        setState(() {});
        print("name is haha" + (listAddress.first.name ?? "null"));
        break;
    }
  }

  bool _isAddressDefault(AddressPickup data, int index) {
    return data.isDefault;
  }
}
