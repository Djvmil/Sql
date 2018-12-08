-----1)creer une fonction scalaire qui retourne le nombre total de clients ayant
--passer une commande

Create Function  Nbtotal_Client ()
RETURNS int 
AS
BEGIN; 
declare @val int;
 set @val=(Select Count(Distinct O.CustomerID) From Orders O);

Return @val ;
END;


Select dbo.Nbtotal_Client() as TotaClient ;

-------------------------------------------------------------------------------------------------------------------

--2)creer une fonction scalaire qui retourne pour chaque client donné le nombre de ces commandes

CREATE FUNCTION nbcom_Client1( @CustomersId nchar(5))
RETURNS int 
AS
BEGIN;
 declare @nbr int ;
  set @nbr= (Select count (O.OrderID) From Orders O 
 where CustomerID= @CustomersId)

 RETURN  @nbr;
 END;

 SELECT dbo.nbcom_Client1('AlFKI') as nombreCom;

 -------------------------------------------------------------------------------------------------------------------
--3)creer une fonction scalaire qui retourne pour chaque client donné  sa premiere date de commande

CREATE FUNCTION  DateCom(@Client nchar(5))
RETURNS datetime
AS
BEGIN;
declare @date datetime;
 set @date =(select top 1  O.OrderDate from  Orders O
  WHERE   CustomerID=@Client order by OrderDate asc);
  RETURN  @date;
 END;
 SELECT dbo.DateCom('AlFKI') as datecom;
 -------------------------------------------------------------------------------------------------------------------
 --------  pour chaque client donné  sa premiere date de commande


Select distinct CustomerID ,dbo.DateCom(CustomerID) as datcommande
from Orders;
-------------------------------------------------------------------------------------------------------------------
create function matricule(@nombre int)
returns nvarchar(8)
as begin
declare @resultat nvarchar(5)
---set @nbZero = replicate('0',5-LEN(@nombre))
---return 'COM'+@nbZero+cast(@nombre as nvarchar(5))

set @resultat= RIGHT('00000'+cast(@nombre as nvarchar(5)),5)
return 'COM'+@resultat
end
go
-------------------------------------------------------------------------------------------------------------------

--select SUBSTRING('djamil00',7,2)


select dbo.matricule(0325) as nom

Select Distinct OrderID, dbo.matricule(OrderID)  From Orders

-------------------------------------------------------------------------------------------------------------------

--mettre en place une fonction qui retoune pour chaque client donnee ces trois commande les plus recentes
alter function trois_requete_plus_recente (@CustomerID nvarchar(10))
returns Table
as
return(
select top 3 CustomerID,OrderDate  as [Order Date] from Orders where CustomerID=@CustomerID order by OrderDate desc
)

select * from dbo.trois_requete_plus_recente('ALFKI')
-------------------------------------------------------------------------------------------------------------------


select * from Orders O1 where OrderDate 
IN (select top 3 O2.OrderDate from Orders O2 where O1.CustomerID=O2.CustomerID order by O2.OrderDate desc) 
order by O1.CustomerID, O1.OrderDate desc
-------------------------------------------------------------------------------------------------------------------

declare @tab_customerID TABLE(id int identity (1,1), customerID nvarchar(50))
insert into @tab_customerID
select distinct(customerID) from Orders

declare @id int,@nb int,@customerID nvarchar(10)
set @id = 1;
set @nb = (select count(*) from @tab_customerID)
while(@id <= @nb)
begin

set @customerID =(select customerID from @tab_customerID  where id = @id)
set @id =@id+ 1;

declare @tab TABLE(id int identity (1,1), customerID nvarchar(50), [Order Date] datetime)
insert into @tab
select * from dbo.trois_requete_plus_recente(@customerID)

end

select * from @tab


-------------------------------------------------------------------------------------------------------------------
alter function trois_requete_plus_recente1 (@CustomerID nvarchar(10))
returns @tab TABLE(id int identity (1,1),OrderID int, customerID nvarchar(50), [Order Date] datetime)
as begin
	insert into @tab
	select top 3 OrderID,CustomerID,OrderDate  as [Order Date] from Orders where CustomerID=@CustomerID order by OrderDate desc
	update @tab set OrderID = OrderID + 1000
return;

end

select*from dbo.trois_requete_plus_recente1('BERGS')

-------------------------------------------------------------------------------------------------------------------

select avg(Quantity), ProductName from  [Order Details] as od inner join Products as p
on od.ProductID = p.ProductID
group by ProductName

having avg(Quantity)*5 < ( )


select Quantity from  [Order Details]




create proc la_moye as
declare @moy real
	declare @tab TABLE(id int identity (1,1), Moyenne real, ProductName nvarchar(50))
	insert into @tab
	select avg(Quantity), ProductName,od.ProductID from  [Order Details] as od inner join Products as p
	on od.ProductID = p.ProductID
	group by ProductName,od.ProductID 


select 



go