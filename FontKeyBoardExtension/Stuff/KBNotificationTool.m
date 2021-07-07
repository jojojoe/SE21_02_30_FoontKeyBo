//
//  KBNotificationTool.m
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

#import "KBNotificationTool.h"

@implementation KBNotificationTool

+ (void)registerForNotificationsWithIdentifier:(nullable NSString *)identifier observerObject:(NSObject *)observerObject actionBlock:(CFNotificationCallback) notificationAction {
    [self unregisterForNotificationsWithIdentifier:identifier];

    CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
    CFStringRef str = (__bridge CFStringRef)identifier;
    
    CFNotificationCenterAddObserver(center,
                                    (__bridge const void *)(observerObject),
                                    notificationAction,
                                    str,
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}


+ (void)unregisterForNotificationsWithIdentifier:(nullable NSString *)identifier {
    CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
    CFStringRef str = (__bridge CFStringRef)identifier;
    CFNotificationCenterRemoveObserver(center,
                                       (__bridge const void *)(self),
                                       str,
                                       NULL);
}


+ (void)sendNotificationForMessageWithIdentifier:(nullable NSString *)identifier userInfo:(nullable NSDictionary *)info {
    CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
    CFDictionaryRef userInfo = (__bridge CFDictionaryRef)info;
    BOOL const deliverImmediately = YES;
    CFStringRef identifierRef = (__bridge CFStringRef)identifier;
    CFNotificationCenterPostNotification(center, identifierRef, NULL, userInfo, deliverImmediately);
}

 
//

@end
