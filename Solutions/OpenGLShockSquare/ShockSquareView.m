//
//  ShockSquareView.m
//  ShockSquare
//
//  Created by Joe Conway on 7/27/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ShockSquareView.h"


@implementation ShockSquareView
@synthesize renderer; 
#pragma mark Initialization 
- (id)initWithFrame:(CGRect)aFrame 
{ 
    [super initWithFrame:aFrame]; 
    
    // Set up the layer that draws to the screen 
    NSMutableDictionary *drawProperties = [NSMutableDictionary dictionary]; 
    [drawProperties setObject:[NSNumber numberWithBool:NO] 
                       forKey:kEAGLDrawablePropertyRetainedBacking]; 
    [drawProperties setObject:kEAGLColorFormatRGBA8 
                       forKey:kEAGLDrawablePropertyColorFormat]; 
    CAEAGLLayer *layer = (CAEAGLLayer *)[self layer]; 
    [layer setOpaque:YES]; 
    [layer setDrawableProperties:drawProperties]; 
    
    // Create the context that handles the OpenGL ES commands/data 
    context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1]; 
    if (!context || ![EAGLContext setCurrentContext:context]) { 
        [self release]; 
        return nil; 
    }         
    
    return self; 
} 
+ (Class)layerClass 
{ 
    return [CAEAGLLayer class]; 
} 
- (BOOL)createBuffers 
{ 
    // Create named buffers 
    glGenFramebuffersOES(1, &frameBuffer); 
    glGenRenderbuffersOES(1, &renderBuffer); 
    
    // Make the named buffers active 
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, frameBuffer); 
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer); 
    
    // Link the currently bound renderbuffer to our layer 
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)[self layer]]; 
    // Attach our renderbuffer to the framebuffer 
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, 
                                 GL_RENDERBUFFER_OES, renderBuffer); 
    
    // Get the width and height of the render buffer 
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, 
                                    &backingWidth); 
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, 
                                    &backingHeight); 
        
    // All good? 
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) { 
        NSLog(@"failed to make complete framebuffer object %x", 
                    glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES)); 
        return NO; 
    } 
    
    return YES; 
} 
- (void)layoutSubviews 
{ 
    [EAGLContext setCurrentContext:context]; 
    [self destroyBuffers]; 
    [self createBuffers]; 
    [self updateGL:nil]; 
} 
#pragma mark Starting and Stopping Animation 
- (void)startAnimation 
{ 
    // Add a timer to the run loop 
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 30.0 
                                             target:self 
                                           selector:@selector(updateGL:) 
                                           userInfo:nil 
                                            repeats:YES]; 
    [animationTimer retain]; 
} 
- (void)stopAnimation 
{ 
    [animationTimer invalidate]; 
    [animationTimer release]; 
    animationTimer = nil; 
} 

#pragma mark Drawing 
- (void)updateGL:(NSTimer *)t 
{ 
    // We always need a context current!
    [EAGLContext setCurrentContext:context]; 
    
    // Make the frame buffer active 
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, frameBuffer); 

    // Set the view port to match the size of the backing 
    glViewport(0, 0, backingWidth, backingHeight); 
	
    // Set up our viewing area in the OpenGL "world" 	
    // Make the projection matrix active 
    glMatrixMode(GL_PROJECTION); 
    // Load the identity matrix into the projection matrix 
    glLoadIdentity(); 
    // Multiply in orthographic projection 
    glOrthof(0, backingWidth, 0, backingHeight, -1.0f, 1.0f);  
	
    // Switch to the modelview matrix and set it to the identity 
    glMatrixMode(GL_MODELVIEW); 
    glLoadIdentity(); 
    
    glClearColor(0.0f, 1.0f, 0.0f, 1.0f); 
    glClear(GL_COLOR_BUFFER_BIT); 
	
	[renderer renderToView:self]; 
     
    // Finalize all of the drawing in to the context - this puts it on the screen 
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer); 
    [context presentRenderbuffer:GL_RENDERBUFFER_OES]; 
	
} 

- (void)destroyBuffers 
{    
    // These functions don't do anything if the buffer name is zero 
    // zero == nil in OpenGL ES 
    glDeleteFramebuffersOES(1, &frameBuffer); 
    frameBuffer = 0; 
    glDeleteRenderbuffersOES(1, &renderBuffer); 
    renderBuffer = 0; 
} 
- (void)touchesBegan:(NSSet *)touches 
           withEvent:(UIEvent *)event 
{ 
    if (animationTimer) { 
        [self stopAnimation]; 
    } else { 
        [self startAnimation]; 
    } 
} 
- (void)dealloc 
{ 
    [self stopAnimation]; 
    
    if ([EAGLContext currentContext] == context) { 
        [EAGLContext setCurrentContext:nil]; 
    } 
    
    [context release];  
    [super dealloc]; 
} 


@end
