#import <Foundation/Foundation.h>

@interface LivenessDetector : NSObject

- (int)loadModel:(NSString *)modelPath configPath:(NSString *)configPath;
- (float)detectLiveness:(NSData *)yuvData 
                  width:(int)width 
                 height:(int)height 
            orientation:(int)orientation 
                   left:(int)left 
                    top:(int)top 
                  right:(int)right 
                 bottom:(int)bottom;
- (void)destroy;

@end
