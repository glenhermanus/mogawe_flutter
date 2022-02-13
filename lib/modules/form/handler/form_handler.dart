import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/modules/form/tracker/model/activity_tracker.dart';

typedef void NotifyDecrementCounterHandler();
typedef void NotifyIncrementCounterHandler();
typedef void SendChangedFact(Fact fact);

typedef void NextFormSection(int index);

typedef void ChangeTrackerStatus(ActivityTracker tracker);



