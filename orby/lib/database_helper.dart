import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    return _database ??= await _initDB('orby.db');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL,
    senha TEXT NOT NULL,
    telefone TEXT NOT NULL,
    nascimento TEXT NOT NULL,
    sexo TEXT NOT NULL
  )
''');

    await db.execute('''
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        address TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');

    await _insertInitialLocations(db);
  }

  Future<void> _insertInitialLocations(Database db) async {
    final locations = [
      {
        'address': 'Alameda Ezequiel Dias,321',
        'latitude': -19.921610,
        'longitude': -43.938710,
      },
      {
        'address': 'Rua Dr Cristiano Rezende, 2505',
        'latitude': -19.990650,
        'longitude': -44.000150,
      },
      {
        'address': 'Rua Grão Pará, 882',
        'latitude': -19.927010,
        'longitude': -43.930460,
      },
      {
        'address': 'Rua Juiz de Fora, 861',
        'latitude': -19.923360,
        'longitude': -43.947180,
      },
      {
        'address': 'Avenida Cristiano Machado, 4002',
        'latitude': -19.869400,
        'longitude': -43.926360,
      },
      {
        'address': 'Rua Ceará, 195',
        'latitude': -19.925080,
        'longitude': -43.924340,
      },
    ];

    for (final loc in locations) {
      await db.insert('locations', loc);
    }
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  final db = await instance.database;
  final result = await db.query(
    'users',
    where: 'email = ? AND senha = ?',
    whereArgs: [email, password],
  );

  if (result.isNotEmpty) {
    return result.first;
  }
  return null;
}

  Future<int> registerUser(String name, String email, String password, String phone) async {
  final db = await instance.database;
  final user = {
    'nome': name,
    'email': email,
    'senha': password,
    'telefone': phone,
  };
  return await db.insert('users', user);
}

  Future<List<Map<String, dynamic>>> getLocations() async {
    final db = await instance.database;
    return await db.query('locations');
  }
}



