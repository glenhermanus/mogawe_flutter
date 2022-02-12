class FactInput {
  int idResult;
  String uuid;
  String? uuidQuestionnaire;
  String? idFactDisplay;
  String? idSectionDisplay;
  dynamic idFactRef;
  String? uuidSection;
  String uuidFactType;
  dynamic idDisplay;
  String factName;
  dynamic reference;
  String? hintName;
  String? actionRules;
  dynamic allowNoResponse;
  String? label;
  String value;
  String? finalScore;
  dynamic valueScore;
  dynamic input;

  FactInput({
    required this.idResult,
    required this.uuid,
    required this.uuidQuestionnaire,
    required this.idFactDisplay,
    required this.idSectionDisplay,
    this.idFactRef,
    required this.uuidSection,
    required this.uuidFactType,
    this.idDisplay,
    required this.factName,
    this.reference,
    this.hintName,
    this.actionRules,
    this.allowNoResponse,
    this.label,
    required this.value,
    this.finalScore,
    this.valueScore,
    required this.input});
}
