import tensorflow as tf

try:
    # Charger le modèle .h5
    model = tf.keras.models.load_model('accuracy_8871.h5', compile=False)

    # Convertir en TensorFlow Lite
    converter = tf.lite.TFLiteConverter.from_keras_model(model)
    converter.target_spec.supported_ops = [
        tf.lite.OpsSet.TFLITE_BUILTINS,  # Opérations de base TensorFlow Lite
        tf.lite.OpsSet.SELECT_TF_OPS     # Opérations TensorFlow supplémentaires si nécessaires
    ]
    converter.optimizations = [tf.lite.Optimize.DEFAULT]  # Optimisation par défaut (quantification)
    tflite_model = converter.convert()

    # Sauvegarder le modèle .tflite
    with open('model.tflite', 'wb') as f:
        f.write(tflite_model)

    print("Conversion terminée ! Fichier model.tflite généré avec succès.")
except Exception as e:
    print(f"Erreur lors de la conversion : {e}")