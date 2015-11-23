//
//  MLNavigationController.m
//  MultiLayerNavigation
//
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//


#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#import "MLNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface MLNavigationController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
//    UIPanGestureRecognizer *_recognizer;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;
@property (nonatomic, assign) UIInterfaceOrientationMask interfaceOrientationMask;


@end

@implementation MLNavigationController


@synthesize interfaceOrientationMask= _interfaceOrientationMask;

- (void)changeSupportedInterfaceOrientations:(UIInterfaceOrientationMask)interfaceOrientation{
    
    _interfaceOrientationMask = interfaceOrientation;
}

-(BOOL)shouldAutorotate{
    
    return self.topViewController.shouldAutorotate;
}

-(NSUInteger)supportedInterfaceOrientations{
    
    return self.topViewController.supportedInterfaceOrientations;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        
        self.screenShotsList = [[[NSMutableArray alloc]initWithCapacity:2]autorelease];
        self.canDragBack = YES;
         
    }
    return self;
} 

- (void)dealloc
{
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // draw a shadow for navigation view to differ the layers obviously.
    // using this way to draw shadow will lead to the low performace
    // the best alternative way is making a shadow image.
    //
    //self.view.layer.shadowColor = [[UIColor blackColor]CGColor];
    //self.view.layer.shadowOffset = CGSizeMake(5, 5);
    //self.view.layer.shadowRadius = 5;
    //self.view.layer.shadowOpacity = 1;
    
    UIImageView *shadowImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]]autorelease];
    shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
    [self.view addSubview:shadowImageView];
    
    
    UIPanGestureRecognizer *recognizer = [[[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(paningGestureReceive:)]autorelease];
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
    
//    _recognizer = recognizer;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionRemoveGesture:) name:@"CanNotScroll" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionSetGesture:) name:@"CanScroll" object:nil];

}

//- (IBAction)actionRemoveGesture:(id)sender
//{
//    [self.view removeGestureRecognizer:_recognizer];
//}
//
//- (IBAction)actionSetGesture:(id)sender
//{
//    UIPanGestureRecognizer *recognizer = [[[UIPanGestureRecognizer alloc]initWithTarget:self
//                                                                                 action:@selector(paningGestureReceive:)]autorelease];
//    [recognizer delaysTouchesBegan];
//    [self.view addGestureRecognizer:recognizer];
//    _recognizer = recognizer;
//
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotsList addObject:[self capture]];
    
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    
    return [super popViewControllerAnimated:animated];
}

#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    
    NSLog(@"Move to:%f",x);
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);

    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        if ((int)[[NSUserDefaults standardUserDefaults] objectForKey:@"IsMoveForDateVC"] == 1) {
             _isMoving = NO;
        }else{
            _isMoving = YES;
        }
       
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame = self.view.frame;
             
            self.backgroundView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)]autorelease];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)]autorelease];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[[UIImageView alloc]initWithImage:lastScreenShot]autorelease];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if ((int)[[NSUserDefaults standardUserDefaults] objectForKey:@"IsMoveForDateVC"] == 1){
            
            _isMoving = NO;
        }else{
            
            if (touchPoint.x - startTouch.x > 50){
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:320];
                } completion:^(BOOL finished){
                    
                    [self popViewControllerAnimated:NO];
                    CGRect frame = self.view.frame;
                    frame.origin.x = 0;
                    self.view.frame = frame;
                    self.backgroundView.hidden = YES;
                    _isMoving = NO;
                }];
            }
            else
            {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0];
                } completion:^(BOOL finished) {
                    _isMoving = NO;
                    self.backgroundView.hidden = YES;
                }];
            }
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        if ((int)[[NSUserDefaults standardUserDefaults] objectForKey:@"IsMoveForDateVC"] == 1){
            _isMoving = NO;
        }else{
            [UIView animateWithDuration:0.3 animations:^{
            
                [self moveViewWithX:0];
        
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
        }
        return;
    }
    // it keeps move with touch
    if (_isMoving) {
//        if (touchPoint.x - startTouch.x<0)return;
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

@end
