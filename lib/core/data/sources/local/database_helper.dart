import 'package:mogawe/core/data/response/form/fact.dart';
import 'package:mogawe/core/data/response/form/form_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFact = 'fact';
  static const String _tblSection = 'section';
  static const String _tblForm = 'form';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/mogaweapp.db',
      onCreate: (db, version) async {
        // await db.execute('''CREATE TABLE $_tblForm(
        //   id integer primary key autoincrement,
        //   returnValue TEXT,
        //   message TEXT,
        //   uuid TEXT,
        //   object TEXT,
        //   object2 TEXT
        // )
        // ''');
        await db.execute('''CREATE TABLE $_tblSection (
          sectionId integer primary key autoincrement,
          id integer,
          uuid TEXT,
          uuidQuestionnaire TEXT,
          uuidQuestionnaireTemplate TEXT,
          questionnaireTemplateName TEXT,
          idDisplay TEXT,
          idSectionDisplay TEXT,
          name TEXT,
          actionRules TEXT,
          sort TEXT,
          hintName TEXT,
          versionNumber integer,
          isActive BOOLEAN,
          facts TEXT,
          idOldQuestionnaire TEXT,
          idItemDisplay TEXT,
          uuidItem TEXT,
          itemName TEXT,
          idMetaDisplay TEXT,
          uuidMeta TEXT,
          metaName TEXT
        )
        ''');
        await db.execute('''CREATE TABLE $_tblFact (
            uuid TEXT PRIMARY KEY,
            uuidQuestionnaire TEXT,
            questionnaireName TEXT,
            idFactDisplay TEXT,
            idSectionDisplay TEXT,
            idFactRef TEXT,
            uuidSection TEXT,
            uuidFactType TEXT,
            factTypeDescription TEXT,
            idDisplay TEXT,
            factName TEXT,
            reference TEXT,
            hintName TEXT,
            actionRules TEXT,
            allowNoResponse TEXT,
            label TEXT,
            value TEXT,
            valueScore TEXT,
            itemValue TEXT,
            minValue INTEGER,
            maxValue INTEGER,
            selectionValidate TEXT,
            stepValue TEXT,
            sequence INTEGER,
            videoUrl TEXT,
            pictureUrl TEXT,
            stampPhoto TEXT,
            minDate TEXT,
            maxDate TEXT,
            idFact TEXT,
            pollings TEXT,
            isActive BOOLEAN,
            sectionName TEXT,
            actionRuleSection TEXT,
            sort INTEGER,
            idItemDisplay INTEGER,
            uuidItem TEXT,
            itemName TEXT,
            factType TEXT,
            isVisible BOOLEAN,
            isMandatory BOOLEAN,
            isCommaAllowed BOOLEAN,
            hintNameItem TEXT,
            itemPlanograms TEXT,
            idQuestionnaire INTEGER,
            oldIdQuestionnaire INTEGER,
            factPlanos TEXT,
            batchMetas TEXT,
            factPlanoCount TEXT,
            defaultValue TEXT,
            input TEXT
          )
          ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertSectionToDatabase(FormModel form) async {
    final db = await database;
    await db!.insert(_tblSection, form.toJson());
  }

  Future<void> insertFactToDatabase(Fact fact) async {
    final db = await database;
    await db!.insert(_tblFact, fact.toJson());
  }

  Future<void> removeFactsFromDatabase(String uuidSection) async {
    final db = await database;
    await db!.delete(
      _tblFact,
      where: 'uuidSection = ?',
      whereArgs: [uuidSection],
    );
  }

  Future<void> removeFactFromDatabaseByUuid(String uuid) async {
    final db = await database;
    await db!.delete(
      _tblFact,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }

  Future<void> removeData() async {
    final db = await database;
    await db!.delete(_tblFact);
  }

  Future<FormModel> getSectionFromDatabase(String uuidSection) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tblSection,
      where: 'uuid = ?',
      whereArgs: [uuidSection],
    );
    return results.map((result) => FormModel.fromJson(result)).toList().first;
  }

  Future<bool> isSectionExistInDatabase(String uuidSection) async {
    final db = await database;
    bool isExist = true;
    try{
      List<Map<String, dynamic>> results = await db!.query(
        _tblSection,
        where: 'uuidSection = ?',
        whereArgs: [uuidSection],
      );
      List<FormModel> listSection =
      results.map((result) => FormModel.fromJson(result)).toList();
    } catch (e) {
      isExist = false;
    }
    return isExist;
  }

  Future<List<Fact>> getFactsFromDatabase(String uuidSection) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tblFact,
      where: 'uuidSection = ?',
      whereArgs: [uuidSection],
    );
    return results.map((result) => Fact.fromJson(result)).toList();
  }
}
