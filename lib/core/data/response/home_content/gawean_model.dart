import 'dart:convert';

Gawean gaweanFromJson(String str) => Gawean.fromJson(json.decode(str));

String? gaweanToJson(Gawean data) => json.encode(data.toJson());

class Gawean {
    Gawean({
        required this.id,
        required this.uuid,
        required this.uuidMogawers,
        required this.idMogawers,
        required this.statusTask,
        required this.statusNotes,
        required this.limit,
        required this.isPinned,
        required this.startDate,
        required this.receivedDate,
        required this.expiredDate,
        required this.createdDate,
        required this.createdBy,
        required this.updatedBy,
        required this.uuidJob,
        required this.jobName,
        required this.jobDescription,
        required this.uuidJobType,
        required this.uuidLocationType,
        required this.uuidLocation,
        required this.uuidLocationLevel,
        required this.uuidProject,
        required this.latitude,
        required this.longitude,
        required this.name,
        required this.locationName,
        required this.locationAddress,
        required this.locationLevel,
        required this.jobTypeName,
        required this.tutorial,
        required this.code,
        required this.description,
        required this.brief,
        required this.howTo,
        required this.minimumLevel,
        required this.jobLimit,
        required this.fee,
        required this.type,
        required this.isScreening,
        required this.isDirect,
        required this.target,
        required this.points,
        required this.duration,
        required this.schedule,
        required this.isPublished,
        required this.isAutoApproved,
        required this.locationDescription,
        required this.isQcNeeded,
        required this.isHaveArea,
        required this.jobPicture,
        required this.jobBanner,
        required this.jobColor,
        required this.jobTextColor,
        required this.radius,
        required this.defaulLimit,
        required this.resultCount,
        required this.mogawersCode,
        required this.fullName,
        required this.email,
        required this.jobId,
        required this.category,
        required this.isDisplayable,
        required this.isAssigned,
        required this.jobActions,
        required this.jobTimes,
        required this.endDate,
        required this.uuidOrder,
        required this.uuidTaskOrder,
        required this.uuidTaskOrderJob,
        required this.idTask,
    });

    int? id;
    String? uuid;
    dynamic uuidMogawers;
    int? idMogawers;
    String? statusTask;
    dynamic statusNotes;
    int? limit;
    bool isPinned;
    int? startDate;
    dynamic receivedDate;
    int? expiredDate;
    int? createdDate;
    dynamic createdBy;
    dynamic updatedBy;
    String? uuidJob;
    String? jobName;
    dynamic jobDescription;
    String? uuidJobType;
    String? uuidLocationType;
    String? uuidLocation;
    String? uuidLocationLevel;
    String? uuidProject;
    String? latitude;
    String? longitude;
    String? name;
    String? locationName;
    String? locationAddress;
    String? locationLevel;
    String? jobTypeName;
    String? tutorial;
    dynamic code;
    String? description;
    dynamic brief;
    dynamic howTo;
    int? minimumLevel;
    dynamic jobLimit;
    double? fee;
    dynamic type;
    dynamic isScreening;
    bool isDirect;
    int? target;
    double? points;
    String? duration;
    dynamic schedule;
    bool isPublished;
    bool isAutoApproved;
    dynamic locationDescription;
    bool isQcNeeded;
    bool isHaveArea;
    dynamic jobPicture;
    dynamic jobBanner;
    dynamic jobColor;
    dynamic jobTextColor;
    int? radius;
    dynamic defaulLimit;
    dynamic resultCount;
    dynamic mogawersCode;
    dynamic fullName;
    dynamic email;
    String? jobId;
    dynamic category;
    bool isDisplayable;
    bool isAssigned;
    dynamic jobActions;
    dynamic jobTimes;
    dynamic endDate;
    dynamic uuidOrder;
    dynamic uuidTaskOrder;
    dynamic uuidTaskOrderJob;
    String? idTask;

