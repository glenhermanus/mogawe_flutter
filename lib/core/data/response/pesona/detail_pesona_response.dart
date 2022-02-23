class DetailPesonaResponses{
  String? returnValue, message, uuid, uuidobj, uuidMogawers, uuidQueue, uuidJob, statusTask, howto, statusNotes, groupTask,
      sequence, limit, startDate, receiveDate, expiredDate, reminderDate, assignmentType, jobName, jobDescription, uuiJobtype, uuidLocationType,
      uuidLocation, uuidLocationLevel, uuidProject, projectName, projectDescription, uuidBatch, batchName, latitude, longitude, name,
      locationName, locationAddress, locationLevel, jobTypeName, tutorial, code, desc, brief, type, duration,
      schedule, locationDescription, jobPicture, jobBanner, jobColor, jobTextColor, postMessage, mogawersCode, fullName, email, jobId,
      category, jobActions, endDate, uuidOrder, uuidTaskOrder, uuidTaskOrderJob, idTask;
  List? certificates, jobTimes;
  int? potentialJob, target, minimumLevel, jobLimit, radius, defaultLimit, resultCount;
  bool? isPinned, isStrating, isScreening, isDirect, isPublished, isAutoApproved, isQcNeeded, isHaveArea, isDisplayable, isAssigned;
  double? minimumjob, fee, points;


  DetailPesonaResponses(
      {this.returnValue,
        this.message,
        this.uuid,
        this.uuidobj,
        this.uuidMogawers,
        this.uuidQueue,
        this.uuidJob,
        this.statusTask,
        this.howto,
        this.statusNotes,
        this.groupTask,
        this.sequence,
        this.limit,
        this.startDate,
        this.receiveDate,
        this.expiredDate,
        this.reminderDate,
        this.assignmentType,
        this.jobName,
        this.jobDescription,
        this.uuiJobtype,
        this.uuidLocationType,
        this.uuidLocation,
        this.uuidLocationLevel,
        this.uuidProject,
        this.projectName,
        this.projectDescription,
        this.uuidBatch,
        this.batchName,
        this.latitude,
        this.longitude,
        this.name,
        this.locationName,
        this.locationAddress,
        this.locationLevel,
        this.jobTypeName,
        this.tutorial,
        this.code,
        this.desc,
        this.brief,
        this.type,
        this.duration,
        this.schedule,
        this.locationDescription,
        this.jobPicture,
        this.jobBanner,
        this.jobColor,
        this.jobTextColor,
        this.postMessage,
        this.mogawersCode,
        this.fullName,
        this.email,
        this.jobId,
        this.category,
        this.jobActions,
        this.endDate,
        this.uuidOrder,
        this.uuidTaskOrder,
        this.uuidTaskOrderJob,
        this.idTask,
        this.certificates,
        this.jobTimes,
        this.potentialJob,
        this.target,
        this.minimumLevel,
        this.jobLimit,
        this.radius,
        this.defaultLimit,
        this.resultCount,
        this.isPinned,
        this.isStrating,
        this.isScreening,
        this.isDirect,
        this.isPublished,
        this.isAutoApproved,
        this.isQcNeeded,
        this.isHaveArea,
        this.isDisplayable,
        this.isAssigned,
        this.minimumjob,
        this.fee,
        this.points});

  factory DetailPesonaResponses.fromJson(Map<String, dynamic> json){
    return DetailPesonaResponses(
      returnValue : json['returnValue'],
      message: json['message'],
      uuid : json['uuid'],
      uuidobj : json['object']['uuid'],
      uuidMogawers : json['object']['uuidMogawers'],
      uuidQueue : json['object']['uuidQueue '],
      uuidJob : json['object']['uuidJob'],
      statusTask: json['object']['statusTask'],
      howto: json['object']['howTo'] == null ? '' : json['object']['howTo'],
      statusNotes: json['object']['statusNotes'],
      groupTask: json['object']['groupTask'],
      sequence: json['object']['sequence'],
      limit: json['object']['limit'],
      startDate: json['object']['startDate'],
      receiveDate: json['object']['receiveDate'],
      expiredDate: json['object']['expiredDate'],
      reminderDate: json['object']['reminderDate'],
      assignmentType: json['object']['assignmentType'],
      jobName: json['object']['jobName'],
      jobDescription: json['object']['jobDescription'],
      uuiJobtype: json['object']['uuidJobType'],
      uuidLocationType: json['object']['uuidLocationType'],
      uuidLocation: json['object']['uuidLocation'],
      uuidLocationLevel: json['object']['uuidLocationLevel'],
      uuidProject: json['object']['uuidProject'],
      projectName: json['object']['projectName'],
      projectDescription: json['object']['projectDescription'],
      uuidBatch: json['object']['uuidBatch'],
      batchName: json['object']['batchName'],
      latitude: json['object']['latitude'],
      longitude: json['object']['ulongitude'],
      name: json['object']['name'],
      locationName: json['object']['locationName'],
      locationAddress: json['object']['locationAddress'],
      locationLevel: json['object']['locationLevel'],
      jobTypeName: json['object']['jobTypeName'],
      tutorial: json['object']['tutorial'],
      code: json['object']['code'],
      desc: json['object']['description'],
      brief: json['object']['brief'],
      type: json['object']['type'],
      duration: json['object']['duration'],
      schedule: json['object']['schedule'],
      locationDescription: json['object']['locationDescription'],
      jobPicture: json['object']['jobPicture'],
      jobBanner: json['object']['jobBanner'],
      jobColor: json['object']['jobColor'],
      jobTextColor: json['object']['jobTextColor'],
      postMessage: json['object']['postMessage'],
      mogawersCode: json['object']['mogawersCode'],
      fullName: json['object']['fullName'],
      email: json['object']['email'],
      jobId: json['object']['jobId'],
      category: json['object']['category'],
      jobActions: json['object']['jobActions'],
      endDate: json['object']['endDate'],
      uuidOrder: json['object']['uuidOrder'],
      uuidTaskOrder: json['object']['uuidTaskOrder'],
      uuidTaskOrderJob: json['object']['uuidTaskOrderJob'],
      idTask: json['object']['idTask'],
      certificates: json['object']['certificates'],
      jobTimes: json['object']['jobTimes'],
      potentialJob: json['object']['potentialJob'],
      target: json['object']['target'],
      minimumLevel: json['object']['minimumLevel'],
      jobLimit: json['object']['jobLimit'],
      radius: json['object']['radius'],
      defaultLimit: json['object']['defaultLimit'],
      resultCount: json['object']['resultCount'],
      isPinned: json['object']['isPinned'],
      isStrating: json['object']['isStarting'],
      isScreening: json['object']['isScreening'],
      isDirect: json['object']['isDirect'],
      isPublished: json['object']['isPublished'],
      isAutoApproved: json['object']['isAutoApproved'],
      isQcNeeded: json['object']['isQcNeeded'],
      isHaveArea: json['object']['isHaveArea'],
      isDisplayable: json['object']['isDisplayable'],
      isAssigned: json['object']['isAssigned'],
      minimumjob: json['object']['minimumjob'],
      fee: json['object']['fee'],
      points: json['object']['points'],
    );

  }

}