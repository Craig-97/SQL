	-- ===== Drop Types =====
	DROP TYPE objName FORCE;
	DROP TYPE objAddress FORCE;
	DROP TYPE objPersonType FORCE;
	DROP TYPE objCustomer FORCE;
	DROP TYPE objEmployee FORCE;
	DROP TYPE objBranch FORCE;
	DROP TYPE objAccType FORCE;
	DROP TYPE objCurrentAcc FORCE;
	DROP TYPE objSavingAcc FORCE;
	
	-- ===== Types =====
	
	-- Name
	CREATE TYPE objName AS OBJECT
	(
	title VARCHAR2(8),
	firstName VARCHAR2(18),
	surName VARCHAR2(18)
	)
	INSTANTIABLE
	NOT FINAL
	;
	/
	
	-- Address
	CREATE TYPE objAddress AS OBJECT
	(
	street VARCHAR(45),
	city VARCHAR(40),
	postcode VARCHAR(8)
	)
	INSTANTIABLE
	NOT FINAL
	;
	/
	
		-- Abstract Person Type
	CREATE TYPE objPersonType AS OBJECT
	(
	pName objName,
	homePhone VARCHAR(12),
	mobile1 VARCHAR(11),
	mobile2 VARCHAR(11),
	niNum VARCHAR(13),
	pAddress objAddress
	)
	INSTANTIABLE
	NOT FINAL
	;
	/
	
	-- Customer
	CREATE TYPE objCustomer UNDER objPersonType
	(
	cID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Employee
	CREATE TYPE objEmployee UNDER objPersonType
	(
	empID INT,
	supervisorID INT,
	position VARCHAR(40),
	salary NUMERIC(6,3),
	bID INT,
	joinDate DATE
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Account Type (Abstract class)
	CREATE TYPE objAccType AS OBJECT
	(
	accID INT,
	balance NUMERIC(38, 18),
	inRate NUMERIC(38, 18), 
	limitOfFreeOD NUMERIC(38,18),
	openDate DATE,
	bID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Savings (Inherits from accType)
	CREATE TYPE objSavingAcc UNDER objAccType
	(
	cID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/

	-- Current (Inherits from accType)
	CREATE TYPE objCurrentAcc UNDER objAccType
	(
	cID INT
	)
	INSTANTIABLE
	NOT FINAL
	;
	/


	-- Branch
	CREATE TYPE objBranch AS OBJECT
	(
	bPhone VARCHAR(12),
	pAddress objAddress,
	bID INT
	)
	INSTANTIABLE
	NOT FINAL;
	/

	-- ===== Drop Tables =====
	DROP TABLE tBranch;
	DROP TABLE tCustomer;
	DROP TABLE tEmployee;
	DROP TABLE tAccount;
	DROP TABLE tSavingAcc;
	DROP TABLE tCurrentAcc;

	-- Branch
	CREATE TABLE tBranch OF objBranch
	(
	PRIMARY KEY(bID)
	)
	;
	/
	
		-- Customer
	CREATE TABLE tCustomer OF objCustomer
	(
	PRIMARY KEY(cID)
	);
	/

	-- Employee
	CREATE TABLE tEmployee OF objEmployee
	(
	PRIMARY KEY(empID),
	FOREIGN KEY(bID) REFERENCES tBranch(bID),
	CONSTRAINT uEmp UNIQUE(niNum)
	)
	;
	/

	-- Account
	CREATE TABLE tAccount OF objAccType
	(
	PRIMARY KEY(accID),
	FOREIGN KEY(bID) REFERENCES tBranch(bID)
	)
	;
	/
	
	-- Current
	CREATE TABLE tCurrentAcc OF objCurrentAcc
	(
	PRIMARY KEY(accID),
	FOREIGN KEY(cID) REFERENCES tCustomer(cID)
	)
	;
	/

	-- Savings
	CREATE TABLE tSavingAcc OF objSavingAcc
	(
	PRIMARY KEY(accID),
	FOREIGN KEY(cID) REFERENCES tCustomer(cID)
	)
	;
	/


