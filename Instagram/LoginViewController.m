//
//  LoginViewController.m
//  Instagram
//
//  Created by Nikita Singh on 6/29/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)didTapSignUp:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];

    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:@"Sign Up Failed" message:@"Empty username or password field" preferredStyle:(UIAlertControllerStyleAlert)
        ];
        UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Retry"
                                  style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                                    NSLog(@ "Retry Tapped");
                                  }
                                 ];
        [alertvc addAction: action];
        [self presentViewController: alertvc animated: true completion: nil];
    }
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            
            UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:@"Sign Up Failed" message: error.localizedDescription preferredStyle:(UIAlertControllerStyleAlert)
            ];
            UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Retry"
                                      style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                                        NSLog(@ "Retry Tapped");
                                      }
                                     ];
            [alertvc addAction: action];
            
            [self presentViewController: alertvc animated: true completion: nil];
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];

        }
    }];
}

- (IBAction)didTapLogin:(id)sender {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"Empty username or password field" preferredStyle:(UIAlertControllerStyleAlert)
        ];
        UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Retry"
                                  style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                                    NSLog(@ "Retry Tapped");
                                  }
                                 ];
        [alertvc addAction: action];
        [self presentViewController: alertvc animated: true completion: nil];
    }
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            
            UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:@"Login Failed" message: error.localizedDescription preferredStyle:(UIAlertControllerStyleAlert)
            ];
            UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Retry"
                                      style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                                        NSLog(@ "Retry Tapped");
                                      }
                                     ];
            [alertvc addAction: action];
            [self presentViewController: alertvc animated: true completion: nil];
            
        } else {
            NSLog(@"User logged in successfully");
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];

        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
