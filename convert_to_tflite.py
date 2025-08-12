import tensorflow as tf

# Affiche la version de TensorFlow
print("TensorFlow version:", tf.__version__)

# Charge le modèle Keras depuis le dossier assets
model = tf.keras.models.load_model('assets/my_model.h5')

# Crée le convertisseur TFLite avec compatibilité forcée
converter = tf.lite.TFLiteConverter.from_keras_model(model)

# Force la compatibilité avec les versions plus anciennes
converter.target_spec.supported_ops = [
    tf.lite.OpsSet.TFLITE_BUILTINS,  # Utilise seulement les ops TFLite de base
    tf.lite.OpsSet.SELECT_TF_OPS,    # Sélectionne les ops TF compatibles
]

# Désactive les optimisations avancées qui peuvent causer des incompatibilités
converter.optimizations = []
converter.experimental_new_converter = False

# Force la version d'opset à une version plus ancienne si possible
try:
    # Essayer de forcer la compatibilité avec les versions plus anciennes
    converter.target_spec.supported_types = [tf.float32]
    print("Configuration pour compatibilité maximale...")
except:
    print("Configuration standard...")

# Conversion
try:
    print("Début de la conversion...")
    tflite_model = converter.convert()
    
    with open('assets/my_model.tflite', 'wb') as f:
        f.write(tflite_model)
    
    print('✅ Conversion terminée ! Fichier généré : assets/my_model.tflite')
    print('📁 Le fichier a été placé directement dans le dossier assets/')
    
except Exception as e:
    print('❌ Erreur lors de la conversion :', e)
    print('\n💡 Solutions possibles :')
    print('1. Vérifie que le fichier my_model.h5 existe dans le dossier assets/')
    print('2. Le modèle peut contenir des opérations non supportées')
    print('3. Essaie de simplifier le modèle avant conversion')
