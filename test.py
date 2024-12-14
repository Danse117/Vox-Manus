from ultralytics import YOLO

# Load trained model
model = YOLO('Second_Train_50_best.pt')

# Print model info
print(model.info())

# Run inference on the source
results = model(source=0, show=True, conf=0.4, save=True, stream=True)

for r in results:
    boxes = r.boxes  # Boxes object for bbox outputs
    probs = r.probs  # Class probabilities for classification outputs


