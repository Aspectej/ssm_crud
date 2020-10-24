package org.example.test;

import org.apache.ibatis.session.SqlSession;
import org.example.bean.Employee;
import org.example.dao.DepartmentMapper;
import org.example.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MyTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void test01(){
        /**
         * 测试dao层的功能
         */

        System.out.println(departmentMapper);
        //插入部门数据
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //插入员工数据
        /*employeeMapper.insertSelective(new Employee(1001,"mike","M","mike@163.com",
                1001));*/

        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);

        for(int i=0;i<100;i++){
            String uid=UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@163.com",1));
        }
        System.out.println("批量完成");
    }


}
