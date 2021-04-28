//#import <Flutter/Flutter.h>
#import <FlutterMacOS/FlutterMacOS.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(macos(10.15))
@interface AppleIDButton : NSObject <FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger ;

- (UIView*)view;
@end

NS_ASSUME_NONNULL_END
