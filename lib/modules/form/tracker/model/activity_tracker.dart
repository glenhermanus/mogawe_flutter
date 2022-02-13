class ActivityTracker {
  ActivityTracker(
      {required this.uuidSection,
      required this.sectionName,
      required this.status,
      required this.startTime,
      required this.sequence,
      required this.trackerTotal});

  String uuidSection;
  String sectionName;
  String status;
  String startTime;
  int sequence;
  int trackerTotal;
}
