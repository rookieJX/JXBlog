//
//  JXSendStatusViewController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//  发状态控制器

#import "JXSendStatusViewController.h"
#import "JXEmotionTextView.h"
#import "JXComposeToolBar.h" // 自定义工具条
#import "JXComposePhotoView.h" // 添加相册
#import "JXSendStatusWithOutPhotoParams.h" //  发表没有图片的微博参数
#import "JXComposeTool.h" // 发表微博业务类
#import "JXEmotionKeyboard.h" // 表情键盘
#import "HMEmotion.h" // 表情模型

@interface JXSendStatusViewController ()<JXComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
/** 自定义TextView */
@property (nonatomic,weak) JXEmotionTextView * textView;
/** 选择相册 */
@property (nonatomic,strong) UIImagePickerController * picker;
/** 工具条 */
@property (nonatomic,weak) JXComposeToolBar * toolBar;
/** 选中图片 */
@property (nonatomic,weak) JXComposePhotoView *composePhoto;
/** 是否在切换键盘 */
@property (nonatomic,assign,getter=isChangeKayboard) BOOL changeKayboard;
/** 表情键盘 */
@property (nonatomic,strong) JXEmotionKeyboard * emotionKeyboard;
@end

@implementation JXSendStatusViewController
// 自定义键盘
- (JXEmotionKeyboard *)emotionKeyboard{
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [JXEmotionKeyboard emotionKeyboard];
        _emotionKeyboard.w = kWidth;
        _emotionKeyboard.h = 216;
        _emotionKeyboard.backgroundColor = kTintColor;
    }
    return _emotionKeyboard;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self setupTextView];
    
    [self setupToolBar];
    
    // 监听表情键盘选中
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emotionKeyboardClick:)
                                                 name:kJXEmotionDidSelectedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emotionKeyboardDeleteClick:)
                                                 name:kJXEmotionDidDeleteNotification
                                               object:nil];
    
    
}

// 表情键盘
- (void)emotionKeyboardClick:(NSNotification *)notification {
    HMEmotion *emotion = notification.userInfo[kJXDidSelectedEmotion];
    
    [self.textView appendEmotion:emotion];
    // 检测当前textView,确保只有一个图片的时候也能发表
    [self textViewDidChange:self.textView];
}

// 删除按钮点击
- (void)emotionKeyboardDeleteClick:(NSNotification *)notification {
    [self.textView deleteBackward];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



// 自定义工具条
- (void)setupToolBar {
    JXComposeToolBar *toolBar = [[JXComposeToolBar alloc] init];
    toolBar.delegate = self;
    toolBar.w = kWidth;
    toolBar.h = 44;
    toolBar.y = kHeight - kStatusH - kNavigateH - toolBar.h;
    toolBar.x = 0;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark - 点击自定义工具条代理
- (void)composeToolBarDidSelectButtonType:(ComposeType)tpe {
    switch (tpe) {
        case ComposeTypeCamera: // 相机
        {
            [self pickerImageFromCrame];
        }
            break;
        case ComposeTypePhoto: // 相册
        {
            [self pickerImageFromPhoto];
        }
            break;
        case ComposeTypeImport: // ##
        {
            
        }
            break;
        case ComposeTypeEmotion: // 表情
        {
            [self setupEmotion];
        }
            break;
        case ComposeTypeMention: // @
        {
            
        }
            break;
        default:
            break;
    }
}

// 打开表情
- (void)setupEmotion {
    self.changeKayboard = YES;
    if (self.textView.inputView) { // 为自定义键盘 , 转换为系统键盘
        self.textView.inputView = nil;
        self.toolBar.showEmotion = YES;
    } else { // 为系统键盘
        self.textView.inputView = self.emotionKeyboard;
        self.toolBar.showEmotion = NO;
    }
    
    
    [self.textView resignFirstResponder];
    
    self.changeKayboard = NO;

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
    
    
}
#pragma mark - picker photo from crame && library
- (void)pickerImageFromCrame {
    if ([self isCameraAvailable]) { // 当手机支持拍照
        
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.picker animated:YES completion:nil];
        
    } else {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"对不起" message:@"手机暂不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actionCancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)pickerImageFromPhoto {
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - UINavigationControllerDelegate,UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.composePhoto addImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImagePickerController *)picker {
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
    }
    _picker.delegate = self;
    _picker.allowsEditing = YES;
    return _picker;
}

// 发表文字
- (void)setupTextView {
    JXEmotionTextView *textView = [[JXEmotionTextView alloc] init];
    textView.frame = CGRectMake(0, 0, kWidth, kHeight - kStatusH - kNavigateH);
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:17.0f];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    textView.placeHolder = @"发表你的心情吧...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 键盘将要显示
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    // 键盘将要隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // 添加相册
    [self setupComposePhotoView];
}

