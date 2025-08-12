# Guide de Dépannage - OculoCheck

## 🔧 Problèmes de Connexion MySQL

### Erreur "Socket has been closed" ou "Connection refused"

**Cause :** Le serveur MySQL n'est pas démarré ou l'émulateur Android ne peut pas se connecter.

**Solutions :**

1. Le stockage utilise désormais SQLite (local). Aucun serveur MySQL/XAMPP/phpMyAdmin n'est requis.
2. Si vous ne voyez pas vos données, vérifiez que l'application a pu écrire dans le dossier documents de l'appareil.

3. **Configuration pour l'émulateur Android :**
   - L'app utilise `10.0.2.2` au lieu de `localhost`
   - Cette adresse permet à l'émulateur de se connecter à votre machine

### Erreur "Access denied"

**Cause :** Identifiants MySQL incorrects.

**Solution :**
- Vérifiez que l'utilisateur `root` n'a pas de mot de passe
- Ou modifiez `lib/config/database_config.dart` avec vos identifiants

### Erreur "Unknown database"

**Cause :** La base de données `oculocheck` n'existe pas.

**Solution :**
1. Redémarrez l'application
2. Vérifiez les permissions de stockage si nécessaires

## 🤖 Problèmes de Modèle TFLite

### Erreur "FULLY_CONNECTED version not supported"

**Cause :** Version du modèle incompatible avec la version de TFLite.

**Solutions :**
1. **Mise à jour de l'application :** L'erreur sera corrigée dans une prochaine version
2. **Modèle alternatif :** Utilisez un modèle compatible avec la version actuelle

### Erreur "FileSystemException"

**Cause :** Fichier modèle manquant.

**Solution :**
- Vérifiez que `assets/my_model.tflite` et `assets/labels.txt` existent
- Redémarrez l'application

## 📱 Problèmes d'Interface

### L'application ne se lance pas

**Solutions :**
1. Exécutez `flutter clean`
2. Exécutez `flutter pub get`
3. Redémarrez l'application

### Boutons ne répondent pas

**Cause :** Problème de navigation ou de state.

**Solution :**
- Redémarrez l'application
- Vérifiez que tous les écrans sont correctement importés

## 🗄️ Problèmes de Données

### Aucun utilisateur trouvé

**Solution :**
1. Allez dans l'écran "Profil Utilisateur"
2. Créez un profil utilisateur
3. L'application utilisera automatiquement ce profil

### Historique vide

**Cause :** Aucun test n'a été effectué ou problème de base de données.

**Solutions :**
1. Effectuez un test d'analyse d'image
2. Vérifiez que l'analyse sauvegarde bien un enregistrement SQLite (utilisez l'écran Historique)

## 🔍 Vérification de la Configuration

### Test de Connexion MySQL

1. Vérifiez que l'écran Historique affiche des entrées après un test
2. Exportez la base `oculocheck.db` depuis Android Studio > Device Explorer pour inspection
4. Testez une requête simple : `SELECT * FROM users;`

### Configuration de l'Application

Vérifiez `lib/config/database_config.dart` :
```dart
static const String host = '10.0.2.2'; // Pour émulateur Android
static const int port = 3306;
static const String user = 'root';
static const String password = '';
static const String database = 'oculocheck';
```

## 📞 Support

Si les problèmes persistent :
1. Vérifiez les logs de l'application
2. Redémarrez l'émulateur Android
3. Relancez l'application Flutter

## 🚀 Optimisations

### Performance
- Fermez les autres applications
- Utilisez un émulateur avec plus de RAM
- Désactivez les animations si nécessaire

### Stabilité
- Vérifiez l'espace disque disponible
- Maintenez à jour Flutter et les dépendances
