import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/response/home/ads_model.dart';
import 'package:mogawe/modules/hire_me/hire_me_page.dart';
import 'package:mogawe/modules/home/bloc/home_bloc.dart';
import 'package:mogawe/modules/home/bloc/home_event.dart';
import 'package:mogawe/modules/home/bloc/home_state.dart';
import 'package:mogawe/modules/pesona/pesona_page.dart';
import 'package:mogawe/utils/global/webview.dart';
import 'package:mogawe/utils/ui/animation/bounce_tap.dart';
import 'package:mogawe/utils/ui/widgets/MogaweImageHandler.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildBannerBuilder extends StatefulWidget {
  const BuildBannerBuilder({Key? key}) : super(key: key);

  @override
  State<BuildBannerBuilder> createState() => _BuildBannerBuilderState();
}

class _BuildBannerBuilderState extends State<BuildBannerBuilder> {
  late HomeBloc bloc;
  var logger = Logger(printer: PrettyPrinter());

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
      height: 175,
      child: ListView.builder(
        itemCount: ads.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String image = ads[index].pictureUrl;
          return BounceTap(
            onTap: () => _handleBannerClick(ads[index]),
            child: Container(
              width: 330,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: mogaweImageHandler(url: image, fit: BoxFit.fill),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleBannerClick(Ads ad) {
    switch (ad.actionType) {
      case "open_webview":
        logger.d("clicked Open Web");
        _handleOpenWebview(ad.actionValue);
        break;
      case "open_apps":
        _handleOpenApp(ad.actionValue);
        break;
      case "open_activity":
        logger.d("clicked Open Activity");
        _handleOpenActivity(ad.actionValue, ad.actionParam);
        break;
    }
  }

  void _handleOpenWebview(String url){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebviewMogawe(url: url),
      ),);
  }

  void _handleOpenApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleOpenActivity(String value, String param){
    List<String> splitValue = value.split(".");
    String activityName = splitValue.last;

    switch (activityName){
      case "HireMeActivity":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HireMePage(),
          ),
        );
        break;
      case "AccreditationListActivity":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PesonaPage(),
          ),
        );
        break;
      case "CertificateInfoActivity":

        break;
    }
  }


}
