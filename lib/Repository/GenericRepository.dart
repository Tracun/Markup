abstract class GenericRepository {
  init();

  Future<int> insert(dynamic object);

  Future update(dynamic object);

  Future delete(int productId);

  Future<List<dynamic>> getAllProducts();

  Future<List<dynamic>> getAllInsumos();
}
