# OculoCheck - Application de Diagnostic Oculaire

Une application mobile Flutter utilisant l'intelligence artificielle pour détecter les maladies oculaires courantes à partir de photos. Optimisée pour les dispositifs médicaux spécialisés.

## 🎨 Design System Médical

### Palette de Couleurs Professionnelle

L'application utilise une palette de couleurs spécialement conçue pour les applications médicales :

- **Couleur Principale** : `#2E5BBA` (Bleu médical professionnel)
- **Couleur Secondaire** : `#38B2AC` (Turquoise médical)
- **Couleur Tertiaire** : `#48BB78` (Vert pour les résultats normaux)
- **Couleur d'Erreur** : `#E53E3E` (Rouge pour les alertes)
- **Arrière-plan** : `#F8FAFC` (Blanc cassé propre)
- **Surface** : `#FFFFFF` (Blanc pur)

### Thèmes Dynamiques

- **Mode Clair** : Interface lumineuse et professionnelle
- **Mode Sombre** : Interface 100% sombre pour la réduction de la fatigue oculaire
- **Mode Système** : Adaptation automatique selon les préférences de l'appareil

### Couleurs par Maladie

- **Normal** : `#38A169` (Vert)
- **Rétinopathie Diabétique** : `#E53E3E` (Rouge)
- **Glaucome** : `#3182CE` (Bleu)
- **Cataracte** : `#805AD5` (Violet)

### Typographie Médicale

- **Titres** : Roboto Bold, 20-32px
- **Corps de texte** : Roboto Regular, 14-16px
- **Labels** : Roboto Medium, 12-14px
- **Hauteur de ligne** : 1.4-1.6 pour une meilleure lisibilité

### Composants UI Médicaux

#### Cartes
- Bordures arrondies : 16px
- Élévation : 3-4px
- Ombres douces avec transparence
- Bordures colorées selon le contexte

#### Boutons
- Bordures arrondies : 12-16px
- Padding généreux : 16-20px vertical
- Icônes médicales appropriées
- États visuels clairs (normal, pressé, désactivé)

#### Indicateurs de Progression
- Couleur primaire pour les indicateurs
- Messages informatifs pendant l'analyse
- Feedback visuel immédiat

## 🚀 Fonctionnalités

### Analyse d'Images
- **Détection de Maladies** :
  - Rétinopathie diabétique
  - Glaucome
  - Cataracte
  - Œil normal

### Interface Utilisateur
- **Design Responsive** : Adapté à tous les écrans
- **Accessibilité** : Contraste élevé, tailles de texte appropriées
- **Navigation Intuitive** : Flux utilisateur clair et logique
- **Feedback Visuel** : États de chargement et résultats clairs
- **Thèmes Dynamiques** : Basculement instantané entre modes clair/sombre

### Sécurité et Confidentialité
- **Traitement Local** : Analyse sur l'appareil
- **Aucune Donnée Partagée** : Respect de la vie privée
- **Avertissements Médicaux** : Disclaimers appropriés
- **Anonymisation** : Noms et prénoms masqués dans l'historique

### Optimisations pour Dispositifs Spécialisés
- **Conseils d'Export** : Recommandations sRGB, résolution ≥ 2048px
- **Formats Supportés** : JPEG/PNG avec profil colorimétrique
- **Bonnes Pratiques** : Guide pour images médicales de qualité

## 📱 Écrans

### 1. Écran d'Accueil
- Logo de l'application avec styling médical
- Introduction aux maladies oculaires
- Cartes informatives avec images
- Bouton d'action principal optimisé
- Avertissement médical
- Menu contextuel (Conseils, Paramètres, FAQ, À propos)

### 2. Écran d'Upload
- Instructions claires adaptées aux dispositifs spécialisés
- Zone de sélection d'image
- Indicateur de progression
- Interface intuitive
- Formulaire de saisie des informations patient

### 3. Écran de Résultats
- Résultat principal avec icône
- Niveau de confiance
- Recommandations médicales
- Avertissements appropriés
- Actions (nouvelle analyse, partage)

### 4. Historique des Tests
- Liste chronologique des analyses
- Vignettes avec aperçus d'images
- Résultats avec codes couleur
- Détails anonymisés (confidentialité)
- Actions rapides (voir détails, partager)

