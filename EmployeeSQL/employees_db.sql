-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP TABLE IF EXISTS departments;
CREATE TABLE "departments" (
    "dept_no"	varchar(4)	NOT NULL,
    "dept_name" varchar(40)	NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

DROP TABLE IF EXISTS employees;
CREATE TABLE "employees" (
    "emp_no" integer   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

DROP TABLE IF EXISTS dept_emp;
CREATE TABLE "dept_emp" (
    "emp_no" int NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

DROP TABLE IF EXISTS dept_manager;
CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" integer  NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);


DROP TABLE IF EXISTS salaries;
CREATE TABLE "salaries" (
    "emp_no" integer  NOT NULL,
    "salary" integer   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

DROP TABLE IF EXISTS titles;
CREATE TABLE "titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

SELECT * FROM departments 
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date DESC;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.last_name, employees.first_name, employees.sex 
FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS frequency
FROM employees GROUP BY last_name ORDER BY frequency DESC;
