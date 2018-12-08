use Northwind
go

--- 1. Sélectionner le nom des clients qui n'ont acheté aucun produit.
--------a. avec NOT IN 
select * from Customers where CustomerID not in (select distinct CustomerID from Orders )

--------a. avec EXISTS  
select * from Customers C where not exists(select * from Orders O  where O.CustomerID = C.CustomerID)

--------a. avec JOINTURE 
select * from Customers C left join Orders O on O.CustomerID = C.CustomerID where O.CustomerID is null

---2. Sélectionner la liste des territoires où il n’y a pas d’employé affecté (utiliser une jointure) 
select * from EmployeeTerritories ET right join Territories T on ET.TerritoryID = T.TerritoryID where ET.TerritoryID is null

---3. Spécifier le nom des clients qui ont acheté tous les produits dont le prix unitaire est inférieur à 5 (ne pas utiliser de clause Group By) 
select * from  Customers C where 
not exists (select * from Products Pr where UnitPrice < 5 
and not exists(select * from [Order Details] Od join Orders O on Od.OrderID = O.OrderID where Od.ProductID = Pr.ProductID and O.CustomerID = C.CustomerID)
)

