//
//  KeyBUnlockManager.h
//  FontKeyBoardExtension
//
//  Created by JOJO on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyBUnlockManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)hasUnlockContentWithContentItemId:(NSString *)contentItemId;
- (void)unlockContentItemWithItemId:(NSString *)contentItemId completion:(void(^)(void))completion;
- (BOOL)isProSVGTempleteWithTempleteName:(NSString *)templeteName;
@end

NS_ASSUME_NONNULL_END
