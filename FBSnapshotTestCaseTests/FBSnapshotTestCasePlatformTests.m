//
//  FBSnapshotTestCasePlatformTests.m
//  FBSnapshotTestCase
//
//  Created by Anton Domashnev on 05/05/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

@import XCTest;
@import UIKit;

#import <OCMock/OCMock.h>

#import "FBSnapshotTestCasePlatform.h"
#import "FBSnapshotTestCaseOSVersionFormat.h"

@interface FBSnapshotTestCasePlatformTests : XCTestCase

@end

@implementation FBSnapshotTestCasePlatformTests

- (void)testAgnosticNormalizedFileNameShouldReturnFileNameWithModelNameIfModelNameOptionPresented {
  UIDevice *currentDeviceMock = OCMPartialMock([UIDevice new]);
  id deviceMock = OCMClassMock([UIDevice class]);
  OCMStub([deviceMock currentDevice]).andReturn(currentDeviceMock);
  OCMStub([currentDeviceMock model]).andReturn(@"iPhone");
  
  NSString *normalizedFileName = FBAgnosticNormalizedFileName(@"testFileName",
                                                              FBSnapshotTestCaseAgnosticnessOptionDeviceModel,
                                                              FBSnapshotTestCaseOSVersionFormatPatch);
  
  XCTAssertTrue([normalizedFileName hasSuffix:@"_iPhone"]);
  
  [deviceMock stopMocking];
}

- (void)testAgnosticNormalizedFileNameShouldReturnFileNameWithPatchOSIfOSOptionPresented {
  UIDevice *currentDeviceMock = OCMPartialMock([UIDevice new]);
  id deviceMock = OCMClassMock([UIDevice class]);
  OCMStub([deviceMock currentDevice]).andReturn(currentDeviceMock);
  OCMStub([currentDeviceMock systemVersion]).andReturn(@"4.0.3");

  NSString *normalizedFileName = FBAgnosticNormalizedFileName(@"testFileName",
                                                              FBSnapshotTestCaseAgnosticnessOptionOSVersion,
                                                              FBSnapshotTestCaseOSVersionFormatPatch);

  XCTAssertTrue([normalizedFileName hasSuffix:@"_4_0_3"]);

  [deviceMock stopMocking];
}

- (void)testAgnosticNormalizedFileNameShouldReturnFileNameWithMinorOSIfOSOptionPresented {
  UIDevice *currentDeviceMock = OCMPartialMock([UIDevice new]);
  id deviceMock = OCMClassMock([UIDevice class]);
  OCMStub([deviceMock currentDevice]).andReturn(currentDeviceMock);
  OCMStub([currentDeviceMock systemVersion]).andReturn(@"4.0.3");

  NSString *normalizedFileName = FBAgnosticNormalizedFileName(@"testFileName",
                                                              FBSnapshotTestCaseAgnosticnessOptionOSVersion,
                                                              FBSnapshotTestCaseOSVersionFormatMinor);

  XCTAssertTrue([normalizedFileName hasSuffix:@"_4_0"]);

  [deviceMock stopMocking];
}

- (void)testAgnosticNormalizedFileNameShouldReturnFileNameWithMajorOSIfOSOptionPresented {
  UIDevice *currentDeviceMock = OCMPartialMock([UIDevice new]);
  id deviceMock = OCMClassMock([UIDevice class]);
  OCMStub([deviceMock currentDevice]).andReturn(currentDeviceMock);
  OCMStub([currentDeviceMock systemVersion]).andReturn(@"4.0.3");

  NSString *normalizedFileName = FBAgnosticNormalizedFileName(@"testFileName",
                                                              FBSnapshotTestCaseAgnosticnessOptionOSVersion,
                                                              FBSnapshotTestCaseOSVersionFormatMajor);

  XCTAssertTrue([normalizedFileName hasSuffix:@"_4"]);

  [deviceMock stopMocking];
}

- (void)testAgnosticNormalizedFileNameShouldReturnFileNameWithScreenSizeIfScreenSizeOptionPresented {
  NSString *normalizedFileName = FBAgnosticNormalizedFileName(@"testFileName",
                                                              FBSnapshotTestCaseAgnosticnessOptionScreenSize,
                                                              FBSnapshotTestCaseOSVersionFormatPatch);
  
  XCTAssertTrue([normalizedFileName hasSuffix:@"_0x0"]);
}

- (void)testAgnosticNormalizedFileNameShouldReturnFileNameWithLocalizationIdentifierIfLocalizationOptionPresented {
  NSUserDefaults *defaults = OCMPartialMock([NSUserDefaults new]);
  id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
  OCMStub([userDefaultsMock standardUserDefaults]).andReturn(defaults);
  [defaults setObject:@[@"ru-RU"] forKey:@"AppleLanguages"];
  
  NSString *normalizedFileName = FBAgnosticNormalizedFileName(@"testFileName",
                                                              FBSnapshotTestCaseAgnosticnessOptionLocalization,
                                                              FBSnapshotTestCaseOSVersionFormatPatch);
  
  XCTAssertTrue([normalizedFileName hasSuffix:@"_ru_RU"]);
  
  [userDefaultsMock stopMocking];
}

- (void)testAgnosticNormalizedFileNameShouldReturnFileNameWithAllProvidedOptions {
  UIDevice *currentDeviceMock = OCMPartialMock([UIDevice new]);
  id deviceMock = OCMClassMock([UIDevice class]);
  OCMStub([deviceMock currentDevice]).andReturn(currentDeviceMock);
  OCMStub([currentDeviceMock model]).andReturn(@"iPhone");
  OCMStub([currentDeviceMock systemVersion]).andReturn(@"4.0");
  
  NSUserDefaults *defaults = OCMPartialMock([NSUserDefaults new]);
  id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
  OCMStub([userDefaultsMock standardUserDefaults]).andReturn(defaults);
  [defaults setObject:@[@"ru-RU"] forKey:@"AppleLanguages"];
  
  NSString *normalizedFileName = FBAgnosticNormalizedFileName(@"testFileName",
                                                              (FBSnapshotTestCaseAgnosticnessOption)(FBSnapshotTestCaseAgnosticnessOptionOSVersion | FBSnapshotTestCaseAgnosticnessOptionScreenSize | FBSnapshotTestCaseAgnosticnessOptionDeviceModel | FBSnapshotTestCaseAgnosticnessOptionLocalization),
                                                              FBSnapshotTestCaseOSVersionFormatPatch);
  
  XCTAssertTrue([normalizedFileName hasSuffix:@"_iPhone4_0_0x0_ru_RU"]);
  
  [deviceMock stopMocking];
  [userDefaultsMock stopMocking];
}

@end
