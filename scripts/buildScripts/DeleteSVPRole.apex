// DeleteSVPRole.apex
// Removes the SVP UserRole if it exists (per ManualUpdates.txt line 5).
// Idempotent: no-op if SVP role doesn't exist.
// Reassigns any child roles to no parent and clears the role from any assigned users
// before deleting, so the delete succeeds even if SVP has dependents.
// Run via: cci task run execute_anon_delete_svp_role --org <org>

List<UserRole> svpRoles = [SELECT Id, Name FROM UserRole WHERE DeveloperName = 'SVP' LIMIT 1];
if (svpRoles.isEmpty()) {
    System.debug('SVP role not found; nothing to delete');
} else {
    UserRole svpRole = svpRoles[0];

    List<UserRole> childRoles = [SELECT Id FROM UserRole WHERE ParentRoleId = :svpRole.Id];
    if (!childRoles.isEmpty()) {
        for (UserRole child : childRoles) {
            child.ParentRoleId = null;
        }
        update childRoles;
        System.debug('Detached ' + childRoles.size() + ' child role(s) from SVP');
    }

    List<User> assignedUsers = [SELECT Id FROM User WHERE UserRoleId = :svpRole.Id];
    if (!assignedUsers.isEmpty()) {
        for (User u : assignedUsers) {
            u.UserRoleId = null;
        }
        update assignedUsers;
        System.debug('Cleared SVP role from ' + assignedUsers.size() + ' user(s)');
    }

    delete svpRole;
    System.debug('Deleted SVP role');
}
