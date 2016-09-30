#import <Foundation/Foundation.h>

@interface NSString (RemoveEmoji)
/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)isIncludingEmoji;

/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)removedEmojiString;

@end
