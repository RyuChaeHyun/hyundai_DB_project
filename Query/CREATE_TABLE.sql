--CREATE Customer
CREATE TABLE Customer
(Customer_SSN varchar2(15) not null,
 LName varchar2(10) not null,
 FName varchar2(10) not null,
 Sex varchar2(5) not null,
 Address varchar2(60),
 Email varchar2(25),
 License# varchar2(15),
 Phone# varchar2(15),
 Job varchar2(20),
 Ins_JoinStatus varchar2(5) not null,
 CONSTRAINT Customer_pk PRIMARY KEY (Customer_SSN));
 
--CREATE Car 
CREATE TABLE Car
(Car_ModelName varchar2(20) not null,
 Width number(11,2),
 Height number(11,2),
 Depth number(11,2),
 Weight number(11,2),
 FuelEfficiency number(11,2) not null,
 Price number(13,0) not null,
 CarType varchar2(10) not null,
 Color varchar2(10) not null,
 FuelType varchar2(10) not null,
 Modelyear varchar2(4) not null,
 CONSTRAINT Car_pk PRIMARY KEY (Car_ModelName));
 
--CREATE CarOption 
CREATE TABLE CarOption
(Car_ModelName varchar2(20) not null,
 CarOption varchar2(30) not null,
 CONSTRAINT Option_pk PRIMARY KEY (Car_ModelName, CarOption),
 CONSTRAINT Option_fk FOREIGN KEY (Car_ModelName) REFERENCES Car(Car_ModelName));

--CREATE Employee  
 CREATE TABLE Employee
(Employee_ID varchar2(20) not null,
 Employee_SSN varchar2(15) not null,
 FName varchar2(10) not null,
 LName varchar2(10) not null,
 Phone# varchar2(15),
 Address varchar2(60),
 Email varchar2(25),
 Position varchar2(10),
 CONSTRAINT Employee_pk PRIMARY KEY (Employee_ID));
 
--CREATE Engineer
CREATE TABLE Engineer
(Engineer_ID varchar2(20) not null,
 Career varchar2(10),
 CONSTRAINT Engineer_pk PRIMARY KEY (Engineer_ID),
 CONSTRAINT Engineer_fk FOREIGN KEY (Engineer_ID) REFERENCES Employee(Employee_ID));

--CREATE SalesEmployee
CREATE TABLE SalesEmployee
(SalesEmployee_ID varchar2(20) not null,
 Sales_Volume varchar2(10),
 CONSTRAINT SalesEmployee_pk PRIMARY KEY (SalesEmployee_ID),
 CONSTRAINT SalesEmployee_fk FOREIGN KEY (SalesEmployee_ID) REFERENCES Employee(Employee_ID));

--CREATE Wholesale 
CREATE TABLE Wholesale
(License# varchar2(20) not null,
 Engineer_ID varchar2(20) not null,
 Address varchar2(70),
 Name varchar2(15),
 Email varchar2(25),
 Phone# varchar2(15),
 CONSTRAINT Wholesale_pk PRIMARY KEY (License#),
 CONSTRAINT Wholesale_fk FOREIGN KEY (Engineer_ID) REFERENCES Engineer(Engineer_ID));

--CREATE Part 
CREATE TABLE Part
(Part_ModelName varchar2(35) not null,
 Usage varchar2(30),
 CONSTRAINT Part_pk PRIMARY KEY (Part_ModelName));

--CREATE UsingPart  
CREATE TABLE UsingPart
(UP_ModelName varchar2(35) not null,
 Quantity number(10,0),
 CONSTRAINT UsingPart_pk PRIMARY KEY (UP_ModelName),
 CONSTRAINT UsingPart_fk FOREIGN KEY (UP_ModelName) REFERENCES Part(Part_ModelName));

--CREATE WholeSalePart
CREATE TABLE WholeSalePart
(WP_ModelName varchar2(35) not null,
 Wholesale_License# varchar2(15) not null,
 Price number(13,0),
 CONSTRAINT WholeSalePart_pk PRIMARY KEY (WP_ModelName),
 CONSTRAINT WholeSalePart_fk1 FOREIGN KEY (WP_ModelName) REFERENCES Part(Part_ModelName),
 CONSTRAINT WholeSalePart_fk2 FOREIGN KEY (Wholesale_License#) REFERENCES Wholesale(License#));

--CREATE Contract
 CREATE TABLE Contract
(Contract# varchar2(20) not null,
 Car_ModelName varchar2(20) not null,
 Customer_SSN varchar2(15) not null,
 SalesEmployee_ID varchar2(20) not null,
 Contract_Date date,
 Car# varchar2(10),
 Price number(13,0),
 Receiving_Date date,
 CONSTRAINT Contract_pk PRIMARY KEY (Contract#),
 CONSTRAINT Contract_fk1 FOREIGN KEY (Car_ModelName) REFERENCES Car(Car_ModelName),
 CONSTRAINT Contract_fk2 FOREIGN KEY (Customer_SSN) REFERENCES Customer(Customer_SSN),
 CONSTRAINT Contract_fk3 FOREIGN KEY (SalesEmployee_ID) REFERENCES SalesEmployee(SalesEmployee_ID));

--CREATE Production 
CREATE TABLE Production
(Car_ModelName varchar2(20) not null,
 UP_ModelName varchar2(35) not null,
 Engineer_ID varchar2(20) not null,
 CONSTRAINT Production_pk PRIMARY KEY (Car_ModelName, UP_ModelName, Engineer_ID),
 CONSTRAINT Production_fk1 FOREIGN KEY (Car_ModelName) REFERENCES Car(Car_ModelName),
 CONSTRAINT Production_fk2 FOREIGN KEY (UP_ModelName) REFERENCES UsingPart(UP_ModelName),
 CONSTRAINT Production_fk3 FOREIGN KEY (Engineer_ID) REFERENCES Engineer(Engineer_ID));
 
