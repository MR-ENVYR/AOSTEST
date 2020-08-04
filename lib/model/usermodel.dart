import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String profilename;
  final String username;
  final String url;
  final String email;
  final String phonenumber;
  final bool isphoneverified;

  User(
      {this.id,
      this.profilename,
      this.username,
      this.url,
      this.email,
      this.phonenumber,
      this.isphoneverified});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        id: doc.documentID,
        email: doc['email'],
        username: doc['username'],
        url: doc['url'],
        profilename: doc['profilename'],
        phonenumber: doc['phonenumber'],
        isphoneverified: doc['isphoneverified']);
  }
}

class UserModel {
  // KEYS to access user model class variable

  static final String USER_ID_KEY = "uid";
  static final String PROFILE_NAME_KEY = "profilename";
  static final String USERNAME_KEY = "username";
  static final String URL_KEY = "url";
  static final String EMAIL_KEY = "email";
  static final String PH_NO_KEY = "phonenumber";
  static final String IS_PH_VERIFIED_KEY = "isphoneverified";
  static final String LOCATION_KEY = "location";
  static final String BOD_KEY = "birthdate";
  static final String GENDER_KEY = "gender";
  static final String LANGUAGE_KEY = "language";
  static final String HEIGHT_KEY = "height";
  static final String WEIGHT_KEY = "weight";
  static final String CLOTHING_SIZE_KEY = "clothingsize";
  static final String BUST_SIZE_KEY = "bustsize";
  static final String WAIST_SIZE_KEY = "waistsize";
  static final String HIP_SIZE_KEY = "hipsize";
  static final String SHOE_SIZE_KEY = "shoesize";
  static final String TIME_STAMP_KEY = "timestamp";
  static final String ISPROFILESHOW_KEY = "isprofileshow";
  static final String TROUSER_lENGTH_KEY = "trouserLength";

  final String id;
  final String profilename;
  final String username;
  final String url;
  final String email;
  final String phonenumber;
  final bool isphoneverified;
  final String location;
  final String birthdate;
  final String gender;
  final String language;
  final String height;
  final String weight;
  final String clothingsize;
  final String bustsize;
  final String waistsize;
  final String hipsize;
  final String shoesize;
  final Timestamp timestamp;
  final bool isprofileshow;
  final String trouserLength;

  UserModel(
      {this.id,
      this.profilename,
      this.username,
      this.url,
      this.email,
      this.phonenumber,
      this.isphoneverified,
      this.height,
      this.gender,
      this.birthdate,
      this.bustsize,
      this.clothingsize,
      this.trouserLength,
      this.hipsize,
      this.language,
      this.location,
      this.shoesize,
      this.waistsize,
      this.weight,
      this.isprofileshow,
      this.timestamp});

  factory UserModel.fromJson(DocumentSnapshot doc) {
    return UserModel(
        id: doc.documentID,
        email: doc[EMAIL_KEY],
        username: doc[USERNAME_KEY],
        url: doc[URL_KEY],
        profilename: doc[PROFILE_NAME_KEY],
        phonenumber: doc[PH_NO_KEY],
        isphoneverified: doc[IS_PH_VERIFIED_KEY],
        height: doc[HEIGHT_KEY],
        birthdate: doc[BOD_KEY],
        bustsize: doc[BUST_SIZE_KEY],
        clothingsize: doc[CLOTHING_SIZE_KEY],
        gender: doc[GENDER_KEY],
        hipsize: doc[HIP_SIZE_KEY],
        language: doc[LANGUAGE_KEY],
        location: doc[LOCATION_KEY],
        shoesize: doc[SHOE_SIZE_KEY],
        waistsize: doc[WAIST_SIZE_KEY],
        weight: doc[WEIGHT_KEY],
        timestamp: doc[TIME_STAMP_KEY],
        trouserLength: doc[TROUSER_lENGTH_KEY],
        isprofileshow: doc[ISPROFILESHOW_KEY]);
  }

  Map<String, dynamic> toJson() => {
        USER_ID_KEY: id,
        USERNAME_KEY: username,
        EMAIL_KEY: email,
        PROFILE_NAME_KEY: profilename,
        PH_NO_KEY: phonenumber,
        IS_PH_VERIFIED_KEY: isphoneverified,
        URL_KEY: url,
        GENDER_KEY: gender,
        BOD_KEY: birthdate,
        LOCATION_KEY: location,
        LANGUAGE_KEY: language,
        HEIGHT_KEY: height,
        WEIGHT_KEY: weight,
        CLOTHING_SIZE_KEY: clothingsize,
        BUST_SIZE_KEY: bustsize,
        WAIST_SIZE_KEY: waistsize,
        SHOE_SIZE_KEY: shoesize,
        HIP_SIZE_KEY: hipsize,
        TROUSER_lENGTH_KEY: trouserLength,
        ISPROFILESHOW_KEY: isprofileshow,
        TIME_STAMP_KEY: timestamp
      };
}
