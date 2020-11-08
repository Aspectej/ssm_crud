package org.example.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.example.bean.Employee;
import org.example.bean.Msg;
import org.example.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的请求
 */
@Controller
public class EmployeeController {

    @Resource
    private EmployeeService employeeService;

    /*
        批量删除员工
        单个和批量删除二合一
        做法:批量删除:1-2-3
            单个删除:1
     */
    @ResponseBody
    @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            //批量删除
            List<Integer> del_ids=new ArrayList<>();
            String[] str_ids=ids.split("-");
            //组装id的集合
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            //单个删除
            Integer id=Integer .parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
    /*
        员工更新的保存

        问题:问题体中有数据,但是Employee对象封装不上,
            update tbl_emp where emp_id=1;

        原因:Tomcat,将请求体中的数据,封装一个map.
            request.getParameter("empName")就会从这个map中取值
            而SpringMVC封装POJO对象的时候,
            会把pojo中每个属性的值,request.getParameter("email");

        AJAX发送put请求因发生的血案:
            put请求:请求体中的数据,request.getParameter("empName")拿不到
            Tomcat一看是put不会封装请求体中的数据为map,只有post形式的请求才会封装请求体为map

        解决方案:
        我们要能支持直接发送put之类的请求还要封装请求体中的数据
        配置上HttpPutFormContentFilter
            作用:将请求体中的数据解析包装成一个map
            request被重新包装,request.getParameter()被重写,就会从自己封装的map中取数据
     */
    @ResponseBody
    @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
    public Msg saveEmp(Employee employee, HttpServletRequest request){
        System.out.println("请求体中的值:"+request.getParameter("gender"));
        System.out.println("将要更新的员工数据库:"+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    /*
        查询员工姓名
     */
    @RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /*
        检测员工姓名是否可用
     */
    @ResponseBody
    @RequestMapping("/checkUser")
    /*
        加上@RequestParam()注解明确告诉springMVC要拿到empName的数据
     */
    public Msg checkUser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regName="(^[A-Za-z0-9-_]{5,16}$)|(^[\\u4e00-\\u9fa5]{2,5}$)";
        if(!empName.matches(regName)){
            //false表示匹配失败
            return Msg.fail().add("va_msg","用户名不合法!(后端校验)");
        }
        //数据库用户名重复校验
        Boolean b=employeeService.checkUser(empName);
        if(b){
            //true,可用
            return Msg.success();
        }else{
            //姓名不可用
            return Msg.fail().add("va_msg","用户名不可用!(后端校验!)");
        }
    }

    /*
        pn:页码
        查询员工信息并以json的形式发送到浏览器上
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(Integer pn){
        //pn为输入的页码,5代表一次显示5条数据
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps=employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //他的里面封装了详细的分页信息,包括有我们查询出来的数据
        PageInfo page=new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    /*
        保存员工数据
     */
    @RequestMapping(value="/emp",method= RequestMethod.POST)
    @ResponseBody
    /*
        @Valid 这个注解是jsr303的,封装employee前要检测用户名和邮箱是否合法
        BindingResult result --封装校验的结果, result可能是失败也可能是成功
     */
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败,应该返回失败,在模态框中显示校验失败的错误信息
            //把错误信息封装到一个容器中
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors= result.getFieldErrors();
            for(FieldError fieldError:errors){
                System.out.println("错误的字段:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            //校验成功
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }
}
