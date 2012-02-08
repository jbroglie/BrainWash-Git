

#import "PatternAddViewController.h"


@implementation PatternAddViewController

@synthesize nameTextField;
@synthesize delegate;
@synthesize patternName;


- (void)viewDidLoad {
    
    // Configure the navigation bar
    self.navigationItem.title = @"Add New Pattern";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    [saveButtonItem release];
	
	[nameTextField becomeFirstResponder];
}


- (void)viewDidUnload {
	self.nameTextField = nil;
	[super viewDidUnload];
}
	
	
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Support all orientations except upside-down
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == nameTextField) {
		[nameTextField resignFirstResponder];
		[self save];
	}
	return YES;
}


- (void)save {
    
    patternName = nameTextField.text;
	[self.delegate patternAddViewController:self didAddPattern:patternName];
}


- (void)cancel {
    [self.delegate patternAddViewController:self didAddPattern:nil];
}


- (void)dealloc {
     
    [nameTextField release];    
    [super dealloc];
}

@end
