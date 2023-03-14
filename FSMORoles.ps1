$FSMO = Get-ADDomain | fl InfrastructureMaster, RIDMaster
$FSMO += Get-ADForest | fl DomainNamingMaster, GlobalCatalogs, SchemaMaster

$FSMO