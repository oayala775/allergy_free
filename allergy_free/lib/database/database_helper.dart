import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print("Iniciando base de datos");
    String path = join(await getDatabasesPath(), 'database.db');
    print("path: $path");
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    print("Creando tablas");
    await db.execute('''
      CREATE TABLE avatars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        avatar_name TEXT NOT NULL UNIQUE,
        avatar_path TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        age INTEGER NOT NULL,
        avatar_id INTEGER,
        FOREIGN KEY (avatar_id) REFERENCES avatars(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE allergies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        allergy_name TEXT NOT NULL UNIQUE,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ingredients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE user_allergies (
        user_id INTEGER NOT NULL,
        allergy_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (allergy_id) REFERENCES allergies(id) ON DELETE CASCADE,
        UNIQUE(user_id, allergy_id),
        PRIMARY KEY (user_id, allergy_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE allergy_ingredients (
        allergy_id INTEGER NOT NULL,
        ingredient_id INTEGER NOT NULL,
        FOREIGN KEY (allergy_id) REFERENCES allergies(id) ON DELETE CASCADE,
        FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
        PRIMARY KEY(allergy_id, ingredient_id)
      )
    ''');

    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    await db.rawInsert('''
      INSERT INTO avatars (avatar_name, avatar_path) VALUES 
      ('Default', 'assets/images/avatar/0_Default.png'),
      ('Mostaza', 'assets/images/avatar/1_Mustard.png'),
      ('Nueces', 'assets/images/avatar/2_Walnut.png'),
      ('Chocolate', 'assets/images/avatar/3_Chocolate.png'),
      ('Tomate', 'assets/images/avatar/4_Tomato.png'),
      ('Manzana', 'assets/images/avatar/5_Apple.png'),
      ('Canela', 'assets/images/avatar/6_Cinnamon.png'),
      ('Huevo', 'assets/images/avatar/7_Egg.png'),
      ('Trigo', 'assets/images/avatar/8_Wheat.png'),
      ('Leche', 'assets/images/avatar/9_Milk.png'),
      ('Cacahuate', 'assets/images/avatar/10_Peanut.png'),
      ('Aguacate', 'assets/images/avatar/11_Avocado.png'),
      ('Camarón', 'assets/images/avatar/12_Shrimp.png'),
      ('Almendra', 'assets/images/avatar/13_Almond.png'),
      ('Pescado', 'assets/images/avatar/14_Fish.png'),
      ('Fresa', 'assets/images/avatar/15_Strawberry.png'),
      ('Naranja', 'assets/images/avatar/16_Orange.png'),
      ('Langosta', 'assets/images/avatar/17_Lobster.png'),
      ('Pan', 'assets/images/avatar/18_Bread.png'),
      ('Apio', 'assets/images/avatar/19_Celery.png'),
      ('Soja', 'assets/images/avatar/20_Soy.png'),
      ('Pistache', 'assets/images/avatar/21_Pistachio.png')
    ''');

    await db.rawInsert('''
      INSERT INTO allergies (allergy_name, description) VALUES 
      ('Mostaza', 'Alergia a la mostaza y semillas de mostaza'),
      ('Nueces', 'Alergia a nueces y frutos secos'),
      ('Chocolate', 'Alergia al cacao o chocolate'),
      ('Tomate', 'Alergia a tomates y solanáceas'),
      ('Manzana', 'Alergia a manzanas y frutas rosáceas'),
      ('Canela', 'Alergia a la canela'),
      ('Huevo', 'Alergia a proteínas del huevo'),
      ('Gluten', 'Intolerancia al gluten y trigo'),
      ('Lactosa', 'Intolerancia a la lactosa de la leche'),
      ('Cacahuate', 'Alergia al cacahuate o maní'),
      ('Aguacate', 'Alergia al aguacate'),
      ('Mariscos', 'Alergia a camarones y crustáceos'),
      ('Almendras', 'Alergia a almendras y frutos secos'),
      ('Pescado', 'Alergia a pescados'),
      ('Fresa', 'Alergia a fresas y frutos rojos'),
      ('Cítricos', 'Alergia a naranjas y cítricos'),
      ('Langosta', 'Alergia a langostas y mariscos'),
      ('Pan', 'Alergia a componentes del pan'),
      ('Apio', 'Alergia al apio'),
      ('Soja', 'Alergia a la soja y derivados'),
      ('Pistache', 'Alergia a pistaches y frutos secos')
    ''');

    await db.rawInsert('''
      INSERT INTO ingredients (name) VALUES 
      ('Harina de trigo'),
      ('Leche entera'),
      ('Huevo fresco'),
      ('Mantequilla de cacahuate'),
      ('Aceite de soja'),
      ('Salsa de tomate'),
      ('Queso cheddar'),
      ('Pan integral'),
      ('Atún enlatado'),
      ('Camarones congelados'),
      ('Almendras fileteadas'),
      ('Fresas congeladas'),
      ('Jugo de naranja'),
      ('Mostaza dijon'),
      ('Chocolate amargo')
    ''');

    // await db.rawInsert('''
    //   INSERT INTO users (username, password, age, avatar_id) VALUES 
    //   ('jcest28', '1234', 23, 1)
    // ''');
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}
