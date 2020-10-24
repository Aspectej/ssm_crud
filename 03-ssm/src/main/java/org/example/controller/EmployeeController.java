package org.example.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.example.bean.Employee;
import org.example.bean.Msg;
import org.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 单个批量二合一
     * 批量删除:1-2-3
     * 单个删除:1
     *
     */
    @ResponseBody
    @RequestMapping(value="/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpBy(@PathVariable("ids")String ids){
        //此处定义了两个方法,一个是批量删除,一个是单个删除.
        if(ids.contains("-")){
            //批量删除
            List<Integer> del_ids=new ArrayList<>();
            String[] str_ids=ids.split("-");
            //组装id的数组
            for(String string:str_ids){
                del_ids.add(Integer .parseInt(string));
            }
            employeeService.deleteBatch(del_ids);

        }else{
            //单个删除
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }

        return Msg.success();
    }

    /*
        员工更新方法
     */
    /*
        问题:
        请求体中有数据:
        但是Employee对象封装不上
        计算机内部执行的sql语句是:
            update tbl_emp where emp_id=1014

         原因:
         Tomcat:1.将请求体中的数据,封装成一个map
                2.request.getParameter("empName")就会从这个map中取值
                3.SpringMVC封装POJO对象的时候,会把POJO中每个
                    属性的值.request.getParameter("email");
         Ajax发送tomcat请求引发的血案:
            put请求:请求体的数据,request.getParameter("empName")拿不到
            Tomcat一看是put不会封装请求体中的数据为map,只有POST形式的请求才封装请求体为map

         org.apache.catalina.connector.Request--parseParameters()  (31xx行)

         protected String parseBodyMethods="POST";
         if(!getConnector().isParseBodyMethod(getMethod())){
                success=true;
                return;
         }

         解决方案:
         我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
         配置上HttpPutFormContentFilter
         它的作用:将请求体中的数据解析包装成一个map,request被重新包装,
         request.getParameter()被重写,就会从自己封装的map中取数据

     */
    @ResponseBody
    @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
    public Msg saveEmp(Employee employee, HttpServletRequest request){
        System.out.println("请求体中的值:"+request.getParameter("gender"));
        System.out.println("将要更新的员工的数据"+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /*
        根据id员工查询员工
     */
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /*
        检查用户名是否可用
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName")String empName){
        //先判断用户名是否是合法的表达式
        String regx="(^[A-Za-z0-9]{5,16}$)|(^[\\u4e00-\\u9fa5]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        //数据库用户名重复校验
        Boolean b=employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    //员工保存
    /*
        1.支持JSR303校验
        2.导入Hibernate-Validator
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败,应该返回失败.在模态宽口中显示校验失败的错误信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors=result.getFieldErrors();
            for(FieldError fieldError:errors){
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误的信息:"+fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }
    /*
        如果要是用@Response注解,必须导入jackson包
     */
    //自动将返回的对象转换为json字符串
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(
            @RequestParam(value="pn",defaultValue="1" )Integer pn){
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用,插入页码以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps=employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需要将PageInfo交给页面就行了
        //封装的详细的分页信息,包括有我们查询出来的数据,连续显示的页数
        PageInfo page=new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    //查询所有员工(分页查询)

    //@RequestMapping("/emps")
    /*public String getEmps(@RequestParam(value="pn",defaultValue="1" )Integer pn,
                          Model model){
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用,插入页码以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps=employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需要将PageInfo交给页面就行了
        //封装的详细的分页信息,包括有我们查询出来的数据,连续显示的页数
        PageInfo page=new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list" ;
    }*/
}
