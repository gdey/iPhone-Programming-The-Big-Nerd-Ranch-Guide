//
//  ShockSquareViewController.m
//  ShockSquare
//
//  Created by Joe Conway on 7/27/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ShockSquareViewController.h"


@implementation ShockSquareViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle 
{ 
    self = [super initWithNibName:nibName bundle:bundle]; 
    [self createArrays]; 
 
    return self; 
} 
- (void)createArrays 
{ 
    // Tri 1 - Vertex 1 
    vertices[0] = -100; 
    vertices[1] = -100;
    
    // Tri 1 - Vertex 2 
    vertices[2] = 100; 
    vertices[3] = 100; 
    
    // Tri 1 - Vertex 3 
    vertices[4] = 100; 
    vertices[5] = -100; 
 
    // Tri 2 - Vertex 1 
    vertices[6] = -100; 
    vertices[7] = -100; 
    
    // Tri 2 - Vertex 2 
    vertices[8] = -100; 
    vertices[9] = 100; 
    
    // Tri 2 - Vertex 3 
    vertices[10] = 100; 
    vertices[11] = 100; 

    for (int i = 0; i < VERTICES_PER_SQUARE * COMPONENTS_PER_COLOR; i++) 
        colors[i] = random() % 256; 
} 
- (void)renderToView:(ShockSquareView *)view 
{ 
    // Translate the modelview matrix 
    glTranslatef(160, 240, 0); 
    
    // Rotate the model view matrix 
    angle += 2; 
    if (angle > 360) { 
        angle = angle - 360; 
    } 
    glRotatef(angle, 0, 0, 1); 

	// Make the arrays active 
    glEnableClientState(GL_VERTEX_ARRAY); 
    glEnableClientState(GL_COLOR_ARRAY); 
    
    // Give our vertex and color data to OpenGL 
    glVertexPointer(2, GL_FLOAT, 0, vertices); 
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, colors);    
    // Draw our vertices as triangles 
    glDrawArrays(GL_TRIANGLES, 0, VERTICES_PER_SQUARE); 
    
    // Make the arrays inactive 
    glDisableClientState(GL_VERTEX_ARRAY); 
    glDisableClientState(GL_COLOR_ARRAY); 
} 


- (void)loadView 
{ 
    ShockSquareView *shockSquareView = 
        [[[ShockSquareView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease]; 
    [shockSquareView setRenderer:self]; 
    [self setView:shockSquareView]; 
 
    [shockSquareView startAnimation]; 
}

@end
