import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mogawe/modules/form/bloc/form_bloc.dart';

class BuildLoadingSubmitForm extends StatefulWidget {
  const BuildLoadingSubmitForm({Key? key}) : super(key: key);

  @override
  _BuildLoadingSubmitFormState createState() => _BuildLoadingSubmitFormState();
}

class _BuildLoadingSubmitFormState extends State<BuildLoadingSubmitForm>
    with TickerProviderStateMixin {
  String loadingSubmitAssetPath =
      'assets/lottie_animations/lottie_finish_form_loading_animation.json';
  String doneSubmitAssetPath =
      'assets/lottie_animations/lottie_done_form_loading_animation.json';
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    FormBloc bloc = context.read<FormBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          stream: bloc.currentSubmitText,
          initialData: "Mengirim form kamu...",
          builder: (context, AsyncSnapshot<String> snapshot) {
            print("snapshot loading submit is ${snapshot.data}");
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 280,
                        child: snapshot.data == "done!"
                            ? Lottie.asset(doneSubmitAssetPath,
                                controller: _controller,
                                animate: snapshot.data == "done!",
                                repeat: false, onLoaded: (composition) {
                                if (snapshot.data == "done!") {
                                  _controller
                                    ..duration = composition.duration
                                    ..forward();
                                }
                              })
                            : Lottie.asset(loadingSubmitAssetPath),
                      ),

                      Text(
                        snapshot.data ?? "",
                        style:
                            TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAnimations(String status) {
    if (status == "done") {
      setState(() {});
      return Lottie.asset(
        doneSubmitAssetPath,
        repeat: false,
      );
    } else {
      setState(() {});
      return Lottie.asset(loadingSubmitAssetPath);
    }
  }
}
