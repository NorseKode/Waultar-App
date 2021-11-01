class EtebaseUser {
  final String username;
  final String email;

  EtebaseUser(this.username, this.email);

  EtebaseUser.fromJson(Map<String, dynamic> json) 
    : username = json['username'],
      email = json['email'];

  // Map<String, dynamic> toJson() => {

  // }

  static Map<String, dynamic> getUserFromEtebaseResponse(Map<String, dynamic> map) {
    return map['user'];
  }
}