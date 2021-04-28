#import <Foundation/Foundation.h>
#import <AuthenticationServices/AuthenticationServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface CredentialConverter : NSObject

+ (NSDictionary*)dictionaryFromAppleIDCredential:(ASAuthorizationAppleIDCredential*)credential API_AVAILABLE(macos(10.15));
+ (NSString*)stringForCredentialState:(ASAuthorizationAppleIDProviderCredentialState)credentialState API_AVAILABLE(macos(10.15));

@end

NS_ASSUME_NONNULL_END
