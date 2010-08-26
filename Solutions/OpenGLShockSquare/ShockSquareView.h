//
//  ShockSquareView.h
//  ShockSquare
//
//  Created by Joe Conway on 7/27/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h> 
#import <OpenGLES/ES1/gl.h> 
#import <OpenGLES/ES1/glext.h> 
#import <QuartzCore/QuartzCore.h> 

@class ShockSquareView; 
@protocol ShockSquareViewRenderer <NSObject> 
- (void)renderToView:(ShockSquareView *)view; 
@end 
@interface ShockSquareView : UIView 
{ 
    // OpenGL objects 
    GLuint renderBuffer, frameBuffer; 
    EAGLContext *context; 
    
    // The pixel dimensions of the render buffer 
    GLint backingWidth; 
    GLint backingHeight; 
    
    // The timer that causes the animation 
    NSTimer *animationTimer; 
 
    id<ShockSquareViewRenderer> renderer; 
} 
@property (nonatomic, assign) id<ShockSquareViewRenderer> renderer; 
- (void)startAnimation; 
- (void)stopAnimation; 
- (void)updateGL:(NSTimer *)t; 
- (BOOL)createBuffers; 
- (void)destroyBuffers; 
@end 
