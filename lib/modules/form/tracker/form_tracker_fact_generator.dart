import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/form/bloc/form_bloc.dart';
import 'package:mogawe/modules/form/bloc/form_event.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';
import 'package:mogawe/modules/form/standart/fact/fact_audio_recorder.dart';
import 'package:mogawe/modules/form/standart/fact/fact_boolean.dart';
import 'package:mogawe/modules/form/standart/fact/fact_checkin.dart';
import 'package:mogawe/modules/form/standart/fact/fact_date.dart';
import 'package:mogawe/modules/form/standart/fact/fact_geolocation.dart';
import 'package:mogawe/modules/form/standart/fact/fact_multiple_selection.dart';
import 'package:mogawe/modules/form/standart/fact/fact_open_url.dart';
import 'package:mogawe/modules/form/standart/fact/fact_phone_number.dart';
import 'package:mogawe/modules/form/standart/fact/fact_rating.dart';
import 'package:mogawe/modules/form/standart/fact/fact_screen_recorder.dart';
import 'package:mogawe/modules/form/standart/fact/fact_single_selection.dart';
import 'package:mogawe/modules/form/standart/fact/fact_slider.dart';
import 'package:mogawe/modules/form/standart/fact/fact_take_pic_camera.dart';
import 'package:mogawe/modules/form/standart/fact/fact_take_pic_gallery.dart';
import 'package:mogawe/modules/form/standart/fact/fact_text_box.dart';
import 'package:mogawe/modules/form/standart/fact/fact_time.dart';
import 'package:mogawe/modules/form/utils/fact_type.dart';
import 'package:provider/src/provider.dart';


class FormActivityTrackerFactGenerator extends StatefulWidget {
  const FormActivityTrackerFactGenerator(
      {required this.facts});

  final List<Fact> facts;

  @override
  _FormActivityTrackerFactGeneratorState createState() => _FormActivityTrackerFactGeneratorState();
}

class _FormActivityTrackerFactGeneratorState extends State<FormActivityTrackerFactGenerator> {
  var logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    FormBloc bloc = context.read<FormBloc>();

    return SingleChildScrollView(
      child: Column(
        children: _buildFactList(widget.facts, bloc),
      ),
    );
  }

  List<Widget> _buildFactList(List<Fact> facts, FormBloc bloc) {
    List<Widget> result = [];
    for (int i = 0; i < facts.length; i++) {
      result.add(
        Container(
          decoration: BoxDecoration(
            color: i.isEven ? Colors.white : Colors.grey[50],
          ),
          child: _factGenerator(facts[i], bloc),
        ),
      );
    }

    Widget button = Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 28.0, left: 18.0, right: 18.0),
      child: FFButtonWidget(
        text: "Kirim",
        onPressed: () {

        },
        options: FFButtonOptions(
          height: 60,
          width: double.infinity,
          color: FlutterFlowTheme.primaryColor,
          textStyle: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.secondaryColor,
            fontSize: 14,
          ),
          elevation: 0,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 12,
        ),
      ),
    );
    result.add(button);

    return result;
  }

  Widget _factGenerator(Fact fact, FormBloc bloc) {
    switch (fact.uuidFactType) {
      case TEXT_BOX:
        return FactTextField(
          incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
          decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
          sendChangedFact: (changedFact) =>
              bloc.add(SaveChangedFacts(changedFact)),
          textInputType: TextInputType.text,
          fact: fact,
        );
      case NUMERIC_BOX:
        return FactTextField(
          incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
          decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
          sendChangedFact: (changedFact) =>
              bloc.add(SaveChangedFacts(changedFact)),
          textInputType: TextInputType.number,
          fact: fact,
        );
      case SINGLE_SELECTION:
        return FactSingleSelection(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case MULTIPLE_SELECTION:
        return FactMultipleSelection(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case TIME:
        return FactTime(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case DATE:
        return FactDate(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case PHONE_NUMBER:
        return FactPhoneNumber(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            textInputType: TextInputType.phone,
            fact: fact);
      case EMAIL:
        return FactTextField(
          incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
          decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
          sendChangedFact: (changedFact) =>
              bloc.add(SaveChangedFacts(changedFact)),
          textInputType: TextInputType.emailAddress,
          fact: fact,
        );
      case GEO_LOCATION:
        return FactGeoLocation(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case CHECK_IN:
        return FactCheckIn(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case TAKE_PIC_FROM_GALLERY:
        return FactTakeGalleryPic(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case PICTURE:
        return FactTakeCameraPic(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case AUDIO_RECORDER:
        return FactAudioRecorder(fact: fact);
      case SCREEN_RECORDER:
        return FactScreenRecorder(fact: fact);
      case RATING:
        return FactRating(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact);
      case SLIDER:
        return FactSlider(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            fact: fact);
      case BOOLEAN:
        return FactBoolean(fact: fact);
      case OPEN_URL:
        return FactOpenUrl(fact: fact);
      default:
        return FactTextField(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFact) =>
                bloc.add(SaveChangedFacts(changedFact)),
            fact: fact,
            textInputType: TextInputType.text);
    }
  }
}
