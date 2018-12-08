USE Formation
GO

---- ALTER concernant des colonnes
CREATE TABLE Employees
(
EmployeeID       int          IDENTITY  NOT NULL,
FirstName        varchar(25)            NOT NULL,
MiddleInitial    char(1)                NULL,
LastName         varchar(25)            NOT NULL,
SSN              varchar(11)            NOT NULL,
Salary           money                  NOT NULL,
PriorSalary      money                  NOT NULL,
HireDate         smalldatetime          NOT NULL,
TerminationDate  smalldatetime          NULL,
ManagerEmpID     int                     NOT NULL,
Department       varchar(25)            NOT NULL
)
-----------question12
DROP TABLE Employees;
-----------desactiver contrainte
ALTER TABLE VENTE NOCHECK CONSTRAINT [FK__VENTE__CodeClien__239E4DCF];
-----------supprimer contrainte
ALTER TABLE VENTE DROP CONSTRAINT [FK__VENTE__CodeClien__239E4DCF];
-----------supprimer la table client
DROP TABLE Client;
GO


