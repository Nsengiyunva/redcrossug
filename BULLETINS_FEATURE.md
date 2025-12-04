# Headquarters Bulletins Feature

## Overview

This feature enables the Red Cross Uganda mobile app to receive and display official bulletins, announcements, events, and alerts from headquarters.

## Implementation Summary

### 1. Models (`lib/models/bulletin.dart`)

- **Bulletin**: Main model with all bulletin fields
- **BulletinCategory**: Enum for categories (Blood Donation, Disaster Management, First Aid)
- **BulletinSubtype**: Enum for 19 different subtypes with automatic priority and field requirements
- **BulletinUser**: Author information
- **BulletinTag**: Tags for categorization

### 2. Controller (`lib/controllers/bulletins_controller.dart`)

- Fetches bulletins from API with pagination
- Supports filtering by category
- Provides helper methods for:
  - Getting urgent bulletins (critical priority)
  - Getting upcoming events
  - Getting bulletins by subtype

### 3. UI Screens

#### Bulletins List (`lib/scenes/bulletins/bulletins_list.dart`)

- Displays all published bulletins
- Category filter chips (All, Blood Donation, Disasters, First Aid)
- Pull-to-refresh functionality
- Infinite scroll with pagination
- Shows appropriate badges for category, subtype, and priority
- Visual indicators for:
  - Featured images
  - Event dates and locations
  - Priority/urgency levels

#### Bulletin Detail (`lib/scenes/bulletins/bulletin_detail.dart`)

- Full bulletin display with WebView for rich HTML content
- Conditional sections based on subtype:
  - **Event fields**: Date, location, capacity, registration
  - **Emergency fields**: Severity, affected area, required actions
  - **Contact fields**: Contact person, phone, email, deadlines
- Tags display
- Actionable links (registration URLs, phone numbers, emails)
- Responsive to different bulletin types

### 4. Home Screen Integration (`lib/scenes/default_home.dart`)

- Dynamic bulletin card showing:
  - Latest upcoming event, or
  - Most recent bulletin, or
  - Placeholder with link to all bulletins
- Auto-updates when new bulletins are fetched
- Tap to view full bulletin details
- Smart date formatting (Today, Tomorrow, In X days)

## API Endpoints

- `GET /api/bulletins` - List bulletins (paginated)
- `GET /api/bulletins?category=blood_donation` - Filter by category
- `GET /api/bulletins/{id}` - Get bulletin details

## Bulletin Categories

1. **Blood Donation** - Blood drives, shortages, donation campaigns
2. **Disaster Management** - Emergency alerts, disaster updates, relief efforts
3. **First Aid** - Training, health tips, safety advisories

## Bulletin Subtypes (19 types)

### General Communication

- Notice, Announcement, Alert, Update

### Events & Activities

- Event, Campaign, Training

### Requests & Appeals

- Urgent Request, Volunteer Call, Donation Appeal

### Emergencies & Disasters

- Emergency Alert, Safety Advisory, Disaster Update

### Health & Medical

- Health Tip, Medical Notice, Blood Shortage

### Administrative

- Policy Update, Service Notice, Report

## Features

✅ Category-based filtering
✅ Pagination support
✅ Pull-to-refresh
✅ Priority badges for urgent bulletins
✅ Rich HTML content rendering
✅ Event registration links
✅ Emergency alert sections
✅ Contact information with callable links
✅ Image support
✅ Tag system
✅ Responsive design
✅ Offline-friendly (caches loaded bulletins)

## Usage Flow

1. User opens app → sees latest bulletin on home screen
2. User taps bulletin card → views full details
3. User navigates to Bulletins List → browses all bulletins
4. User filters by category → sees specific bulletins
5. User scrolls down → automatically loads more bulletins
6. User pulls to refresh → fetches latest bulletins

## Dependencies

- `get` - State management
- `http` - API communication
- `webview_flutter` - HTML content rendering
- `url_launcher` - Opening external links
- `intl` - Date formatting

## Testing

To test the feature:

1. Ensure backend is running with bulletin data
2. Launch the app
3. Check home screen for bulletin card
4. Tap to view bulletin details
5. Navigate to full bulletins list
6. Test filtering by categories
7. Test pagination by scrolling
8. Test pull-to-refresh

## Backend Integration

The feature integrates with the Laravel backend's bulletin system which includes:

- User authentication (Sanctum)
- Published bulletin filtering
- Category-based queries
- Pagination
- Rich HTML body content
- Multiple conditional fields based on bulletin subtype
