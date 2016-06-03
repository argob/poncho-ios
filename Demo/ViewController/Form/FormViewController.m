//
//  FormViewController.m
//  Demo
//
//  Created by Sergio Cirasa on 6/3/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import "FormViewController.h"
#import "LocationPickerViewController.h"
#import "Report.h"
#import "Reachability.h"
#import "DialogUtils.h"

#define kImageFileName @"report.png"

@interface FormViewController () <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,LocationPickerDelegate>

@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic, weak) IBOutlet UIView *containerView;

@property(nonatomic, weak) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@property(nonatomic, weak) IBOutlet UITextField *addressTextField;
@property(nonatomic, weak) IBOutlet UITextField *titleTextField;
@property(nonatomic, weak) IBOutlet UITextField *descriptionTextField;
@property(nonatomic, weak) IBOutlet UITextField *categoryTextField;
@property(nonatomic, weak) IBOutlet UITextField *nameTextField;
@property(nonatomic, weak) IBOutlet UITextField *lastNameTextField;
@property(nonatomic, weak) IBOutlet UITextField *dniTextField;
@property(nonatomic, weak) IBOutlet UITextField *phoneAreaTextField;
@property(nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property(nonatomic, weak) IBOutlet UITextField *emailTextField;

@property(nonatomic, weak) IBOutlet UIButton *femaleButton;
@property(nonatomic, weak) IBOutlet UIButton *maleButton;
@property(nonatomic, weak) IBOutlet UIButton *removeImageButton;
@property(nonatomic, weak) IBOutlet UIButton *addImageButton;

@property(nonatomic, strong) IBOutletCollection(UITextField) NSArray *textfields;
@property(nonatomic, weak) IBOutlet UIView *pickerContainerView;
@property(nonatomic,assign) ReportType reportType;

@property(nonatomic,strong) UIImage *selectedImage;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property(nonatomic, assign) CLLocationCoordinate2D chosenLocation;

@end

@implementation FormViewController

#pragma mark -  Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Formulario";
    self.femaleButton.layer.borderWidth = 1;
    self.maleButton.layer.borderWidth = 1;
    self.maleButton.layer.borderColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor;
    self.femaleButton.layer.borderColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor;
    
    self.imageViewHeight.constant = 0;
    self.removeImageButton.hidden = YES;
    
    self.categoryTextField.inputView = self.pickerContainerView;
    [self.pickerContainerView removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}
//------------------------------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated
{
    __weak typeof(self) weakSelf = self;
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        [DialogUtils showInternetErrorMessage:weakSelf handler:^(UIAlertAction * action) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        return;
    }
}
//------------------------------------------------------------------------------------------------
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.textfields = nil;
}
//------------------------------------------------------------------------------------------------
#pragma mark - Button Action
-(IBAction)sexButtonAction:(UIButton*)btn
{
    self.maleButton.backgroundColor = [UIColor whiteColor];
    self.femaleButton.backgroundColor = [UIColor whiteColor];
    self.maleButton.layer.borderColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor;
    self.femaleButton.layer.borderColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor;
    self.maleButton.selected = NO;
    self.femaleButton.selected = NO;
    btn.selected = YES;
    btn.layer.borderColor = [UIColor appBlueColor].CGColor;
    btn.backgroundColor = [UIColor appBlueColor];
}
//------------------------------------------------------------------------------------------------
-(IBAction)sendButtonAction:(UIButton*)btn
{
    [self hideKeyboard];
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        [DialogUtils showInternetErrorMessage:self handler:^(UIAlertAction * action) {
        }];
    }
    
    if([self isValidateForm]){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Enviar formulario" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
    }
}
//------------------------------------------------------------------------------------------------
-(IBAction)removeImageButtonAction:(UIButton*)btn
{
    self.imageViewHeight.constant = 0;
    [self.imageView setNeedsUpdateConstraints];
    self.selectedImage = nil;
    self.removeImageButton.hidden = YES;
    self.addImageButton.alpha = 0;
    self.addImageButton.hidden = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [weakSelf.imageView layoutIfNeeded];
        [weakSelf.containerView layoutIfNeeded];
        weakSelf.addImageButton.alpha = 1;
    } completion:^(BOOL finished){
        weakSelf.imageView.image = nil;
    }];
}
//------------------------------------------------------------------------------------------------
-(IBAction)addImageButtonAction:(UIButton*)btn
{
    [self showImageActionSheet];
}
//------------------------------------------------------------------------------------------------
-(IBAction)hideKeyboard
{
    [self.addressTextField resignFirstResponder];
    [self.titleTextField resignFirstResponder];
    [self.descriptionTextField resignFirstResponder];
    [self.categoryTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.dniTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.phoneAreaTextField resignFirstResponder];
}
//------------------------------------------------------------------------------------------------
-(void)keyboardShow:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
}
//------------------------------------------------------------------------------------------------
-(void)keyboardHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
    } completion:^(BOOL finished){     }];
}
//------------------------------------------------------------------------------------------------
#pragma mark - Private Methods
-(BOOL)isValidateForm
{
    if([self.addressTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese una dirección" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.titleTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese un título" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.descriptionTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese una descripción" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.categoryTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Seleccione una categoría" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.nameTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese su nombre" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.lastNameTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese su apellido" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.dniTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese su DNI" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if(self.maleButton.selected==NO && self.femaleButton.selected==NO){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Seleccione su sexo" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.phoneAreaTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese el codigó de area" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.phoneTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese su telefono" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if([self.emailTextField.text length]==0){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese su mail" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    if(![self.emailTextField.text isValidEmailAddress]){
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"Ingrese un mail valido" image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
        return NO;
    }
    
    return YES;
}
//------------------------------------------------------------------------------------------------
-(Report*)reportFromForm
{
    Report *report = [[Report alloc] init];
    report.title = self.titleTextField.text;
    report.text = self.descriptionTextField.text;
    report.type = self.reportType;
    report.status = REPORTED;
    report.address = self.addressTextField.text;
    report.latitude = [NSString stringWithFormat:@"%f",self.chosenLocation.latitude];
    report.longitude = [NSString stringWithFormat:@"%f",self.chosenLocation.longitude];
    report.name = self.nameTextField.text;
    report.lastname = self.lastNameTextField.text;
    report.dni = self.dniTextField.text;
    report.phone_area = self.phoneAreaTextField.text;
    report.phone_number = self.phoneTextField.text;
    report.email = self.emailTextField.text;
    report.gender = self.maleButton.selected?MALE:FEMALE;
    if(self.selectedImage)
        report.image = [self imageFilePath];
    return report;
}
//------------------------------------------------------------------------------------------------
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==self.addressTextField){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LocationPickerViewController *vc = (LocationPickerViewController*) [storyboard instantiateViewControllerWithIdentifier:@"LocationPickerViewController"];
        vc.delegate = self;
        [self.navigationController presentViewController:vc animated:YES completion:^{}];
        return NO;
    }
    
    return YES;
}
//------------------------------------------------------------------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
//------------------------------------------------------------------------------------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
//------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.emailTextField){
        [self keyboardHide:nil];
        [self.emailTextField resignFirstResponder];
    }else{
        NSInteger index = textField.tag + 1;
        UITextField *aTextField = self.textfields[index];
        [aTextField becomeFirstResponder];
    }
    
    return YES;
}
//------------------------------------------------------------------------------------------------
#pragma mark -  UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//------------------------------------------------------------------------------------------------
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}
//------------------------------------------------------------------------------------------------
#pragma mark -  UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[Report reportTypeText:row+1] stylizeString];
}
//------------------------------------------------------------------------------------------------
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.categoryTextField.text = [[Report reportTypeText:row+1]  stylizeString];;
    self.reportType = row+1;
}
//------------------------------------------------------------------------------------------------
#pragma mark - Private Methods For Take Picture
-(void)showImageActionSheet {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Seleccionar una foto de la galería"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              [self startMediaBrowser];
                                                          }];
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Tomar una foto"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               [self startCameraControllerForPhoto];
                                                           }];
    
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Cancelar"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                              
                                                          }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    [self presentViewController:alert animated:YES completion:nil];
}
//------------------------------------------------------------------------------------------------
- (BOOL)startMediaBrowser {
    if (NO == [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        return NO;
    } else {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        self.imagePicker.delegate = self;
        [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
        return YES;
    }
}
//------------------------------------------------------------------------------------------------
- (BOOL)startCameraControllerForPhoto {
    if (NO == [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return NO;
    }
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    self.imagePicker.delegate = self;
    self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
    return YES;
}
//------------------------------------------------------------------------------------------------
#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if (CFStringCompare (( CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if(originalImage==nil)
            originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        self.selectedImage = [self resizeImage:originalImage];
        
        self.imageView.image = self.selectedImage;
        self.imageViewHeight.constant = 160;
        self.removeImageButton.hidden = NO;
        self.addImageButton.hidden = YES;
        
        // Save image.
        [UIImagePNGRepresentation(self.selectedImage) writeToFile:[self imageFilePath] atomically:YES];
        [self.imagePicker dismissViewControllerAnimated:YES completion:^{}];
    }
}
//------------------------------------------------------------------------------------------------
-(NSString*)imageFilePath
{
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:kImageFileName];
    return filePath;
}
//------------------------------------------------------------------------------------------------
-(UIImage*)resizeImage:(UIImage*)image{
    UIImage *upImage = image;
    
    CGSize size = upImage.size;
    if(upImage.size.width>480){
        size.width = 480;
        size.height = 480 *upImage.size.height/upImage.size.width;
    }else if(upImage.size.height > 852){
        size.height = 852;
        size.width = 852*upImage.size.width/upImage.size.height;
    }
    
    upImage = [upImage resizedImage:size interpolationQuality:kCGInterpolationMedium];
    return upImage;
}
//------------------------------------------------------------------------------------------------
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
    }];
}
//------------------------------------------------------------------------------------------------
#pragma mark - LocationPickerDelegate
-(void)didSelect:(CLLocationCoordinate2D)coord address:(NSString*)address
{
    self.addressTextField.text = address;
    self.chosenLocation = coord;
    [self dismissViewControllerAnimated:YES completion:nil];
}
//------------------------------------------------------------------------------------------------
-(void)didCancelLocationPicker
{
    self.addressTextField.text = @"";
    self.chosenLocation = kCLLocationCoordinate2DInvalid;
}
//------------------------------------------------------------------------------------------------

@end
