# Smart Home IoT Controller

A Flutter application that controls and monitors IoT devices in a smart room using Firebase Realtime Database.

## Project OverView



https://github.com/user-attachments/assets/0a63fc99-4bcd-4ffa-bd8b-03987acf6146



## Features

- Real-time monitoring of room conditions (light, temperature, humidity)
- Control LED lights remotely
- IR sensor detection with visual warnings
- Ultrasonic Distance Monitoring
   - Real-time distance measurement 
   - Object detection warning system
   - Visual feedback when objects are too close
- Firebase Realtime Database integration
- Responsive UI with custom components


## Firebase Database Structure

The app expects the following data structure in Firebase:

```json
{
  "distance": 0.85,
  "humidity": 47,
  "irSensor": 0,
  "led1Status": 0,
  "led2Status": 1,
  "light": 616,
  "temperature": 26,
  "warning": "Object too close!"
}
```
## Architecture Overview
![deepseek_mermaid_20250514_e14aa7](https://github.com/user-attachments/assets/4eb45ea9-bb85-4fd1-9efe-1aaeb31b756f)
