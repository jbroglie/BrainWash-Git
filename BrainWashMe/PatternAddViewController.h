
@protocol PatternAddDelegate;

@interface PatternAddViewController : UIViewController <UITextFieldDelegate> {
    @private
        UITextField *nameTextField;
        id <PatternAddDelegate> delegate;
        NSString *patternName;
}

@property(nonatomic, retain) IBOutlet UITextField *nameTextField;
@property(nonatomic, assign) id <PatternAddDelegate> delegate;
@property(nonatomic, retain) NSString *patternName;

- (void)save;
- (void)cancel;

@end


@protocol PatternAddDelegate <NSObject>
// pattern == nil on cancel
- (void)patternAddViewController:(PatternAddViewController *)patternAddViewController didAddPattern:(NSString *)patternName;

@end
