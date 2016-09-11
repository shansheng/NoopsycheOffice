package cn.jflow.model.designer;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jflow.common.model.BaseModel;
import cn.jflow.system.ui.core.CheckBox;
import cn.jflow.system.ui.core.LinkButton;
import cn.jflow.system.ui.core.NamesOfBtn;
import cn.jflow.system.ui.core.TextBox;
import cn.jflow.system.ui.core.TextBoxMode;
import BP.WF.Template.Listen;
import BP.WF.Template.ListenAttr;
import BP.WF.Template.Listens;
import BP.WF.Node;
import BP.WF.Nodes;

public class ListenModel extends BaseModel {
	HttpServletRequest request;

	HttpServletResponse response;
	public StringBuilder Pub1 = new StringBuilder();

	public ListenModel(HttpServletRequest request,
			HttpServletResponse response) {
		super(request, response);
		Pub1 = new StringBuilder();
	}

	public String init() {
		// C# TO JAVA CONVERTER NOTE: The following 'switch' operated on a
		// string member and was converted to Java 'if-else' logic:
		// switch (this.DoType)
		// ORIGINAL LINE: case "New":
			if (this.getDoType()!=null&&this.getDoType().equals("New")) {
				return this.BindNew();
			} else {
				return this.BindList();
			}
	}

	public String BindNew() {
		//查询收听列表个数
		Listens ens = new Listens();
		ens.Retrieve(ListenAttr.FK_Node, this.getFK_Node());
		Listen li = new Listen();
		if (this.getRefOID() != 0) {
			li.setOID(this.getRefOID());
			li.Retrieve();
		}
		
		Node nd = new Node(this.getFK_Node());

		this.Pub1
				.append(AddTable("class='Table' cellSpacing='1' cellPadding='1' border='1' style='width:100%'"));
		this.Pub1.append(AddTR());
		this.Pub1.append(AddTD("class='GroupTitle'", "设置收听：" + nd.getName()
				+"<span style='color:red'> ( "+ens.size()+" )<span/>"
				+ " - <a href='Listen.jsp?FK_Node=" + this.getFK_Node()
				+ "' >收听列表</a>"));
		this.Pub1.append(AddTR());
		this.Pub1.append(AddTD("class='GroupTitle'", "选择您要收听的节点（可以选择多个）"));
		this.Pub1.append(AddTREnd());

		this.Pub1.append(AddTR());
		this.Pub1.append(AddTDBegin());

		Nodes nds = new Nodes(nd.getFK_Flow());

		for (Node en : nds.ToJavaList()) {
			if (en.getNodeID() == this.getFK_Node()) {
				continue;
			}

			CheckBox cb = new CheckBox();
			cb.setText("步骤：" + en.getStep() + " - " + en.getName());
			cb.setId("CB_" + en.getNodeID());
			cb.setName("CB_" + en.getNodeID());
			cb.setChecked(li.getNodes().contains("@" + en.getNodeID()));
			this.Pub1.append(cb);
			this.Pub1.append(AddBR());
		}

		this.Pub1.append(AddTDEnd());
		this.Pub1.append(AddTREnd());

		this.Pub1.append(AddTR());
		this.Pub1.append(AddTD("class='GroupTitle'",
				"设置标题(最大长度不超过250个字符，可以包含字段变量变量以@开头)"));
		this.Pub1.append(AddTREnd());

		this.Pub1.append(AddTR());

		TextBox tb = new TextBox();
		tb.setId("TB_Title");
		tb.setName("TB_Title");
		tb.setCols(70);
		tb.addAttr("style", "width:99%");
		tb.setText(li.getTitle());

		this.Pub1.append(AddTDBegin());
		this.Pub1.append(tb);
		this.Pub1.append(AddBR());
		this.Pub1.append("例如：您发起的工作@Title已经被@WebUser.Name处理。");
		this.Pub1.append(AddTDEnd());
		this.Pub1.append(AddTREnd());

		this.Pub1.append(AddTR());
		this.Pub1.append(AddTD("class='GroupTitle'",
				"内容信息(长度不限制，可以包含字段变量变量以@开头)"));
		this.Pub1.append(AddTREnd());

		this.Pub1.append(AddTR());
		this.Pub1.append(AddTDBegin());

		tb = new TextBox();
		tb.setTextMode(TextBoxMode.MultiLine);
		tb.setId("TB_Doc");
		tb.setName("TB_Doc");
		tb.setCols(70);
		tb.setRows(8);
		tb.addAttr("width", "99%");
		tb.setText(li.getDoc());

		this.Pub1.append(tb);
		this.Pub1.append(AddBR());
		this.Pub1.append("例如：处理时间@RDT，您可以登录系统查看处理的详细信息，特此通知。");
		this.Pub1.append(AddTDEnd());
		this.Pub1.append(AddTREnd());

		this.Pub1.append(AddTableEnd());

		this.Pub1.append(AddBR());
		this.Pub1.append(AddSpace(1));

		LinkButton btn = new LinkButton(false, NamesOfBtn.Save.toString(), "保存");
		// LinkButton btn = new LinkButton(false, "Btn_Save", "保存");
		
		// event wireups:
		btn.setHref("btn_Click('" + NamesOfBtn.Save.toString() + "')");
		this.Pub1.append(btn);
		this.Pub1.append(AddSpace(1));
		btn = new LinkButton(false, NamesOfBtn.SaveAndNew.toString(), "保存并新建");
		// btn = new LinkButton(false, "Btn_SaveAndNew", "保存并新建");
		
		// event wireups:
		btn.setHref("btn_Click('" + NamesOfBtn.SaveAndNew.toString() + "')");
		this.Pub1.append(btn);
		this.Pub1.append(AddSpace(1));
		btn = new LinkButton(false, NamesOfBtn.Delete.toString(), "删除");
		// btn = new LinkButton(false, "Btn_Delete", "删除");
		// btn.Attributes["onclick"] = " return confirm('您确认删除吗？');";
		// btn.addAttr("onclick", "return confirm('您确认删除吗？');");
		
		// event wireups:
		// btn.Click += new EventHandler(btn_Del_Click);
		btn.setHref("btn_Del_Click()");

		if (this.getRefOID() == 0) {
			btn.setEnabled(false);
		}

		this.Pub1.append(btn);
		this.Pub1.append(AddBR());
		this.Pub1.append(AddBR());

		this.Pub1.append(AddEasyUiPanelInfo("特别说明",
				"消息以什么样的渠道(短信，邮件)发送出去，是以用户设置的 “信息提示”来确定的。"));
		return Pub1.toString();
	}

