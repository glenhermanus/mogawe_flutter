class PesonaResponsesObject{
  String? uuidobj, uuidClient, uuidCategory, uuidJob, questName, howto, tutorial, jobpic,
      name, code, category, categroyname, desc, instruction, iconUrl, status, uuidquest;
  int? potentialJob, id;
  double? minimumjob;

  PesonaResponsesObject(
      {
        this.uuidobj,
        this.uuidClient,
        this.uuidCategory,
        this.uuidJob,
        this.questName,
        this.howto,
        this.tutorial,
        this.jobpic,
        this.name,
        this.code,
        this.category,
        this.categroyname,
        this.desc,
        this.instruction,
        this.iconUrl,
        this.status,
        this.uuidquest,
        this.potentialJob,
        this.minimumjob});

  factory PesonaResponsesObject.fromJson(Map<String, dynamic> json){
    return PesonaResponsesObject(
        uuidobj: json['uuid'],
        uuidClient: json['uuidClient'],
        uuidCategory: json['uuidCategory'],
        uuidJob: json['uuidJob'],
        uuidquest: json['uuidQuestionnaire'],
        questName: json['questionnaireName'],
        howto: json['howTo'],
        tutorial:  json['tutorial'],
        jobpic: json['jobPicture'],
        name: json['name'],
        code: json['code'],
        category: json['category'],
        categroyname: json['categoryName'],
        desc: json['description'],
        instruction: json['instruction'],
        iconUrl: json['iconUrl'],
        status: json['status'],
        potentialJob: json['potentialJob'],
        minimumjob: json['minimumJobFee']
    );
  }

}