-- Nicholas Brown --

-- End of file.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'contacts')
DROP TABLE contacts;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'customers')
DROP TABLE customers;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'employee_skills')
DROP TABLE employee_skills;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'employees')
DROP TABLE employees;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'projects')
DROP TABLE projects;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'skills')
DROP TABLE skills;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'task_skills')
DROP TABLE task_skills;
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tasks')
DROP TABLE tasks;

-- tables
-- Table: contacts
CREATE TABLE contacts (
    contact_id int  NOT NULL,
    name varchar(50)  NOT NULL,
    email varchar(50)  NOT NULL,
    customer_id int  NOT NULL,
    CONSTRAINT contacts_pk PRIMARY KEY  (contact_id)
);

-- Table: customers
CREATE TABLE customers (
    customer_id int  NOT NULL,
    name_first varchar(20)  NOT NULL,
    name_last varchar(20)  NOT NULL,
    address_street varchar(20)  NOT NULL,
    address_street2 varchar(20)  NOT NULL,
    address_city varchar(20)  NOT NULL,
    address_state char(2)  NOT NULL,
    address_zip varchar(10)  NOT NULL,
    phone int  NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY  (customer_id)
);

-- Table: employee_skills
CREATE TABLE employee_skills (
    skill_id int  NOT NULL,
    employee_id int  NOT NULL,
    CONSTRAINT employee_skills_pk PRIMARY KEY  (skill_id,employee_id)
);

-- Table: employees
CREATE TABLE employees (
    employee_id int  NOT NULL,
    name varchar(50)  NOT NULL,
    email varchar(50)  NOT NULL,
    billable_hourly_rate money  NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY  (employee_id)
);

-- Table: projects
CREATE TABLE projects (
    project_id int  NOT NULL,
    name_first varchar(20)  NOT NULL,
    name_last varchar(20)  NOT NULL,
    estimated_cost money  NOT NULL,
    estimated_hours int  NOT NULL,
    agreed_to_hourly_rate varchar(3)  NOT NULL,
    description char(10)  NOT NULL,
    employee_id int  NOT NULL,
    contact_id int  NOT NULL,
    CONSTRAINT projects_pk PRIMARY KEY  (project_id)
);

-- Table: skills
CREATE TABLE skills (
    skill_id int  NOT NULL,
    name varchar(50)  NOT NULL,
    CONSTRAINT skills_pk PRIMARY KEY  (skill_id)
);

-- Table: task_skills
CREATE TABLE task_skills (
    skill_id int  NOT NULL,
    task_id int  NOT NULL,
    CONSTRAINT task_skills_pk PRIMARY KEY  (skill_id,task_id)
);

-- Table: tasks
CREATE TABLE tasks (
    task_id int  NOT NULL,
    name varchar(50)  NOT NULL,
    estimated_time_of_completion datetime  NOT NULL,
    actual_time_of_completion datetime  NOT NULL,
    employee_id int  NOT NULL,
    project_id int  NOT NULL,
    CONSTRAINT tasks_pk PRIMARY KEY  (task_id)
);

-- foreign keys
-- Reference: contacts_customers (table: contacts)
ALTER TABLE contacts ADD CONSTRAINT contacts_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id);

-- Reference: employee_skills_employees (table: employee_skills)
ALTER TABLE employee_skills ADD CONSTRAINT employee_skills_employees
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);

-- Reference: employee_skills_skills (table: employee_skills)
ALTER TABLE employee_skills ADD CONSTRAINT employee_skills_skills
    FOREIGN KEY (skill_id)
    REFERENCES skills (skill_id);

-- Reference: projects_contacts (table: projects)
ALTER TABLE projects ADD CONSTRAINT projects_contacts
    FOREIGN KEY (contact_id)
    REFERENCES contacts (contact_id);

-- Reference: projects_employees (table: projects)
ALTER TABLE projects ADD CONSTRAINT projects_employees
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);

-- Reference: task_skills_skills (table: task_skills)
ALTER TABLE task_skills ADD CONSTRAINT task_skills_skills
    FOREIGN KEY (skill_id)
    REFERENCES skills (skill_id);

-- Reference: task_skills_tasks (table: task_skills)
ALTER TABLE task_skills ADD CONSTRAINT task_skills_tasks
    FOREIGN KEY (task_id)
    REFERENCES tasks (task_id);

-- Reference: tasks_employees (table: tasks)
ALTER TABLE tasks ADD CONSTRAINT tasks_employees
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);

-- Reference: tasks_projects (table: tasks)
ALTER TABLE tasks ADD CONSTRAINT tasks_projects
    FOREIGN KEY (project_id)
    REFERENCES projects (project_id);

-- End of file.