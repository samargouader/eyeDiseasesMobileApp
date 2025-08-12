import tensorflow as tf
import numpy as np

print("TensorFlow version:", tf.__version__)

# Crée un modèle simple compatible avec TFLite
def create_simple_model():
    model = tf.keras.Sequential([
        tf.keras.layers.Input(shape=(224, 224, 3)),
        tf.keras.layers.Conv2D(32, 3, activation='relu'),
        tf.keras.layers.MaxPooling2D(),
        tf.keras.layers.Conv2D(64, 3, activation='relu'),
        tf.keras.layers.MaxPooling2D(),
        tf.keras.layers.Conv2D(64, 3, activation='relu'),
        tf.keras.layers.Flatten(),
        tf.keras.layers.Dense(64, activation='relu'),
        tf.keras.layers.Dense(4, activation='softmax')  # 4 classes
    ])
    return model

# Crée et compile le modèle
model = create_simple_model()
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

# Affiche les informations du modèle
print(f"Modèle créé avec {len(model.layers)} couches")
print(f"Forme d'entrée: {model.input_shape}")
print(f"Forme de sortie: {model.output_shape}")

# Sauvegarde le modèle Keras
model.save('assets/my_model.h5')
print("✅ Modèle Keras sauvegardé: assets/my_model.h5")

# Conversion en TFLite avec approche simplifiée
try:
    print("Conversion en TFLite...")
    
    # Approche simple pour TensorFlow 2.19
    converter = tf.lite.TFLiteConverter.from_keras_model(model)
    converter.optimizations = []
    
    tflite_model = converter.convert()
    
    with open('assets/my_model.tflite', 'wb') as f:
        f.write(tflite_model)
    
    print('✅ Modèle TFLite créé: assets/my_model.tflite')
    
    # Test du modèle
    interpreter = tf.lite.Interpreter(model_content=tflite_model)
    interpreter.allocate_tensors()
    print('✅ Modèle TFLite testé avec succès')
    
except Exception as e:
    print('❌ Erreur lors de la conversion:', e)
    print('Tentative avec configuration alternative...')
    
    try:
        # Configuration alternative
        converter = tf.lite.TFLiteConverter.from_keras_model(model)
        converter.allow_custom_ops = True
        
        tflite_model = converter.convert()
        
        with open('assets/my_model.tflite', 'wb') as f:
            f.write(tflite_model)
        
        print('✅ Modèle TFLite créé avec configuration alternative')
        
    except Exception as e2:
        print('❌ Échec de la conversion alternative:', e2)
