import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/home/gawean/all/bloc/task_bloc.dart';
import 'package:mogawe/modules/home/gawean/all/bloc/task_event.dart';
import 'package:mogawe/modules/home/gawean/all/bloc/task_state.dart';
import 'package:mogawe/modules/home/widgets/build_gawean_item.dart';
import 'package:mogawe/modules/home/widgets/loading/build_gawean_see_all_loading.dart';

class AllGaweanScreen extends StatefulWidget {
  const AllGaweanScreen({Key? key}) : super(key: key);

  @override
  _AllGaweanScreenState createState() => _AllGaweanScreenState();
}

class _AllGaweanScreenState extends State<AllGaweanScreen> {
  late TaskBloc _bloc;
  bool loading = false;
  var token;

  void getToken() async {
    setState(() {
      loading = true;
    });
    token = await AuthRepository().readSecureData('token');

    print("OUT >> hey");
    print(token);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = TaskBloc();
    _bloc.add(GetTaskListEvent());
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  Widget blocListener(Widget child) {
    return BlocListener(
      bloc: _bloc,
      listener: (ctx, state) => print("$state"),
      child: child,
    );
  }

  Widget blocBuilder(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (ctx, state) {
        if (state is ShowLoadingListTaskState) {
          print("State : $state");
          return buildGaweanSeeAllLoading();
        }
        if (state is ShowListTaskState) {
          print("State : $state");
          print("State : $state");
          return _buildGaweanList(state.list);
        }
        if (state is ShowErrorState) {
          log(state.message);
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.secondaryColor,
          iconTheme: IconThemeData(color: FlutterFlowTheme.tertiaryColor),
          automaticallyImplyLeading: true,
          title: Text(
            'Gaweanku',
            style: FlutterFlowTheme.subtitle1.override(
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: blocListener(blocBuilder(context)),
      ),
    );
  }



  Widget _buildGaweanList(List<Gawean> jobs) {
    return ListView.builder(
      itemCount: jobs.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        var gawean = jobs[index];
        return BuildGaweanItem(
          gaweanModel: gawean,
        );
      },
    );
  }
}
