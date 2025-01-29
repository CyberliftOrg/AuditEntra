# Clone le dépôt GitHub contenant le module BARK dans le répertoire courant
git clone https://github.com/BloodHoundAD/BARK

# Importation du script BARKps1 situé dans le répertoire courant
$Path = Join-Path -Path (Get-Location) -ChildPath "BARK/BARK.ps1"
. $Path

# Obtention d'un jeton d'accès Microsoft Graph en utilisant les identifiants d'une application (ID client, secret client et nom du tenant).
# Ce jeton est nécessaire pour effectuer des requêtes via les API Microsoft Graph.
$MSGraphToken = (Get-MSGraphTokenWithClientCredentials `
    -ClientID 'ClientID' `                 # Identifiant unique de l'application (remplacer 'ClientID' par la valeur réelle)
    -ClientSecret 'ClientSecret' `         # Secret associé à l'application (remplacer 'ClientSecret' par la valeur réelle)
    -TenantName 'ClientTenantName'         # Nom du tenant Azure (remplacer 'ClientTenantName' par la valeur réelle)
).access_token

# Obtention des identités d'applications critiques (Tier Zero Service Principals) via le module BARK.
# La commande "Get-EntraTierZeroServicePrincipals" retourne les principaux d'application avec des privilèges critiques.
Get-EntraTierZeroServicePrincipals -Token $MSGraphToken | %{
    $tierZeroPrivilege = $_.tiersZeroPrivilege # Stockage des privilèges Tier Zero associés à l'identité actuelle.
    
    # Récupération des informations détaillées pour chaque Service Principal identifié.
    Get-EntraServicePrincipal `
        -Token $MSGraphToken `
        -ObjectID $_.ServicePrincipalID |      
        Select-Object id,                      
            appDisplayName,                    
            appOwnerOrganizationId,           
            @{Name="InternalApplication"; Expression={ $_.appOwnerOrganizationId -eq "TenantID" }}, # Identifiant unique du tenant Azure (remplacer 'TenantID' par la valeur réelle)
            @{Name="TierZeroPrivilege"; Expression={ $tierZeroPrivilege }}
} | Export-Csv -Path "Serviceprincipals.csv" -NoTypeInformation -Encoding UTF8
# Exporte les informations collectées dans un fichier CSV appelé "Serviceprincipals.csv"
