//
//  WelcomeController+methods.m
//  task8
//
//  Created by Roman on 7/30/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "WelcomeController+methods.h"

@implementation WelcomeController (methods)

-(void)goWithRegistrationMethod {
    [self createAlert];
}

-(void)goWithoutRegistrationMethod {
    [self moveToNextVC:nil];
}

-(void)moveToNextVC:(NSString *)apiKey {
    ViewController *viewController = [[ViewController alloc] initWithApiKey:apiKey];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navController animated:YES completion:nil];
}

-(void)createAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter your API Key"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        // optionally configure the text field
        textField.keyboardType = UIKeyboardTypeAlphabet;
    }];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
        UITextField *textField = [alert.textFields firstObject];
        if (![textField.text isEqualToString:@""]) {
            [self moveToNextVC:textField.text];
        } else {
            UIAlertController *alertError = [UIAlertController alertControllerWithTitle:@"Wrong API Key!"
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertError addAction:okAction];
            [self presentViewController:alertError animated:YES completion:nil];
        }
                                                     }];
    [alert addAction:okAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotate {
    return false;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
