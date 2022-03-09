import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/request/gawean/update_gawean_sequence.dart';
import 'package:mogawe/core/data/response/home_content/gawean_model.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/repositories/auth_repository.dart';
import 'package:mogawe/modules/home/gawean/bloc/gawean_bloc.dart';
import 'package:mogawe/modules/home/gawean/bloc/gawean_event.dart';
import 'package:mogawe/modules/home/gawean/bloc/gawean_state.dart';
import 'package:mogawe/modules/home/widgets/build_gawean_item.dart';
import 'package:mogawe/modules/home/widgets/loading/build_gawean_see_all_loading.dart';

class AllGaweanScreen extends StatefulWidget {
  const AllGaweanScreen({Key? key}) : super(key: key);

  @override
  _AllGaweanScreenState createState() => _AllGaweanScreenState();
}

class _AllGaweanScreenState extends State<AllGaweanScreen> {
  late GaweanBloc _bloc;
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
    _bloc = GaweanBloc();
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
        if (state is ShowLoadingListGaweanState) {
          print("State : $state");
          return buildGaweanSeeAllLoading();
        }
        if (state is ShowListTaskState) {
          return _buildGaweanList(state.list);
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
    return ReorderableListView.builder(
      itemCount: jobs.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        var gawean = jobs[index];
        return Container(
          key: ValueKey(jobs[index].uuid),
          child: BuildGaweanItem(
            gaweanModel: gawean,
          ),
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        try {
          // dragging from top to bottom
          if (oldIndex < newIndex) {
            int end = newIndex - 1;
            Gawean oldIndexItem = jobs[oldIndex];
            int i = 0;
            int local = oldIndex;
            do {
              jobs[local] = jobs[++local];
              i++;
            } while (i < end - oldIndex);
            jobs[end] = oldIndexItem;
          }

          // dragging from bottom to top
          else if (oldIndex > newIndex) {
            Gawean oldIndexItem = jobs[oldIndex];
            for (int i = oldIndex; i > newIndex; i--) {
              jobs[i] = jobs[i - 1];
            }
            jobs[newIndex] = oldIndexItem;
          }
          setState(() {});
        } finally {
          List<UpdateGaweanSequenceRequestItem> listUuidsGawean = [];
          jobs.forEach((element) {
            listUuidsGawean
                .add(UpdateGaweanSequenceRequestItem(uuid: element.uuid ?? ""));
          });

          UpdateGaweanSequenceRequest request =
              UpdateGaweanSequenceRequest(fieldTasks: listUuidsGawean);
          _bloc.add(UpdateGaweanSequence(request));
        }
      },
    );
  }
}
