# Détecter une intrusion critique dans Entra  

## Description  

Ce script PowerShell a été conçu pour vous aider à détecter des intrusions critiques dans votre système d'information (SI) et à identifier les applications les plus sensibles dans votre environnement Microsoft 365 (M365).  
Il est destiné à être utilisé par votre équipe en charge des identités Microsoft 365 afin de détecter des droits critiques sur :  
- Votre référentiel d'identité  
- Votre messagerie  
- Vos stockages de fichiers  
- Vos communications  

L'objectif principal est d'identifier les identités et applications critiques pouvant compromettre l'intégralité de votre tenant M365.  

Pour un accompagnement complet et une visibilité exhaustive, contactez **Cyberlift** à l'adresse : [M365@cyberlift.fr](mailto:M365@cyberlift.fr).  
Pour plus de détails, retrouvez notre fiche pratique AuditEntra [ici](https://cyberlift.fr/cybershow).

## Objectifs  

- Identifier les identités d’applications critiques au sein de votre tenant M365.  
- Faciliter la détection d'intrusions malveillantes dans votre environnement Microsoft Entra.  
- Répertorier les applications les plus sensibles pour protéger votre SI.  

## Prérequis  

Avant d’utiliser ce script, assurez-vous de répondre aux conditions suivantes :  

### Conditions préalables  

1. **Droits nécessaires**  
   - Vous devez disposer des autorisations requises pour exécuter des scripts PowerShell dans votre environnement.  

2. **Compte de service Entra**  
   - Un service principal Entra (compte de service) est nécessaire avec l’autorisation API `User.Read` de type application.  
   - **Recommandation :** Créez une application dédiée pour exécuter ce script.  

### Informations nécessaires  

- **Nom du tenant** : Tenant Name  
- **Identifiant de l'application Entra ID** : App ID  
- **Secret de l'application** : Client Secret  
- **Identifiant unique du tenant** : Tenant ID  

## Utilisation  

1. Configurez un service principal avec les permissions nécessaires dans votre Microsoft Entra ID.  
2. Collectez les informations requises (voir ci-dessus).  
3. Téléchargez et exécutez le script PowerShell pour analyser votre tenant M365 (voir ci-dessous).  

Pour toute question ou assistance technique, n'hésitez pas à contacter **Cyberlift** à [M365@cyberlift.fr](mailto:M365@cyberlift.fr). 

## Installation des prérequis  

1. **Créer un Service Principal dédié :**  
   Configurez un Service Principal sur Microsoft Entra ID avec un accès en lecture seule.  

2. **Télécharger le script :**  
   Récupérez le script depuis le dépôt GitHub de Cyberlift :  
   [AuditEntraID/AuditEntra.ps1](https://github.com/CyberliftOrg/AuditEntra/blob/main/AuditEntra.ps1).  

3. **Configurer le script :**  
   Avant d’exécuter le script, remplacez les valeurs de référence par vos informations spécifiques :  
   - `ClientID`  
   - `ClientSecret`  
   - `TenantID`  
   - `ClientTenantName`  

   Modifiez directement ces valeurs dans le script à l’aide de votre éditeur de texte préféré.  

## Exécution du script  

1. Accédez au répertoire contenant le fichier `AuditEntra.ps1`.  
2. Lancez le script avec la commande suivante :  
   ```powershell
   ./AuditEntra.ps1
   ```  

3. **Fonctionnalités principales :**  
   Le script identifie les comptes de service disposant des droits critiques suivants :  
   - **Rôles** :  
     - Global Administrator  
     - Privileged Authentication Administrator  
     - Privileged Role Administrator  
     - Partner Tier2 Support  
   - **Permissions Microsoft Graph** :  
     - `RoleManagement.ReadWrite.Directory`  
     - `AppRoleAssignment.ReadWrite.All`  

4. Les informations collectées sont exportées dans un fichier CSV nommé **`ServicePrincipals.csv`**.  

## Analyse des résultats  

1. Ouvrez le fichier CSV généré (`ServicePrincipals.csv`).  
2. Ce fichier contient :  
   - Le nom des applications  
   - Les droits attribués  
   - Les identifiants des applications  
   - Les applications tierces avec des permissions critiques, identifiées par la valeur **`false`** dans la colonne `InternalApplication`.  

3. **Recommandations d’analyse :**  
   - Réévaluez les droits attribués aux applications identifiées
   - Priorisez l’analyse des applications tierces (non internes) 
   - Diminuez les privilèges inutiles attribués aux applications si possible.  

## Limitations  

Le script identifie uniquement **6 permissions critiques** parmi plus de **300 permissions critiques** possibles.  

Pour une analyse complète et une visibilité exhaustive, nous vous recommandons de contacter les auditeurs de **Cyberlift**.  
**Contact :** [M365@cyberlift.fr](mailto:M365@cyberlift.fr).  

