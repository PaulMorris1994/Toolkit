$Users = import-csv "U:\Paul Morris\Mailbox.csv"

ForEach ($U in $Users) {
        $u.DisplayName
        Add-MailboxPermission -User $U.Displayname -Identity $U.Identity -AccessRights Fullaccess -Verbose
        Add-MailboxPermission -User $U.Displayname -Identity $U.Identity1 -AccessRights Fullaccess -Verbose
        Add-MailboxPermission -User $U.Displayname -Identity $U.Identity2 -AccessRights Fullaccess -Verbose
        Add-MailboxPermission -User $U.Displayname -Identity $U.Identity3 -AccessRights Fullaccess -Verbose
        Add-MailboxPermission -User $U.Displayname -Identity $U.Identity4 -AccessRights Fullaccess -Verbose
        Add-MailboxPermission -User $U.Displayname -Identity $U.Identity5 -AccessRights Fullaccess -Verbose

}