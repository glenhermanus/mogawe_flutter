import 'package:flutter/material.dart';
import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/modules/form/continous/bloc/continous_form_bloc.dart';
import 'package:mogawe/modules/form/continous/bloc/continous_form_event.dart';
import 'package:mogawe/modules/form/utils/fact_type.dart';
import 'package:mogawe/modules/form/widget/fact/fact_text_box.dart';
import 'package:provider/src/provider.dart';

class BuildContinuousFactListBuilder extends StatefulWidget {
  final List<Fact> facts;
  const BuildContinuousFactListBuilder({Key? key, required this.facts}) : super(key: key);

  @override
  _BuildContinuousFactListBuilderState createState() => _BuildContinuousFactListBuilderState();
}

class _BuildContinuousFactListBuilderState extends State<BuildContinuousFactListBuilder> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _buildFactList(widget.facts, context),
      ),
    );
  }

  List<Widget> _buildFactList(List<Fact> facts, BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < facts.length; i++) {
      result.add(
        Container(
          decoration: BoxDecoration(
            color: i.isEven ? Colors.white : Colors.grey[100],
          ),
          child: _factGenerator(facts[i], context),
        ),
      );
    }
    return result;
  }


  //Fact filter goes here!
  Widget _factGenerator(Fact fact, BuildContext context) {
    ContinuousFormBloc bloc = context.read<ContinuousFormBloc>();
    Widget filteredWidgetFact = SizedBox();

    switch (fact.uuid) {
      case TEXT_BOX:
        filteredWidgetFact = FactTextField(
          incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
          decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
          sendChangedFact: (changedFact) {},
          textInputType: TextInputType.text,
          fact: fact,
        );
        break;
      case NUMERIC_BOX:
        filteredWidgetFact = FactTextField(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFact) {},
            textInputType: TextInputType.number,
            fact: fact);
        break;
      default:
        filteredWidgetFact = FactTextField(
            incrementCounterCallback: () => bloc.add(NotifyIncrementCounter()),
            decrementCounterCallback: () => bloc.add(NotifyDecrementCounter()),
            sendChangedFact: (changedFact) {},
            textInputType: TextInputType.text,
            fact: fact);
        break;
    }
    return filteredWidgetFact;
  }

}
