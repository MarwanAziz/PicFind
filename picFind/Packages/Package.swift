// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

let package = Package(
  name: "Packages",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "ApiServices",
      targets: ["ApiServices"]
    )
  ],
  targets: [
    .target(
      name: "ApiServices"
    ),
    .testTarget(
      name: "ApiServicesTest"
    ),
  ]
)
