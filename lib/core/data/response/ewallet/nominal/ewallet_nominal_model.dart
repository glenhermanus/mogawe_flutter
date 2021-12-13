class EWalletNominalModel {
    EWalletNominalModel({
        required this.status,
        required this.iconUrl,
        required this.pulsaCode,
        required this.pulsaOp,
        required this.pulsaNominal,
        required this.pulsaDetails,
        required this.pulsaPrice,
        required this.pulsaType,
        required this.masaaktif,
    });

    String status;
    String iconUrl;
    String pulsaCode;
    String pulsaOp;
    String pulsaNominal;
    String pulsaDetails;
    int pulsaPrice;
    String pulsaType;
    String masaaktif;

    factory EWalletNominalModel.fromJson(Map<String, dynamic> json) => EWalletNominalModel(
        status: json["status"],
        iconUrl: json["iconUrl"],
        pulsaCode: json["pulsaCode"],
        pulsaOp: json["pulsaOp"],
        pulsaNominal: json["pulsaNominal"],
        pulsaDetails: json["pulsaDetails"],
        pulsaPrice: json["pulsaPrice"],
        pulsaType: json["pulsaType"],
        masaaktif: json["masaaktif"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "iconUrl": iconUrl,
        "pulsaCode": pulsaCode,
        "pulsaOp": pulsaOp,
        "pulsaNominal": pulsaNominal,
        "pulsaDetails": pulsaDetails,
        "pulsaPrice": pulsaPrice,
        "pulsaType": pulsaType,
        "masaaktif": masaaktif,
    };
}