### 5. Paramètres
- **Général** : Vibrations/Haptique, Sauvegarder les photos
- **Apparence** : Sélection du thème (Système/Clair/Sombre)
- Interface simplifiée et intuitive

### 6. Écrans d'Aide
- **Conseils** : Guide pour images de qualité (éclairage, cadrage, sRGB)
- **FAQ** : Questions fréquentes sur l'utilisation et la fiabilité
- **À propos** : Informations sur l'application et la version

## 🛠️ Technologies

- **Framework** : Flutter 3.x
- **IA** : TensorFlow Lite embarqué
- **Traitement d'Images** : Image package
- **Sélection d'Images** : Image Picker
- **Design** : Material Design 3
- **Base de Données** : SQLite (Sqflite)
- **Gestion des Thèmes** : Contrôleur global avec ValueNotifier

## 📋 Prérequis

- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / VS Code
- Émulateur Android ou appareil physique

## 🔧 Installation

1. **Cloner le repository**
   ```bash
   git clone [url-du-repo]
   cd eyeDiseasesMobileApp
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Lancer l'application**
   ```bash
   flutter run
   ```

## 📁 Structure du Projet

```
lib/
├── main.dart                 # Point d'entrée avec thèmes dynamiques
├── config/
│   └── theme_controller.dart # Contrôleur global des thèmes
├── screens/
│   ├── home_screen.dart      # Écran d'accueil avec menu contextuel
│   ├── upload_screen.dart    # Écran d'upload et analyse
│   ├── result_screen.dart    # Écran de résultats
│   ├── test_history_screen.dart # Historique des tests
│   ├── test_details_screen.dart # Détails d'un test
│   ├── settings_screen.dart  # Paramètres simplifiés
│   ├── tips_screen.dart      # Conseils pour images de qualité
│   ├── faq_screen.dart       # Questions fréquentes
│   └── about_screen.dart     # À propos de l'application
├── models/
│   └── test.dart            # Modèle de données pour les tests
└── services/
    └── database_service.dart # Service de gestion de la base de données
assets/
├── my_model.tflite          # Modèle TensorFlow Lite
├── labels.txt               # Labels des classes
└── images/                  # Images des maladies et logo
```

## 🎯 Principes de Design Médical

### 1. Confiance et Professionnalisme
- Couleurs sobres et professionnelles
- Typographie claire et lisible
- Icônes médicales appropriées
- Interface adaptée aux dispositifs spécialisés

### 2. Accessibilité
- Contraste élevé pour la lisibilité
- Tailles de texte appropriées
- Navigation intuitive
- Thèmes adaptés aux préférences utilisateur

### 3. Clarté de l'Information
- Hiérarchie visuelle claire
- Messages d'erreur informatifs
- Instructions étape par étape
- Conseils pratiques pour la qualité des images

### 4. Responsabilité Médicale
- Avertissements appropriés
- Disclaimers visibles
- Recommandations médicales
- Confidentialité des données patient

## 🔒 Avertissements Médicaux

⚠️ **Important** : Cette application est conçue à des fins éducatives et informatives uniquement. Elle ne remplace pas une consultation médicale professionnelle.

- Les résultats sont préliminaires
- Consultez toujours un ophtalmologue
- Ne basez pas de décisions médicales uniquement sur cette application
- Optimisée pour les images issues de dispositifs médicaux spécialisés

## 🆕 Nouvelles Fonctionnalités

### Version 1.0.0
- ✅ **Thèmes Dynamiques** : Mode clair/sombre/système avec basculement instantané
- ✅ **Menu Contextuel** : Accès rapide aux écrans d'aide et paramètres
- ✅ **Confidentialité Renforcée** : Anonymisation des données patient
- ✅ **Interface Simplifiée** : Paramètres épurés et intuitifs
- ✅ **Conseils Spécialisés** : Guide pour images de dispositifs médicaux
- ✅ **FAQ Complète** : Réponses aux questions fréquentes
- ✅ **Mode Sombre 100%** : Interface totalement sombre pour la réduction de la fatigue oculaire

## 🤝 Contribution

Les contributions sont les bienvenues ! Veuillez respecter les principes de design médical lors de l'ajout de nouvelles fonctionnalités.

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.

## 📞 Support

Pour toute question ou problème, veuillez ouvrir une issue sur GitHub.

---

**Développé avec ❤️ pour la santé oculaire**
