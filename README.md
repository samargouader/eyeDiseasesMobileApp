# OculoCheck - Application de Diagnostic Oculaire

Une application mobile Flutter utilisant l'intelligence artificielle pour détecter les maladies oculaires courantes à partir de photos.

## 🎨 Design System Médical

### Palette de Couleurs Professionnelle

L'application utilise une palette de couleurs spécialement conçue pour les applications médicales :

- **Couleur Principale** : `#2E5BBA` (Bleu médical professionnel)
- **Couleur Secondaire** : `#38B2AC` (Turquoise médical)
- **Couleur Tertiaire** : `#48BB78` (Vert pour les résultats normaux)
- **Couleur d'Erreur** : `#E53E3E` (Rouge pour les alertes)
- **Arrière-plan** : `#F8FAFC` (Blanc cassé propre)
- **Surface** : `#FFFFFF` (Blanc pur)

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

### Sécurité et Confidentialité
- **Traitement Local** : Analyse sur l'appareil
- **Aucune Donnée Partagée** : Respect de la vie privée
- **Avertissements Médicaux** : Disclaimers appropriés

## 📱 Écrans

### 1. Écran d'Accueil
- Logo de l'application avec styling médical
- Introduction aux maladies oculaires
- Cartes informatives avec images
- Bouton d'action principal
- Avertissement médical

### 2. Écran d'Upload
- Instructions claires
- Zone de sélection d'image
- Indicateur de progression
- Interface intuitive

### 3. Écran de Résultats
- Résultat principal avec icône
- Niveau de confiance
- Recommandations médicales
- Avertissements appropriés
- Actions (nouvelle analyse, partage)

## 🛠️ Technologies

- **Framework** : Flutter 3.x
- **IA** : TensorFlow Lite
- **Traitement d'Images** : Image package
- **Sélection d'Images** : Image Picker
- **Design** : Material Design 3

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
├── main.dart                 # Point d'entrée avec thème médical
├── screens/
│   ├── home_screen.dart      # Écran d'accueil
│   ├── upload_screen.dart    # Écran d'upload et analyse
│   ├── result_screen.dart    # Écran de résultats
│   └── eye_diseases_home_page.dart
assets/
├── my_model.tflite          # Modèle TensorFlow Lite
├── labels.txt               # Labels des classes
└── images/                  # Images des maladies
```

## 🎯 Principes de Design Médical

### 1. Confiance et Professionnalisme
- Couleurs sobres et professionnelles
- Typographie claire et lisible
- Icônes médicales appropriées

### 2. Accessibilité
- Contraste élevé pour la lisibilité
- Tailles de texte appropriées
- Navigation intuitive

### 3. Clarté de l'Information
- Hiérarchie visuelle claire
- Messages d'erreur informatifs
- Instructions étape par étape

### 4. Responsabilité Médicale
- Avertissements appropriés
- Disclaimers visibles
- Recommandations médicales

## 🔒 Avertissements Médicaux

⚠️ **Important** : Cette application est conçue à des fins éducatives et informatives uniquement. Elle ne remplace pas une consultation médicale professionnelle.

- Les résultats sont préliminaires
- Consultez toujours un ophtalmologue
- Ne basez pas de décisions médicales uniquement sur cette application

## 🤝 Contribution

Les contributions sont les bienvenues ! Veuillez respecter les principes de design médical lors de l'ajout de nouvelles fonctionnalités.

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.

## 📞 Support

Pour toute question ou problème, veuillez ouvrir une issue sur GitHub.

---

**Développé avec ❤️ pour la santé oculaire**
