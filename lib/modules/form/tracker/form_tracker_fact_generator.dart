import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/form/bloc/form_bloc.dart';
import 'package:mogawe/modules/form/bloc/form_event.dart';
import 'package:mogawe/modules/form/handler/form_handler.dart';
import 'package:mogawe/modules/form/utils/fact_type.dart';
import 'package:provider/src/provider.dart';

import 'fact/fact_tracker_audio_recorder.dart';
import 'fact/fact_tracker_boolean.dart';
import 'fact/fact_tracker_checkin.dart';
import 'fact/fact_tracker_date.dart';
import 'fact/fact_tracker_geolocation.dart';
import 'fact/fact_tracker_multiple_selection.dart';
import 'fact/fact_tracker_open_url.dart';
import 'fact/fact_tracker_phone_number.dart';
import 'fact/fact_tracker_rating.dart';
import 'fact/fact_tracker_screen_recorder.dart';
import 'fact/fact_tracker_single_selection.dart';
import 'fact/fact_tracker_slider.dart';
import 'fact/fact_tracker_take_pic_camera.dart';
import 'fact/fact_tracker_take_pic_gallery.dart';
import 'fact/fact_tracker_text_box.dart';
import 'fact/fact_tracker_time.dart';


class FormActivityTrackerFactGenerator extends StatefulWidget {
  const FormActivityTrackerFactGenerator(
      {required this.facts, required this.finishTrackerSection});

  final List<Fact> facts;
  final FinishTrackerSection finishTrackerSection;

  @override
  _FormActivityTrackerFactGeneratorState createState() =>
      _FormActivityTrackerFactGeneratorState();
}

class _FormActivityTrackerFactGeneratorState extends State<FormActivityTrackerFactGenerator> {
  var logger = Logger(printer: PrettyPrinter());
  final _pageController = PageController(keepPage: false);
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
        _buildFactTrackerNavigationFooter(),
      ],
    );
  }

  Widget _buildFactTrackerNavigationFooter() {
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
        onPressed: () {
          if (_hasReachedEnd) {
            widget.finishTrackerSection();
          } else {
            _pageController.nextPage(duration: _kDuration, curve: _kCurve);
          }
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
        return FactTrackerTextField(
          incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
          decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
          sendChangedFact: (changedFactTracker) =>
              bloc.add(SaveChangedFacts(changedFactTracker)),
          textInputType: TextInputType.text,
          fact: fact,
        );
      case NUMERIC_BOX:
        return FactTrackerTextField(
          incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
          decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
          sendChangedFact: (changedFactTracker) =>
              bloc.add(SaveChangedFacts(changedFactTracker)),
          textInputType: TextInputType.number,
          fact: fact,
        );
      case SINGLE_SELECTION:
        return FactTrackerSingleSelection(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case MULTIPLE_SELECTION:
        return FactTrackerMultipleSelection(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case TIME:
        return FactTrackerTime(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case DATE:
        return FactTrackerDate(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case PHONE_NUMBER:
        return FactTrackerPhoneNumber(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            textInputType: TextInputType.phone,
            fact: fact);
      case EMAIL:
        return FactTrackerTextField(
          incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
          decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
          sendChangedFact: (changedFactTracker) =>
              bloc.add(SaveChangedFacts(changedFactTracker)),
          textInputType: TextInputType.emailAddress,
          fact: fact,
        );
      case GEO_LOCATION:
        return FactTrackerGeoLocation(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case CHECK_IN:
        return FactTrackerCheckIn(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case TAKE_PIC_FROM_GALLERY:
        return FactTrackerTakeGalleryPic(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case PICTURE:
        return FactTrackerTakeCameraPic(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case AUDIO_RECORDER:
        return FactTrackerAudioRecorder(fact: fact);
      case SCREEN_RECORDER:
        return FactTrackerScreenRecorder(fact: fact);
      case RATING:
        return FactTrackerRating(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact);
      case SLIDER:
        return FactTrackerSlider(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            fact: fact);
      case BOOLEAN:
        return FactTrackerBoolean(fact: fact);
      case OPEN_URL:
        return FactTrackerOpenUrl(fact: fact);
      default:
        return FactTrackerTextField(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFactTracker) =>
                bloc.add(SaveChangedFacts(changedFactTracker)),
            fact: fact,
            textInputType: TextInputType.text);
    }
  }
}
