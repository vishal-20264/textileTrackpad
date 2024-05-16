import processing.serial.*; // Importing the Serial library for serial communication
import oscP5.*; // Importing the oscP5 library for OSC communication
import netP5.*; // Importing the netP5 library for networking
import peasy.*; // Importing the PeasyCam library for 3D navigation

PeasyCam cam; // PeasyCam object for camera control
Serial port; // Serial object for serial communication
int[] data = new int[2]; // Array to store touch coordinates
int gridSize = 50; // Size of each grid cell
boolean[][] touched = new boolean[5][4]; // 2D array to store touch state of each grid cell

OscP5 oscP5; // OscP5 object for OSC communication
NetAddress dest; // NetAddress object to define the destination address
String wekinatorOutput = ""; // Variable to store Wekinator output data

void setup() {
  size(800, 600, P3D); // Set canvas size with 3D renderer
  cam = new PeasyCam(this, 500); // Initialize PeasyCam with distance 500
  cam.setMinimumDistance(50); // Set minimum distance for PeasyCam
  cam.setMaximumDistance(1000); // Set maximum distance for PeasyCam
  port = new Serial(this, "COM6", 115200); // Initialize Serial port with COM6 and baud rate 115200
  
  // Set up OSC communication
  oscP5 = new OscP5(this, 12000); // Initialize OscP5 with listening port 12000
  dest = new NetAddress("127.0.0.1", 6448); // Define the destination address for Wekinator
}

void draw() {
  if (port.available() > 0) { // Check if data is available from the serial port
    String serialData = port.readStringUntil('\n'); // Read the serial data until newline
    if (serialData != null) { // Check if data is received
      String[] values = serialData.trim().split(","); // Split the received data by comma
      if (values.length == 2) { // Ensure the array has at least 2 elements
        data[0] = int(values[0]); // Parse the x-coordinate
        data[1] = int(values[1]); // Parse the y-coordinate
        updateGrid(data[0], data[1]); // Update the grid based on touch coordinates
        sendOSCData(data[0], data[1]); // Send touch data to Wekinator
      }
    }
  }
  
  // Receive Wekinator output data
  OscMessage msg = new OscMessage("/wek/outputs"); // Create OSC message for Wekinator output
  oscP5.send(msg, dest); // Send the OSC message to Wekinator
  
  // Print Wekinator output in console
  println("Wekinator Output: " + wekinatorOutput);
  
  // Draw the grid
  background(255); // Set background color to white
  drawGrid(); // Draw the grid based on touch state
}

void updateGrid(int x, int y) {
  // Reset the touch state of all grid cells
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 4; j++) {
      touched[i][j] = false;
    }
  }
  // Mark the touched grid cell
  if (x >= 0 && x < 5 && y >= 0 && y < 4) {
    touched[x][y] = true;
  }
}

void drawGrid() {
  // Draw the grid with highlighted touched cells
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 4; j++) {
      stroke(0); // Set stroke color to black
      noFill(); // Disable filling shapes
      rect(i * gridSize, j * gridSize, gridSize, gridSize); // Draw grid cell
      if (touched[i][j]) { // Check if grid cell is touched
        fill(255, 0, 0, 100); // Set fill color to transparent red
        rect(i * gridSize, j * gridSize, gridSize, gridSize); // Highlight touched grid cell
      }
    }
  }
}

void sendOSCData(int x, int y) {
  // Create an OSC message with the touch coordinates
  OscMessage msg = new OscMessage("/wek/inputs"); // Create OSC message for Wekinator inputs
  msg.add((float)x); // Add x-coordinate as float
  msg.add((float)y); // Add y-coordinate as float
  oscP5.send(msg, dest); // Send the OSC message to Wekinator
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/wek/outputs")) { // Check if received message is from Wekinator
    float x = msg.get(0).floatValue(); // Get the x-coordinate from the OSC message
    float y = msg.get(1).floatValue(); // Get the y-coordinate from the OSC message
    wekinatorOutput = x + ", " + y; // Store the raw Wekinator output
  }
}
