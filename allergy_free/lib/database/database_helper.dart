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
      ('Nueces', 'Alergia general a frutos de cáscara (árbol)'),
      ('Chocolate', 'Alergia al cacao o componentes del chocolate'),
      ('Tomate', 'Alergia a tomates y solanáceas'),
      ('Manzana', 'Alergia a manzanas y frutas rosáceas'),
      ('Canela', 'Alergia a la canela'),
      ('Huevo', 'Alergia a proteínas del huevo'),
      ('Gluten', 'Intolerancia o alergia al gluten'),
      ('Lactosa', 'Intolerancia a la lactosa'),
      ('Cacahuate', 'Alergia al cacahuate o maní'),
      ('Aguacate', 'Alergia al aguacate'),
      ('Mariscos', 'Alergia a crustáceos (camarones, cangrejos)'),
      ('Almendras', 'Alergia específica a almendras'),
      ('Pescado', 'Alergia a pescados (salmón, atún, etc.)'),
      ('Fresa', 'Alergia a fresas y frutos rojos'),
      ('Cítricos', 'Alergia a naranjas, limones y cítricos'),
      ('Langosta', 'Alergia a langostas y crustáceos'),
      ('Pan', 'Alergia a levaduras o componentes del pan'),
      ('Apio', 'Alergia al apio'),
      ('Soja', 'Alergia a la soja y derivados'),
      ('Pistache', 'Alergia específica a pistaches'),
      ('Sésamo', 'Alergia a semillas de sésamo o ajonjolí'),
      ('Sulfitos', 'Sensibilidad a sulfitos (conservantes)'),
      ('Maíz', 'Alergia al maíz y sus derivados'),
      ('Coco', 'Alergia al coco'),
      ('Kiwi', 'Alergia al kiwi'),
      ('Plátano', 'Alergia al plátano'),
      ('Carne de res', 'Alergia a la proteína de la carne de res'),
      ('Carne de cerdo', 'Alergia a la proteína de la carne de cerdo'),
      ('Pollo', 'Alergia a la proteína de pollo'),
      ('Arroz', 'Alergia al arroz'),
      ('Ajo', 'Alergia al ajo'),
      ('Cebolla', 'Alergia a la cebolla'),
      ('Melocotón', 'Alergia al melocotón (durazno)')
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
      ('Limón'),
      ('Mostaza dijon'),
      ('Chocolate amargo'),
      ('Crema'),
      ('Yogur'),
      ('Caseína'),
      ('Suero de leche'),
      ('Lactosa'),
      ('Mantequilla'),
      ('Queso parmesano'),
      ('Queso mozzarella'),
      ('Sémola'),
      ('Cuscús'),
      ('Malta'),
      ('Cebada'),
      ('Centeno'),
      ('Harina de cebada'),
      ('Clara de huevo'),
      ('Yema de huevo'),
      ('Albúmina'),
      ('Mayonesa'),
      ('Salsa de soja'),
      ('Tofu'),
      ('Edamame'),
      ('Lecitina de soja'),
      ('Proteína de soja'),
      ('Cacahuate'),
      ('Aceite de cacahuate'),
      ('Nueces de nogal'),
      ('Pacanas'),
      ('Avellanas'),
      ('Anacardos'),
      ('Pistaches'),
      ('Harina de almendra'),
      ('Salmón'),
      ('Bacalao'),
      ('Anchoas'),
      ('Surimi'),
      ('Cangrejo'),
      ('Semillas de mostaza'),
      ('Cacao'),
      ('Tomate'),
      ('Manzana'),
      ('Canela'),
      ('Aguacate'),
      ('Naranja'),
      ('Apio'),
      ('Semillas de sésamo'),
      ('Tahini'),
      ('Dióxido de azufre'),
      ('Sulfitos'),
      ('Maíz'),
      ('Jarabe de maíz'),
      ('Almidón de maíz'),
      ('Coco'),
      ('Kiwi'),
      ('Plátano'),
      ('Carne de res'),
      ('Carne de cerdo'),
      ('Pollo'),
      ('Arroz'),
      ('Ajo'),
      ('Cebolla'),
      ('Melocotón')
    ''');

await db.rawInsert('''
      INSERT INTO allergy_ingredients (allergy_id, ingredient_id) VALUES
      (9, 2),
      (9, 17),
      (9, 18),
      (9, 19),
      (9, 20),
      (9, 21),
      (9, 22),
      (9, 7),
      (9, 23),
      (9, 24),
      (8, 1),
      (8, 8),
      (8, 25),
      (8, 26),
      (8, 27),
      (8, 28),
      (8, 29),
      (8, 30),
      (18, 1),
      (18, 3),
      (18, 2),
      (7, 3),
      (7, 31),
      (7, 32),
      (7, 33),
      (7, 34),
      (20, 5),
      (20, 35),
      (20, 36),
      (20, 37),
      (20, 38),
      (20, 39),
      (10, 4),
      (10, 40),
      (10, 41),
      (2, 11),
      (2, 42),
      (2, 43),
      (2, 44),
      (2, 45),
      (2, 46),
      (2, 47),
      (13, 11),
      (13, 47),
      (21, 46),
      (12, 10),
      (12, 17),
      (12, 51),
      (12, 52),
      (17, 17),
      (14, 9),
      (14, 48),
      (14, 49),
      (14, 50),
      (14, 51),
      (1, 15),
      (3, 16),
      (4, 6),
      (15, 12),
      (16, 13),
      (16, 14),
      (1, 53),
      (3, 54),
      (4, 55),
      (5, 56),
      (6, 57),
      (11, 58),
      (16, 59),
      (19, 60),
      (22, 61),
      (22, 62),
      (23, 63),
      (23, 64),
      (24, 65),
      (24, 66),
      (24, 67),
      (25, 68),
      (26, 69),
      (27, 70),
      (28, 71),
      (29, 72),
      (30, 73),
      (31, 74),
      (32, 75),
      (33, 76),
      (34, 77)
    ''');

    // await db.rawInsert('''
    //   INSERT INTO allergy_ingredients (allergy_name, ingredient_name) VALUES
    //   ('Lactosa', 'Leche entera'),
    //   ('Lactosa', 'Crema'),
    //   ('Lactosa', 'Yogur'),
    //   ('Lactosa', 'Caseína'),
    //   ('Lactosa', 'Suero de leche'),
    //   ('Lactosa', 'Lactosa'),
    //   ('Lactosa', 'Mantequilla'),
    //   ('Lactosa', 'Queso cheddar'),
    //   ('Lactosa', 'Queso parmesano'),
    //   ('Lactosa', 'Queso mozzarella'),
    //   ('Gluten', 'Harina de trigo'),
    //   ('Gluten', 'Pan integral'),
    //   ('Gluten', 'Sémola'),
    //   ('Gluten', 'Cuscús'),
    //   ('Gluten', 'Malta'),
    //   ('Gluten', 'Cebada'),
    //   ('Gluten', 'Centeno'),
    //   ('Gluten', 'Harina de cebada'),
    //   ('Pan', 'Harina de trigo'),
    //   ('Pan', 'Huevo fresco'),
    //   ('Pan', 'Leche entera'),
    //   ('Huevo', 'Huevo fresco'),
    //   ('Huevo', 'Clara de huevo'),
    //   ('Huevo', 'Yema de huevo'),
    //   ('Huevo', 'Albúmina'),
    //   ('Huevo', 'Mayonesa'),
    //   ('Soja', 'Aceite de soja'),
    //   ('Soja', 'Salsa de soja'),
    //   ('Soja', 'Tofu'),
    //   ('Soja', 'Edamame'),
    //   ('Soja', 'Lecitina de soja'),
    //   ('Soja', 'Proteína de soja'),
    //   ('Cacahuate', 'Mantequilla de cacahuate'),
    //   ('Cacahuate', 'Cacahuate'),
    //   ('Cacahuate', 'Aceite de cacahuate'),
    //   ('Nueces', 'Almendras fileteadas'),
    //   ('Nueces', 'Nueces de nogal'),
    //   ('Nueces', 'Pacanas'),
    //   ('Nueces', 'Avellanas'),
    //   ('Nueces', 'Anacardos'),
    //   ('Nueces', 'Pistaches'),
    //   ('Nueces', 'Harina de almendra'),
    //   ('Almendras', 'Almendras fileteadas'),
    //   ('Almendras', 'Harina de almendra'),
    //   ('Pistache', 'Pistaches'),
    //   ('Mariscos', 'Camarones congelados'),
    //   ('Mariscos', 'Langosta'),
    //   ('Mariscos', 'Surimi'),
    //   ('Mariscos', 'Cangrejo'),
    //   ('Langosta', 'Langosta'),
    //   ('Pescado', 'Atún enlatado'),
    //   ('Pescado', 'Salmón'),
    //   ('Pescado', 'Bacalao'),
    //   ('Pescado', 'Anchoas'),
    //   ('Pescado', 'Surimi'),
    //   ('Mostaza', 'Mostaza dijon'),
    //   ('Mostaza', 'Semillas de mostaza'),
    //   ('Chocolate', 'Chocolate amargo'),
    //   ('Chocolate', 'Cacao'),
    //   ('Tomate', 'Salsa de tomate'),
    //   ('Tomate', 'Tomate'),
    //   ('Fresa', 'Fresas congeladas'),
    //   ('Cítricos', 'Jugo de naranja'),
    //   ('Cítricos', 'Limón'),
    //   ('Cítricos', 'Naranja'),
    //   ('Manzana', 'Manzana'),
    //   ('Canela', 'Canela'),
    //   ('Aguacate', 'Aguacate'),
    //   ('Apio', 'Apio'),
    //   ('Sésamo', 'Semillas de sésamo'),
    //   ('Sésamo', 'Tahini'),
    //   ('Sulfitos', 'Dióxido de azufre'),
    //   ('Sulfitos', 'Sulfitos'),
    //   ('Maíz', 'Maíz'),
    //   ('Maíz', 'Jarabe de maíz'),
    //   ('Maíz', 'Almidón de maíz'),
    //   ('Coco', 'Coco'),
    //   ('Kiwi', 'Kiwi'),
    //   ('Plátano', 'Plátano'),
    //   ('Carne de res', 'Carne de res'),
    //   ('Carne de cerdo', 'Carne de cerdo'),
    //   ('Pollo', 'Pollo'),
    //   ('Arroz', 'Arroz'),
    //   ('Ajo', 'Ajo'),
    //   ('Cebolla', 'Cebolla'),
    //   ('Melocotón', 'Melocotón')
    // ''');
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
