//
//  ViewController.m
//  FlexboxKitDemo
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#import "ButtonDemoViewController.h"
@import FlexboxKit;

@interface ButtonDemoViewController ()

@property (nonatomic, strong) FLEXBOXContainerView *container;
@property (nonatomic, strong) NSArray *views;

@end

@implementation ButtonDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the flexbox container
    FLEXBOXContainerView *c = [[FLEXBOXContainerView alloc] initWithFrame:self.view.bounds];
    c.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    c.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:c];
    
    self.container = c;

    self.views = [self createDummyViews];
    
    for (UIView *v in self.views)
        [c addSubview:v];
    
    //Flexbox
    [self layout:0];
}

- (void)didPressButton:(UIButton*)sender
{
    [self layout:sender.tag];
}

#pragma mark - Different layouts

- (void)layout:(NSInteger)index
{
    self.container.flexJustifyContent = FLEXBOXJustificationCenter;
    self.container.flexAlignItems = FLEXBOXAlignmentCenter;
    self.container.flexPadding = (UIEdgeInsets){32,16,32,16};;
    
    for (UIView *v in self.views) {
        v.flexMargin = (UIEdgeInsets){8,8,8,8};
        v.flexPadding = (UIEdgeInsets){4,4,4,4};
        v.flex = 0;
        v.flexFixedSize = CGSizeZero;
        v.flexMaximumSize = (CGSize){FLT_MAX, FLT_MAX};
    }
    
    switch (index) {
            
        // all items in in a column
        case 0: {
            self.container.flexJustifyContent = FLEXBOXJustificationCenter;
            self.container.flexAlignItems = FLEXBOXAlignmentCenter;
            self.container.flexDirection = FLEXBOXFlexDirectionColumn;
            
            break;
        }
            
        // all items in a row,
        case 1: {
            self.container.flexJustifyContent = FLEXBOXJustificationCenter;
            self.container.flexAlignItems = FLEXBOXAlignmentCenter;
            self.container.flexDirection = FLEXBOXFlexDirectionRow;

            for (UIView *v in self.views) {
                v.flex = 1;
            }
            break;
        }

        // wraps to the next line
        case 2: {
            
            for (UIView *v in self.views) {
                v.flexPadding = (UIEdgeInsets){12,12,12,12};
            }
            self.container.flexWrap = YES;
            break;
        }
            
        // start
        case 3: {
            self.container.flexAlignItems = FLEXBOXAlignmentFlexStart;
            self.container.flexJustifyContent = FLEXBOXJustificationFlexStart;
            break;
            
        }
         
        // end
        case 4: {
            self.container.flexAlignItems = FLEXBOXAlignmentFlexEnd;
            self.container.flexJustifyContent = FLEXBOXJustificationFlexEnd;
            for (UIView *v in self.views) {
                v.flex = 1;
            }
            
            break;
        }
            
        // stretch
        case 5: {
            self.container.flexAlignItems = FLEXBOXAlignmentStretch;
            self.container.flexJustifyContent = FLEXBOXJustificationCenter;
            
            for (UIView *v in self.views) {
                v.flex = 1;
            }
            break;
        }
            
        // stretch (with max width)
        case 6: {
            self.container.flexJustifyContent = FLEXBOXJustificationCenter;
            self.container.flexAlignItems = FLEXBOXAlignmentCenter;
            
            for (UIView *v in self.views) {
                
                v.flexMinimumSize = (CGSize){100, 32};
                v.flexMaximumSize = (CGSize){150, 32};
            }
            break;
        }
            
        // fixed size
        case 7: {
            
            for (UIView *v in self.views) {
                v.flexFixedSize = CGSizeMake(64, 32);
            }
            
            break;
        }

        default:
            break;
    }
    
    [UIView animateWithDuration:0.66 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        
        [self.container flexLayoutSubviews];
        //...or just [self.view setNeedsLayout]
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Test view (No layout logic)

- (NSArray*)labels
{
    return @[@"colum", @"row", @"wrap", @"flex-start", @"flex-end", @"stretch", @"maximum/minimum dimensions", @"fixed"];
}

// creates some test views
- (NSArray*)createDummyViews
{
    UIColor *tomatoColor = [UIColor colorWithRed:255.f/255.f green:99.f/255.f blue:71.f/255.f alpha:1.f];
    UIColor *steelBlueColor = [UIColor colorWithRed:0.f/255.f green:154.f/255.f blue:184.f/255.f alpha:1.f];
    UIColor *purpleColor = [UIColor colorWithRed:0.533 green:0.247 blue:0.671 alpha:1.000];
    
    //Dum
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSUInteger i = 0; i < self.labels.count; i++) {
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTitle:self.labels[i] forState:UIControlStateNormal];
        [b setBackgroundColor:@[tomatoColor, steelBlueColor, purpleColor][i%3]];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius = 8;
        b.tag = i;
        [buttons addObject:b];
    }
    
    return buttons.copy;
}



@end
