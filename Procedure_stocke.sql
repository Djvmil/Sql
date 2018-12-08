
    if exists(select * from sysobjects where type 'p' and name = 'nbr_commande_client')
    drop 
   ---------------------------------------------------------------------------------------------------------------
    create proc nbr_commande_client as
    select CustomerID, count(*) as [Nombre de commande] from orders group by (CustomerID)
    go
	---------------------------------------------------------------------------------------------------------------
	create proc les_clients as
	select * from Customers where CustomerID not in (select distinct CustomerID from Orders )
	go
	---------------------------------------------------------------------------------------------------------------
	create proc les_comandes_inf_5 as
    select * from  Customers C where 
	not exists (select * from Products Pr where UnitPrice < 5 
	and not exists(select * from [Order Details] Od join Orders O on Od.OrderID = O.OrderID where Od.ProductID = Pr.ProductID and O.CustomerID = C.CustomerID)
	)
	go
	---------------------------------------------------------------------------------------------------------------
	alter proc nbr_commande_client_parm @id nvarchar(50) as
    select CustomerID, count(*) as [Nombre de commande] from orders o where o.CustomerID =@id  group by (CustomerID)
    go
	---------------------------------------------------------------------------------------------------------------
	
	alter proc nbr_commande_client_parm (@id nvarchar(50)) as
    select count(*) as [Nombre de commande] from orders o where o.CustomerID =@id  group by (CustomerID)
    go

	---------------------------------------------------------------------------------------------------------------
	alter proc nbr_commande_client_parm (@id nvarchar(50)) as
	declare @nbr int;

	set @nbr = ( select count(*)from orders o where o.CustomerID = @id)

    ---select @nbr  = count(*)from orders o where o.CustomerID =@id  group by (CustomerID)

	print 'Le nombre de commande pour le client '+ @id +' est '+cast(@nbr as nvarchar)
    go

	exec nbr_commande_client_parm BERGS
	go
	---------------------------------------------------------------------------------------------------------------
	/*
	Exercice d'app:
	mettre en place une procedure stocke qui renvoi la quantite commander pour chaque client
	*/


	alter proc nbr_commande_client_parm_exo @id nvarchar(50) as
	declare @qte int

	select @qte =SUM(Od.Quantity) from Orders O inner join [Order Details] Od  
	on O.OrderID = Od.OrderID 
	where O.CustomerID= @id

    print 'La quantite totale commandee par le client '+ @id +' est '+cast(@qte as nvarchar)
    go

	exec nbr_commande_client_parm_exo BERGS

	/*
	Exercice d'app:
	mettre en place une procedure stocke qui renvoi la nombre total de commander ainsi que la quantite total commander pour un client donn
	*/

    alter proc nbr_commande_client_parm_exo2 @id nvarchar(50) as
	declare @qte int, @nbr int

	select @qte =SUM(Od.Quantity), @nbr = count(distinct Od.OrderID) from Orders O inner join [Order Details] Od  
	on O.OrderID = Od.OrderID 
	where O.CustomerID= @id 

    print 'Le nbr total commander par le client '+ @id +' est '+cast(+@nbr as nvarchar)
	print'la quantite totale commandee par le client '+ @id +' est '+cast(@qte as nvarchar)
    go

	exec nbr_commande_client_parm_exo2 ALFKI

	select * from [Order Details]

	
	
	/*
	Exercice d'app:
	10. Dans la base Northwind, lister les 5 commandes les plus récentes passées par un client. 
	*/


	create proc nbr_commande_client_parm_exo3 @id nvarchar(50) as

	select top 5 * from Orders O inner join Customers C 
	on O.CustomerID = C.CustomerID
	where O.CustomerID= @id
	order by O.OrderDate desc

    go

	exec nbr_commande_client_parm_exo3 AlFKI


	select CustomerID from Orders order by CustomerID (select top 5  OrderID,CustomerID,OrderDate  from Orders  group by OrderID,CustomerID,OrderDate order by OrderDate desc)
