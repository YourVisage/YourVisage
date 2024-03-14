import 'package:client/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  // Stream<UserInfoModel?> getUserInfoStream(String userId) {
  //   return _firestore
  //       .collection('users')
  //       .doc(userId)
  //       .snapshots()
  //       .map((snapshot) {
  //     if (snapshot.exists) {
  //       return UserInfoModel.fromSnapShot(snapshot);
  //     } else {
  //       return null;
  //     }
  //   });
  // }
}
