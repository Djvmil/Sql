----------------serie 2
-----2) S�lectionner les commandes (Orders) ayant une date comprise entre le � 10/12/1996 � et le � 20/12/1996 �   
 
SELECT * FROM Orders WHERE OrderDate BETWEEN '10-12-1996' AND '20-12-1996'
-----3)S�lectionner les clients qui ont pass� au moins une commande 
---.a)Utiliser une version avec IN 
SELECT * FROM Customers WHERE CustomerID IN (SELECT CustomerID  FROM Orders)

----.b)Utiliser une version avec EXISTS 
SELECT  * FROM Customers WHERE  EXISTS (SELECT CustomerID  FROM Orders WHERE Orders.CustomerID = Customers.CustomerID)

----.c) Utiliser une version avec une jointure 
SELECT  DISTINCT * FROM Customers  INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
 
jdhjdskjgfkjdsgfdskj
 ----4)S�lectionner le nombre total de clients 
 SELECT COUNT(CustomerID) FROM Customers 
 ----Clients qui ont command�es
 SELECT COUNT(CustomerID),  COUNT(DISTINCT CustomerID) FROM Orders 

 ----5)S�lectionner les clients qui n'ont pass� au moins une commande

 --a)Utiliser une version avec NOT IN 
 SELECT * FROM Customers WHERE CustomerID  NOT IN (SELECT DISTINCT  CustomerID  FROM Orders)

 --b)Utiliser une version avec NOT EXISTS

 SELECT  * FROM Customers WHERE NOT  EXISTS (SELECT CustomerID  FROM Orders WHERE Orders.CustomerID =Customers.CustomerID)

 ---c)Utiliser une version avec une jointure 
  SELECT  CustomerID FROM Customers
  
 SELECT * FROM Customers C LEFT JOIN Orders O ON O.CustomerID = C.CustomerID WHERE O.CustomerID IS NULL

 ----AVEC RIGHT JOIN 

  SELECT * FROM Orders O RIGHT JOIN  Customers C  ON O.CustomerID = C.CustomerID WHERE O.CustomerID IS NULL

  SELECT  DISTINCT C.CustomerID, C.ContactName FROM Orders O   RIGHT JOIN Customers C 
   ON  O.CustomerID = C.CustomerID	---- WHERE O.CustomerID IS NOT NULL

 ----6)Dans la table Order Details de la base Northwind, donner la quantit� totale command�e

 SELECT SUM(Quantity) FROM [Order Details]

 ------7)Dans la table Order Details de la base Northwind, donner la quantit� totale command�e par commande (OrderID) 
  
 SELECT  OrderID,SUM(Quantity) as Qtite_Total FROM [Order Details]  GROUP BY OrderID 

 ---8)Dans la table Order Details de la base Northwind, donner la quantit� moyenne, 
 --la quantit� minimale et maximale par commande (OrderID) pour tout identifiant de commande compris entre 11000 et 11002 


 SELECT  OrderID, 
 AVG(Quantity) as MoyeneCom,
 MIN(Quantity) as MinimalCom,
 MAX(Quantity) as MaximalCom 
  FROM [Order Details] WHERE OrderID BETWEEN  11000 AND  11002 GROUP BY  OrderID
  
 

  --9) Dans la table Order Details de la base Northwind, donner la quantit� moyenne,
  -- la quantit� minimale et maximale par commande (OrderID) pour les totaux sup�rieurs � 300 
  
 

  SELECT OrderID, AVG(Quantity)as MoyeneCom,
  Min(Quantity)  as MinimalCom,
  Max(Quantity)as MaximalCom 
   FROM [Order Details] GROUP BY  OrderID
   HAVING SUM(Quantity) > 300

  ----10) S�lectionner les clients ayant pass� exactement 2 commandes 
  
  SELECT CustomerID FROM Orders
   GROUP BY  CustomerID 
   HAVING COUNT( CustomerID )=2
 
 -----1)	S�lectionner les clients qui ont achet�s des produits dont le prix unitaire est inferieur a 5
 
  SELECT DISTINCT  CompanyName,ContactName,ContactTitle,Address From Customers
  INNER JOIN Orders O ON  Customers.CustomerID= O.CustomerID 
   INNER JOIN [Order Details] OD   ON O.OrderID= OD.OrderID 
   INNER JOIN Products P ON P.ProductID = OD.ProductID
   WHERE P.UnitPrice <5
  
  ----2)S�lectionner les clients qui ont achet�s tous les produits dont le prix unitaire est inferieur a 5

  --GROUP BY
 -- SELECT DISTINCT  CompanyName,ContactName,ContactTitle,Address From Customers 
  --NOT EXIT
   