    factory Gawean.fromJson(Map<String, dynamic> json) => Gawean(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        uuidMogawers: json["uuidMogawers"],
        idMogawers: json["idMogawers"] == null ? null : json["idMogawers"],
        statusTask: json["statusTask"] == null ? null : json["statusTask"],
        statusNotes: json["statusNotes"],
        limit: json["limit"] == null ? null : json["limit"],
        isPinned: json["isPinned"] == null ? null : json["isPinned"],
        startDate: json["startDate"] == null ? null : json["startDate"],
        receivedDate: json["receivedDate"],
        expiredDate: json["expiredDate"] == null ? null : json["expiredDate"],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        uuidJob: json["uuidJob"] == null ? null : json["uuidJob"],
        jobName: json["jobName"] == null ? null : json["jobName"],
        jobDescription: json["jobDescription"],
        uuidJobType: json["uuidJobType"] == null ? null : json["uuidJobType"],
        uuidLocationType: json["uuidLocationType"] == null ? null : json["uuidLocationType"],
        uuidLocation: json["uuidLocation"] == null ? null : json["uuidLocation"],
        uuidLocationLevel: json["uuidLocationLevel"] == null ? null : json["uuidLocationLevel"],
        uuidProject: json["uuidProject"] == null ? null : json["uuidProject"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        name: json["name"] == null ? null : json["name"],
        locationName: json["locationName"] == null ? null : json["locationName"],
        locationAddress: json["locationAddress"] == null ? null : json["locationAddress"],
        locationLevel: json["locationLevel"] == null ? null : json["locationLevel"],
        jobTypeName: json["jobTypeName"] == null ? null : json["jobTypeName"],
        tutorial: json["tutorial"] == null ? null : json["tutorial"],
        code: json["code"],
        description: json["description"] == null ? null : json["description"],
        brief: json["brief"],
        howTo: json["howTo"],
        minimumLevel: json["minimumLevel"] == null ? null : json["minimumLevel"],
        jobLimit: json["jobLimit"],
        fee: json["fee"] == null ? null : json["fee"],
        type: json["type"],
        isScreening: json["isScreening"],
        isDirect: json["isDirect"] == null ? null : json["isDirect"],
        target: json["target"] == null ? null : json["target"],
        points: json["points"] == null ? null : json["points"],
        duration: json["duration"] == null ? null : json["duration"],
        schedule: json["schedule"],
        isPublished: json["isPublished"] == null ? null : json["isPublished"],
        isAutoApproved: json["isAutoApproved"] == null ? null : json["isAutoApproved"],
        locationDescription: json["locationDescription"],
        isQcNeeded: json["isQcNeeded"] == null ? null : json["isQcNeeded"],
        isHaveArea: json["isHaveArea"] == null ? null : json["isHaveArea"],
        jobPicture: json["jobPicture"],
        jobBanner: json["jobBanner"],
        jobColor: json["jobColor"],
        jobTextColor: json["jobTextColor"],
        radius: json["radius"] == null ? null : json["radius"],
        defaulLimit: json["defaulLimit"],
        resultCount: json["resultCount"],
        mogawersCode: json["mogawersCode"],
        fullName: json["fullName"],
        email: json["email"],
        jobId: json["jobId"] == null ? null : json["jobId"],
        category: json["category"],
        isDisplayable: json["isDisplayable"] == null ? null : json["isDisplayable"],
        isAssigned: json["isAssigned"] == null ? null : json["isAssigned"],
        jobActions: json["jobActions"],
        jobTimes: json["jobTimes"],
        endDate: json["endDate"],
        uuidOrder: json["uuidOrder"],
        uuidTaskOrder: json["uuidTaskOrder"],
        uuidTaskOrderJob: json["uuidTaskOrderJob"],
        idTask: json["idTask"] == null ? null : json["idTask"],
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "uuidMogawers": uuidMogawers,
        "idMogawers": idMogawers == null ? null : idMogawers,
        "statusTask": statusTask == null ? null : statusTask,
        "statusNotes": statusNotes,
        "limit": limit == null ? null : limit,
        "isPinned": isPinned == null ? null : isPinned,
        "startDate": startDate == null ? null : startDate,
        "receivedDate": receivedDate,
        "expiredDate": expiredDate == null ? null : expiredDate,
        "createdDate": createdDate == null ? null : createdDate,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "uuidJob": uuidJob == null ? null : uuidJob,
        "jobName": jobName == null ? null : jobName,
        "jobDescription": jobDescription,
        "uuidJobType": uuidJobType == null ? null : uuidJobType,
        "uuidLocationType": uuidLocationType == null ? null : uuidLocationType,
        "uuidLocation": uuidLocation == null ? null : uuidLocation,
        "uuidLocationLevel": uuidLocationLevel == null ? null : uuidLocationLevel,
        "uuidProject": uuidProject == null ? null : uuidProject,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "name": name == null ? null : name,
        "locationName": locationName == null ? null : locationName,
        "locationAddress": locationAddress == null ? null : locationAddress,
        "locationLevel": locationLevel == null ? null : locationLevel,
        "jobTypeName": jobTypeName == null ? null : jobTypeName,
        "tutorial": tutorial == null ? null : tutorial,
        "code": code,
        "description": description == null ? null : description,
        "brief": brief,
        "howTo": howTo,
        "minimumLevel": minimumLevel == null ? null : minimumLevel,
        "jobLimit": jobLimit,
        "fee": fee == null ? null : fee,
        "type": type,
        "isScreening": isScreening,
        "isDirect": isDirect == null ? null : isDirect,
        "target": target == null ? null : target,
        "points": points == null ? null : points,
        "duration": duration == null ? null : duration,
        "schedule": schedule,
        "isPublished": isPublished == null ? null : isPublished,
        "isAutoApproved": isAutoApproved == null ? null : isAutoApproved,
        "locationDescription": locationDescription,
        "isQcNeeded": isQcNeeded == null ? null : isQcNeeded,
        "isHaveArea": isHaveArea == null ? null : isHaveArea,
        "jobPicture": jobPicture,
        "jobBanner": jobBanner,
        "jobColor": jobColor,
        "jobTextColor": jobTextColor,
        "radius": radius == null ? null : radius,
        "defaulLimit": defaulLimit,
        "resultCount": resultCount,
        "mogawersCode": mogawersCode,
        "fullName": fullName,
        "email": email,
        "jobId": jobId == null ? null : jobId,
        "category": category,
        "isDisplayable": isDisplayable == null ? null : isDisplayable,
        "isAssigned": isAssigned == null ? null : isAssigned,
        "jobActions": jobActions,
        "jobTimes": jobTimes,
        "endDate": endDate,
        "uuidOrder": uuidOrder,
        "uuidTaskOrder": uuidTaskOrder,
        "uuidTaskOrderJob": uuidTaskOrderJob,
        "idTask": idTask == null ? null : idTask,
    };
}
