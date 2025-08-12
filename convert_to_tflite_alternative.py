import tensorflow as tf
import numpy as np

print("TensorFlow version:", tf.__version__)

# Charge le modèle Keras depuis le dossier assets
model = tf.keras.models.load_model('assets/my_model.h5')

# Affiche les informations du modèle
print(f"Modèle chargé avec {len(model.layers)} couches")
print(f"Forme d'entrée: {model.input_shape}")
print(f"Forme de sortie: {model.output_shape}")

# Crée le convertisseur avec une approche plus simple
converter = tf.lite.TFLiteConverter.from_keras_model(model)

# Configuration minimale pour compatibilité maximale
converter.allow_custom_ops = True
converter.experimental_new_converter = False

# Désactive toutes les optimisations
converter.optimizations = []

# Force l'utilisation de float32
converter.target_spec.supported_types = [tf.float32]

# Conversion
try:
    print("Conversion en cours...")
    tflite_model = converter.convert()
    
    with open('assets/my_model.tflite', 'wb') as f:
        f.write(tflite_model)
    
    print('✅ Conversion réussie !')
    print('📁 Fichier assets/my_model.tflite créé')
    
    # Test rapide du modèle converti
    interpreter = tf.lite.Interpreter(model_content=tflite_model)
    interpreter.allocate_tensors()
    print('✅ Modèle TFLite testé avec succès')
    
except Exception as e:
    print('❌ Erreur:', e)
    print('\n🔄 Tentative avec configuration alternative...')
    
    # Configuration alternative
    try:
        converter = tf.lite.TFLiteConverter.from_keras_model(model)
        converter.allow_custom_ops = True
        converter.experimental_new_converter = True
        
        tflite_model = converter.convert()
        
        with open('assets/my_model.tflite', 'wb') as f:
            f.write(tflite_model)
        
        print('✅ Conversion alternative réussie !')
        print('📁 Fichier assets/my_model.tflite créé')
        
    except Exception as e2:
        print('❌ Échec de la conversion alternative:', e2)
        print('\n💡 Le modèle peut nécessiter une modification avant conversion')
