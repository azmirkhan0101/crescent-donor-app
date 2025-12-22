# Notification Page Integration

## Overview
The notification page is fully integrated with `GetNotificationsController` to display real-time notifications from the backend API while preserving the existing design.

## Features

### 1. **Category Filter (Reactive)**
- **Categories**: All, Impact, Rewards, Donations, Campaigns, System
- Wrapped with `Obx` for reactive updates
- Filters notifications based on selected category
- Category-to-type mapping:
  - **Impact**: donation_success, scheduled_donation, donation_failed
  - **Rewards**: new_reward, reward_claimed
  - **Donations**: donation_success, scheduled_donation
  - **Campaigns**: campaign, new_campaign
  - **System**: system, alert

### 2. **Time-Based Grouping**
Notifications are automatically grouped into:
- **Today**: Notifications from current day
- **Yesterday**: Notifications from previous day
- **This Week**: Notifications from current week (excluding today/yesterday)
- **Older**: All older notifications

### 3. **Pull-to-Refresh**
- Swipe down to refresh notification list
- Calls `refreshNotifications()` method

### 4. **Real-time Data**
- Fetches notifications on page load via `initState()`
- Uses `GetNotificationsController.fetchNotifications(refresh: true)`
- Reactive UI updates when data changes

### 5. **Notification States**
- **Unread**: Shows red dot indicator
- **Alert**: Red background for failed/alert types
- **Different Icons**: Based on notification type (campaigns, impact, donations, rewards, system)

## Data Flow

```
NotificationsPage
    ↓
GetNotificationsController.fetchNotifications()
    ↓
API: /notification/me
    ↓
NotificationModel (List)
    ↓
Filter by Category (if not "All")
    ↓
Group by Time (Today, Yesterday, This Week, Older)
    ↓
Display UI
```

## Key Methods

### `_getFilteredNotifications()`
Filters notifications based on selected category using type mapping.

### `_groupNotificationsByTime(List<NotificationModel>)`
Groups filtered notifications into time-based sections.

### `_formatTimestamp(DateTime)`
Formats timestamp as:
- `Xm ago` (< 1 hour)
- `Xh ago` (< 24 hours)
- `Yesterday • HH:MM PM` (yesterday)
- `DD MMM YYYY • HH:MM PM` (older)

### `_getNotificationType(String)`
Maps backend notification type string to `NotificationType` enum.

## Preserved Design Elements
✅ Category filter chips with active state  
✅ Time-based section headers  
✅ Notification card design (icon, title, message, timestamp)  
✅ Red dot for unread notifications  
✅ Red background for alerts/failures  
✅ Icon colors based on type  
✅ Empty state UI  

## State Management
- **Controller**: `GetNotificationsController` (GetX)
- **Observables**:
  - `selectedCategoryIndex` - Current active category
  - `notificationController.notifications` - Notification list
  - `notificationController.isLoading` - Loading state

## Integration Checklist
✅ Import `GetNotificationsController`  
✅ Import `NotificationModel`  
✅ Initialize controller in `initState()`  
✅ Call `fetchNotifications(refresh: true)`  
✅ Reactive category filter with `Obx`  
✅ Filter notifications by category  
✅ Group notifications by time  
✅ Display with existing design  
✅ Handle loading/empty states  
✅ Zero lint errors  

## Usage
No configuration needed. The page automatically:
1. Initializes controller on load
2. Fetches notifications from API
3. Groups and displays them reactively
4. Allows filtering by category
5. Supports pull-to-refresh

## Dependencies
- `GetNotificationsController`: API integration and state management
- `NotificationModel`: Data model for notifications
- GetX: Reactive state management (`Obx`, `.obs`)
