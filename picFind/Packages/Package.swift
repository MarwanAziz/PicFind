// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Packages",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "ApiServices",
      targets: ["ApiServices"]
    ),
    .library(
      name: "AppStorage",
      targets: ["AppStorage"]
    ),
    .library(
      name: "DataManager",
      targets: ["DataManager"]
    )
  ],
  targets: [
    .target(
      name: "ApiServices"
    ),
    .testTarget(
      name: "ApiServicesTest",
      dependencies: ["ApiServices"]
    ),
    .target(
      name: "AppStorage"
    ),
    .testTarget(
      name: "AppStorageTest",
      dependencies: ["AppStorage"]
    ),
    .target(
      name: "DataManager",
      dependencies: ["ApiServices", "AppStorage"]
    ),
    .testTarget(
      name: "DataManagerTest",
      dependencies: ["DataManager", "ApiServices", "AppStorage"]
    )
  ]
)
