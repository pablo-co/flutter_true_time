import 'dart:async';

/// NTP client for Flutter. Calculate the date and time "now" impervious to manual changes to device clock time.
/// In certain applications it becomes important to get the real or "true" date and time. On most devices, if the clock has been changed manually, then a new Date() instance gives you a time impacted by local settings.
/// Users may do this for a variety of reasons, like being in different timezones, trying to be punctual by setting their clocks 5 – 10 minutes early, etc. Your application or service may want a date that is unaffected by these changes and reliable as a source of truth. TrueTime gives you that.
/// You can read more about the use case in our blog post.
class TrueTime {
  static const MethodChannel _channel = const MethodChannel('true_time');

  /// Returns `true` if TrueTime was initialized.
  /// This function must be called and verified to have returned true before any call to [now] is made.
  static Future<bool> init() async {
    try {
      return await _channel.invokeMethod('init');
    } catch (e) {
      return false;
    }
  }

  /// Returns a `DateTime` representing the current time impervious of device clock time.
  /// Throws an [Error] if TrueTime has not been initialized.
  static Future<DateTime> now() async {
    final int millisecondsSinceEpoch = await _channel.invokeMethod('now');
    return new DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }
}
