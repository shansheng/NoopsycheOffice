package cn.jflow.controller.wf;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.jflow.common.model.AjaxJson;
import cn.jflow.common.model.OfficeTemplate;
import cn.jflow.controller.wf.workopt.BaseController;
@Controller
@RequestMapping("/WF/Template")
public class TemplateController extends BaseController {
	
	@RequestMapping(value = "/loadJson", method = RequestMethod.POST)
	@ResponseBody
	public String loadJson(HttpServletRequest request,HttpServletResponse response) {
		String path1=request.getSession().getServletContext().getRealPath("/DataUser/OfficeTemplate");
		String path2=request.getSession().getServletContext().getRealPath("/DataUser/OfficeOverTemplate");
		String path3=request.getSession().getServletContext().getRealPath("/DataUser/OfficeSeal");
		String path4=request.getSession().getServletContext().getRealPath("/DataUser/FlowDesc");
		
		AjaxJson j = new AjaxJson();
		 String type = request.getParameter("LoadType");
	        String loadType = request.getParameter("Type");
	        String workID = request.getParameter("workID");
	        String FK_Flow = request.getParameter("FK_Flow");
	        String json = "";

	        List<OfficeTemplate> list = new ArrayList<OfficeTemplate>();
	        String path = "";
	        if (type.equals("word"))
	        {
	            path = path1;
	        }
	        else if (type.equals("over"))
	        {
	            path = new File(path2).getAbsolutePath();
	        }
	        else if (type.equals("seal"))
	        {
	            path = new File(path3).getAbsolutePath();
	        }
	        else if (type.equals("flow"))
	        {
	            path = new File(path4).getAbsolutePath();
	        }

	        if(!(new File(path).exists()))
	        {
	        	new File(path).mkdirs();
	        }
	        if (loadType.equals("File"))
	        {
	            File[] files =new File(path).listFiles();

	            for(File fileName : files)
	            {
	                OfficeTemplate template = new OfficeTemplate();
	                template.Name = fileName.getName();
	                template.Type = fileName.getName().substring(fileName.getName().lastIndexOf(".")+1);
	                template.Size = fileName.length() / 1024 + "";

	                list.add(template);
	            }
	            json = "{\"total\":" + list.size() + ",\"rows\":" + JSONArray.fromObject(list).toString() + "}";
	        }
	        else if (loadType.equals("Dic"))
	        {
	            File[] dics = new File(path).listFiles();//System.IO.Directory.GetDirectories(path);

	            for(File fileName : dics)
	            {
	                OfficeTemplate template = new OfficeTemplate();
	                template.Name = fileName.getName();
	                template.Type = fileName.getName().substring(fileName.getName().lastIndexOf(".")+1);
	                template.Size = "无";

	                list.add(template);
	            }
	            json = "{\"total\":" + list.size() + ",\"rows\":" + JSONArray.fromObject(list).toString() + "}";
	        }else if (loadType.equals("marks"))
	        {
	        	  File[] files =new File(path).listFiles();
	        	  int i = 0;
	              for(File fileName : files){
	                if (!fileName.getName().startsWith(workID + "Mark"))
	                    continue;
	                OfficeTemplate template = new OfficeTemplate();
	                template.Name = "文档修订痕迹" + i;
	                template.Type = fileName.getName().substring(fileName.getName().lastIndexOf(".")+1);
	                template.RealName = fileName.getName();
	                template.Size = fileName.length() / 1024 + "";
	                template.Index = i;
	                i++;
	                list.add(template);
	            }
	            json = "{\"total\":" + list.size() + ",\"rows\":" + JSONArray.fromObject(list).toString() + "}";

	        }
		
		
		return String.valueOf(json);
	}
}
