<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.*,java.util.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String sessemail = String.valueOf(session.getAttribute("uemail"));
if(sessemail.equals("null")){
    response.sendRedirect("landing.jsp?opt=signin");
}else{
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "notes";
String userid = "root";
String password = "";
String sql="",sql1="",sql2="",sql3="";
Connection con=null,con1=null,con2=null,con3=null;
Statement stm=null,stm1=null,stm2=null,stm3=null;
ResultSet rs=null,rs1=null,rs2=null,rs3=null;
String inpusrname="",opt="",clas="",upload="",useradmin="admin",logout="",newopt="";
String sessemailstr="",sessname="",sesstype="";
int sessclass=0;
int optint=0,classint=0,newclass=0;
boolean uploadbool=false;
//inpusrname = request.getParameter("inpusername");
opt = request.getParameter("opt");
clas = request.getParameter("class");
upload = request.getParameter("upload");
logout = request.getParameter("logout");
if(opt==null){optint=1;}
if(opt!=null && opt.equals("null")){optint=1;newopt="notes";}
else if(opt!=null && opt.equals("notes")){optint=1;newopt="notes";}
else if(opt!=null && opt.equals("assignments")){optint=2;newopt="assignments";}
else if(opt!=null && opt.equals("signout")){optint=2;newopt="signout";}
if(clas!=null){classint = Integer.parseInt(clas);newclass=classint;}
else{classint=1;newclass=classint;}
if(upload!=null&&upload.equals("yes")){uploadbool=true;}
try{
    Class.forName("com.mysql.jdbc.Driver");  
    con = DriverManager.getConnection(connectionUrl+database, userid, password);
    stm=con.createStatement();
    sql ="select * from userinfo where email='"+sessemail+"';";
    rs = stm.executeQuery(sql);
    while(rs.next()){
        sessemailstr = rs.getString("email");
        sessname = rs.getString("name");
        sesstype = rs.getString("type");
        sessclass = rs.getInt("class");
    }
    useradmin=sesstype;
    con.close();
}
catch(Exception ex) {
    System.out.println(ex.toString());
    out.print("ERROR: "+ex.toString());
}
//"Select * from users where USERNAME=? and PASSWORD=?"
%>
<!DOCTYPE html>
<html>
  <head>
    <title><%=sessemail%> | School Managament System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      .mainbody{height:100vh;background:#ede2dc;color:#123d6a;}
      .navbarbox{padding:10px 100px;}
      .nbox1{font-size:32px;color:#123d6a;font-weight:600;}
      .nbox1,.nbox2{width:50%;}
      .lis{padding:0 15px;}
      .ahr{padding:5px 0;font-size:18px;}

      .bigroom1{flex-grow: 1;padding:0 100px;}
      .brPartA{width:20%;padding-right:20px;}
      .brPartB{width:80%;}
      .brpatxt1{font-size:26px;color:#123d6a;font-weight:500;padding-bottom:10px;}
      .brpatxtc0{font-size:20px;color:#123d6a;font-weight:500;padding:10px 0;border:0px solid #999;border-radius:3px;
        transition:.3s;box-shadow:2px 2px 4px rgba(0, 0, 0, 0);}
      .brpatxtc0::after{content:'';position:absolute;bottom:0;left:0;background:#999;width:100%;height:1px;}
      .brpatxtc0:hover{cursor: pointer;box-shadow:1px 1px 2px rgba(50, 50, 50, .6);}

      
      .brpbtxt1{font-size:26px;color:#123d6a;font-weight:500;}
      .uploadbtn{font-size:18px;padding:5px 15px;border-radius:3px;background:#ab3b61;color:#ede2dc;}
      .r1notesbox{flex-grow: 1;}
      .inrr1notesbox{padding:15px;overflow: auto;}
      .nonotesmsgbox{font-size:16px;color:#123d6a;}
      .notesbox0{padding:10px 0;}
      .nbtxt0{font-size:16px;font-weight:500;color:#000;}
      .nbtxt1{width:40%;}
      .nbtxt2,.nbtxt3,.nbtxt4,.nbtxt5{width:12%;text-align: center;}
      .deletenote{border:none;font-size:16px;background:#ede2dc;font-weight:500;text-decoration:underline;cursor:pointer;}
      

      .r2uploadform{padding:15px;border-radius:4px;width:500px;}
      .inrroom2{padding:20px;}
      .r2title{font-size:26px;font-weight:500;padding-bottom:10px;}
      .r2txt0{font-size:18px;color:#3a3a3a;font-weight:500;padding:5px 0 5px 0;}
      .inp0{border:1px solid #666;font-size:16px;padding:5px 10px;width:100%;font-weight:500;border-radius:3px;
        background:#ede2dc;margin-bottom:5px;color:#1a1a1a;}
      .r2inpbox3{padding-top:10px;}
      .r2txt4{width:25%;}
      .classoptionbox{font-size:16px;padding:0;width:120px;height:30px;text-align:center;background:#ede2dc;border-radius:3px;}
      .classoptions{border:1px solid #000;background:#ede2dc;}
      .hidden{height:1px;width:1px;opacity:0.01;}
      .uploadimgbtn{cursor: pointer;width:120px;border-radius:3px;}
      .r2inpbtnbox{padding-top:15px;}
      .submitcancelfile{font-size:18px;padding:5px 20px;border: none;border-radius:3px;color:#ede2dc;cursor: pointer;}
      .submitfile{background:#123d6a;margin-right:15px;border:0px solid #123d6a;}
      .cancelfile{background:#ab3b61;}


      .bigroom2{flex-grow: 1;padding:0 200px;}
      .inrbigroom2{padding:20px;}
      .downloadnote{color:#123d6a;}
      
      .bigroom3{height:calc(100vh - 100px);}
      .signoutbox{width:280px;padding:20px;border-radius:3px;font-size:18px;}
      .signoutupper{text-align: center;padding-bottom:15px;line-height:26px;}
      .sout{font-size:16px;padding:6px 20px;border:none;border-radius:3px;color:#ede2dc;cursor: pointer;}
      .soutyes{background:#123d6a;}
      .soutno{background:#ab3b61;}
    </style>
  </head>
  <body>
    <div class="mainbody bor">
      <div class="inrmainbody bor hw100 flex fdc">
        <div class="navbarbox bor flex jcsb">
          <div class="nbox1 bor">
            Don Bosco <%out.print(sessname);%>
          </div>
          <div class="nbox2 bor flex aic jcc">
            <ul class="ulnav bor flex">
                <li class="lis flex"><a href="index.jsp?opt=notes&class=<%if(newclass!=0){out.print(newclass);}%>" class="ahr txt bor">Notes</a></li>
              <li class="lis flex"><a href="index.jsp?opt=assignments&class=<%if(newclass!=0){out.print(newclass);}%>" class="ahr txt bor">Assignments</a></li>
              <!-- <li class="lis flex"><a href="#" class="ahr txt bor">Profile</a></li> -->
              <li class="lis flex"><a href="index.jsp?logout=yes&class=<%if(newclass!=0){out.print(newclass);}%>" class="ahr txt bor">Sign Out</a></li>
              <!-- <li class="lis flex"><a href="#" class="ahr txt bor">Sign Up</a></li>
              <li class="lis flex"><a href="#" class="ahr txt bor">Log Out</a></li> -->
            </ul>
          </div>
        </div>
        <%if(useradmin.equals("admin")&&logout==null){%>
        <div class="bigroom1 bor flex jcsb non">
          <div class="inrbigroom1 bor flex w100">
            <div class="brPartA bor flex fdc">
              <div class="brpatxt1">Classes</div>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=1" class="brpatxtc1 brpatxtc0 txt rel">Class 1</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=2" class="brpatxtc2 brpatxtc0 txt rel">Class 2</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=3" class="brpatxtc3 brpatxtc0 txt rel">Class 3</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=4" class="brpatxtc4 brpatxtc0 txt rel">Class 4</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=5" class="brpatxtc5 brpatxtc0 txt rel">Class 5</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=6" class="brpatxtc6 brpatxtc0 txt rel">Class 6</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=7" class="brpatxtc7 brpatxtc0 txt rel">Class 7</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=8" class="brpatxtc8 brpatxtc0 txt rel">Class 8</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=9" class="brpatxtc9 brpatxtc0 txt rel">Class 9</a>
              <a href="index.jsp?opt=<%if(!newopt.equals("")){out.print(newopt);}%>&class=10" class="brpatxtc10 brpatxtc0 txt rel">Class 10</a>
            </div>
            <div class="brPartB bor">
              <%if(!uploadbool){%>
              <div class="room1 rooms bor hw100 flex fdc non">
                <div class="r1partone flex bor jcsb">
                  <div class="brpbtitlebox bor flex">
                    <div class="brpbtxt1 bor">Notes&nbsp;&nbsp;&#62;&#62;&nbsp;&nbsp;</div>
                    <div class="brpbtxt1 bor">Class <%=classint%></div>
                  </div>
                  <div class="uploadbtnbox bor flex jcfe">
                    <a href="index.jsp?opt=notes&class=<%if(newclass!=0){out.print(newclass);}%>&upload=yes" class="brpbtxt1 uploadbtn txt bor">Upload</a>
                  </div>
                </div>
                <div class="r1notesbox bor flex fdc">
                  <div class="inrr1notesbox bor hw100">
                    <div class="notesbox1 notesbox0 bor flex fdc">
                      <div class="nbupper bor flex jcsb">
                        <div class="nbtxt1 nbtxt0 bor">Name</div>
                        <div class="nbtxt2 nbtxt0 bor">Date</div>
                        <div class="nbtxt3 nbtxt0 bor">Subject</div>
                        <div class="nbtxt4 nbtxt0 bor">Uploaded by</div>
                        <div class="nbtxt4 nbtxt0 bor flex jcc">
                          Delete
                        </div>
                      </div>
                      <div class="nblower bor flex"></div>
                    </div>
                    <!-- from here -->
                    <%
                    
                    %>
                    <div class="notesbox1 notesbox0 bor flex fdc">
                      <div class="nbupper bor flex jcsb">
                        <div class="nbtxt1 nbtxt0 bor">Why Apple Falls</div>
                        <div class="nbtxt2 nbtxt0 bor">6/18/2022</div>
                        <div class="nbtxt3 nbtxt0 bor">Physics</div>
                        <div class="nbtxt4 nbtxt0 bor">Prasamsa</div>
                        <div class="nbtxt4 nbtxt0 bor flex">
                          <form action="checkemail" method="post" class="bor hw100 flex jcc">
                            <input type="submit" value="Delete" class="deletenote colx">
                          </form>
                        </div>
                      </div>
                      <div class="nblower bor flex"></div>
                    </div>
                    <div class="notesbox1 notesbox0 bor flex fdc">
                      <div class="nbupper bor flex jcsb">
                        <div class="nbtxt1 nbtxt0 bor">Why alphabet with numbers</div>
                        <div class="nbtxt2 nbtxt0 bor">6/18/2022</div>
                        <div class="nbtxt3 nbtxt0 bor">Math</div>
                        <div class="nbtxt4 nbtxt0 bor">Prasamsa</div>
                        <div class="nbtxt4 nbtxt0 bor flex">
                          <form action="" method="post" class="bor hw100 flex jcc">
                            <a href="#" class="deletenote colx">Delete</a>
                          </form>
                        </div>
                      </div>
                      <div class="nblower bor flex"></div>
                    </div>
                    <!-- to here -->
                    <div class="nonotesmsgbox bor none">
                      There aren't any notes uploaded.
                    </div>
                  </div>
                </div>
              </div>
              <%}else if(uploadbool){%>
              <div class="room2 rooms bor hw100 flex fdc non">
                <div class="inrroom2 hw100 bor flex fdc aic">
                  <form action="uploadfile" method="post" enctype="multipart/form-data" class="r2uploadform borx2">
                    <div class="r2title">Upload notes</div>
                    <div class="r2txt3 r2txt0 bor">Title</div>
                    <div class="r2inpbox bor">
                      <input type="text" name="ftitle" class="inp1 inp0" placeholder="title...">
                    </div>
                    <div class="r2txt3 r2txt0 bor">Subject</div>
                    <div class="r2inpbox bor">
                      <input type="text" name="fsubject" class="inp1 inp0" placeholder="subject...">
                    </div>
                    <div class="r2inpbox r2inpbox3 bor flex jcfs">
                      <div class="r2txt4 r2txt0 bor">Class</div>
                      <div class="r2iboxA bor">
                        <select class="classoptionbox border" name="fclass">
                          <option class="classoptions" value=null>N/A</option>
                          <option class="classoptions" value="1">1</option>
                          <option class="classoptions" value="2">2</option>
                          <option class="classoptions" value="3">3</option>
                          <option class="classoptions" value="4">4</option>
                          <option class="classoptions" value="5">5</option>
                          <option class="classoptions" value="6">6</option>
                          <option class="classoptions" value="7">7</option>
                          <option class="classoptions" value="8">8</option>
                          <option class="classoptions" value="9">9</option>
                          <option class="classoptions" value="10">10</option>
                        </select>
                      </div>
                    </div>
                    <div class="r2inpbox r2inpbox3 bor flex jcfs">
                      <div class="r2txt4 r2txt0 bor">File</div>
                      <div class="r2iboxA bor flex">
                        <label class="uploadimgbtn borx2 flex jcc aic" for="image-input-update">
                          Upload file
                        </label>
                        <input type="file" id="image-input-update" class = "abs hidden" name="ffile">
                      </div>
                    </div>
                    <div class="r2inpbtnbox bor rel flex">
                      <input type="submit" class="submitfile submitcancelfile" value="Post">
                      <input type="reset" class="cancelfile submitcancelfile" value="Reset">
                    </div>
                  </form>
                </div>
              </div>
              <%}%>
            </div>
          </div>
        </div>
        <%}else if(useradmin.equals("user")&&logout==null){%>
        <div class="bigroom2 bor flex jcsb non">
          <div class="inrbigroom2 bor hw100 flex fdc">
            <div class="br2partone flex bor jcsb">
              <div class="brpbtitlebox bor flex">
                <div class="brpbtxt1 bor">Notes&nbsp;&nbsp;&#62;&#62;&nbsp;&nbsp;</div>
                <div class="brpbtxt1 bor">Class <%=classint%></div>
              </div>
            </div>
            <div class="br2parttwo bor">
              <div class="inrr1notesbox bor hw100">
                <div class="notesbox1 notesbox0 bor flex fdc">
                  <div class="nbupper bor flex jcsb">
                    <div class="nbtxt1 nbtxt0 bor">Name</div>
                    <div class="nbtxt2 nbtxt0 bor">Date</div>
                    <div class="nbtxt3 nbtxt0 bor">Subject</div>
                    <div class="nbtxt4 nbtxt0 bor">Uploaded by</div>
                    <div class="nbtxt4 nbtxt0 bor flex jcc">
                      Download
                    </div>
                  </div>
                  <div class="nblower bor flex"></div>
                </div>
                <!-- from here -->
                <div class="notesbox1 notesbox0 bor flex fdc">
                  <div class="nbupper bor flex jcsb">
                    <div class="nbtxt1 nbtxt0 bor">Why Apple Falls</div>
                    <div class="nbtxt2 nbtxt0 bor">6/18/2022</div>
                    <div class="nbtxt3 nbtxt0 bor">Physics</div>
                    <div class="nbtxt4 nbtxt0 bor">Prasamsa</div>
                    <div class="nbtxt4 nbtxt0 bor flex">
                      <form action="" method="post" class="bor hw100 flex jcc">
                        <a href="#" class="downloadnote colx">Download</a>
                      </form>
                    </div>
                  </div>
                  <div class="nblower bor flex"></div>
                </div>
                <div class="notesbox1 notesbox0 bor flex fdc">
                  <div class="nbupper bor flex jcsb">
                    <div class="nbtxt1 nbtxt0 bor">Why alphabet with numbers</div>
                    <div class="nbtxt2 nbtxt0 bor">6/18/2022</div>
                    <div class="nbtxt3 nbtxt0 bor">Math</div>
                    <div class="nbtxt4 nbtxt0 bor">Prasamsa</div>
                    <div class="nbtxt4 nbtxt0 bor flex">
                      <form action="" method="post" class="bor hw100 flex jcc">
                        <a href="#" class="downloadnote colx">Download</a>
                      </form>
                    </div>
                  </div>
                  <div class="nblower bor flex"></div>
                </div>
                <!-- to here -->
                <div class="nonotesmsgbox borx3 none">
                  There aren't any notes uploaded.
                </div>
              </div>
            </div>
          </div>
        </div>
        <%}%>
        <%if(logout!=null&&logout.equals("yes")){%>
        <div class="bigroom3 bor  non">
          <div class="inrbigroom3 bor hw100 flex aic jcc">
            <form class="signoutbox borx2" action="" method="post">
              <div class="signoutupper bor flex jcc">Are you sure you want to sign out?</div>
              <div class="signoutlower bor flex jcsa">
                <input type="submit" value="yes" class="soutno sout">
                <a href="index.jsp?opt=notes&class=<%if(newclass!=0){out.print(newclass);}%>" class="soutyes txt sout">No</a>
              </div>
            </form>
          </div>
        </div>
        <%}%>
      </div>
    </div>
    <script>
      // function download(fileUrl, fileName) {
      //   var a = document.createElement("a");
      //   a.href = fileUrl;
      //   a.setAttribute("download", fileName);
      //   a.click();
      // }
      // download("/css/style.css", "makeup.css");
    </script>
  </body>
</html>
<%}%>