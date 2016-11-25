package com.sojson.common.utils;

import java.security.MessageDigest;
import java.util.Random;

public class MathUtil {
	/**
	 * 获取随机的数值。
	 * @param length	长度
	 * @return
	 */
	public static String getRandom620(Integer length){
	   String result = "";
	   Random rand = new Random();
	   int n = 20;
	   if(null != length && length > 0){
		   n = length;
	   }
       boolean[]  bool = new boolean[n];
       int randInt = 0;
       for(int i = 0; i < length ; i++) {
            do {
                randInt  = rand.nextInt(n);

            }while(bool[randInt]);

           bool[randInt] = true;
           result += randInt;
       }
       return result;
	}
	/**
	 * MD5 加密
	 * @param str
	 * @return
	 * @throws Exception
	 */
	 public static String  getMD5(String str) {  
	        MessageDigest messageDigest = null;  
	            try {
					messageDigest = MessageDigest.getInstance("MD5");
					messageDigest.reset();
					messageDigest.update(str.getBytes("UTF-8"));
				} catch (Exception e) {
					LoggerUtils.fmtError(MathUtil.class,e, "MD5转换异常！message：%s", e.getMessage());
				}  
				
	        byte[] byteArray = messageDigest.digest();  
	        StringBuffer md5StrBuff = new StringBuffer();  
	        for (int i = 0; i < byteArray.length; i++) {              
	            if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)  
	                md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));  
	            else  
	                md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));  
	        }  
	        return md5StrBuff.toString();  
	    }  
}