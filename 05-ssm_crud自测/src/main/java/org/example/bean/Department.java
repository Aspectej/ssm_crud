package org.example.bean;

import java.util.List;

public class Department {

    private Integer deptId;

    private String deptName;
    /**
     * code : 100
     * msg : 处理成功!
     * extend : {"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}
     */

    private int code;
    private String msg;
    private ExtendBean extend;


    public Department() {
    }

    public Department(Integer deptId, String deptName) {
        this.deptId = deptId;
        this.deptName = deptName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public ExtendBean getExtend() {
        return extend;
    }

    public void setExtend(ExtendBean extend) {
        this.extend = extend;
    }

    public static class ExtendBean {
        private List<Department> depts;

        public List<Department> getDepts() {
            return depts;
        }

        public void setDepts(List<Department> depts) {
            this.depts = depts;
        }
    }
}