import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/vendor.dart';
import '../models/order.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'vendor_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE vendors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            company TEXT,
            contact TEXT,
            products TEXT,
            isInactive INTEGER,
            rating REAL,
            feedback TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            vendorId INTEGER,
            product TEXT,
            quantity INTEGER,
            date TEXT,
            status TEXT,
            FOREIGN KEY (vendorId) REFERENCES vendors(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  Future<int> insertVendor(Vendor vendor) async {
    final db = await database;
    final result = await db.insert('vendors', vendor.toMap());
    print('Vendor inserted with id: $result');
    return result;
  }

  Future<List<Vendor>> getAllVendors() async {
    final db = await database;
    final vendorMap = await db.query('vendors');
    List<Vendor> vendors = vendorMap.map((map) => Vendor.fromMap(map)).toList();

    for (Vendor vendor in vendors) {
      final orders = await getOrdersByVendorId(vendor.id!);
      vendor.orders = orders;
    }

    print('Fetched ${vendors.length} vendors from DB');
    return vendors;
  }

  Future<int> updateVendor(Vendor vendor) async {
    final db = await database;
    return await db.update(
      'vendors',
      vendor.toMap(),
      where: 'id = ?',
      whereArgs: [vendor.id],
    );
  }

  Future<int> deleteVendor(int id) async {
    final db = await database;
    return await db.delete('vendors', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Order>> getOrdersByVendorId(int vendorId) async {
    final db = await database;
    final result = await db.query(
      'orders',
      where: 'vendorId = ?',
      whereArgs: [vendorId],
    );
    return result.map((map) => Order.fromMap(map)).toList();
  }

  Future<int> insertOrder(Order order, int vendorId) async {
    final db = await database;
    final result = await db.insert('orders', {
      'vendorId': vendorId,
      'product': order.product,
      'quantity': order.quantity,
      'date': order.date.toIso8601String(),
      'status': order.status,
    });
    print('Order inserted with id: $result');
    return result;
  }

  Future<List<Vendor>> getAllVendorsWithOrders() async {
    final db = await database;
    final vendorMaps = await db.query('vendors');
    final orderMaps = await db.query('orders');

    return vendorMaps.map((vendorMap) {
      final vendorOrders = orderMaps
          .where((order) => order['vendorId'] == vendorMap['id'])
          .map((order) => Order.fromMap(order))
          .toList();

      return Vendor.fromMap(vendorMap)..orders = vendorOrders;
    }).toList();
  }

  Future<Vendor?> getVendorById(int id) async {
    final db = await database;
    final result = await db.query('vendors', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      Vendor vendor = Vendor.fromMap(result.first);

     
      final orderResult = await db.query(
        'orders',
        where: 'vendorId = ?',
        whereArgs: [id],
      );

      vendor.orders = orderResult.map((map) => Order.fromMap(map)).toList();
      return vendor;
    } else {
      return null;
    }
  }
}
