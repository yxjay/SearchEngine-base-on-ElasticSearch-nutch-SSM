package com.yxjay.adapter;

public class StringDigest {

	public static int digestCountLimit;

	public static int getDigestCountLimit() {
		return digestCountLimit;
	}

	public static void setDigestCountLimit(int digestCountLimit) {
		StringDigest.digestCountLimit = digestCountLimit;
	}

	public StringDigest() {
		// TODO Auto-generated constructor stub
	}

	public static String Digest(String string,String keyword) {
		String digest = string;
		int keylength = keyword.length();
		int stringlength = string.length();
		int lengthwithoutkey = digestCountLimit - keylength;
		int keybegin =string.indexOf(keyword);
		int keytoend = stringlength-keybegin-keylength;
		int beginindex = 0;
		int endindex = 0;
		
		if(stringlength < digestCountLimit)
			return digest;
		else if(keybegin+keylength <= digestCountLimit)
			return digest.substring(0,digestCountLimit);
		else
		{
			//System.out.println(keybegin+","+digestCountLimit+","+keytoend+","+stringlength);
			//第一个关键字左右两边的字符串长度大于digestCountLimit
			if(keybegin > digestCountLimit && keytoend > digestCountLimit)
			{
				beginindex = keybegin - lengthwithoutkey/2;
				endindex =  digestCountLimit + beginindex;
				//System.out.println(beginindex+","+endindex);
				digest =  "..."+digest.substring(beginindex, endindex)+"...";	
			}
			else if(keybegin > digestCountLimit && keytoend < digestCountLimit )	//左长右短
			{
				endindex = keytoend + keylength > digestCountLimit ? keybegin + digestCountLimit : stringlength;
				beginindex = endindex - digestCountLimit;
				digest =  "..."+digest.substring(beginindex, endindex);	
			}
			else if (keybegin < digestCountLimit && keytoend > digestCountLimit)	//左短右长
			{
				beginindex = keybegin+keylength > digestCountLimit ? keybegin+keylength-digestCountLimit : keybegin;
				endindex = digestCountLimit + beginindex;
				digest =  digest.substring(beginindex, endindex)+"...";	
			}
		}
		return digest;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String text="关于2016届优秀毕业生的公示-计算机工程学院    学院首页  |  学院概况  |  教学科研  |  实验中心  |  学生工作  |  党团建设  |  返回学校   管理登录   师资队伍   学院风光   机构设置   学院简介   教务信息   教学评建   科研工作   专业学科   考试培训   中心介绍   对外服务   专业实验室   基础实验室   通知公告   硬件协会   院自律会   学生活动   院学生会   学生公告   勤工助学   教育管理   院就业会   软件协会   心理协会   时事讨论   党团活动   宣传资料   二级党校      当前位置： 学院首页 >> 院务公开 >> 正文     关于2016届优秀毕业生的公示 2016-04-29 10:50   审核人：     根据《集美大学“三好学生”、“优秀学生干部”、“优秀毕业生”、“先进班集体”评选办法》（ 集大学  [2016]19号）规定，经同学申请、辅导员审核，院学生工作小组研究，决定推荐李雯欣等30名同学参评2016届校优秀毕业生生，具体名单如下：     李雯欣  林秀眉  张嘉炜     丁  楠  张杨烽  游  捷     刘梦昕  王潇锋  严晓杰     林晓红  王  娇  杨青青     朱彩发  张  聪  潘睿剑     张晓东  郭芳泽  陈雨宁     秦  诚  沈至君  许梦婷     陈彩丽  陈远毅  樊亚娟     童瑞玲  卢永辉  王彩云     江玲微  赵志平  王  硕     公示时间：2016.4.29—2015.5.4     公示电话：6181765、6185140                                                    计算机工程学院                                                    2016年4月29日 【 关闭窗口 】   读取内容中,请等待... 厦门市集美区银江路183号(校总部) 邮编/361021";
		StringDigest.setDigestCountLimit(200);
		System.out.println(StringDigest.Digest(text, "严晓杰"));;
	}

}
