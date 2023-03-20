import 'package:bear_test/models/bear.dart';

abstract class BearRepository {
  Future<List<Bear>> getBearList();
  Future<Bear> getBear({required int id});
}
