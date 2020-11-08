<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script type="text/javascript"
            src="${APP_PATH}/static/jquery/jquery-3.4.1.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!--修改员工的模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">

        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <%--<input type="text" name="empName" class="form-control"
                                   id="empName_update_input" placeholder="empName">
                            <span class="help-block"></span>--%>
                                <p class="form-control-static"
                                   id="empName_update_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control"
                                   id="email_update_input" placeholder="email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender"
                                       id="gender1_update_input"
                                       value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender"
                                       id="gender2_update_input"
                                       value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                                <%--<option>1</option>
                                   <option>2</option>
                                   <option>3</option>
                                   <option>4</option>
                                   <option>5</option>--%>
                            </select>


                        </div>
                    </div>

                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新
                </button>
            </div>
        </div>
    </div>
</div>

<!--添加员工的模态框-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">

        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control"
                                   id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control"
                                   id="email_add_input" placeholder="email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input"
                                       value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input"
                                       value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="select_dept">
                                <%--<option>1</option>
                                   <option>2</option>
                                   <option>3</option>
                                   <option>4</option>
                                   <option>5</option>--%>
                            </select>


                        </div>
                    </div>

                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存
                </button>
            </div>
        </div>
    </div>
</div>

<!--搭建显示页面-->
<div class="container">
    <!--标题
        row:行
        column:列
    -->

    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD-自测</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                新增</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">
                <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
                删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-bordered" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all" />
                        </th>
                        <th>编号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->

        <div class="col-md-6" id="page_nav_area">
            <%--<nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li>
                        <a href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>--%>
        </div>
    </div>
</div>
<!--

