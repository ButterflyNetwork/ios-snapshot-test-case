//
//  FBSnapshotTestCaseOSVersionFormat.h
//  FBSnapshotTestCase iOS
//
//  Created by Vineet Shah on 11/7/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

@import Foundation;

/**
 Specifies the OS version format used in a snapshot filename suffix.

 - FBSnapshotTestCaseOSVersionFormatPatch: Specifies the version number up to the patch, e.g. `10.3.3`.
 - FBSnapshotTestCaseOSVersionFormatMinor: Specifies the version number up to the minor version, e.g. `10.3`.
 - FBSnapshotTestCaseOSVersionFormatMajor: Specifies the version number up to the major version, e.g. `10`.
 */
typedef NS_ENUM(NSUInteger, FBSnapshotTestCaseOSVersionFormat) {
  FBSnapshotTestCaseOSVersionFormatPatch = 0,
  FBSnapshotTestCaseOSVersionFormatMinor,
  FBSnapshotTestCaseOSVersionFormatMajor,
};
