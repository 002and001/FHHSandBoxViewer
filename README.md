# FHHSandBoxViewer
View your App's SandBox and shares Documents or Files you selected.


![gif](https://upload-images.jianshu.io/upload_images/2351207-6955703981bbca2b.gif?imageMogr2/auto-orient/strip)
FHHSandBoxViewer is a lite Compoment,you use it like 

#### How to get started?

##### Swift Usage
Drag Floder FHHSandBoxViewer to your project.
Then add code in one Controller
`
	let title = FHHSandboxViewController.defaultNavTitle
	let path = FHHSandboxViewController.defaultPath
	let sandBoxViewerVC = FHHSandboxViewController.init(navTitle: title, path: path)
	let nav = UINavigationController.init(rootViewController: sandBoxViewerVC)
	nav.navigationBar.isHidden = true
	nav.navigationBar.isTranslucent = true
	self.present(nav, animated: true, completion: {
	    sandBoxViewerVC.fhh_enterType = .present
	})
` 


##### Obj-C usage
Drag Floder FHHSandBoxViewer to your project,and config ProductName-Bridging-Header.h file in your Xcode if your project not ever use Swift before.
Then add code in one Controller
`
	NSString *defaultTitle = [FHHSandboxViewController defaultNavTitle];
    NSString *defaultPath = [FHHSandboxViewController defaultPath];
    FHHSandboxViewController *sandBoxViewerVC = [[FHHSandboxViewController alloc]
                                                    initWithNavTitle:defaultTitle
                                                                path:defaultPath];
    UINavigationController *nav = [[UINavigationController alloc]
                                      initWithRootViewController:sandBoxViewerVC];
    [nav.navigationBar setHidden:YES];
    [nav.navigationBar setTranslucent:YES];
    [self presentViewController:nav animated:YES completion:^{
        sandBoxViewerVC.fhh_enterType = FHHEnterTypePresent;
    }];

`
##### Attention: 
 If you use the System NavigationBar you might need to set true for the navigationBar's isHiiden and translucent before you push sandBoxViewerVC,like
`
	[self.navigationController.navigationBar setHidden:YES];
	[self.navigationController.navigationBar setTranslucent:YES];
	[self.navigationController pushViewController:sandBoxViewerVC animated:YES];
`

##### Tip: 
 If you are not satisied with existing functions,you could make a fork then do some changes you like.

