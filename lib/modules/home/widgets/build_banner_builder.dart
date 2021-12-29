import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mogawe/core/data/response/home/ads_model.dart';
import 'package:mogawe/modules/home/bloc/home_bloc.dart';
import 'package:mogawe/modules/home/bloc/home_event.dart';
import 'package:mogawe/modules/home/bloc/home_state.dart';
import 'package:mogawe/modules/pesona/pesona_page.dart';

class BuildBannerBuilder extends StatefulWidget {
  const BuildBannerBuilder({Key? key}) : super(key: key);

  @override
  State<BuildBannerBuilder> createState() => _BuildBannerBuilderState();
}

class _BuildBannerBuilderState extends State<BuildBannerBuilder> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc();
    bloc.add(GetAdsBanner());
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

  Widget blockBuilder() {
    return BlocBuilder(
      bloc: bloc,
      builder: (ctx, state) {
        if (state is ShowLoadingAds) {
          print("State : $state");
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShowHomeAds) {
          print("ads size is ${state.list.length}");
          return _buildAdsBanner(state.list);
        }
        if (state is ShowErrorHomeState) {
          print("error ads" + state.message);
          return Container();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(blockBuilder());
  }

  Widget _buildAdsBanner(List<Ads> ads) {
    return SizedBox(
      height: 140,
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PesonaPage(),
            ),
          );
        },
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String placeHolder = "https://sbu.co.id/info/wp-content/themes/easymag/images/no-image.png";
            String image = ads[index].pictureUrl == "" ? placeHolder : ads[index].pictureUrl;
            return Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(image, fit: BoxFit.fill)));
          },
        ),
      ),
    );
  }
}
