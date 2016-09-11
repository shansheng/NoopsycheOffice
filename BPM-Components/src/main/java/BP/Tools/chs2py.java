package BP.Tools;

import cn.jflow.common.util.PingYinUtil;

public class chs2py
{
	public chs2py()
	{
	}
	
	/**
	 * 获取汉字串拼音首字母，英文字符不变
	 */
	public static String ConvertWordFirst(String str)
	{
		return PingYinUtil.getFirstSpell(str);
	}
	
	public static String convert(String chrstr, String isNullAsVal)
	{
		try
		{
			return convert(chrstr);
		} catch (java.lang.Exception e)
		{
			return isNullAsVal;
		}
	}
	
	/**
	 * 获取拼音
	 * 
	 * @param chrstr
	 * @return
	 */
	public static String convert(String chrstr)
	{
		// char[] t1 = null;
		// t1 = chrstr.toCharArray();
		// String[] t2 = new String[t1.length];
		// HanyuPinyinOutputFormat t3 = new HanyuPinyinOutputFormat();
		// t3.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		// t3.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		// t3.setVCharType(HanyuPinyinVCharType.WITH_V);
		// String t4 = "";
		// int t0 = t1.length;
		// try {
		// for (int i = 0; i < t0; i++) {
		// // 判断是否为汉字字符
		// if (java.lang.Character.toString(t1[i]).matches(
		// "[\\u4E00-\\u9FA5]+")) {
		// t2 = PinyinHelper.toHanyuPinyinStringArray(t1[i], t3);
		// t4 += t2[0];
		// } else
		// t4 += java.lang.Character.toString(t1[i]);
		// }
		// // System.out.println(t4);
		// return t4;
		// } catch (BadHanyuPinyinOutputFormatCombination e1) {
		// e1.printStackTrace();
		// }
		// return t4;
		return PingYinUtil.getPingYin(chrstr);
	}
	
	// // 返回中文的首字母
	// public static String getPinYinHeadChar(String str) {
	// String convert = "";
	// for (int j = 0; j < str.length(); j++) {
	// char word = str.charAt(j);
	// String[] pinyinArray = PinyinHelper.toHanyuPinyinStringArray(word);
	// if (pinyinArray != null) {
	// convert += pinyinArray[0].charAt(0);
	// } else {
	// convert += word;
	// }
	// }
	// return convert;
	// }
	//
	// // 将字符串转移为ASCII码
	// public static String getCnASCII(String cnStr) {
	// StringBuffer strBuf = new StringBuffer();
	// byte[] bGBK = cnStr.getBytes();
	// for (int i = 0; i < bGBK.length; i++) {
	// // System.out.println(Integer.toHexString(bGBK[i]&0xff));
	// strBuf.append(Integer.toHexString(bGBK[i] & 0xff));
	// }
	// return strBuf.toString();
	// }
	
//	public static void main(String[] args)
//	{
//		System.out.println(chs2py.convert("要有一人一伙 去粗取精"));
//		System.out.println(chs2py.ConvertWordFirst("要有一人一伙 去粗取精"));
//	}
}