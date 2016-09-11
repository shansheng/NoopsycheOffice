package cn.jflow.common.model;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;

import cn.jflow.common.util.ContextHolderUtils;
import net.sf.json.JSONArray;

public class TempLateModel {
	private String path1;
	private String path2;
	private String path3;
	private String path4;
	private HttpServletRequest req;
	private HttpServletResponse res;
	
	public TempLateModel()
	{
		
	}
	public TempLateModel(String path1,String path2,String path3,String path4,HttpServletRequest req,HttpServletResponse res) {
		this.path1=path1;
		this.path2=path2;
		this.path3=path3;
		this.path4=path4;
		this.req=req;
		this.res=res;
	}

	public String init(String load){
		if (load != null && !load.equals("")) {
			if (Boolean.parseBoolean(load) == true) {
				LoadJson();
			}
		}
		return "";
	}
	
	public void LoadJson()
    {

        String type = req.getParameter("LoadType");
        String loadType = req.getParameter("Type");
        String workID = req.getParameter("workID");
        String FK_Flow = req.getParameter("FK_Flow");
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
//        if (!Directory.Exists(path))
//            Directory.CreateDirectory(path);
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
            json = "{d:{\"total\":" + list.size() + ",\"rows\":" + JSONArray.fromObject(list).toString() + "}}";
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
        try {
			res.flushBuffer();
	        res.getWriter().write(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
//        Response.Clear();

//        Response.Write(json);
    }
}
