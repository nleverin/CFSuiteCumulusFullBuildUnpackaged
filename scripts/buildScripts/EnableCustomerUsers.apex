// EnableCustomerUsers.apex
// Enables Customer Community Login users for the demo person accounts (Hammy, Hilda, Horatio Hampster).
// Idempotent: skips creation if an active user already exists for the contact.
// Run via: cci task run execute_anon_enable_customer_users --org <org>

// Salesforce requires the owner of a person account to have a UserRole before
// portal/community users can be enabled against it. Ensure the running user has one.
User runningUser = [SELECT Id, UserRoleId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
if (runningUser.UserRoleId == null) {
    List<UserRole> existing = [SELECT Id FROM UserRole WHERE DeveloperName = 'Council' LIMIT 1];
    UserRole councilRole = existing.isEmpty()
        ? new UserRole(Name = 'Council', DeveloperName = 'Council')
        : existing[0];
    if (existing.isEmpty()) {
        insert councilRole;
    }
    runningUser.UserRoleId = councilRole.Id;
    update runningUser;
    System.debug('Assigned Council role to running user');
}

Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'cfsuite community login user' LIMIT 1];

Map<String, String> aliasByName = new Map<String, String>{
    'Hammy Hampster' => 'hhampy',
    'Hilda Hampster' => 'hhilda',
    'Horatio Hampster' => 'hhorat'
};

for (Account acct : [SELECT Id, Name, FirstName, LastName, PersonContactId, PersonEmail
                     FROM Account WHERE Name IN :aliasByName.keySet()]) {
    List<User> existing = [SELECT Id FROM User WHERE ContactId = :acct.PersonContactId AND IsActive = true];
    if (!existing.isEmpty()) {
        System.debug(acct.Name + ' already has community user: ' + existing[0].Id);
        continue;
    }

    String emailLocal = acct.FirstName.toLowerCase() + '.' + acct.LastName.toLowerCase();
    String email = emailLocal + '@test.example.com';
    String username = emailLocal + '.' + UserInfo.getOrganizationId() + '@test.example.com';

    User u = new User(
        ContactId = acct.PersonContactId,
        ProfileId = communityProfile.Id,
        Username = username,
        Email = email,
        FirstName = acct.FirstName,
        LastName = acct.LastName,
        Alias = aliasByName.get(acct.Name),
        TimeZoneSidKey = 'Australia/Adelaide',
        LocaleSidKey = 'en_AU',
        EmailEncodingKey = 'UTF-8',
        LanguageLocaleKey = 'en_US',
        CommunityNickname = acct.FirstName.toLowerCase() + '_' + String.valueOf(Math.random()).substring(2, 8)
    );
    insert u;
    System.debug('Created community user for ' + acct.Name + ': ' + u.Id);
}

// Assign the External Credentials permission set to all Hampster community users
// (covers principal access for the 3 Rates credentials + UserExternalCredential read)
List<PermissionSet> psList = [SELECT Id FROM PermissionSet WHERE Name = 'External_Credentials' LIMIT 1];
if (!psList.isEmpty()) {
    Set<Id> hampsterContactIds = new Set<Id>();
    for (Account acct : [SELECT PersonContactId FROM Account WHERE Name IN :aliasByName.keySet()]) {
        hampsterContactIds.add(acct.PersonContactId);
    }
    List<User> hampsterUsers = [SELECT Id FROM User WHERE ContactId IN :hampsterContactIds AND IsActive = true];

    Set<Id> alreadyAssigned = new Set<Id>();
    for (PermissionSetAssignment psa : [SELECT AssigneeId FROM PermissionSetAssignment
                                        WHERE PermissionSetId = :psList[0].Id
                                        AND AssigneeId IN :hampsterUsers]) {
        alreadyAssigned.add(psa.AssigneeId);
    }

    List<PermissionSetAssignment> newAssignments = new List<PermissionSetAssignment>();
    for (User u : hampsterUsers) {
        if (!alreadyAssigned.contains(u.Id)) {
            newAssignments.add(new PermissionSetAssignment(
                AssigneeId = u.Id,
                PermissionSetId = psList[0].Id
            ));
        }
    }
    if (!newAssignments.isEmpty()) {
        insert newAssignments;
        System.debug('Assigned External_Credentials permission set to ' + newAssignments.size() + ' user(s)');
    }
} else {
    System.debug('External_Credentials permission set not found; skipping assignment');
}
