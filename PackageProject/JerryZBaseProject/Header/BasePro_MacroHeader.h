//
//  BasePro_MacroHeader.h
//  PackageProject
//
//  Created by zfk on 2020/4/23.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#ifndef BasePro_MacroHeader_h
#define BasePro_MacroHeader_h

//-----------项目IP地址或域名-----------//
//#define Domain_Name @""  //正式地址
#define Domain_Name @""  //测试地址


//-----------三方框架需要的AppKey及Secret-----------//
#define UM_App_Key @""
#define Weibo_App_Key @""
#define Weibo_App_Secret @""
#define Weibo_Redirect_URL @""
#define Wechat_App_Key @""
#define Wechat_App_Secret @""
#define QQ_App_Key @""
#define QQ_App_Secret @""
#define QQ_Redirect_URL @""
#define JPush_App_Key @""
#define JPush_App_Secret @""


//----------- 刷新是每页数据 -----------//
#define Page_Size 10


//-----------常用颜色-----------//
#define Theme_Color Color_With_RGB(30, 127, 241, 1)// 主题色
#define Second_Theme_Color Color_With_RGB(241, 50, 74, 1)// 第二主题色

#define Default_VC_Background_Color Color_With_RGB(234, 234, 234, 1)// 默认页面背景色

#define Default_Navigation_Bar_Tint_Color [UIColor whiteColor]// 默认导航栏颜色
#define Default_Navigation_Bar_Title_Color [UIColor blackColor]// 默认导航栏中间字体颜色
#define Default_Navigation_Bar_Bar_Button_Item_Color [UIColor blackColor]// 默认导航栏BarButtonItem颜色

#define Default_Tab_Bar_Tint_Color [UIColor whiteColor]// 默认TabBar颜色
#define Default_Tab_Bar_Selected_Item_Tint_Color Theme_Color// 默认TabBar选中时颜色
#define Default_Tab_Bar_Unselected_Item_Tint_Color Color_With_RGB(150, 150, 150, 1)// 默认TabBar未选中时颜色


//-----------字体大小和颜色-----------//
#define First_Level_Font_Size 16.0
#define Second_Level_Font_Size 14.0
#define Third_Level_Font_Size 12.0

#define First_Level_Text_Color Color_With_Hex(0x333333, 1)
#define Second_Level_Text_Color Color_With_Hex(0x666666, 1)
#define Third_Level_Text_Color Color_With_Hex(0x999999, 1)


//-----------系统版本-----------//
#define System_Version [[UIDevice currentDevice].systemVersion floatValue]


//-----------需要适配的机型-----------//
// 更早的机型就不要适配了，从5开始
#define Device_Is_iPhone5 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))// 5、SE系列
#define Device_Is_iPhone6 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667))// 6、7、8系列
#define Device_Is_iPhone6Plus CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736))// Plus系列
#define Device_Is_iPhoneXR CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896))// XR、11全面屏低配系列
#define Device_Is_iPhoneX CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812))// X、11Pro全面屏旗舰系列
#define Device_Is_iPhone11ProMax CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896))// 全面屏Max系列
#define Device_Is_Full_Screen (Device_Is_iPhoneXR || Device_Is_iPhoneX || Device_Is_iPhone11ProMax)// 是否全面屏

//-----------需要适配的屏幕参数-----------//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Status_Bar_Height (Device_Is_Full_Screen ? 44.0 : 20.0)
#define Navigation_Bar_Height (Status_Bar_Height + 44.0)
#define Tab_Bar_Height (Device_Is_Full_Screen ? 83.0 : 49.0)
#define Bottom_Safe_Area_Height (Device_Is_Full_Screen ? 34.0 : 0.00)


//-----------颜色-----------//
#define Color_With_Hex(hex, α) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:α]
#define Color_With_RGB(r, g, b, α) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:α]


//-----------常用宏定义-----------//
#define Key_Window [UIApplication sharedApplication].keyWindow
#define NS_User_Defaults [NSUserDefaults standardUserDefaults]
#define NS_Notification_Center [NSNotificationCenter defaultCenter]


//-----------判断字符串是否为空-----------//
// 注意：如果服务端传的数据时 nil 或 Null 及 <null>容易出现问题
#define String_Is_Empty(string) ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || [string isEqualToString:@"NULL"] || string == NULL || [string isKindOfClass:[NSNull class]] || string == nil || ((NSString *)string).length == 0)


#endif /* BasePro_MacroHeader_h */
