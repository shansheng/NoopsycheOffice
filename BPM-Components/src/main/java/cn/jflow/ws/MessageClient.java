package cn.jflow.ws;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;
import org.junit.BeforeClass;
import org.junit.Ignore;

import BP.Sys.SystemConfig;
/**
 * 其他系统webservice客户端实现
 * @author 裴孝峰
 * @date 2016-71-15
 */
public class MessageClient {
	private static Client client = null;

	@BeforeClass
	public static void init() {
		// 不依赖服务器端接口来完成调用的，也就是不仅仅能调用Java的接口
		JaxWsDynamicClientFactory clientFactory = JaxWsDynamicClientFactory.newInstance();
		client = clientFactory.createClient(String.valueOf(SystemConfig.getAppSettings().get("OtherSysMsgUrl")));
	}
	
	/**
	 * 判断是否存在
	 * @Title: userIsexit  
	 * @author 裴孝峰
	 * @date 2016年7月15日
	 */
	@Ignore
	public boolean userIsexit(String userCode){
		Object[] result;
		try {
			result = client.invoke("userIsexit", userCode);
			if(result.length>0){
				return (Boolean) result[0];
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	/**
	 * 发送消息
	 * @Title: sendMsg  
	 * @author 裴孝峰
	 * @date 2016年7月15日
	 */
	@Ignore
	public void sendMsg(String contentTitle, String contentLevel, String contentType, String contentText, String receiverType, String receiverCodes, String receiverNames, String[][] buttons, String type){
		try {
			client.invoke("sendMsg",new Object[]{contentTitle,contentLevel,contentType,contentText,receiverType,receiverCodes,receiverNames,null,type});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
