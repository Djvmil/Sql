INSERT INTO Produit1 (IdP, Nom, Prix) VALUES(1,'mango',45.45);
SELECT * FROM Produit1;
SELECT * FROM Formation.dbo.Produit1;

DELETE Produit1 Where IdP=1;

CREATE TABLE Magasin (CodeMagasin Varchar(30) PRIMARY KEY, Nom Varchar(30)); 
CREATE TABLE Client (CodeClient Varchar(20) PRIMARY KEY, Nom Varchar(30), ville Varchar(20), Dept Varchar(20)); 
Use Formation Go (aller vers une nouvelle base)
If exists (SELECT * FROM Produit1 sysobjects WHERE TYPE=’U’ AND Name=’Produit1’) 
		DROP table Produit1
CREATE TABLE  VENTE (CodeMagasin varchar(30),
CodeClient varchar(20),
Qtite tinyint,prix decimal(7,3),
Constraint FK_Mag  FOREIGN KEY(CodeMagasin) REFERENCES Magasin(CodeMagasin),
Constraint FK_CodClient  FOREIGN KEY(CodeClient) REFERENCES Client(CodeClient)

ALTER TABLE Employees
ADD DateOfBirth datetime;
ALTER TABLE Employees
ADD title varchar(25) DEFAULT 'informaticien';
ALTER TABLE Employees 
ALTER COLUMN title varchar(35);
ALTER TABLE VENTE NOCHECK CONSTRAINT [FK__VENTE__CodeClien__239E4DCF];
-----------supprimer contrainte
ALTER TABLE VENTE DROP CONSTRAINT [FK__VENTE__CodeClien__239E4DCF];
-----------supprimer la table client
DROP TABLE Client;
QUESTION :
1)	Modifier la structure de la table produit pour définir une séquence au niveau de la colonne id avec 1 comme valeur de départ de la séquence  et 2 le pas 
2)	Insérer 5 lignes dans la table produit
3)	Indiquer la valeur de @@identity
4)	Supprimer les lignes de la table produit  avec DELETE
5)	Indiquer la valeur de @@identity
6)	Insérer  à nouveau une ligne dans la table produit
7)	Indiquer la valeur de @@identity
8)	Supprimer les lignes de la Table produit avec TRUNCATE  puis insérer  à nouveau une ligne dans la table produit  et indiquer la valeur de @@identity
SOLUTION :

Drop table Produit

Create Table  Produit

Dbcc checkident( Nomtable, reseed,100)

----------------serie 2
-----2) Sélectionner les commandes (Orders) ayant une date comprise entre le « 10/12/1996 « et le « 20/12/1996 »   
 
SELECT * FROM Orders WHERE OrderDate BETWEEN '10-12-1996' AND '20-12-1996'
-----3)Sélectionner les clients qui ont passé au moins une commande 
---.a)Utiliser une version avec IN 
SELECT * FROM Customers WHERE CustomerID IN (SELECT CustomerID  FROM Orders)

----.b)Utiliser une version avec EXISTS 
SELECT  * FROM Customers WHERE  EXISTS (SELECT CustomerID  FROM Orders WHERE Orders.CustomerID = Customers.CustomerID)

----.c) Utiliser une version avec une jointure 
SELECT  DISTINCT * FROM Customers  INNER JOIN Orders ON Customers.CustomerID =Orders.CustomerID
 

 ----4)Sélectionner le nombre total de clients 
 SELECT COUNT(CustomerID) FROM Customers 
 ----Clients qui ont commandées
 SELECT COUNT(CustomerID),  COUNT(DISTINCT CustomerID) FROM Orders 

 ----5)Sélectionner les clients qui n'ont passé au moins une commande

 --a)Utiliser une version avec NOT IN 
 SELECT * FROM Customers WHERE CustomerID  NOT IN (SELECT DISTINCT  CustomerID  FROM Orders)

 --b)Utiliser une version avec NOT EXISTS

 SELECT  * FROM Customers WHERE NOT  EXISTS (SELECT CustomerID  FROM Orders WHERE Orders.CustomerID =Customers.CustomerID)

 ---c)Utiliser une version avec une jointure 
  SELECT  CustomerID FROM Customers
  
 SELECT * FROM Customers  LEFT JOIN Orders ON Customers.CustomerID =Orders.CustomerID

 ----6)Dans la table Order Details de la base Northwind, donner la quantité totale commandée

 SELECT SUM(Quantity) FROM [Order Details]


QUESTION :

1)	Sélectionner les clients qui ont achetés des produits dont le prix unitaire est inferieur a 5

2)	Sélectionner les clients qui ont achetés tous les produits dont le prix unitaire est inferieur a 5


3)	Sélectionner les clients qui ont achetés exactement les mêmes  produits  que le client dont l’identifiant (CustomersID) est ALFKI

4)	

Reponse:


