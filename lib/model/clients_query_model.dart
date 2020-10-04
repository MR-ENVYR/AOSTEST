class ClientQuery {
  static final String UID_KEY = "uid";
  static final String ID_KEY = "id";
  static final String USERNAME_KEY = "username";
  static final String EMAIL_KEY = "email";
  static final String PNO_KEY = "phone no";
  static final String QUES1_KEY = "ques1";
  static final String QUES2_KEY = "ques2";
  static final String QUES3_KEY = "ques3";
  static final String STATUS_KEY = "status";
//  static final String QUES4_KEY = "uid";

  final String id;
  final String email;
  final String status;
  final String uid;
  final String username;
  final String phno;
  final String ques1;
  final String ques2;
  final List<dynamic> ques3;

  ClientQuery(
      {this.id,
        this.uid,
        this.username,
        this.phno,
        this.ques1,
        this.ques2,
        this.ques3,
        this.email,
        this.status});
}