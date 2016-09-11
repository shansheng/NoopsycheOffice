package cn.jflow.model.wf.ccform;
//package cn.jflow.model.wf.ccform;
//
//import java.io.BufferedOutputStream;
//import java.io.DataOutputStream;
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileNotFoundException;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.io.OutputStream;
//import java.io.PrintWriter;
//import java.lang.reflect.Field;
//import java.lang.reflect.Modifier;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import net.sf.json.JSONArray;
//import net.sf.json.JSONObject;
//
//import org.apache.commons.io.FileUtils;
//import org.aspectj.runtime.reflect.FieldSignatureImpl;
//import org.aspectj.weaver.ast.Var;
//import cn.jflow.common.model.BaseModel;
//import org.springframework.util.FileCopyUtils;
//
//import com.sun.tools.internal.ws.processor.model.Response;
//
//import BP.DA.DataSet;
//import BP.DA.DataTable;
//import BP.DA.DataType;
//import BP.En.Entity;
//import BP.Port.WebUser;
//import BP.Sys.GEDtl;
//import BP.Sys.GEDtlAttr;
//import BP.Sys.GEDtls;
//import BP.Sys.GEEntityExcelFrm;
//import BP.Sys.Glo;
//import BP.Sys.SystemConfig;
//import BP.Sys.ToolbarExcel;
//import BP.Sys.Frm.MapAttr;
//import BP.Sys.Frm.MapAttrs;
//import BP.Sys.Frm.MapDtl;
//import BP.Sys.Frm.MapDtls;
//import BP.Sys.Frm.MapExt;
//import BP.Sys.Frm.MapExtAttr;
//import BP.Sys.Frm.MapExtXmlList;
//import BP.Sys.Frm.MapExts;
//import BP.Sys.Frm.ToolbarExcelSln;
//import BP.Tools.DataTableConvertJson;
//import BP.Tools.StringHelper;
//import BP.WF.RefObject;
//import BP.WF.Template.FrmNode;
//import BP.WF.Template.FrmField;
//import BP.WF.Template.FrmFields;
//
//public class FrmExcelModel extends BaseModel {
//
//	public FrmExcelModel(HttpServletRequest request,
//			HttpServletResponse response) {
//		super(request, response);
//	}
//
//	public final String getFK_Flow() {
//		String fk_flow = getParameter("FK_Flow");
//		return fk_flow;
//	}
//
//	public final int getFK_Node() {
//		try {
//			String nodeid = getParameter("NodeID");
//			if (nodeid == null) {
//				nodeid = getParameter("FK_Node");
//			}
//			return Integer.parseInt(nodeid);
//		} catch (java.lang.Exception e) {
//			if (StringHelper.isNullOrEmpty(this.getFK_Flow())) {
//				return 0;
//			} else {
//				return Integer.parseInt(this.getFK_Flow()); // 0; 有可能是流程调用流程表单。
//			}
//		}
//	}
//
//	// 继承父类的workid
//	public final String getWorkId() {
//		return String.valueOf(getWorkID());
//	}
//
//	public final int getOID() {
//		String oid = String.valueOf(getWorkID());
//		if (StringHelper.isNullOrEmpty(oid)) {
//			oid = getParameter("OID");
//		}
//		return Integer.parseInt(oid);
//	}
//
//	/**
//	 * 延续流程ID
//	 */
//	public final int getCWorkID() {
//		try {
//			return Integer.parseInt(getParameter("CWorkID"));
//		} catch (java.lang.Exception e) {
//			return 0;
//		}
//	}
//
//	/**
//	 * 父流程ID
//	 */
//	public final int getPWorkID() {
//		try {
//			return Integer.parseInt(getParameter("PWorkID"));
//		} catch (java.lang.Exception e) {
//			return 0;
//		}
//	}
//
//	/**
//	 * 流程ID
//	 */
//	// public final int getFID() {
//	// try {
//	// return Integer.parseInt(getfi getParameter("FID"));
//	// } catch (java.lang.Exception e) {
//	// return 0;
//	// }
//	// }
//
//	public final String getFK_MapData() {
//		String s = getParameter("FK_MapData");
//
//		return s;
//	}
//
//	/**
//	 * SID
//	 */
//	public final String getSID() {
//		return getParameter("SID");
//	}
//
//	/**
//	 * 是否打印？
//	 */
//	private boolean privateIsPrint;
//
//	public final boolean getIsPrint() {
//		return privateIsPrint;
//	}
//
//	public final void setIsPrint(boolean value) {
//		privateIsPrint = value;
//	}
//
//	/**
//	 * 是否编辑？
//	 */
//	private boolean privateIsEdit;
//
//	public final boolean getIsEdit() {
//		return privateIsEdit;
//	}
//
//	public final void setIsEdit(boolean value) {
//		privateIsEdit = value;
//	}
//
//	/**
//	 * 是否留痕？
//	 */
//	private boolean privateIsMarks;
//
//	public final boolean getIsMarks() {
//		return privateIsMarks;
//	}
//
//	public final void setIsMarks(boolean value) {
//		privateIsMarks = value;
//	}
//
//	/**
//	 * 用户编号
//	 */
//	private String privateUserName;
//
//	public final String getUserName() {
//		return privateUserName;
//	}
//
//	public final void setUserName(String value) {
//		privateUserName = value;
//	}
//
//	private boolean privateIsCheck;
//
//	public final boolean getIsCheck() {
//		return privateIsCheck;
//	}
//
//	public final void setIsCheck(boolean value) {
//		privateIsCheck = value;
//	}
//
//	/**
//	 * 是否是第一次打开Word表单
//	 */
//	private String privateIsFirsts;
//
//	public final String getIsFirsts() {
//		return privateIsFirsts;
//	}
//
//	public final void setIsFirsts(String value) {
//		privateIsFirsts = value;
//	}
//
//	/**
//	 * 填充的主表JSON数据，为含有key,value的数组
//	 */
//	private String privateReplaceParams;
//
//	public final String getReplaceParams() {
//		return privateReplaceParams;
//	}
//
//	public final void setReplaceParams(String value) {
//		privateReplaceParams = value;
//	}
//
//	/**
//	 * 填充的主表属性名组织的JSON数据,为String数组
//	 */
//	private String privateReplaceFields;
//
//	public final String getReplaceFields() {
//		return privateReplaceFields;
//	}
//
//	public final void setReplaceFields(String value) {
//		privateReplaceFields = value;
//	}
//
//	/**
//	 * 填充的明细表数据JSON数据，为对象数组
//	 */
//	private String privateReplaceDtls;
//
//	public final String getReplaceDtls() {
//		return privateReplaceDtls;
//	}
//
//	public final void setReplaceDtls(String value) {
//		privateReplaceDtls = value;
//	}
//
//	/**
//	 * 填充的明细表编号JSON数据，为String数组。
//	 */
//	private String privateReplaceDtlNos;
//
//	public final String getReplaceDtlNos() {
//		return privateReplaceDtlNos;
//	}
//
//	public final void setReplaceDtlNos(String value) {
//		privateReplaceDtlNos = value;
//	}
//
//	/**
//	 * 要显示的excel表单的FK_MapData编号集合，为String数组
//	 */
//	private String privateFK_MapDatas;
//
//	public final String getFK_MapDatas() {
//		return privateFK_MapDatas;
//	}
//
//	public final void setFK_MapDatas(String value) {
//		privateFK_MapDatas = value;
//	}
//
//	/**
//	 * 每个excel表单对应的权限集合，为对象数组，格式如：[{"ExcelBSD1":{"OfficeSaveEnable":true,...}},{
//	 * "ExcelBSD2":{"OfficeSaveEnable":false,...}]
//	 */
//	private String privateToolbarSlns;
//
//	public final String getToolbarSlns() {
//		return privateToolbarSlns;
//	}
//
//	public final void setToolbarSlns(String value) {
//		privateToolbarSlns = value;
//	}
//
//	/**
//	 * 填充的主表属性控制，存储在Sys_FrmSln表中各字段的可用性等控制，为对象数组，格式如：[{"ExcelBSD1":[{"Field":
//	 * "aaa","UIVisible":true,"UIIsEnable":true,"IsNotNull":true},{...}]},{
//	 * "ExcelBSD2"
//	 * :[{"Field":"bbb","UIVisible":true,"UIIsEnable":false,"IsNotNull"
//	 * :false},{...}]}]
//	 */
//	private String privateReplaceFieldCtrls;
//
//	public final String getReplaceFieldCtrls() {
//		return privateReplaceFieldCtrls;
//	}
//
//	public final void setReplaceFieldCtrls(String value) {
//		privateReplaceFieldCtrls = value;
//	}
//
//	/**
//	 * 记录每个excel表单是否是第一次加载
//	 */
//	private java.util.HashMap<String, Boolean> privatefirsts;
//
//	public final java.util.HashMap<String, Boolean> getfirsts() {
//		return privatefirsts;
//	}
//
//	public final void setfirsts(java.util.HashMap<String, Boolean> value) {
//		privatefirsts = value;
//	}
//
//	/**
//	 * 定义一个权限控制变量.
//	 */
//	public ToolbarExcel toolbar = new ToolbarExcel();
//
//	// /#endregion 属性
//
//	private String[] fk_mapdatas = null;
//
//	private StringBuffer divMenu;
//
//	private String fileName;
//
//	private String fileType;
//
//	public String getFileName() {
//		return fileName;
//	}
//
//	public String getFileType() {
//		return fileType;
//	}
//
//	public String getDivMenu() {
//		return divMenu.toString();
//	}
//
//	public void loadPage() {
//		// WebUser.SignInOfGener(new BP.Port.Emp("fuhui"));
//
//		setUserName(WebUser.getName());
//		if (StringHelper.isNullOrEmpty(this.getFK_MapData())) {
//			divMenu = new StringBuffer();
//			divMenu.append("<h1 style='color:red'>必须传入参数FK_Mapdata!<h1>");
//			return;
//		}
//
//		fk_mapdatas = getFK_MapData().split(",");
//
//		// 获得外部的标记。
//		String type = getParameter("action");
//		if (StringHelper.isNullOrEmpty((type))) {
//			// * 第一次进来，的时候，没有标记。
//			// 初始化它的解决方案. add by stone. 2015-01-25. 增加权限控制方案，以在不同的节点实现不同的控制.
//
//			// qin .net IsNullOrWhiteSpace方法比isNullOrEmpty 严禁 java没有此方法
//			setIsEdit(StringHelper.isNullOrEmpty(getParameter("IsEdit")) ? true
//					: getParameter("IsEdit").equals("1"));
//
//			setIsPrint(StringHelper.isNullOrEmpty(getParameter("IsPrint")) ? true
//					: getParameter("IsPrint").equals("1"));
//
//			GenerateToolbarSlns();
//		} else {
//			if (type.equals("LoadFile")) {
//				LoadFile();
//				return;
//			}
//
//			if (type.equals("SaveFile")) {
//				SaveFile(fk_mapdatas);
//				SaveFieldInfos(fk_mapdatas);
//				return;
//			}
//
//			throw new RuntimeException("@没有处理的标记错误:" + type);
//		}
//
//		setfirsts(new java.util.HashMap<String, Boolean>());
//		GEEntityExcelFrm en = null;
//		File tmpFile = null;
//		File excelFile = null;
//		FrmFields frmFields = null;
//
//		// 检查数据文件是否存在？如果存在并打开不存在并copy模版。
//
//		String root = SystemConfig.getPathOfDataUser()
//				+ "\\FrmOfficeTemplate\\";
//
//		File rootInfo = new File(root);
//
//		boolean isFirst = false;
//		if (!rootInfo.exists()) {
//			try {
//				rootInfo.createNewFile();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//
//		setReplaceParams("[");
//		setReplaceFields("[");
//		setReplaceDtlNos("[");
//		setReplaceDtls("[");
//		setIsFirsts("[");
//		setFK_MapDatas("[");
//		setReplaceFieldCtrls("[");
//
//		// 根据excel表单no来处理各自的信息
//		int pk = 0;
//
//		for (String fk_md : fk_mapdatas) {
//			// 创建excel数据实体.
//			en = new GEEntityExcelFrm(fk_md);
//
//			File[] files = rootInfo.listFiles();
//
//			// 判断是否有这个数据文件.
//			if (files.length == 0) {
//				throw new RuntimeException(
//						"<h3>Excel表单模板文件不存在，请确认已经上传Excel表单模板，该模版的位于服务器："
//								+ rootInfo.getPath() + "</h3>");
//			}
//
//			setFK_MapDatas(getFK_MapDatas() + "{\"Name\":\"" + en.getClassID()
//					+ "\",\"Text\":\"" + en.getEnDesc() + "\"},");
//
//			// 检查数据目录文件是否存在？
//
//			String pathDir = SystemConfig.getPathOfDataUser()
//					+ "\\FrmOfficeFiles\\" + fk_md;
//			File pathDirFile = new File(pathDir);
//
//			if (!pathDirFile.exists()) {
//				try {
//					pathDirFile.createNewFile();
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//			}
//
//			// 判断who is pk
//			pk = GetPK(fk_md);
//			if (pk == 0) {
//				return;
//			}
//
//			// 初始化数据文件.
//			tmpFile = files[0];
//
//			// 获取文件的扩展名 qin add
//			String tmpFileExt = tmpFile.toString().substring(
//					tmpFile.toString().lastIndexOf((".")));
//
//			excelFile = new File(pathDir + "\\" + pk + tmpFileExt);
//
//			if (!excelFile.exists()) {
//				// 如果不存在就copy 一个副本。 qin edit java 小文件采取先全部读取，再全部写入的方式
//				File inputFile = new File(tmpFile.getPath());
//				File outputFile = new File(excelFile.getPath());
//
//				byte b[] = new byte[(int) inputFile.length()];
//
//				try {
//					FileInputStream inputStream;
//
//					inputStream = new FileInputStream(inputFile);
//					inputStream.read(b);
//					// 一次性读入
//
//					FileOutputStream outputStream;
//					outputStream = new FileOutputStream(outputFile);
//					outputStream.write(b);
//
//				} catch (FileNotFoundException e) {
//					e.printStackTrace();
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//				// 一次性写入
//
//				isFirst = true;
//			} else {
//				// edited by
//				// liuxc,2015-3-25,此处增加判断，如果模板文件与生成的数据文件的最后修改时间是一致的，表明此数据文件还没有经过修改，也标识为第一次，加载填充数据信息
//
//				// qin edit 区别.net的返回值类型DateTime
//				if (excelFile.lastModified() == tmpFile.lastModified()) {
//					isFirst = true;
//				} else {
//					isFirst = true;
//				}
//			}
//
//			getfirsts().put(fk_md, isFirst);
//			setIsFirsts(getIsFirsts() + "{\"" + fk_md + "\":"
//					+ (new Boolean(isFirst)).toString().toLowerCase() + "},");
//
//			// edited by
//			// liuxc,2015-1-30,如果在构造中使用传递OID的构造函数，则下面的Save时，第一次会插入不成功，此处是因为insert时判断OID不为0则认为是已经存在的记录，实际上此处还没有存在，所以使用下面的逻辑进行判断，如果没有该条记录，则插入新记录
//			en.setOID(pk);
//
//			if (en.getIsExits() == false) {
//				try {
//					en.InsertAsOID(pk);
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			} else {
//				en.Retrieve();
//			}
//
//			// 给实体赋值.
//			en.setFilePath(excelFile.getPath());
//
//			Date nowTime = new Date();
//			SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//			en.setRDT(time.format(nowTime));
//
//			en.setLastEditer(WebUser.getName());
//			en.ResetDefaultVal();
//
//			// 接受外部参数数据。
//			ArrayList<String> parasKeys = Glo.getQueryStringKeys();
//			for (String key : parasKeys) {
//				en.SetValByKey(key, getParameter(key));
//			}
//
//			// String[] paras =this.get_request() this.RequestParas.split("[&]",
//			// -1);
//			// for (String str : paras) {
//			// if (string.isNullOrEmpty(str)
//			// || str.contains("=") == false) {
//			// continue;
//			// }
//			// String[] kvs = str.split("[=]", -1);
//			// en.SetValByKey(kvs[0], kvs[1]);
//			// }
//
//			en.Save(); // 执行保存.
//
//			// 装载数据。
//			setReplaceParams(getReplaceParams() + "{\"" + fk_md + "\":");
//			setReplaceFields(getReplaceFields() + "{\"" + fk_md + "\":");
//			setReplaceDtlNos(getReplaceDtlNos() + "{\"" + fk_md + "\":");
//			setReplaceDtls(getReplaceDtls() + "{\"" + fk_md + "\":");
//			setReplaceFieldCtrls(getReplaceFieldCtrls() + "{\"" + fk_md
//					+ "\":[");
//
//			this.LoadFrmData(fk_md, en);
//
//			// 字段控制
//			frmFields = new FrmFields(fk_md, getFK_Node());
//			for (FrmField frmField : frmFields.ToJavaList()) {
//				setReplaceFieldCtrls(getReplaceFieldCtrls()
//						+ String.format(
//								"{{\"{0}\":{{\"Name\":\"{1}\",\"UIVisible\":{2},\"UIIsEnable\":{3},\"IsNotNull\":{4},\"OldValue\":\"{5}\"}}}},",
//								frmField.getKeyOfEn(),
//								frmField.getName(),
//								String.valueOf(frmField.getUIVisible())
//										.toLowerCase(),
//								String.valueOf(frmField.getUIIsEnable())
//										.toLowerCase(),
//								String.valueOf(frmField.getIsNotNull())
//										.toLowerCase(),
//								frmField.getUIIsEnable() ? "" : en
//										.GetValStringByKey(
//												frmField.getKeyOfEn(), "")));
//			}
//
//			setReplaceParams(getReplaceParams() + "},");
//			setReplaceFields(getReplaceFields() + "},");
//			setReplaceDtlNos(getReplaceDtlNos() + "},");
//			setReplaceDtls(getReplaceDtls() + "},");
//			setReplaceFieldCtrls(StringHelper.trimEnd(getReplaceFieldCtrls(),
//					',') + "]},");
//		}
//
//		setReplaceParams(StringHelper.trimEnd(getReplaceParams(), ',') + "]");
//		setReplaceFields(StringHelper.trimEnd(getReplaceFields(), ',') + "]");
//		setReplaceDtlNos(StringHelper.trimEnd(getReplaceDtlNos(), ',') + "]");
//		setReplaceDtls(StringHelper.trimEnd(getReplaceDtls(), ',') + "]");
//		setIsFirsts(StringHelper.trimEnd(getIsFirsts(), ',') + "]");
//		setFK_MapDatas(StringHelper.trimEnd(getFK_MapDatas(), ',') + "]");
//		setReplaceFieldCtrls(StringHelper.trimEnd(getReplaceFieldCtrls(), ',')
//				+ "]");
//
//		// 替换掉 word 里面的数据.
//		// 获取excelFile文件的扩展名
//		String excelFileExt = excelFile.toString().substring(
//				excelFile.toString().lastIndexOf((".")));
//
//		fileName = "@\\" + fk_mapdatas[0] + "\\" + pk + excelFileExt;
//		fileType = excelFileExt.substring(1);
//	}
//
//	/**
//	 * 计算PK值
//	 * 
//	 * @param fk_md
//	 *            FK_MapData
//	 * @return
//	 */
//	private int GetPK(String fk_md) {
//		int pk = this.getOID();
//		FrmNode fn = new FrmNode(this.getFK_Flow(), this.getFK_Node(), fk_md);
//
//		switch (fn.getWhoIsPK()) {
//		case FID:
//			pk = Integer.parseInt(String.valueOf(getFID()));
//			if (pk == 0) {
//				throw new RuntimeException("@没有接收到参数FID");
//			}
//			break;
//		case CWorkID: // 延续流程ID
//			pk = this.getCWorkID();
//			if (pk == 0) {
//				throw new RuntimeException("@没有接收到参数CWorkID");
//			}
//			break;
//		case PWorkID: // 父流程ID
//			pk = this.getPWorkID();
//			if (pk == 0) {
//				throw new RuntimeException("@没有接收到参数PWorkID");
//			}
//			break;
//		default:
//			break;
//		}
//
//		return pk;
//	}
//
//	/**
//	 * 生成各FK_MapData对应的权限控制json字符串，应用于前端JS控制相应的显示
//	 */
//	private void GenerateToolbarSlns() {
//		FrmNode fn = null;
//		ToolbarExcelSln toobarsln = null;
//		setToolbarSlns("[");
//
//		for (String fk_mapdata : fk_mapdatas) {
//			setToolbarSlns(getToolbarSlns() + "{\"" + fk_mapdata + "\":");
//
//			if (!StringHelper.isNullOrEmpty(this.getFK_Flow())) {
//				// 接受到了流程编号，就要找到他的控制方案.
//				fn = new FrmNode(this.getFK_Flow(), this.getFK_Node(),
//						fk_mapdata);
//				if (fn.getFrmSln() == 1) {
//					// 如果是自定义方案.
//					toobarsln = new ToolbarExcelSln(this.getFK_Flow(),
//							this.getFK_Node(), fk_mapdata);
//					toolbar.setRow(toobarsln.getRow());
//				} else {
//					// 非自定义方案就取默认方案.
//					toolbar = new ToolbarExcel(fk_mapdata);
//				}
//			} else {
//				// 没有找打他的控制方案，就取默认方案.
//				toolbar = new ToolbarExcel(fk_mapdata);
//			}
//
//			setToolbarSlns(getToolbarSlns() + GetToolbarSlnJsonString(toolbar)
//					+ "},");
//		}
//
//		setToolbarSlns(StringHelper.trimEnd(getToolbarSlns(), ',') + "]");
//	}
//
//	/**
//	 * 生成权限控制的对象json字符串
//	 * 
//	 * @param toolbar
//	 *            权限控制对象
//	 * @return
//	 */
//	private String GetToolbarSlnJsonString(ToolbarExcel toolbar) {
//		String json = "{";
//
//		Class clazz = toolbar.getClass();
//
//		Field[] fields = clazz.getFields();
//		String typeName = "";
//		String name = "";
//		String value = null;
//		for (Field field : fields) {
//			if (field.getModifiers() != Modifier.PUBLIC) {
//				continue;
//			}
//			// String, Boolean
//			typeName = field.getType().getSimpleName();
//			name = field.getName();
//
//			if (!name.startsWith("Office")) {
//				continue;
//			}
//
//			value = toolbar.GetValStrByKey(name);
//
//			if (typeName.equalsIgnoreCase("Boolean")) {
//				json += "\"" + name + "\":" + value.toLowerCase() + ",";
//			}
//			// ORIGINAL LINE: case "String":
//			else if (typeName.equalsIgnoreCase("String")) {
//				json += "\"" + name + "\":\"" + ((value != null) ? value : "")
//						+ "\",";
//			}
//
//		}
//
//		return StringHelper.trimEnd(json, ',') + "}";
//	}
//
//	/**
//	 * 保存从word中提取的数据
//	 * 
//	 * @param fk_mds
//	 *            excel表单的编号
//	 */
//	private void SaveFieldInfos(String[] fk_mds) {
//
//		for (String fk_md : fk_mds) {
//			MapExts mes = new MapExts(fk_md);
//			if (mes.size() == 0) {
//				return;
//			}
//
//			Object tempVar = mes.GetEntityByKey(MapExtAttr.ExtType,
//					MapExtXmlList.PageLoadFull);
//
//			MapExt item = (MapExt) ((tempVar instanceof MapExt) ? tempVar
//					: null);
//			if (item == null) {
//				return;
//			}
//
//			int fieldCount = 0;
//
//			String prefix = "field_" + fk_md;
//			boolean isParseValue = false;
//			ArrayList<String> allkeys = Glo.getQueryStringKeys();
//			for (String key : allkeys) {
//				int idx = 0;
//
//				try {
//					idx = Integer.parseInt(key.substring(prefix.length()));
//					isParseValue = true;
//				} catch (Exception e) {
//					isParseValue = false;
//				}
//
//				boolean tempVar2 = key.startsWith(prefix)
//						&& key.length() > prefix.length() && isParseValue;
//				if (tempVar2) {
//					fieldCount++;
//				}
//			}
//
//			String fieldsJson = "";
//			for (int i = 0; i < fieldCount; i++) {
//				fieldsJson += getParameter(prefix + i);
//			}
//
//			// var fieldsJson = Request["field"];
//
//			// 更新主表数据
//			GEEntityExcelFrm en = new GEEntityExcelFrm(fk_md);
//			int pk = GetPK(fk_md);
//			en.setOID(pk);
//			// var pk = en.OID = GetPK(fk_md);
//
//			if (en.RetrieveFromDBSources() == 0) {
//				throw new RuntimeException("OID=" + pk + "的数据在" + fk_md
//						+ "中不存在，请检查！");
//			}
//
//			// 此处因为weboffice在上传的接口中，只有上传成功与失败的返回值，没有具体的返回信息参数，所以未做异常处理
//
//			// for (var field : fields)
//			// {
//			// en.SetValByKey(field.key, field.value);
//			// }
//			List<ReplaceField> list = JsonPluginsUtil.jsonToBeanList(
//					fieldsJson, ReplaceField.class);
//			for (ReplaceField replaceField : list) {
//				en.SetValByKey(replaceField.getkey(), replaceField.getvalue());
//			}
//			en.setLastEditer(WebUser.getName());
//			en.setRDT(DataType.getCurrentDataTime());
//			en.Update();
//
//			// todo:更新明细表数据，此处逻辑可能还有待商榷
//			MapDtls mdtls = new MapDtls(fk_md);
//			if (mdtls.size() == 0) {
//				return;
//			}
//
//			int dtlsCount = 0;
//			prefix = "dtls_" + fk_md;
//
//			boolean isParseV = false;
//			ArrayList<String> AllKeys = Glo.getQueryStringKeys();
//			for (String key : AllKeys) {
//				int idx = 0;
//				try {
//					idx = Integer.parseInt(key.substring(prefix.length()));
//					isParseV = true;
//				} catch (Exception e) {
//					isParseV = false;
//				}
//				boolean tempVar3 = key.startsWith(prefix)
//						&& key.length() > prefix.length() && isParseV;
//				if (tempVar3) {
//					dtlsCount++;
//				}
//			}
//
//			String dtlsJson = "";
//			for (int i = 0; i < dtlsCount; i++) {
//				dtlsJson += getParameter(prefix + i);
//			}
//			List<ReplaceDtlTable> dtls = JsonPluginsUtil.jsonToBeanList(
//					dtlsJson, ReplaceDtlTable.class);
//			// var dtlsJson = Request["dtls"];
//			// var dtls =
//			// LitJson.JsonMapper.<java.util.ArrayList<ReplaceDtlTable>>ToObject(HttpUtility.UrlDecode(dtlsJson));
//			GEDtls gedtls = null;
//			GEDtl gedtl = null;
//			ReplaceDtlTable wdtl = null;
//
//			for (MapDtl mdtl : mdtls.ToJavaList()) {
//				// 需要遍历，在java中
//				for (ReplaceDtlTable entity : dtls) {
//					if (entity.getdtlno().equals(mdtl.getNo())) {
//						wdtl = entity;
//						break;
//					}
//				}
//				// wdtl = dtls.FirstOrDefault(o => o.dtlno == mdtl.getNo());
//
//				if (wdtl == null || wdtl.getdtl().size() == 0) {
//					continue;
//				}
//
//				// 此处不是真正意义上的更新，因为不知道明细表的主键，只能将原明细表中的数据删除掉，然后再重新插入新的数据
//				gedtls = new GEDtls(mdtl.getNo());
//				gedtls.Delete(GEDtlAttr.RefPK, en.getPKVal());
//
//				for (ReplaceDtlRow d : wdtl.getdtl()) {
//					gedtl = (GEDtl) ((gedtls.getGetNewEntity() instanceof GEDtl) ? gedtls
//							.getGetNewEntity() : null);
//
//					for (ReplaceField cell : d.getcells()) {
//						gedtl.SetValByKey(cell.getkey(), cell.getvalue());
//					}
//
//					gedtl.setRefPK(en.getPKVal().toString());
//					gedtl.setRDT(DataType.getCurrentDataTime());
//					gedtl.setRec(WebUser.getNo());
//					gedtl.Insert();
//				}
//			}
//		}
//	}
//
//	private static Object asyncObj = new Object();
//
//	/**
//	 * 装载文件.
//	 */
//	private void LoadFile() {
//		synchronized (asyncObj) {
//			String name = getParameter("fileName");
//
//			String path = SystemConfig.getPathOfDataUser() + "\\FrmOfficeFiles"
//					+ name;
//
//			FileInputStream fileStr = new FileInputStream(path);
//			int i = fileStr.available();
//
//			byte data[] = new byte[i];
//			fileStr.read(data);
//			
//			OutputStream outClient= response.getOutputStream();
//
//			DataOutputStream out = new DataOutputStream(
//					new BufferedOutputStream(new FileOutputStream(path)));
//
//			try {
//				File file = new File(path);
//				FileInputStream fileInputStream = new FileInputStream(file);
//				byte[] result = TL.FileUtils.readAsByteArray(fileInputStream);
//				PrintWriter out = get_response().getWriter();
//				out.print(result);
//				out.flush();
//				out.close();
//
//			} catch (FileNotFoundException e) {
//				e.printStackTrace();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//			// Response.Clear();
//			// Response.BinaryWrite(result);
//			// Response.End();
//		}
//	}
//
//	/**
//	 * 生成要返回给page的Json数据.
//	 * 
//	 * @param fk_md
//	 * @param en
//	 */
//	public final void LoadFrmData(String fk_md, Entity en) {
//		ReplaceFieldList dictParams = new ReplaceFieldList(); // 主表参数值集合
//		java.util.ArrayList<String> fields = new java.util.ArrayList<String>(); // 主表参数名集合
//
//		dictParams.Add("No", WebUser.getNo(), "string");
//		dictParams.Add("Name", WebUser.getName(), "string");
//		dictParams.Add("FK_Dept", WebUser.getFK_Dept(), "string");
//		dictParams.Add("FK_DeptName", WebUser.getFK_DeptName(), "string");
//
//		MapExts mes = new MapExts(fk_md);
//		Object tempVar = mes.GetEntityByKey(MapExtAttr.ExtType,
//				MapExtXmlList.PageLoadFull);
//		MapExt item = (MapExt) ((tempVar instanceof MapExt) ? tempVar : null);
//		// 把数据装载到表里，包括从表数据，主表数据未存储.
//		MapDtls dtls = new MapDtls(fk_md);
//		MapAttrs mattrs = new MapAttrs(fk_md);
//		en = BP.WF.Glo.DealPageLoadFull(en, item, mattrs, dtls); // 处理表单装载数据.
//
//		// MapData md=new MapData(this.FK_MapData);
//		for (MapAttr mapattr : mattrs.ToJavaList()) {
//			fields.add(mapattr.getKeyOfEn());
//			dictParams.Add(mapattr.getKeyOfEn(),
//					en.GetValStringByKey(mapattr.getKeyOfEn()),
//					mapattr.getIsSigan() ? "sign" : "string");
//		}
//		setReplaceParams(getReplaceParams()
//				+ (getfirsts().get(fk_md) ? GenerateParamsJsonString(dictParams)
//						: "[]"));
//
//		// 生成json格式。
//		setReplaceFields(getReplaceFields() + GenerateFieldsJsonString(fields));
//
//		if (item == null || StringHelper.isNullOrEmpty(item.getTag1())
//				|| item.getTag1().length() < 15) {
//			setReplaceDtls(getReplaceDtls() + "[]");
//			setReplaceDtlNos(getReplaceDtlNos() + "[]");
//			return;
//		}
//
//		java.util.ArrayList<String> replaceDtlNos = new java.util.ArrayList<String>();
//		DataSet ds = new DataSet();
//		DataTable table = null;
//
//		String sql = "";
//		int pk = GetPK(fk_md);
//
//		// 填充从表.
//		for (MapDtl dtl : dtls.ToJavaList()) {
//			replaceDtlNos.add(dtl.getNo());
//
//			if (!getfirsts().get(fk_md)) {
//				continue;
//			}
//
//			sql = "SELECT * FROM " + dtl.getPTable() + " WHERE RefPK='" + pk
//					+ "'";
//			table = BP.DA.DBAccess.RunSQLReturnTable(sql);
//			table.TableName = dtl.getNo();
//			ds.Tables.add(table);
//		}
//
//		// 从表数据.
//		setReplaceDtls(getReplaceDtls()
//				+ (getfirsts().get(fk_md) ? DataTableConvertJson
//						.Dataset2Json(ds) : "[]"));
//		setReplaceDtlNos(getReplaceDtlNos()
//				+ GenerateFieldsJsonString(replaceDtlNos));
//	}
//
//	/**
//	 * 转换键值集合为json字符串
//	 * 
//	 * @param dictParams
//	 *            键值集合
//	 * @return
//	 */
//	private String GenerateParamsJsonString(ReplaceFieldList dictParams)
//			{
//	//ORIGINAL LINE: return "[" + dictParams.Aggregate(String.Empty, (curr, next) => curr + String.Format("{{\"key\":\"{0}\",\"value\":\"{1}\",\"type\":\"{2}\"}},", next.key, ((next.value != null) ? next.value : "").Replace("\\", "\\\\").Replace("'", "\'"), next.type)).TrimEnd(',') + "]";
//				return "[" + dictParams.Aggregate("", (curr, next) => curr + String.format("%s},", next.key, ((next.value != null) ? next.value : "").Replace("\\", "\\\\").Replace("'", "\'"), next.type)).TrimEnd(',') + "]";
//			}
//
//	/**
//	 * 转换String集合为json字符串
//	 * 
//	 * @param fields
//	 *            String集合
//	 * @return
//	 */
//	private String GenerateFieldsJsonString(java.util.ArrayList<String> fields) {
//		return JsonPluginsUtil.beanListToJson(fields);
//	}
//
//	private void SaveFile(String[] fk_mds) {
//		try {
//			HttpFileCollection files = HttpContext.Current.Request.Files;
//
//			if (files.size() > 0) {
//				// 检查文件扩展名字
//				HttpPostedFile postedFile = files[0];
//
//				String fileName = Path.GetFileName(getParameter("filename"));
//
//				for (String fk_md : fk_mds) {
//
//					String path = SystemConfig.getPathOfDataUser()
//							+ "\\FrmOfficeFiles\\" + fk_md;
//
//					if (!fileName.equals("")) {
//						postedFile.SaveAs(path + "\\" + fileName);
//
//						GEEntityExcelFrm en = new GEEntityExcelFrm(fk_md);
//						en.RetrieveFromDBSources();
//
//						en.setLastEditer(WebUser.getName());
//
//						SimpleDateFormat sdf = new SimpleDateFormat(
//								"yyyy-MM-dd HH:mm:ss");
//						String time = sdf.format(new Date());
//
//						en.setRDT(time);
//						en.Update();
//					}
//				}
//			}
//		} catch (RuntimeException e) {
//			throw e;
//		}
//	}
//
//	// /#region 用于和前端JS进行JSON交互定义的辅助类
//	/**
//	 * 字段
//	 */
//	class ReplaceField {
//		/**
//		 * 字段名称
//		 */
//		private String privatekey;
//
//		public final String getkey() {
//			return privatekey;
//		}
//
//		public final void setkey(String value) {
//			privatekey = value;
//		}
//
//		/**
//		 * 字段值
//		 */
//		private String privatevalue;
//
//		public final String getvalue() {
//			return privatevalue;
//		}
//
//		public final void setvalue(String value) {
//			privatevalue = value;
//		}
//
//		/**
//		 * 类型
//		 */
//		private String privatetype;
//
//		public final String gettype() {
//			return privatetype;
//		}
//
//		public final void settype(String value) {
//			privatetype = value;
//		}
//	}
//
//	class ReplaceFieldList extends java.util.ArrayList<ReplaceField> {
//		public final void Add(String _key, String _value, String _type) {
//			ReplaceField tempVar = new ReplaceField();
//			tempVar.setkey(_key);
//			tempVar.setvalue(_value);
//			tempVar.settype(_type);
//			add(tempVar);
//		}
//	}
//
//	/**
//	 * 明细表
//	 */
//	class ReplaceDtlTable {
//		/**
//		 * 明细表编号
//		 */
//		private String privatedtlno;
//
//		public final String getdtlno() {
//			return privatedtlno;
//		}
//
//		public final void setdtlno(String value) {
//			privatedtlno = value;
//		}
//
//		/**
//		 * 明细表行集合
//		 */
//		private java.util.ArrayList<ReplaceDtlRow> privatedtl;
//
//		public final java.util.ArrayList<ReplaceDtlRow> getdtl() {
//			return privatedtl;
//		}
//
//		public final void setdtl(java.util.ArrayList<ReplaceDtlRow> value) {
//			privatedtl = value;
//		}
//	}
//
//	/**
//	 * 明细表行
//	 */
//	class ReplaceDtlRow {
//		/**
//		 * 行序号
//		 */
//		private String privaterowid;
//
//		public final String getrowid() {
//			return privaterowid;
//		}
//
//		public final void setrowid(String value) {
//			privaterowid = value;
//		}
//
//		/**
//		 * 行单元格数据集合
//		 */
//		private ReplaceFieldList privatecells;
//
//		public final ReplaceFieldList getcells() {
//			return privatecells;
//		}
//
//		public final void setcells(ReplaceFieldList value) {
//			privatecells = value;
//		}
//	}
//	// /#endregion
//}
