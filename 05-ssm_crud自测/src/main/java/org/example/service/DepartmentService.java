package org.example.service;

import org.example.bean.Department;
import org.example.dao.DepartmentMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service
public class DepartmentService {

    @Resource
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        List<Department> lists=departmentMapper.selectByExample(null);
        return lists;
    }
}
