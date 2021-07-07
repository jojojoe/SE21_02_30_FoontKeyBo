//
//  KBNotificationTool.h
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface KBNotificationTool : NSObject
+ (void)sendNotificationForMessageWithIdentifier:(nullable NSString *)identifier userInfo:(nullable NSDictionary *)info;
+ (void)registerForNotificationsWithIdentifier:(nullable NSString *)identifier observerObject:(NSObject *)observerObject actionBlock:(CFNotificationCallback) notificationAction;
+ (void)unregisterForNotificationsWithIdentifier:(nullable NSString *)identifier;
@end
NS_ASSUME_NONNULL_END