-->
<script type="text/javascript">
    var totalRecode,currentPage;
    //在页面加载完成之后,直接发送一个ajax请求,要到分页数据
    $(function(){
        //去第一页
        to_page(1);
    });

    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"get",
            success:function(resp){
                //在浏览器显示服务端发送的json数据
                //console.log(resp);
                //1.在页面解析这个json并显示员工数据
                build_emps_table(resp);
                //2.解析并显示分页信息
                build_page_info(resp);
                //3.解析显示分页条数据
                build_page_nav(resp);
            }
        })
    }

    function build_emps_table(resp){
        //清空table表格
        $("#emps_table tbody").empty();
        //拿到查询的5位员工信息
        var emps=resp.extend.pageInfo.list;
        $.each(emps,function(i,n){
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd=$("<td></td>").append(n.empId);
            var empNameTd=$("<td></td>").append(n.empName);
            var genderTd=$("<td></td>").append(n.gender=='M'?"男":"女");
            var emailTd=$("<td></td>").append(n.email);
            var deptNameTd=$("<td></td>").append(n.department.deptName);

            var editBtn=$("<button></button>").addClass("btn btn-success btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为编辑按钮添加一个自定义的属性,来表示当前员工的id
            editBtn.attr("edit-id",n.empId);

            var
                delBtn=$("<button></button>").addClass("btn btn-warning btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加一个自定义属性来表示当前删除的员工的id
            delBtn.attr("del-id",n.empId);

            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完之后,还是放回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    /*<!--<nav>
                <ul class="pagination">
                    <li>
                        <a href="#">
                            <span>&laquo;</span>
                        </a>
                    </li>

                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>

                    <li>
                        <a href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>-->*/
    /*
        {"code":100,"msg":"处理成功!",
        "extend":
            {"pageInfo":{"pageNum":2,"pageSize":5,"size":5,"startRow":6,"endRow":10,"total":1002,"pages":201,
            "list":[{"empId":6,"empName":"94d87","gender":"M","email":"94d87@163.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},
                    {"empId":7,"empName":"0bf98","gender":"M","email":"0bf98@163.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},
                    {"empId":8,"empName":"50d25","gender":"M","email":"50d25@163.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},
                    {"empId":9,"empName":"40595","gender":"M","email":"40595@163.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},
                    {"empId":10,"empName":"97185","gender":"M","email":"97185@163.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}}],
                    "prePage":1,"nextPage":3,"isFirstPage":false,"isLastPage":false,"hasPreviousPage":true,"hasNextPage":true,"navigatePages":5,
                    "navigatepageNums":[1,2,3,4,5],"navigateFirstPage":1,"navigateLastPage":5,"firstPage":1,"lastPage":5}}}
     */
    //解析显示分页文字信息
    function build_page_info(resp){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+resp.extend.pageInfo.pageNum+"页,总"
            +resp.extend.pageInfo.pages+"页,共"
            +resp.extend.pageInfo.total+"条记录");
        totalRecode=resp.extend.pageInfo.total;
        currentPage=resp.extend.pageInfo.pageNum;
    }

    //解析分页条信息,点击分页条能到达指定的页码位置
    function build_page_nav(resp){
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(resp.extend.pageInfo.hasPreviousPage==false){
            //没有上一页
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //有上一页
            //为元素绑定事件
            firstPageLi.click(function(){
                to_page(1);
            });
            //前一页
            prePageLi.click(function(){
                to_page(resp.extend.pageInfo.pageNum-1);
            })
        }
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        //加入一个判断
        if(resp.extend.pageInfo.hasNextPage==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            //下一页
            nextPageLi.click(function(){
                to_page(resp.extend.pageInfo.pageNum+1);
            })
            //最后一页
            lastPageLi.click(function(){
                to_page(resp.extend.pageInfo.pages);
            })
        }
        ul.append(firstPageLi).append(prePageLi);
        //遍历页码(1,2,3,4,5)
        $.each(resp.extend.pageInfo.navigatepageNums,function(i,n){
            var numLi=$("<li></li>").append($("<a></a>").append(n));
            numLi.click(function(){
                to_page(n);
            })
            ul.append(numLi);
        })


        ul.append(nextPageLi).append(lastPageLi);
        var navEle=$("<nav></nav>").append(ul);
        $("#page_nav_area").append(navEle)
    }

    /*
        清空表单的样式和数据(完整重置)
     */
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        //清空表单的内容
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function(){
        //清除表单数据(表单完整重置,包括校验样式+数据)
        reset_form("#empAddModal form");
        /*
            jquery没有reset()这个方法,所以加上[0],将dom对象转为jquery对象
         */
        //$("#empAddModal form")[0].reset();
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        })
    })

    //查出所有部门信息并显示在下拉列表中
    //抽取,加入一个参数ele,传入那个元素就查出那个
    function getDepts(ele){
        //清空之前下拉列表中的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"get",
            success:function(resp){
                /*{"code":100,"msg":"处理成功!",
                "extend":
                {"depts":
                [{"deptId":1,"deptName":"开发部"},
                {"deptId":2,"deptName":"测试部"}]}}*/
                $.each(resp.extend.depts,function(i,n){
                    var
                        optionEle=$("<option></option>").append(n.deptName).attr("value",n.deptId);
                    optionEle.appendTo(ele);

                })
            }
        })
    }

    //校验表单数据
    function validate_add_form(){
        //1.先拿到要校验的数据,使用正则表达式进行比对
        var empName=$("#empName_add_input").val();
        var regName= /(^[A-Za-z0-9-_]{5,16}$)|(^[\u4e00-\u9fa5]{2,5}$)/;
        if(!regName.test(empName)){
            //测试不成功
            //alert("用户名必须是2-5位中文或者5-16位英文组合");
            show_validate_msg("#empName_add_input","error","用户名必须是2-5位中文或者5-16位英文组合");
            return false;
        }else{
            show_validate_msg("#empName_add_input","success","");
        }

        //2.拿到邮箱信息
        var email=$("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //邮箱格式不正确
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else{
            //校验成功
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }

    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            //成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            //失败
            $(ele).parent().addClass("has-error");
            //next()表示紧邻的意思
            $(ele).next("span").text(msg);
        }
    }

    //校验员工的用户名是否可用
    $("#empName_add_input").change(function(){
        var empName=this.value;
        //添加change事件,当文本发生改变时,会发送ajax请求校验用户名是否重名
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+empName,
            type:"post",
            success:function(resp){
                if(resp.code==100){
                    //代表成功
                    show_validate_msg("#empName_add_input","success","用户名可用!");

                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    //代表失败
                    show_validate_msg("#empName_add_input","error",resp.extend.va_msg);

                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        })

    });
    //添加模态窗口的----保存---功能,发送ajax请求
    $("#emp_save_btn").click(function(){
        //1.将模态框中填写的表单数据先进行校验
        //前端校验
        if(!validate_add_form()){
            //校验失败
            return false;
        }
        //2.判断之前的ajax用户名校验是否成功了,如果成功了,才保存信息.
        /*
            要先拿到ajax-va状态在判断
         */
        if($(this).attr("ajax-va")=="error"){
            return false;
        }

        //发送ajax请求,保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"post",
            data:$("#empAddModal form").serialize(),
            success:function(resp){
                if(resp.code==100){
                    //成功
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    to_page(totalRecode);
                }else{
                    //失败,显示失败信息
                    //console.log(resp);
                    //有那个字段的错误信息就显示那个字段的
                    if(undefined!=resp.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input","error",resp.extend.errorFields.empName);
                    }
                    if(undefined!=resp.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",resp.extend.errorFields.email);
                    }
                }
                //alert(resp.msg);
            }
        });
    });
    //我们是在按钮创建之前就绑定了click,所以绑定不上
    //绑定单击使用.live(),而新版jquery没有live,而使用on来代替了
    $(document).on("click",".edit_btn",function(){
        //alert("edit");
        //查出部门信息,并显示部门列表
        getDepts("#empUpdateModal select");
        //查出员工信息,并显示员工信息
        getEmp($(this).attr("edit-id"));
        //把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    /*
        点击删除按钮,删除单个员工
     */
    $(document).on("click",".delete_btn",function(){
        //1.弹出确认删除的对话框
        //$(this):表示当前点击的删除按钮
        //点击删除弹出员工名字
        //alert($(this).parents("tr").find("td:eq(1)").text())
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        var empId=$(this).attr("del-id");
        if(confirm("确认删除["+empName+"]吗?")){
            //确认,发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function(resp){
                    alert(resp.msg);
                    //回到本页
                    to_page(currentPage);
                }
            })
        }
    })

    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function(resp){
                //console.log(resp);
                var empData=resp.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    //点击更新,更新员工信息
    $("#emp_update_btn").click(function(){
        //验证邮箱是否合法
        var email=$("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //邮箱格式不正确
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_update_input","error","邮箱格式不正确(更新)");
            return false;
        }else{
            //校验成功
            show_validate_msg("#email_update_input","success","");
        }
        //发送ajax请求,保存信息
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"put",
            data:$("#empUpdateModal form").serialize(),
            success:function(resp){
                alert(resp.msg);
                //1.关闭模态框
                $("#empUpdateModal").modal('hide');
                //2.回到本页面
                to_page(currentPage);
            }
        })
    });

    //完成全选全选/全不选功能
    $("#check_all").click(function(){
        //attr获取checked是undefined
        //我们这些dom原生的属性,attr获取自定义属性的值
        //alert($(this).attr("checked"));
        //使用prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
        //alert($(this).prop("checked"));
    });

    //当所有的checkbox点满后,总的checkbox会自动点上
    $(document).on("click",".check_item",function(){
        //点击按钮显示点击的个数
        //alert($(".check_item:checked").length)
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    })

    //点击全部删除,就批量删除
    $("#emp_delete_all_btn").click(function(){
        //$(".check_item:checked")
        var empNames="";
        var del_idstr="";
        $.each($(".check_item:checked"),function(){
            //this
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的,
        empNames=empNames.substring(0,empNames.length-1);
        //去除员工id中的-
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除["+empNames+"]吗?")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"delete",
                success:function(resp){
                    alert(resp.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            })
        }
    })
</script>
</body>
</html>
