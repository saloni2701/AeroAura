class AppConstants {
  static const String weatherApiKey = 'YOUR_OPENWEATHERMAP_API_KEY';
  static const String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5';

  // Your forwarded port 5000 URL from the Ports tab, keep the /api at the end
  static const String backendBaseUrl = 'https://YOUR-CODESPACE-5000.app.github.dev/api';

  // Hydration goal (ml)
  static const double defaultHydrationGoal = 2500;

  // Temperature thresholds
  static const double heatwaveThreshold = 38.0; // °C
  static const double coldThreshold = 10.0; // °C
}