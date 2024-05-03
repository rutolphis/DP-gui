# Intelligent Interior Car Detector Frontend

## Overview
The Intelligent Interior Car Detector is a crucial component of a comprehensive accident detection and response system designed for automotive safety. This frontend interface is built using Flutter and integrates with vehicle systems via an NVIDIA Jetson module. The system employs dual cameras and multiple sensors to provide real-time data analysis and accident detection.

## System Features
- **Real-time Vehicle Monitoring:** Continuously receives data from the vehicle via NVIDIA Jetson, including car statistics and camera feeds.
- **Advanced Computer Vision:** Analyzes the video feed to detect:
  - Number of persons in the car.
  - Driver's condition (e.g., dizziness).
  - Seatbelt usage.
  - License plates of nearby vehicles and any traffic violations preceding an accident.
- **Emergency Response:** Allows users to set emergency contacts in the app. These contacts, along with specific personal information, are automatically notified in the event of an accident.
- **Rescue Services Interface:** Provides a GUI for rescue services to monitor accidents in real-time, aiding them in understanding the context and severity of each situation.
- **Health Monitoring Integration:** Supports connectivity with Xiaomi Mi Band 6 via Bluetooth to monitor the wearer's heart rate, which is shared with rescue services post-accident.

## Installation

### Prerequisites
- Flutter (latest version)
- Android SDK or iOS SDK
- NVIDIA Jetson module set up with the car
- Backend part of the code

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/yourgithubusername/intelligent-interior-car-detector-frontend.git
   ```
2. Navigate to the project directory:
   ```bash
   cd intelligent-interior-car-detector-frontend
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Connect your device or emulator and ensure it is visible to `adb`:
   ```bash
   adb devices
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## Configuration
Ensure the NVIDIA Jetson module and all sensors and cameras are properly configured and connected. The system should be capable of communicating with the app continuously through a stable network connection.

## Contributing
Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request.

## License
Specify your license here or indicate if the project is open for public use.

## Contact
For further information or support, please contact [your email](mailto:rudolfkrizan@yahoo.com).

## Acknowledgements
Thanks to all contributors and testers who have helped in developing this advanced accident detection system.
