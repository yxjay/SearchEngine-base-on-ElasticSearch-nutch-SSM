package com.yxjay.adapter;

public class HighLighterCode {
	private static String pre="<font color='#F00'>";
	private static String post="</font>";
	public static String Change(String input,String keyword)
	{
		String str="";
		for(int i =0;i<input.length();i++)
		{
			boolean match = false;
			String s = input.substring(i, i+1);
			for(int j=0;j<keyword.length();j++)
			{
				String temp = keyword.substring(j,j+1);
				if(temp.equals(s))
				{
					str=str+pre+s+post;
					match = true;
					break;
				}
			}
			if(!match)
				str+=s;
		}
		//System.out.println("output="+str);
		return str;
	}


}
