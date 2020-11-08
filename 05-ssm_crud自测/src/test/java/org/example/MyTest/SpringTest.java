package org.example.MyTest;

import org.apache.ibatis.session.SqlSession;
import org.example.bean.Department;
import org.example.bean.Employee;
import org.example.dao.DepartmentMapper;
import org.example.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.UUID;

/*
    这里我们使用spring的单元测试,可以自动注入我们需要的组件
    1.导入SpringTest的测试模块
    2.使用@ContextConfiguration
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class SpringTest {

    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private EmployeeMapper employeeMapper;

    @Resource
    private SqlSession sqlSession;

    @Test
    public void test01(){
        //1.插入几个部门
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //2.插入几个员工
        //employeeMapper.insertSelective(new Employee(null,"Mike","M","Mike@163.com",1));
        //employeeMapper.insertSelective(new Employee(null,"Tony","M","Tony@163.com",2));


        /*
            substring()的作用是:截取0,5位的数字
         */

        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<1000;i++){
            String uid=UUID.randomUUID().toString().substring(0,5);
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@163.com",1));
        }
        System.out.println("批量完成");

    }
}
