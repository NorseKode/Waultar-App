abstract class IBaseRepository<T> {
  int put<T>(T model);
  List<int> putAll(List<T> models);
  T get();
  List<T> getAll();
  List<T> getPagination(int offset, int limit);
  List<T> getTextSearch(String searchText);
  List<T> getTextSearchPagination(String searchText, int offset, int limit);
  bool remove<T>(T model);
  int removeAll();
}