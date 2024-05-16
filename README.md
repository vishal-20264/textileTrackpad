# textileTrackpad

**Introduction:**
The Textile Trackpad project explores the integration of textile materials with electronic components to create a touch-sensitive interface. The project aims to develop an interactive fabric-based trackpad capable of detecting touch inputs and translating them into digital signals for various applications. Two prototypes were developed, each employing different materials and components to achieve the desired functionality.

**Hardware Components:**<br />
**Arduino Nano Microcontroller/ Bare conductive touch board:** The Arduino Nano/Bare conductive touch board served as the central processing unit, responsible for interfacing with the capacitive touch sensors and processing touch input data.
**Capacitive Tape:** Capacitive tape was employed to create touch-sensitive regions on the textile surface. When touched, the capacitance of the tape changed, which was detected by the microcontroller.
**Conductive Materials:** Conductive thread and bare conductive touch board were utilized to establish electrical connections and create touch-sensitive areas on the fabric.

**Prototype 1:**
The first prototype utilized bare conductive touch board, capacitive tape, conductive thread, crocodile wires, and other auxiliary materials. The conductive touch board served as the sensing element, detecting changes in capacitance when touched. Capacitive tape and conductive thread were used to create touch-sensitive areas on the fabric surface. Crocodile wires facilitated the connection between the touch board and the Arduino microcontroller.

**Prototype 2:**
The second prototype employed an Arduino Nano microcontroller, capacitive tape, and jumper wires. Capacitive tape was used to establish touch-sensitive regions on the textile surface. Jumper wires provided the electrical connections between the capacitive tape and the Arduino Nano microcontroller.

**Software Implementation:**
The Arduino code was developed to handle touch input detection and data processing. The code utilized the MPR121 library for interfacing with the capacitive touch sensors. Upon detecting a touch event, the Arduino calculated the centroid position of the touch and transmitted the data serially.

The Processing code was responsible for receiving the serial data from the Arduino, visualizing the touch input on the screen, and communicating with external applications (Wekinator) using OSC (Open Sound Control) protocol. The Processing sketch drew a grid representing the textile trackpad, with highlighted regions indicating touch events. It also facilitated communication with machine learning frameworks such as Wekinator for gesture recognition.

Both prototypes were integrated with Wekinator, an interactive machine learning tool, to train and recognize gestures performed on the textile trackpad. Five gestures were trained: swipeDown, swipeUp, swipeLeft, swipeRight, and double tap. Wekinator's capabilities allowed for real-time gesture recognition, enhancing the interactivity and usability of the textile trackpad

**Conclusion:**
The Textile Trackpad project demonstrates the feasibility of integrating textile materials with electronic components to create interactive interfaces. By leveraging capacitive sensing technology and microcontrollers, touch-sensitive trackpads can be embedded seamlessly into textiles, opening up possibilities for innovative wearable devices, interactive fabrics, and smart textiles. The project lays the foundation for further exploration in the field of e-textiles and human-computer interaction, offering potential applications in areas such as fashion, healthcare, and assistive technology.


By employing a grid of capacitive touch sensors, this project creates a versatile trackpad, replacing traditional mice. It enables direct modeling, sketching, and drawing on the computer, fostering creative expression and innovative interface design.






