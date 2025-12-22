# Firebase Push Notification Service

## Overview
This service handles all Firebase Cloud Messaging (FCM) functionality for the Crescent Charge app, including receiving, displaying, and handling push notifications.

## Features
- ✅ FCM token generation and management
- ✅ Foreground notification handling (app is open)
- ✅ Background notification handling (app is minimized)
- ✅ Terminated state handling (app is closed)
- ✅ Local notification display
- ✅ Notification permission requests
- ✅ Custom notification navigation
- ✅ Topic subscription support

## Architecture

### Files
- **`firebase_notification_service.dart`**: Main notification service (singleton pattern)
- **`main.dart`**: Service initialization

### Service Flow
```
App Launch → Firebase Init → Request Permissions → Get Token → Setup Handlers
```

## Implementation Details

### 1. Service Initialization
The service is initialized in `main.dart` before the app runs:

```dart
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
await FirebaseNotificationService.instance.initialize();
```

### 2. Notification States

#### Foreground (App is Open)
- Notification is intercepted by `FirebaseMessaging.onMessage`
- Displayed as local notification using Flutter Local Notifications
- User can tap to navigate

#### Background (App is Minimized)
- Handled by `FirebaseMessaging.onMessageOpenedApp`
- Automatically displays notification (system tray)
- Tap opens app and navigates

#### Terminated (App is Closed)
- Handled by top-level function `firebaseMessagingBackgroundHandler`
- Displays notification
- Tap opens app and navigates via `getInitialMessage()`

### 3. Token Management

**Get Token:**
```dart
String? token = await FirebaseNotificationService.instance.getToken();
// Send this token to your backend to enable push notifications
```

**Token Refresh Listener:**
```dart
FirebaseNotificationService.instance.onTokenRefresh((newToken) {
  // Send updated token to backend
  print('New token: $newToken');
});
```

**Delete Token (on logout):**
```dart
await FirebaseNotificationService.instance.deleteToken();
```

### 4. Custom Navigation

Notifications can include custom data for navigation:

**Backend Payload Example:**
```json
{
  "notification": {
    "title": "New Reward Available!",
    "body": "You've earned 100 points"
  },
  "data": {
    "type": "reward",
    "route": "/rewards/details",
    "id": "123"
  }
}
```

**Navigation Logic:**
The service checks `data.route` or `data.type` to navigate:
- If `route` exists → navigates directly
- If `type` exists → navigates based on predefined routes

### 5. Topic Subscriptions

Subscribe users to notification topics:

```dart
// Subscribe to general updates
await FirebaseNotificationService.instance.subscribeToTopic('all_users');

// Subscribe to donation updates
await FirebaseNotificationService.instance.subscribeToTopic('donations');

// Unsubscribe
await FirebaseNotificationService.instance.unsubscribeFromTopic('all_users');
```

## Usage Examples

### Send Token to Backend on Login
```dart
class LoginController extends GetxController {
  Future<void> login() async {
    // ... login logic
    
    // After successful login, send FCM token
    final fcmToken = await FirebaseNotificationService.instance.getToken();
    if (fcmToken != null) {
      await apiService.updateUserFcmToken(fcmToken);
    }
  }
}
```

### Handle Token Refresh
```dart
class AppController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    
    // Listen for token refresh
    FirebaseNotificationService.instance.onTokenRefresh((newToken) {
      apiService.updateUserFcmToken(newToken);
    });
  }
}
```

### Delete Token on Logout
```dart
class LogoutController extends GetxController {
  Future<void> logout() async {
    // Delete FCM token
    await FirebaseNotificationService.instance.deleteToken();
    
    // ... rest of logout logic
  }
}
```

## Testing Push Notifications

### 1. Get FCM Token
Run the app and check debug console for:
```
FCM Token: <your-device-token>
```

### 2. Send Test Notification

**Using Firebase Console:**
1. Go to Firebase Console → Cloud Messaging
2. Click "Send your first message"
3. Enter title and body
4. Click "Send test message"
5. Paste your FCM token
6. Send

**Using curl:**
```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "DEVICE_FCM_TOKEN",
    "notification": {
      "title": "Test Notification",
      "body": "This is a test"
    },
    "data": {
      "type": "test",
      "route": "/home"
    }
  }'
```

### 3. Test Different States
- **Foreground**: App open → Should show local notification
- **Background**: App minimized → Should show system notification
- **Terminated**: App closed → Should show notification, open app on tap

## Backend Integration

### Sending Notifications from Backend

**Example (Node.js):**
```javascript
const admin = require('firebase-admin');

// Send to specific device
await admin.messaging().send({
  token: userFcmToken,
  notification: {
    title: 'New Donation',
    body: 'You donated $10 to Save the Ocean'
  },
  data: {
    type: 'donation',
    donationId: '123',
    route: '/donations/123'
  }
});

// Send to topic
await admin.messaging().send({
  topic: 'all_users',
  notification: {
    title: 'App Update',
    body: 'New features available!'
  }
});
```

## Android Configuration

**Already configured in:**
- `android/app/build.gradle` - Google Services plugin
- `android/app/google-services.json` - Firebase config

## iOS Configuration

**Required steps:**
1. Add `GoogleService-Info.plist` to `ios/Runner/`
2. Enable Push Notifications capability in Xcode
3. Upload APNs certificate to Firebase Console

## Troubleshooting

### No Token Generated
- Check internet connection
- Verify Firebase configuration
- Check Google Services JSON/plist files

### Notifications Not Showing
- Check notification permissions
- Verify FCM token sent to backend
- Check Firebase Console for delivery status

### Navigation Not Working
- Verify route names match app routes
- Check payload data structure
- Review debug logs for navigation attempts

## Security Considerations
- Never expose server keys in client code
- Store FCM tokens securely in backend
- Validate notification payloads on backend
- Use Firebase Security Rules appropriately

## Future Enhancements
- [ ] Add notification categories
- [ ] Implement notification badges
- [ ] Add rich media support (images)
- [ ] Implement notification actions (buttons)
- [ ] Add notification scheduling
- [ ] Track notification analytics

---

**Last Updated:** December 22, 2025
**Version:** 1.0.0
