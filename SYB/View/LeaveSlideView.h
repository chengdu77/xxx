//
//  SlideTabBarView.h
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/25.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeaveSlideViewDelegate <NSObject>

@optional
- (void)deleteAction:(id)object withPageTag:(NSInteger)page;
- (UIView *)drawTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)drawTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@required
- (UITableViewCell *)fillCellDataTableView:(UITableView *)tableView withObject:(id)object withPageTag:(NSInteger)page;

- (void)reloadDataWithPageTag:(NSInteger)page withPageNumber:(NSInteger)pagenum;

- (void)openInfoViewWith:(id)object withPageTag:(NSInteger)page;

@end

@interface LeaveSlideView : UIView
-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)array slideColor:(UIColor *)color withObjects:(NSArray *)objects cellName:(NSString *)cellName errorImage:(UIImage *)images errorInfos:(NSArray *)errorInfos;

- (void)refreshWithTitles:(NSArray *)array;

- (void)reloadViewWithData:(NSArray *)data index:(NSInteger)index;

- (void)defaultAction:(NSInteger)tag;


@property (nonatomic,assign) id delegate;
@property (nonatomic,strong) NSString *cellName;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat headerInSectionHeight;
@property (nonatomic,assign) CGFloat footerInSectionHeight;
@property (nonatomic,strong) NSArray *editingStyle;

@property (nonatomic,assign) CGRect contentViewframe;

@end



