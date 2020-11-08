package org.example.controller;

import org.example.bean.Department;
import org.example.bean.Msg;
import org.example.service.DepartmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/*
    查出所有部门信息
 */
@Controller
public class DepartmentController {

    @Resource
    private DepartmentService departmentService;

    /*
        返回所有部门信息
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list=departmentService.getDepts();
        return Msg.success().add("depts",list);

    }
}
