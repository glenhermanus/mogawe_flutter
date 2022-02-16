import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/form/bloc/form_bloc.dart';
import 'package:mogawe/modules/form/bloc/form_event.dart';
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
  const FormActivityTrackerFactGenerator({required this.facts});

  final List<Fact> facts;

  @override
  _FormActivityTrackerFactGeneratorState createState() => _FormActivityTrackerFactGeneratorState();
}

class _FormActivityTrackerFactGeneratorState extends State<FormActivityTrackerFactGenerator> {
  var logger = Logger(printer: PrettyPrinter());
  final _pageController = PageController(keepPage: true);
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  bool _hasReachedEnd = false;
  bool _hasReachedStart = true;

  @override
  Widget build(BuildContext context) {
    FormBloc bloc = context.read<FormBloc>();
    return Column(
      children: [
        Flexible(
          child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                if (index + 1 == widget.facts.length) {
                  setState(() {
                    _hasReachedEnd = true;
                  });
                } else if (index == 0){
                  setState(() {
                    _hasReachedStart = true;
                  });
                }
                else {
                  setState(() {
                    _hasReachedStart = false;
                    _hasReachedEnd = false;
                  });
                }
              },
              itemCount: widget.facts.length,
              itemBuilder: (context, index) {
                return _factGenerator(widget.facts[index], bloc);
              }),
        ),
        _buildFactNavigationFooter(),
      ],
    );
  }

  Widget _buildFactNavigationFooter() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
            visible: !_hasReachedStart,
              child: _buildPreviousButton()),
          _buildNextButton()
        ],
      ),
    );
  }

  Widget _buildPreviousButton(){
    return FFButtonWidget(
      text: 'Prev',
      icon: Icon(Icons.arrow_back_ios, size: 18),
      onPressed: ()  {
        _pageController.previousPage(duration: _kDuration, curve: _kCurve);
      },
      options: FFButtonOptions(
        height: 40,
        color: Colors.transparent,
        textStyle: FlutterFlowTheme.subtitle2.override(
          fontFamily: 'Poppins',
          color: FlutterFlowTheme.blackColor,
          fontSize: 14,
        ),
        elevation: 0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: 12,
      ),
    );
  }


  Widget _buildNextButton(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FFButtonWidget(
        icon: _hasReachedEnd ? Icon(Icons.save) : Icon(Icons.arrow_back_ios, size: 18),
        text: _hasReachedEnd ? 'Send' : 'Next',
        onPressed: ()  {
          _pageController.nextPage(duration: _kDuration, curve: _kCurve);
        },
        options: FFButtonOptions(
          height: 40,
          color: _hasReachedEnd ? FlutterFlowTheme.primaryColor : Colors.transparent,
          textStyle: FlutterFlowTheme.subtitle2.override(
            fontFamily: 'Poppins',
            color: _hasReachedEnd ? Colors.white : FlutterFlowTheme.blackColor,
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
