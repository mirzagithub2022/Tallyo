<h1 align="center">Tallyo</h1>

<p align="center">
  A clean, tactile tap counter for iOS, built with SwiftUI and MVVM.
</p>

<p align="center">
  <img alt="Platform" src="https://img.shields.io/badge/platform-iOS%2016%2B-blue">
  <img alt="Swift" src="https://img.shields.io/badge/Swift-5.9-orange">
  <img alt="UI" src="https://img.shields.io/badge/UI-SwiftUI-informational">
  <img alt="Architecture" src="https://img.shields.io/badge/architecture-MVVM-success">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-lightgrey">
</p>

---

## Overview

**Tallyo** is a minimal counting app centered on one large, circular tap target. Tap to count up, pick a target limit, and watch a progress ring fill as you approach it. Haptic feedback makes every tap feel responsive, and a one-tap reset gets you ready for the next round.

The project is intentionally small and serves as a clear reference for structuring a SwiftUI app with the MVVM pattern.

## Features

- **Tap to count:** a large circular button increments the counter.
- **Selectable limits:** choose 30, 60, 90 or 100 from a segmented control.
- **Progress ring:** visual feedback showing how close you are to the limit.
- **Limit protection:** the button disables and changes color when the limit is reached.
- **Smart clamping:** lowering the limit below the current count adjusts the count to fit.
- **One-tap reset:** return the counter to zero instantly.
- **Haptic feedback:** distinct haptics for tapping, reaching the limit and resetting.
- **Accessibility:** VoiceOver labels and hints on the main control.
- **Unit tested:** view model logic is covered by XCTest.

## Requirements

| Tool  | Version |
|-------|---------|
| Xcode | 15.0+   |
| iOS   | 16.0+   |
| Swift | 5.9+    |

## Getting Started

This repository contains the source files. To run them:

1. Clone the repository:
   ```bash
   git clone https://github.com/mirzagithub2022/Tallyo.git
   ```
2. In Xcode, create a new project: **File > New > Project > iOS > App**.
   - Product Name: `Tallyo`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Check **Include Tests** if you want to run the unit tests.
3. Delete the template `TallyoApp.swift` and `ContentView.swift` that Xcode generated.
4. Drag the `Tallyo/` source folder (App, Models, ViewModels, Views) into your project, with **Copy items if needed** checked.
5. Replace the generated test file with `TallyoTests/TallyoViewModelTests.swift`.
6. Select an iPhone simulator or device and press **Cmd + R**.

## Architecture

Tallyo follows **MVVM** (Model, View, ViewModel) with a strict separation of concerns:

| Layer     | Type             | Responsibility |
|-----------|------------------|----------------|
| Model     | `TallyoLimit`    | Defines the allowed counting limits. |
| ViewModel | `TallyoViewModel`| Holds state (`count`, `limit`) and logic (`increment`, `reset`, `progress`). No UI code. |
| View      | `TallyoView`     | Renders state and forwards user actions to the view model. |

The view observes the view model through `@StateObject` and `@Published`, so any state change re-renders the UI automatically. Keeping the logic out of the view makes it easy to unit test.

## Project Structure

```
Tallyo/
├── Tallyo/
│   ├── App/
│   │   └── TallyoApp.swift
│   ├── Models/
│   │   └── TallyoLimit.swift
│   ├── ViewModels/
│   │   └── TallyoViewModel.swift
│   └── Views/
│       ├── TallyoView.swift
│       └── TallyoPressStyle.swift
├── TallyoTests/
│   └── TallyoViewModelTests.swift
├── .gitignore
├── LICENSE
└── README.md
```

## Testing

Run the unit tests in Xcode with **Cmd + U**. They cover incrementing, limit enforcement, reset, count clamping when the limit is lowered, and progress calculation.

## Roadmap

- [ ] Persist the count and selected limit across launches
- [ ] Custom limit input
- [ ] Light and dark theme options
- [ ] Sound effects toggle
- [ ] Home Screen widget

## Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m "Add your feature"`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a pull request

Please keep changes consistent with the existing MVVM structure and include tests for new view model logic.

## License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for details.

## Author

**[Mirza Hasan]**: [GitHub](https://github.com/<your-username>)
