#include <Wire.h>
#include <MPR121.h>

void setup() {
  Serial.begin(115200); // Start serial communication at 115200 baud rate
  Wire.begin(); // Initialize I2C communication
  
  // Check if MPR121 sensor is connected
  if (!MPR121.begin(0x5C)) { // If MPR121 not found, print error message and halt
    Serial.println("MPR121 not found, check your wiring!");
    while (1); // Halt program execution
  }
}
 
void loop() {
  MPR121.updateAll(); // Update touch states for all electrodes

  // Variables to store the centroid position
  float xCentroid = 0.0; // Initialize x centroid
  float yCentroid = 0.0; // Initialize y centroid
  int count = 0; // Initialize count of touched electrodes
  
  // Calculate the centroids of touch
  for (int i = 0; i < 12; i++) {
    if (MPR121.isNewTouch(i)) { // If electrode i is touched
      // Calculate the centroids based on the electrode's position in the grid
      // Assign weight to horizontal and vertical positions
      if (i <= 3) { // If electrode is in the row (vertical electrodes)
        yCentroid += i; // Add that row to y centroid because vertical position contributes to y centroid
      } else if (i >= 7 && i <= 11) { // If electrode is in the second row (horizontal electrodes)
        xCentroid += (i - 7); // Add (i - 7) to x centroid because horizontal position contributes to x centroid
      }
      count++; // Increment count of touched electrodes
    }
  }

  if (count > 0) { // If at least one electrode is touched
    xCentroid /= count; // Calculate average x centroid
    yCentroid /= count; // Calculate average y centroid

    // Send centroid data over serial
    Serial.print(xCentroid); // Print x centroid to serial
    Serial.print(","); // Print comma separator to separate x and y centroids
    Serial.println(yCentroid); // Print y centroid to serial
  }
  
  delay(100); // Prevent data flooding by adding a delay
}
