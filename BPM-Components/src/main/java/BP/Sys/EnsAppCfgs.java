package BP.Sys;

import BP.En.Entities;
import BP.En.Entity;

/**
 * 应用配置
 */
public class EnsAppCfgs extends Entities
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 获取数据
	public static String GetValString(String ensName, String cfgKey)
	{
		EnsAppCfg cfg = new EnsAppCfg(ensName, cfgKey);
		return cfg.getCfgVal();
	}
	
	public static int GetValInt(String ensName, String cfgKey)
	{
		try
		{
			EnsAppCfg cfg = new EnsAppCfg(ensName, cfgKey);
			return cfg.getCfgValOfInt();
		} catch (java.lang.Exception e)
		{
			return 400;
		}
	}
	
	public static boolean GetValBoolen(String ensName, String cfgKey)
	{
		EnsAppCfg cfg = new EnsAppCfg(ensName, cfgKey);
		return cfg.getCfgValOfBoolen();
	}
	
	// 获取数据
	
	// 构造
	/**
	 * 应用配置
	 */
	public EnsAppCfgs()
	{
		
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new EnsAppCfg();
	}
}