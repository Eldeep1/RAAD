# RAAD — iOS Weather App

> **RAAD** (رَعْد, Arabic for *thunder*) is a native iOS weather application built with Swift and SwiftUI. It delivers real-time weather data, a 3-day hourly forecast, city search, and a favourites system — all wrapped in a polished, time-aware UI that automatically switches between a light morning theme and a dark evening theme.

---

## Features

### 🌤 Dashboard
- Displays the **current weather** for the device's GPS location (city, country, date, temperature, condition)
- **3-day forecast** rows — tap any day to open the detailed hourly view
- **Weather metrics grid**: humidity, pressure, visibility, feels-like temperature
- Auto-refreshes data on every app launch

### 📅 Weather Details
- **Hourly forecast selector** — a horizontal scrollable card strip
- Opening **today** automatically highlights the card matching the current clock hour
- Opening **future days** starts with no card selected (tap any card to reveal details)
- Per-hour summary card: temperature, condition, rain chance
- Metrics grid: humidity, wind speed, pressure, rain chance

### 🔍 Search & Favourites
- **Live city search** powered by the WeatherAPI autocomplete endpoint, with a 400 ms debounce to minimise API calls
- **Recent searches** chips (up to 5, stored in `UserDefaults`) for quick re-access
- **Saved Locations** section showing live weather cards for each favourite:
  - City name, local time with timezone abbreviation (e.g. `15:42 • BST`)
  - Condition with icon, temperature, daily High / Low
- Empty state message when no favourites have been saved yet
- **Edit mode** — reveals a delete button per card; tapping it shows a confirmation alert before removing the city
- Tapping a search result or a saved card navigates to a **City Weather** screen

### 🏙 City Weather
- Identical layout to the Dashboard (current conditions, forecast, metrics)
- **Heart toggle** (♡ / ♥) in the navigation bar — adds or removes the city from Core Data favourites with a spring animation
- Heart state persists across app launches

### 🎨 Adaptive Theme
- **Morning theme** (before 18:00): white background, `systemGray6` cards, black primary text
- **Evening theme** (18:00+): deep navy background, translucent white cards, white primary text
- Accent colour: **cyan** in both themes
- Tab bar background, selected/unselected icon colours, and all view layers react to the active theme
- `ThemeManager` is an `ObservableObject` injected as an `@EnvironmentObject` at the root

---

## Architecture

RAAD follows a clean, layered **MVVM + Repository** architecture:

```
┌─────────────────────────────────────────────────┐
│                  Presentation                   │
│  Views (SwiftUI)  ←→  ViewModels (@MainActor)   │
└──────────────────────┬──────────────────────────┘
                       │ protocols
┌──────────────────────▼──────────────────────────┐
│                   Domain / Data                 │
│  Repositories  ←→  Models  ←→  Remote/Local DS  │
└─────────────────────────────────────────────────┘
```

| Layer | Responsibility |
|---|---|
| **Views** | SwiftUI views; read state from ViewModels via `@StateObject` / `@EnvironmentObject` |
| **ViewModels** | `@MainActor ObservableObject`; orchestrate async data loading, expose `@Published` state |
| **Repositories** | Protocol-based; map raw DTOs to clean domain models |
| **Remote Data Source** | `URLSession`-backed; maps `Endpoint` enum cases to real API URLs |
| **Local Data Source** | Core Data — `FavouriteLocationRepository` wraps `NSManagedObjectContext` |
| **DI Container** | `DIContainer.shared` constructs and wires all dependencies |

---

## Project Structure

```
RAAD/
├── DI/
│   └── DIContainer.swift
├── Data/
│   ├── Models/
│   │   ├── WeatherModel.swift
│   │   ├── ForecastModel.swift
│   │   ├── ForecastResult.swift          # hourlyForecastByDay: [[HourlyForecastModel]]
│   │   ├── HourlyForecastModel.swift
│   │   ├── SearchResultModel.swift
│   │   └── FavouriteWeatherModel.swift
│   ├── Remote/
│   │   ├── Networking/
│   │   │   ├── APIConstants.swift        # Base URL + API key from xcconfig
│   │   │   ├── Endpoints.swift           # current / forecast / search
│   │   │   └── NetworkManager.swift      # Generic URLSession + JSON decoding
│   │   ├── DTOs/
│   │   │   ├── CurrentWeatherResponse.swift
│   │   │   ├── ForecastResponse.swift    # Includes location, max/min temps
│   │   │   ├── HoursDTO.swift
│   │   │   └── SearchResultDTO.swift
│   │   └── WeatherRemoteDataSource.swift
│   ├── Local/
│   │   ├── FavouriteLocation+CoreDataClass.swift
│   │   └── FavouriteLocationRepository.swift
│   └── Repositories/
│       └── WeatherRepository.swift
├── Presentation/
│   ├── Dashboard/
│   │   ├── View/
│   │   │   ├── DashboardView.swift
│   │   │   └── Components/
│   │   │       ├── HeaderView.swift
│   │   │       ├── CurrentWeatherView.swift
│   │   │       ├── ForecastSection.swift
│   │   │       └── WeatherMetricsGrid.swift
│   │   └── ViewModel/
│   │       └── DashboardViewModel.swift
│   ├── WeatherDetails/
│   │   ├── View/
│   │   │   ├── WeatherDetailsView.swift
│   │   │   └── Components/
│   │   │       ├── HourCard.swift
│   │   │       ├── HourSelectorView.swift
│   │   │       ├── WeatherSummaryCard.swift
│   │   │       └── WeatherDetailsMetricsGrid.swift
│   │   └── ViewModel/
│   │       └── WeatherDetailsViewModel.swift
│   └── Search/
│       ├── View/
│       │   ├── SearchView.swift           # Search bar, chips, saved locations
│       │   └── CityWeatherView.swift      # Dashboard-style + heart toggle
│       └── ViewModel/
│           ├── SearchViewModel.swift
│           └── CityWeatherViewModel.swift
├── Utils/
│   ├── Theme/
│   │   ├── AppTheme.swift
│   │   ├── ThemeColors.swift
│   │   └── ThemeManager.swift
│   ├── Location/
│   │   └── LocationService.swift
│   └── Collection+SafeSubscript.swift
├── RAAD.xcdatamodeld/                    # Core Data model (FavouriteLocation entity)
├── Config.xcconfig                        # WEATHER_API_KEY
└── ContentView.swift                      # TabView root (Home + Search tabs)
```

