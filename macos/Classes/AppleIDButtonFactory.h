//#import <Flutter/Flutter.h>
#import <FlutterMacOS/FlutterMacOS.h>
#import <Foundation/Foundation.h>
#import "AppleIDButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppleIDButtonFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

NS_ASSUME_NONNULL_END
