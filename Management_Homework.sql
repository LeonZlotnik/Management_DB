-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/X9pGGg
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(40)   NOT NULL,
    "last_name" varchar(40)  NOT NULL,
    "gender" varchar(40)   NOT NULL,
    "hire_date" date   NOT NULL,
    "salary_asigned" int  NOT NULL,
    "titles_asigned" int  NOT NULL,
    "manager_asigned" int NOT NULL,
    "employee_asigned" int NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(40)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Dep_Manager" (
    "dep_no" int   NOT NULL,
    "emp_no" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Dep_Manager" PRIMARY KEY (
        "dep_no"
     )
);

CREATE TABLE "Dep_Employees" (
    "dep_no" int   NOT NULL,
    "emp_no" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_Dep_Employees" PRIMARY KEY (
        "dep_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_salary_asigned" FOREIGN KEY("salary_asigned")
REFERENCES "Salaries" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_titles_asigned" FOREIGN KEY("titles_asigned")
REFERENCES "Titles" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_manager_asigned" FOREIGN KEY("manager_asigned")
REFERENCES "Dep_Manager" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_employee_asigned" FOREIGN KEY("employee_asigned")
REFERENCES "Dep_Employees" ("emp_no");

CREATE INDEX "idx_Salaries_salary"
ON "Salaries" ("salary");

CREATE INDEX "idx_Titles_title"
ON "Titles" ("title");

CREATE INDEX "idx_Dep_Manager_emp_no"
ON "Dep_Manager" ("emp_no");

CREATE INDEX "idx_Dep_Employees_emp_no"
ON "Dep_Employees" ("emp_no");

______________________________________

COPY "Employees" (emp_no, birth_date, first_name, last_name, gender, hire_date) FROM 'data_employees.csv' CSV HEADER DELIMITER ',';
COPY "Salaries" (emp_no, salary, from_date, to_date) FROM 'data_salaries.csv' CSV HEADER DELIMITER ',';
COPY "Titles" (emp_no, title, from_date, to_date) FROM 'data_titles.csv' CSV HEADER DELIMITER ',';
COPY "Dep_Manager" (dep_no, emp_no, from_date, to_date) FROM 'data_dept_manager.csv' CSV HEADER DELIMITER ',';
COPY "Dep_Employees" (dep_no, emp_no, from_date, to_date) FROM 'data_dept_emp.csv' CSV HEADER DELIMITER ',';

SELECT emp_no, birth_date, first_name, last_name, gender, hire_date, salary_asigned
FROM Employees;

SELECT *
FROM Dep_Employees
WHERE from_date = '1986';

#SELECT dep_no, title, emp_no, last_name, first_name, from_date, to_date
#FROM

SELECT * 
FROM Employees
WHERE emp_no IN 
(
    SELECT dep_no
    FROM Dep_Manager
    WHERE emp_no IN 
    (
        SELECT from_date, to_date
        FROM Dep_Employees
        WHERE emp_no IN 
        (
            SELECT title
            FROM Titles
        )
    )
);

SELECT emp_no, first_name, last_name, title
FROM Employees, Titles
WHERE Employees.emp_no = Titles.emp_no
GROUP BY title;

SELECT *
FROM Employees
WHERE first_name = "Hercules" AND last_name LIKE "B%";

SELECT emp_no, salary, from_date, to_date, first_name, last_name, title
FROM Salaries 
WHERE emp_no IN 
(
    SELECT first_name, last_name
    FROM Employees
    Where emp_no IN 
    (
        SELECT title
        FROM Title 
    )
);

