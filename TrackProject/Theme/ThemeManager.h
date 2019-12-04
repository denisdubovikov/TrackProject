//
//  ThemeManager.h
//  TrackProject
//
//  Created by Денис Дубовиков on 02/12/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



NS_SWIFT_NAME(ThemeManager_swift)
@interface ThemeManager : NSObject

//- (void)makeColors;

//@property [[UIDevice currentDevice].systemVersion floatValue];
@property BOOL isDarkModeAvailable;
@property BOOL isDarkModeOn;
@property (nonatomic, readonly, nullable) NSString *readerName;

@property UIColor *textColor;

@property NSString *menuButtonImageName;
@property NSString *buttonAccountImageName;
@property NSString *cameraButtonImageName;


//@property UIColor *

@end

NS_ASSUME_NONNULL_END