---

## API Integration

RAAD uses the **[WeatherAPI.com](https://www.weatherapi.com)** REST API.

| Endpoint | Used for |
|---|---|
| `GET /current.json?q={lat,lon}` | Dashboard & City Weather current conditions |
| `GET /forecast.json?q={lat,lon}&days=3` | 3-day daily + hourly forecast; includes `location.localtime`, `location.tz_id`, `day.maxtemp_c`, `day.mintemp_c` |
| `GET /search.json?q={query}` | City autocomplete in the Search screen |

### API Key Setup

The API key is stored in `Config.xcconfig` and injected into `Info.plist` at build time — it is **never** hard-coded in source files.

```
// Config.xcconfig
WEATHER_API_KEY = your_api_key_here
```

---

## Data Persistence

### Core Data — Favourites

The `FavouriteLocation` entity stores saved cities with these attributes:

| Attribute | Type | Notes |
|---|---|---|
| `cityName` | String | Used as the lookup key |
| `country` | String | |
| `latitude` | Double | Used to re-fetch live weather |
| `longitude` | Double | |
| `addedAt` | Date | List sorted descending by this |

`FavouriteLocationRepository` provides:

```swift
favouriteRepo.add(cityName:country:latitude:longitude:)
favouriteRepo.remove(cityName:)
favouriteRepo.isFavourite(cityName:) -> Bool
favouriteRepo.fetchAll()            -> [FavouriteLocation]
```

### UserDefaults — Recent Searches

The last 5 searched city names are stored as `[String]` under the key `"recentSearches"` and appear as tappable chips below the search bar.

---

## Requirements

| Requirement | Version |
|---|---|
| iOS | 15.2+ |
| Xcode | 14+ |
| Swift | 5.7+ |
| WeatherAPI.com account | Free tier sufficient |

---

## Getting Started

```bash
# 1. Clone the repository
git clone <repo-url>
cd "RAAD/RAAD"

# 2. Open in Xcode
open RAAD.xcodeproj

# 3. Set your API key in RAAD/Config.xcconfig
WEATHER_API_KEY = your_api_key_here

# 4. Select a simulator and run (⌘R)
#    Or build from the command line:
xcodebuild build \
  -scheme RAAD \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -project RAAD.xcodeproj
```

> **Location Permission** — On first launch, the app requests *When In Use* location access to load weather for your current position. Grant permission in the simulator prompt or in Settings → Privacy → Location Services.

---

## Key Design Decisions

### Time-aware Theming
Rather than mirroring the system light/dark mode setting, RAAD uses its own **hour-based theme**. This creates a visual connection between the app's appearance and the real time of day. `ThemeManager.updateTheme()` checks the current hour at init and switches automatically at 18:00.

### Per-day Hourly Forecasts
The WeatherAPI `/forecast.json` response contains a `forecastday` array, each with its own `hour` array. RAAD maps these into `[[HourlyForecastModel]]` indexed by day, so tapping **Day 1** on the forecast list shows Day 1's 24 hours, tapping **Day 2** shows Day 2's — rather than always showing today's hours (the original bug this fixed).

### Current-hour Auto-selection
On the Weather Details screen for **today**, the app automatically highlights the card whose `HH` component matches `Calendar.current.component(.hour, from: Date())`. For future days the selector starts empty, inviting the user to explore freely.

### Favourite Local Times
When building `FavouriteWeatherModel` for the saved locations list, the repository concurrently fetches current weather and a 1-day forecast (which includes `location.localtime` and `location.tz_id`). It converts the raw timestamp to the city's local time and derives the timezone abbreviation (`BST`, `JST`, `EDT`, etc.) using Swift's `TimeZone(identifier:)`.

### Protocol-based Dependencies
Every repository and data source is hidden behind a protocol. `DIContainer` resolves concrete types at the composition root. This keeps ViewModels testable and swappable without touching call sites.

---