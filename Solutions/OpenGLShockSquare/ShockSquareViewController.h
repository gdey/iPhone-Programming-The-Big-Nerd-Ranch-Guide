//
//  ShockSquareViewController.h
//  ShockSquare
//
//  Created by Joe Conway on 7/27/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h> 
#import <OpenGLES/ES1/gl.h> 
#import <OpenGLES/ES1/glext.h> 
#import "ShockSquareView.h" 

// Two triangles @ 3 Vertices a piece 
#define VERTICES_PER_SQUARE (6) 
// X Y coordinates of each vertex 
#define COMPONENTS_PER_VERTEX (2) 
// R G B A values of each vertex 
#define COMPONENTS_PER_COLOR (4) 

@interface ShockSquareViewController : UIViewController <ShockSquareViewRenderer> 
{ 
    // Arrays of data for drawing 
    GLfloat vertices[VERTICES_PER_SQUARE * COMPONENTS_PER_VERTEX]; 
    GLubyte colors[VERTICES_PER_SQUARE * COMPONENTS_PER_COLOR];
    float angle; 
} 
- (void)createArrays; 
@end 

