import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance_tracker/models/role.dart';

class UserModel {
  final String? uid;
  final String? email;
  final UserRole? role;
  final RolePermissions? permissions;

  UserModel({this.uid, this.email, this.role, this.permissions});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    UserRole role = UserRole.values
        .firstWhere((e) => e.toString() == 'UserRole + ${data['role']}');

    return UserModel(
      uid: data['uid'],
      email: data['email'],
      role: role,
      permissions: rolePermissions[role],
    );
  }
}
