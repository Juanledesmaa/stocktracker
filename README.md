# Welcome to the StockStracker README 

### Summary: screenshots highlighting some of the app features.

<img src="https://github.com/user-attachments/assets/a4173132-ed8b-4094-85d1-d9680311ae8f" alt="Screenshot_1" width="200">
<img src="https://github.com/user-attachments/assets/52f50ecd-b123-4162-a3d5-c5f678446845" alt="Screenshot_2" width="200">
<img src="https://github.com/user-attachments/assets/7c35d5fd-9d10-46ed-8f39-24d5560c2be0" alt="Screenshot_3" width="200">
<img src="https://github.com/user-attachments/assets/a46a8c36-86e3-4d98-9160-b6730862b04c" alt="Screenshot_4" width="200">

| Feature                | Video |
|-------------------------|-------|
| Home | ![Simulator Screen Recording - iPhone 16 Pro Max - 2025-05-21 at 17 36 32](https://github.com/user-attachments/assets/905a77c7-121b-4379-b16f-63607996b9b5) |
| Favorites and Persistence | ![Simulator Screen Recording - iPhone 16 Pro Max - 2025-05-21 at 17 39 17](https://github.com/user-attachments/assets/41c76e08-0d25-4a64-8a3a-b89bdc1d4680) |
| Theming | ![Simulator Screen Recording - iPhone 16 Pro Max - 2025-05-21 at 17 41 08](https://github.com/user-attachments/assets/1f8f3dc8-acde-4b40-9ae9-59f09f443d32) |
| Mock behaviors | ![Simulator Screen Recording - iPhone 16 Pro Max - 2025-05-21 at 17 42 21](https://github.com/user-attachments/assets/84563e5b-d9a7-4c5b-85d8-006fe8067294) |
| Accessibility Fonts |  ![Dynamicfonts-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/7007e946-d447-44ec-a2a9-8fe654180938) |
| VoiceOverSupport | https://youtube.com/shorts/ep5nbsre2ek |
| Smallest Device (Showcasing dynamyc fonts) | ![Simulator Screen Recording - iPhone SE (3rd generation) - 2025-05-21 at 18 00 13](https://github.com/user-attachments/assets/e9fbd1cd-07a9-485b-a8f4-c3adf9ea622c) |

## 🏗 Architecture Choices

This project follows a modular **MVVM architecture** built for clarity, scalability, and testability.

### 🔧 Key Components

- **ViewModels**
  - `StockListViewModel`, `FavoriteStocksViewModel`
  - Own all business logic and state (`@Published`) for SwiftUI views.

- **Service Abstraction**
  - `StockListServiceProtocol` and `StockListDataSourceProtocol` cleanly separate data-fetching concerns.
  - Dependencies are injected to support mocking and future extension.

- **Protocol-Oriented Design**
  - All core dependencies (`FavoritesManagerProtocol`, `StockListServiceProtocol`) are protocol-based for easy mocking in unit tests.

- **Reusable Sorting Logic**
  - Sorting is extracted into `StockSorter`, ensuring consistent behavior and DRY code across view models.

- ** Unit Testing**
  - `XCTest` coverage for:
    - All `load`, `toggle`, and `sort` paths
    - Edge cases (e.g., early returns, unmatched IDs)
    - Full testable mocks for services and persistence

---

## ✨ Additional Features

- **Mock API Configuration**
  - Simulate different API behaviors (`success`, `empty`, `error`, `longDelay`) via `UserDefaults`.
  - Used in `StockListDataSource` to support testing and offline scenarios.

- **Favorite Stocks**
  - Toggle favorites across stock lists.
  - Favorites are stored using a `FavoritesManager` with file-based persistence.

- **Accessibility**
  - Dynamic font support.
  - VoiceOver-friendly messages for empty and loading states.

- **Haptic Feedback**
  - Toggling a favorite provides haptic confirmation using `UIImpactFeedbackGenerator`.

- **Dynamic Sorting**
  - Users can sort by:
    - Alphabetical naming
    - Price ( Ascending / Descending )
    - 24H Price Change (Ascending / Descending)
  - The sort option is persisted and shared across views.

- **Scalable Design**
  - Easy to add new tabs or data sources due to separation of concerns and protocol abstraction.

