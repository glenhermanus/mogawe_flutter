import 'package:mogawe/core/data/response/home_content/Revenue.dart';
import 'package:mogawe/core/data/response/home_content/product_etalasa_model.dart';

import 'Certificate.dart';
import 'gawean_model.dart';

class GaweanRowModel {
    GaweanRowModel({
        required this.uuid,
        required this.name,
        required this.description,
        required this.type,
        required this.action,
        required this.actionValue,
        required this.actionName,
        required this.sequence,
        required this.code,
        required this.tag,
        required this.jobs,
        required this.taskToDos,
        required this.postTimelines,
        required this.jobCategories,
        required this.targetRevenue,
        required this.myCertificates,
        required this.tasks,
        required this.products,
    });

    String uuid;
    String name;
    dynamic description;
    String type;
    String action;
    String actionValue;
    String actionName;
    int sequence;
    String code;
    dynamic tag;
    List<Gawean>? jobs;
    dynamic taskToDos;
    dynamic postTimelines;
    dynamic jobCategories;
    Revenue? targetRevenue;
    List<Certificate> myCertificates;
    dynamic tasks;
    List<ProductModel>? products;

    factory GaweanRowModel.fromJson(Map<String, dynamic> json) => GaweanRowModel(
        uuid: json["uuid"],
        name: json["name"] == null ? "" : json["name"],
        description: json["description"],
        type: json["type"],
        action: json["action"],
        actionValue: json["actionValue"],
        actionName: json["actionName"] == null ? "--" : json["actionName"],
        sequence: json["sequence"],
        code: json["code"],
        tag: json["tag"],
        jobs: json["jobs"] == null ? [] : List<Gawean>.from(json["jobs"].map((x) => Gawean.fromJson(x))),
        taskToDos: json["taskToDos"],
        postTimelines: json["postTimelines"],
        jobCategories: json["jobCategories"],
        targetRevenue: json["targetRevenue"] == null ? null : Revenue.fromJson(json["targetRevenue"]),
        myCertificates: json["myCertificates"] == null ? [] : List<Certificate>.from(json["myCertificates"].map((x) => Certificate.fromJson(x))),
        tasks: json["tasks"],
        products: json["products"] == null ? [] : List<ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name == null ? "" : name,
        "description": description,
        "type": type,
        "action": action,
        "actionValue": actionValue,
        "actionName": actionName == null ? "" : actionName,
        "sequence": sequence,
        "code": code,
        "tag": tag,
        "jobs": jobs == null ? [] : List<Gawean>.from(jobs!.map((x) => x.toJson())),
        "taskToDos": taskToDos,
        "postTimelines": postTimelines,
        "jobCategories": jobCategories,
        "targetRevenue": targetRevenue,
        "myCertificates": myCertificates == null ? [] : List<Certificate>.from(myCertificates.map((x) => x.toJson())),
        "tasks": tasks,
        "products": products == null ? [] : List<ProductModel>.from(products!.map((x) => x.toJson())),
    };
}