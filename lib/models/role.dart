enum UserRole {
  admin,
  guardEmployee,
  supervisorEmployee,
  generalEmployee,
}

class RolePermissions {
  final bool canScan;
  final bool canViewCode;
  final bool canGenerateReport;

  RolePermissions({
    required this.canScan,
    required this.canViewCode,
    required this.canGenerateReport,
  });
}

Map<UserRole, RolePermissions> rolePermissions = {
  UserRole.admin: RolePermissions(
      canScan: true, canViewCode: true, canGenerateReport: true),
  UserRole.guardEmployee: RolePermissions(
      canScan: true, canViewCode: true, canGenerateReport: false),
  UserRole.supervisorEmployee: RolePermissions(
      canScan: false, canViewCode: true, canGenerateReport: true),
  UserRole.generalEmployee: RolePermissions(
      canScan: false, canViewCode: true, canGenerateReport: false),
};