	public String BindList() {
		Node nd = new Node(this.getFK_Node());

		Listens ens = new Listens();
		ens.Retrieve(ListenAttr.FK_Node, this.getFK_Node());

		if (ens.size() == 0) {
			String str=null;
			try {
				str=BindNew();
				//response.sendRedirect("Listen.jsp?FK_Node=" + this.getFK_Node()+ "&DoType=New");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return str;
		}

		this.Pub1
				.append(AddTable("class='Table' cellSpacing='1' cellPadding='1' border='1' style='width:100%'"));
		this.Pub1.append(AddTR());
		this.Pub1.append(AddTD("class='GroupTitle' colspan='3'",
				"设置收听：" + nd.getName()+"<span style='color:red'> ( "+ens.size()+" )<span/>" + " - <a href='Listen.jsp?FK_Node="
						+ this.getFK_Node() + "&DoType=New' >新建</a>"));
		this.Pub1.append(AddTREnd());

		this.Pub1.append(AddTR());
		this.Pub1.append(AddTD("class='GroupTitle'", "当前节点"));
		this.Pub1.append(AddTD("class='GroupTitle'", "收听节点"));
		this.Pub1.append(AddTD("class='GroupTitle'", "操作"));
		this.Pub1.append(AddTREnd());

		for (Listen en : ens.ToJavaList()) {
			this.Pub1.append(AddTR());
			this.Pub1.append(AddTD(nd.getName()));
			this.Pub1.append(AddTD(en.getNodes()));
			this.Pub1
					.append(AddTD("<a href='Listen.jsp?FK_Node="
							+ this.getFK_Node()
							+ "&DoType=New&RefOID="
							+ en.getOID()
							+ "' class='easyui-linkbutton' data-options=\"iconCls:'icon-edit'\">编辑</a>"));
			this.Pub1.append(AddTREnd());
		}

		this.Pub1.append(AddTableEnd());
		return Pub1.toString();
	}
}