// 添加相册
- (void)setupComposePhotoView {
    JXComposePhotoView *composePhoto = [[JXComposePhotoView alloc] init];
    composePhoto.w = kWidth;
    composePhoto.h = self.textView.h / 2;
    composePhoto.y = 85;
    composePhoto.x = 0;
    [self.textView addSubview:composePhoto];
    self.composePhoto = composePhoto;
}
#pragma mark - 键盘处理
// 键盘显示
- (void)keyboardWillShow:(NSNotification *)note {
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardFrame.size.height;
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
    
}

// 键盘隐藏
- (void)keyboardWillHide:(NSNotification *)note {
    
    if (self.isChangeKayboard) return;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
    
}


#pragma mark - UITextViewDelegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    self.navigationItem.rightBarButtonItem.enabled = textView.attributedText.length != 0;
}
// 创建导航
- (void)setupNavigation {
    self.title = @"发表状态";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"取消"
                                                                     style:UIBarButtonItemStyleDone target:self
                                                                    action:@selector(cancelController)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发送"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(sendController)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancelController {
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)sendController {
    if (self.composePhoto.images.count) { // 如果有图片
        [self sendStatusWithPhoto];
    } else {
        [self sendStatusWithOutPhoto];
    }
}

// 发表没有图片的微博
- (void)sendStatusWithOutPhoto {
    JXSendStatusWithOutPhotoParams *sendStatusWithOutParams = [[JXSendStatusWithOutPhotoParams alloc] init];
    JXAccount *account = [JXAccountTool account];
    sendStatusWithOutParams.access_token = account.access_token;
    sendStatusWithOutParams.status = [self.textView getTextViewString ];
    
    [JXComposeTool composeWithOutPhotoStatusWithParams:sendStatusWithOutParams success:^(id responseObj) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
    
    [self cancelController];
}

// 发表有图片的微博
- (void)sendStatusWithPhoto {
    JXSendStatusWithOutPhotoParams *sendStatusWithOutParams = [[JXSendStatusWithOutPhotoParams alloc] init];
    JXAccount *account = [JXAccountTool account];
    sendStatusWithOutParams.access_token = account.access_token;
    sendStatusWithOutParams.status = self.textView.text;
    // 1.获得请求管理者
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//    [manager POST:kSendWithPhoto
//       parameters:sendStatusWithOutParams.mj_keyValues constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//           // 这里上传图片 , 上传最后一张
//           UIImage *image = [self.composePhoto.images lastObject];
//           // 使用jpg图片较小
//           NSData *data = UIImageJPEGRepresentation(image, 1.0);
//           // name:@"pic"为服务器定义图片字段 fileName:fileName:@"status.jpg"为自己定义图片名称
//           [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
//       } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//           [MBProgressHUD showSuccess:@"发表成功"];
//       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//           [MBProgressHUD showError:@"发表失败"];
//       }];
    // 这里上传图片 , 上传最后一张
    UIImage *image = [self.composePhoto.images lastObject];
    // 使用jpg图片较小
    NSData *data = UIImageJPEGRepresentation(image, 1.0);

    [JXComposeTool composeWithPhotoStatusWithParams:sendStatusWithOutParams imageData:data success:^(id responseObj) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
    
    
    [self cancelController];
}
@end
