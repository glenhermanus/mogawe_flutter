class EWalletModel {
    EWalletModel({
        required this.uuid,
        required this.uuidMogawers,
        required this.accountService,
        required this.accountNo,
        required this.accountOwner,
        required this.accountType,
    });

    String uuid;
    String uuidMogawers;
    String accountService;
    String accountNo;
    String accountOwner;
    String accountType;

    factory EWalletModel.fromJson(Map<String, dynamic> json) => EWalletModel(
        uuid: json["uuid"],
        uuidMogawers: json["uuidMogawers"],
        accountService: json["accountService"],
        accountNo: json["accountNo"],
        accountOwner: json["accountOwner"],
        accountType: json["accountType"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "uuidMogawers": uuidMogawers,
        "accountService": accountService,
        "accountNo": accountNo,
        "accountOwner": accountOwner,
        "accountType": accountType,
    };
}
