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

COPY "Salaries" (emp_no, salary, from_date, to_date) FROM 'data_salaries.csv' CSV HEADER DELIMITER ',';
