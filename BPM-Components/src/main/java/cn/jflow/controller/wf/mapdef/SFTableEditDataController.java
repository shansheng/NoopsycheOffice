package cn.jflow.controller.wf.mapdef;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.jflow.common.model.TempObject;
import cn.jflow.common.util.PingYinUtil;
import cn.jflow.controller.wf.workopt.BaseController;
import cn.jflow.system.ui.core.BaseWebControl;
import cn.jflow.system.ui.core.HtmlUtils;
import BP.En.QueryObject;
import BP.Sys.GENoName;
import BP.Sys.GENoNames;

@Controller
@RequestMapping("/WF/MapDef")
public class SFTableEditDataController extends BaseController {
	@RequestMapping(value = "/btn_Click3", method = RequestMethod.POST)
	public void btn_Click(TempObject object, HttpServletRequest request,
			HttpServletResponse response) {
		//批量保存数据。
		GENoNames ens = new GENoNames(this.getRefNo(), "sdsd");
		QueryObject qo = new QueryObject(ens);
		qo.DoQuery("No", 10, this.getPageIdx(), false);
		for (GENoName myen : ens.ToJavaList())
		{
			String no = myen.getNo();
			String name1 = request.getParameter("TB_" + myen.getNo());
			if (name1.equals(""))
			{
				continue;
			}
			BP.DA.DBAccess.RunSQL("update " + this.getRefNo() + " set Name='" + name1 + "' WHERE no='" + no + "'");
		}


		GENoName en = new GENoName(this.getRefNo(), "sd");
		String name = request.getParameter("TB_Name");
		if (name.length() > 0)
		{
			en.setName(name);
			en.setNo(en.getGenerNewNo());
			//en.setNo(PingYinUtil.getFirstSpell(name).toUpperCase());
			en.Insert();
			try {
				response.sendRedirect("SFTableEditData.jsp?RefNo=" + this.getRefNo() + "&PageIdx=" + this.getPageIdx());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
	}

}
