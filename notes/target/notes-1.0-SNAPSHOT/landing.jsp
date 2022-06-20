<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.*,java.util.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String sessemail = String.valueOf(session.getAttribute("uemail"));
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "notes";
String userid = "root";
String password = "";
String sql="",sql1="",sql2="",sql3="";
Connection con=null,con1=null,con2=null,con3=null;
Statement stm=null,stm1=null,stm2=null,stm3=null;
ResultSet rs=null,rs1=null,rs2=null,rs3=null;
String inpusrname="",opt="";
int optint=0;
inpusrname = request.getParameter("inpusername");
opt = request.getParameter("opt");
if(opt==null){optint=1;}
if(opt!=null && opt.equals("null")){optint=1;}
else if(opt!=null && opt.equals("signup")){optint=2;}
else if(opt!=null && opt.equals("signin")){optint=3;}
try{
    Class.forName("com.mysql.jdbc.Driver");  
    con = DriverManager.getConnection(connectionUrl+database, userid, password);
    stm=con.createStatement();
    sql ="select * from userinfo;";
    rs = stm.executeQuery(sql);
    while(rs.next()){
    }
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
    <title><%=optint%> | School Managament System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      .mainbody{height:100vh;background:#ede2dc;}
      .navbarbox{padding:10px 100px;}
      .nbox1{font-size:32px;color:#123d6a;font-weight:600;}
      .nbox1,.nbox2{width:50%;}
      .room1{flex-grow: 1;padding:0 100px;}
      .r1boxA{width:40%;}
      .r1boxB{width:60%;}
      .imgboxes{height:auto;width:80%;padding:15px;box-shadow:0 0 6px rgba(50,50,50,.5);
        border-radius:3px;background:#eee;}
      .img0{border-radius:3px;}
      .imgbox1{left:10%;top:100px;}
      .imgbox2{width:200px;height:auto;top:30px;left:10px;padding:10px;}
      .imgbox3{width:220px;height:auto;padding:10px;bottom:80px;right:0px;}

      .r1txt1{font-size:60px;color:#123d6a;font-weight:500;padding-top:120px;}
      .r1txt2{font-size:18px;color:#123d6a;font-weight:500;padding-top:10px;line-height:26px;}
      .r1btnbox1{padding-top:20px;}
      .r1btn1{font-size:24px;padding:12px 35px;background:#ab3b61;color:#edc8b8;font-weight:500;border-radius:5px;
        cursor: pointer;}
      .lis{padding:0 5px;}
      .ahr{padding:5px 0;font-size:18px;}

      .room2{flex-grow: 1;padding:0 100px;}
      .inrroom2{}
      .r2form{padding:20px;width:360px;border-radius:3px;border:1px solid #7a7a7a;}
      
      .r2txt1{font-size:24px;color:#123d6a;font-weight:600;text-align: center;padding-bottom:10px;}
      .r2txt0{font-size:18px;color:#3a3a3a;font-weight:500;padding:5px 0 3px 0;}
      .r2txt4{padding-right:50px;}
      .inp0{border:none;border-bottom:1px solid #123d6a;font-size:18px;padding:7px 10px;width:100%;font-weight:500;
        background:#ede2dc;margin-bottom:20px;color:#1a1a1a;}
      .classoptionbox{font-size:16px;padding:0;width:100px;height:30px;text-align:center;background:#ede2dc;}
      .classoptions{border:1px solid #000;}
      .r2btnbox1{padding-top:20px;}
      .r2btn0{font-size:18px;background:#ab3b61;font-weight:400;color:#fff;border-radius:3px;padding:8px;text-align: center;
        cursor: pointer;}
      .r2btnbox2{padding-top:10px;}
      .r2btn2{background:none;padding:0;color:#123d6a;font-size:16px;}
      .r2btn1{border:none;}

      .room3{flex-grow: 1;padding:0 100px;}
    </style>
  </head>
  <body>
    <div class="mainbody bor">
      <div class="inrmainbody bor hw100 flex fdc">
        <div class="navbarbox bor flex jcsb">
          <a href="landing.jsp" class="nbox1 bor txt">
            Don Bosco
          </a>
          <div class="nbox2 bor flex aic jcfe">
            <ul class="ulnav bor">
              <li class="lis flex"><a href="landing.jsp?opt=signin" class="ahr txt bor">Sign In</a></li>
            </ul>
          </div>
        </div>
        <%if(optint==1){%>
        <div class="room1 bor non">
          <div class="inrroom1 bor hw100 flex">
            <div class="r1boxA r1boxes bor">
              <div class="r1txt1">School Managament System</div>
              <div class="r1txt2">
                A place dedicated for student with the purpose of making easy access of knowledge to students.
              </div>
              <div class="r1btnbox1 bor flex">
                <a href="landing.jsp?opt=signup" class="r1btn1 bor txt">
                  <!-- Elegant Yet Approachable -->
                  Join Us
                </a>
              </div>
            </div>
            <div class="r1boxB r1boxes bor rel">
              <div class="imgbox1 imgboxes bor abs">
                <img src="image/b.jpg" alt="" class="img1 img0 w100">
              </div>
              <div class="imgbox2 imgboxes bor abs">
                <img src="image/c.jpg" alt="" class="img2 img0 w100">
              </div>
              <div class="imgbox3 imgboxes bor abs">
                <img src="image/a.jpg" alt="" class="img3 img0 w100">
              </div>
            </div>
          </div>
        </div>
        <%}else if(optint==2){%>
        <div class="room2 bor flex jcc aic non">
          <div class="inrroom2 bor felx">
            <form action="signup" method="post" class="r2form bor flex fdc">
              <div class="r2txt1 bor">Sign Up</div>
              <div class="r2txt2 r2txt0 bor">Enter Your Name</div>
              <div class="r2inpbox bor">
                <input type="text" name="uname" class="inp1 inp0" placeholder="name..." value="Kritesh Thapa">
              </div>
              <div class="r2txt3 r2txt0 bor">Enter Your Email</div>
              <div class="r2inpbox bor">
                <input type="text" name="uemail" class="inp1 inp0" placeholder="email...">
              </div>
              <div class="r2txt3 r2txt0 bor">Create Pasword</div>
              <div class="r2inpbox bor">
                <input type="text" name="upass" class="inp1 inp0" placeholder="password...">
              </div>
              <div class="r2inpbox bor flex jcfs">
                <div class="r2txt4 r2txt0 bor">Class</div>
                <div class="r2iboxA bor">
                  <select class="classoptionbox border" name="uclass">
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
              <div class="r2btnbox1 r2btnbox0 bor flex">
                <input type="submit" class="r2btn1 r2btn0 bornone w100" value="Sign Up">
              </div>
              <div class="r2btnbox2 r2btnbox0 bor flex">
                <a href="landing.jsp?opt=signin" class="r2btn2 r2btn0 bor w100">Already have an account?</a>
              </div>
            </form>
          </div>
        </div>
        <%}else if(optint==3){%>
        <div class="room3 bor flex jcc aic non">
          <div class="inrroom3 bor felx">
            <form action="signin" method="post" class="r2form bor flex fdc">
              <div class="r2txt1 bor">Sign In</div>
              <div class="r2txt3 r2txt0 bor">Enter Your Email</div>
              <div class="r2inpbox bor">
                <input type="text" name="uemail" class="inp1 inp0" placeholder="email...">
              </div>
              <div class="r2txt3 r2txt0 bor">Create Pasword</div>
              <div class="r2inpbox bor">
                <input type="text" name="upass" class="inp1 inp0" placeholder="password...">
              </div>
              <div class="r2btnbox1 r2btnbox0 bor flex">
                <input type="submit" class="r2btn1 r2btn0 bornone w100" value="Sign In">
              </div>
              <div class="r2btnbox2 r2btnbox0 bor flex">
                <a href="landing.jsp?opt=signup" class="r2btn2 r2btn0 bor w100">Create an account?</a>
              </div>
            </form>
          </div>
        </div>
        <%}%>
      </div>
    </div>
  </body>
</html>