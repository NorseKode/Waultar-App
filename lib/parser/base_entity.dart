class BaseEntity {
  // final String guid;
  // final DateTime Timestamp;
  // final String ProfileId;

  BaseEntity(); 

  BaseEntity.fromJson(Map<String, dynamic> json);

  fromJson(Map<String, dynamic> json) {
    return BaseEntity();
  }
}
