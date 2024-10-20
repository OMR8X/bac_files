abstract class ManagersBaseConverter<T> {
  ///
  T fromJson(Map<String, dynamic> json);

  ///
  Map<String, dynamic> toJson(T entity);
}
