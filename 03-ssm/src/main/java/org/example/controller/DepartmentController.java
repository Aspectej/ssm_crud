package org.example.controller;

import com.github.pagehelper.PageInfo;
import org.example.bean.Department;
import org.example.bean.Msg;
import org.example.service.DepartmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 处理与部门有关的请求
 */
@Controller
public class DepartmentController {

    @Resource
    private DepartmentService departmentService;

    /*
        返回所有的部门信息
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        //查出的所有的部门信息
        List<Department> list=departmentService.getDepts();
        return Msg.success().add("depts", list);

    }
}
