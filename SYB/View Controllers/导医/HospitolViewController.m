//
//  HospitolViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "HospitolViewController.h"

@interface HospitolViewController ()

@end

@implementation HospitolViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    CGRect frame = CGRectMake(0,0,self.viewWidth,156);
    UIView *headView = [[UIView alloc] initWithFrame:frame];
    UIImageView *hospitolImageView = [[UIImageView alloc] initWithFrame:frame];
    hospitolImageView.image = nil;
    [headView addSubview:hospitolImageView];
    [self.scrollView addSubview:headView];
    
    frame.origin.y = CGRectGetMaxY(frame);
    frame.size.height = self.viewHeight - CGRectGetHeight(headView.frame);
    NSString *detail = @"泸州得名“泸水说”，古称江阳。南朝梁大同年间（535—546年）置泸州，领江阳郡。江阳郡领：江阳县（治今江阳区）、汉安县（治今纳溪区大渡口镇）、绵水县（治今长宁县北）、安乐戍（治今合江县合江镇）。州、郡治今江阳区。\n       夏、商时属梁州之域。周代属巴国辖地。周慎靓王五年（前316年）春，秦国灭巴、蜀，同年设置巴郡，辖包括江阳在内的大片土地。西汉景帝六年（前151年）封苏嘉为江阳侯，在长江与沱江交汇处（今泸州市江阳区）设置江阳县。汉武帝建元六年（前135年），开发西南少数民族地区，置犍为郡，领江阳县。东汉献帝建安十八年（213年）置江阳郡。西晋仍置江阳郡。江阳郡属益川，下辖江阳县、符县、江安县。南朝刘宋、南齐置东江阳郡。\n       梁大同年间（535—546年），建置泸州。泸州辖一郡即江阳郡，三县即江阳县、江安县、绵水县。隋大业三年（607年）改泸州为泸川郡，仁寿中升为泸州总管府。改江阳县为泸川县，为泸川郡治。泸川郡辖泸川县、富世县、江安县、合江县、绵水县。唐武德元年（618年）复置为泸州，三年（620年）置总管府，四年（621年）升为都督府。泸州辖泸川县、富义县、江安县、合江县、绵水县。\n       北宋泸州泸川郡置泸川军节度。南宋乾道六年（1170年）升本路安抚使。宋未改泸州为江安川，属潼川路。辖泸川县、江安县、合江县、纳溪县。宋、元之际，蒙古军入蜀，泸州城先后迁治于合江榕山、江安三江碛、合江安乐山，最终筑城于合江神臂崖，坚持抗战35年。元改为泸州，并废泸川县入泸州，属重庆路，辖江安县、合江县、纳溪县。明洪武六年（1373年）泸州直隶四川行中书省，九年（1376年）直隶四川布政使司。辖江安县、纳溪县、合江县。清嘉庆七年（1802年）泸州置川南永宁道（1908年改名下川南道）。民国初改泸州为泸县，属永宁道，为永宁道治，并与江安、纳溪、合江三县脱离。民国二十四年（1935年）设置第七行政督察区。\n       1949年中共川南区委在自贡成立。1950年1月川南区委迁泸县，设置川南人民行政公署（省级，1952年8月撤销）。\n       1949年12月1日，叙永解放；2日，古蔺解放；3日，泸县、合江、纳溪解放。5日，泸县人民解放委员会成立，代行县政府日常工作。13日，中共泸县委员会和泸县人民政府成立。1950年1月17日，设泸县专区，辖泸县、纳溪、合江、隆昌、富顺、叙永、古蔺和古宋8县。\n      1949年12月设置泸县行政督察专员公署，1950年9月改称泸县专员公署，属川南行署区。7月10日，经中央人民政府批准，泸县析出设立泸州市，同月底成立中共泸州市委，8月15日正式成立泸州市人民政府。泸县专署驻泸州市，辖泸县（驻泸州市小市镇）、合江、古蔺、叙永、古宋、纳溪、富顺、隆昌等8县。\n       1952年3月，泸县专署迁隆昌县，改称隆昌专区，后属四川省领导。同年12月专署迁泸州后，改称泸州专区。原由川南行署直辖的泸州市划归泸州专区。辖1市、8县。\n       1953年1月12日，泸州市划归泸州专署领导，并为专员公署所在地。（1953年，泸州市改为省辖市，委托泸州专署代管。）\n       1960年，撤销古宋县，并入叙永县。7月14日，国务院批复撤销泸州专区，所属市县划归宜宾专区。\n       1983年3月3日，泸州市升为地级泸州市，将宜宾地区的泸县、纳溪、合江等3县划归泸州市管辖。同年5月四川省政府批准设立泸州市市中区。6月1日，市委、市政府办事机构正式成立。1985年1月17日，市中区政府成立。1985年6月4日，宜宾地区的古蔺、叙永2县划归泸州市管辖。\n       1995年12月24日，泸州市市中区更名为江阳区；撤销纳溪县，设立泸州市纳溪区；新设泸州市龙马潭区；泸县人民政府驻地由原市中区新街子街迁至泸县福集镇；对江阳区、纳溪区、泸县的行政区域作相应调整。\n       1996年7月1日，正式实施行政区划调整，泸州市辖三区四县（江阳区、龙马潭区、纳溪区、泸县、合江县、叙永县、 古蔺县）。";
    UIView *jjView = [self jjViewWithFrame:frame detail:detail];
    [self.scrollView addSubview:jjView];
    frame = jjView.frame;
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
    
}

- (UIView *)jjViewWithFrame:(CGRect)frame detail:(NSString *)detail{
    
    CGRect rect = CGRectMake(0,0,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    //label高度自适应
    UILabel *detailLabel = [self adaptiveLabelWithFrame:CGRectMake(5,5,self.viewWidth -10, 0) detail:detail fontSize:14];
    [view addSubview:detailLabel];
    
    CGFloat height = detailLabel.frame.size.height;
    frame.size.height = height+45;
    view.frame = frame;
    
    return view;
}


@end
