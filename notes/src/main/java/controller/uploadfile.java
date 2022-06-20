package controller;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
/* The Java file upload Servlet example */
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "uploadfile", urlPatterns = { "/uploadfile" })
@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
  maxFileSize = 1024 * 1024 * 10,      // 10 MB
  maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class uploadfile extends HttpServlet {

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

      
    /* Receive file uploaded to the Servlet from the HTML5 form */
    String driver = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String database = "notes";
    String userid = "root";
    String password = "";
    String sql="",sql1="",sql2="",sql3="";
    int imgcount=0;
    Connection con = null;
    Statement stm=null,stm1=null,stm2=null,stm3=null;
    ResultSet rs=null,rs1=null,rs2=null,rs3=null;
    boolean inputempty=true;
    try{
        String fileName="",realPath="",realPathFile="",newRealPathFile="",ftitle="",fsubject="",fclass="";
        int fclassint=0;
        boolean fileempty=true;
        ftitle = request.getParameter("ftitle");
        fsubject = request.getParameter("fsubject");
        fclass = request.getParameter("fclass");
        fclassint = Integer.parseInt(fclass);
        response.getWriter().print(ftitle+" "+fsubject+" "+fclass);
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(connectionUrl+database, userid, password);
        stm=con.createStatement();
//        sql="select count(*) from blog;";
//        rs=stm.executeQuery(sql);
//        while(rs.next()){
//            imgcount=rs.getInt("count(*)");
//        }
        Part filePart = request.getPart("ffile");
        fileName = filePart.getSubmittedFileName();
        String fileName1 = ""+fileName;
        realPath = getServletContext().getRealPath("/upload/");
 
        realPathFile = realPath+fileName;
        newRealPathFile = realPathFile.replace("\\","\\\\");
        response.getWriter().print("fileName="+newRealPathFile+"...");
        if(fileName!=null){
            if(fileName.equals("")){
                response.getWriter().print("empty");
            }else{
                fileempty=false;
            }
        }
        if(!fileempty){
            for (Part part : request.getParts()) {
                part.write(newRealPathFile);
            }
            sql ="insert into notes(title,subject,class,filename,date,uploadedby)values"
                    + "('"+ftitle+"','"+fsubject+"',"+fclassint+",'"+fileName+"','0/0/0000','"+ftitle+"');";
            stm.executeUpdate(sql);
//            response.getWriter().print("The file uploaded sucessfully. "+imgcount+" "+newRealPathFile);
//            response.getWriter().print("upload success");
            response.sendRedirect("index.jsp");
        }else{
            response.getWriter().print("upload fail");
            response.sendRedirect("index.jsp");
        }
        con.close();
    }
    catch(Exception ex) {
        System.out.println(ex.toString());
        response.getWriter().print("ERROR:"+ex.toString());
    }
    
  }

}