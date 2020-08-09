/*-----TABLES CREATING-----*/
create table dbo.Client (
    Id int not null identity -- идентификатор клиента
        constraint PK_Client primary key clustered,
    [Name] varchar(128) not null -- наименование клиента
);
go

create table dbo.ClientOrder (
    Id int not null identity -- идентификатор заказа
        constraint PK_ClientOrder primary key clustered,
    ClientId int not null -- идентификатор клиента
        constraint FK_ClientOrder_Client foreign key (ClientId) references dbo.Client (Id),
    [Datetime] datetime2(7) not null, -- дата/время заказа
    AmountInRub decimal(19,2) not null -- сумма заказа
);
go

/*-----TABLES SEEDING-----*/
INSERT INTO [dbo].[Client]
           ([Name])
     VALUES
            ('Mike Taison')
		   ,('Ivan Ivanov')
		   ,('John Maslow')
		   ,('Peter Jackson')
		   ,('Robert Langdon')
		   ,('Ivan Ivanov');

INSERT INTO [dbo].[ClientOrder]
           ([ClientId]
           ,[Datetime]
           ,[AmountInRub])
     VALUES
           (1, '20200801 15:45:41', 100)
		  ,(1, '20200802 13:41:24', 1000)
		  ,(1, '20200702 12:24:52', 500)
		  ,(2, '20200709 11:59:24', 30)
		  ,(2, '20200809 18:21:21', 800)
		  ,(2, '20200806 17:53:52', 800)
		  ,(3, '20200806 21:11:22', 50)
		  ,(4, '20200706 21:15:52', 350.80)
		  ,(4, '20200720 14:32:59', 750.80)
		  ,(5, '20200802 15:41:11', 420)
		  ,(6, '20200709 12:40:08', 350)
		  ,(6, '20200809 10:35:10', 800);
GO

/*-----TASKS-----*/
/* Задание
1. Составить запрос, который вернет наименования клиентов (идентификатор возвращаться не должен), сделавших хотя бы один заказ за последний месяц и
    сумму всех заказов для каждого клиента за этот же период, отсортировать так, чтобы клиенты потратившие больше были наверху

2. Условия из предыдущей задачи (1), но учесть, что могут быть клиенты с неуникальными наименованиями
*/
SELECT DISTINCT c.[Name]
			   ,SUM(co.AmountInRub) OVER(PARTITION BY c.[Id]) AS [OrderSumInRub]
FROM dbo.Client c
INNER JOIN dbo.ClientOrder co ON co.ClientId = c.Id
WHERE co.[Datetime] >= '20200801' AND co.[Datetime] <= '20200831'
ORDER BY [OrderSumInRub] DESC;

-- 3. Условия из предыдущей задачи (2), но также вывести клиентов, которые не сделали ни одного заказа за указанный период
SELECT DISTINCT c.[Name]
			   ,ISNULL(SUM(co.AmountInRub) OVER(PARTITION BY c.[Id]), 0) AS [OrderSumInRub]
FROM dbo.Client c
LEFT JOIN dbo.ClientOrder co ON co.ClientId = c.Id
	AND co.[Datetime] >= '20200801' AND co.[Datetime] <= '20200831'
ORDER BY [OrderSumInRub] DESC;

-- 4. Условия из предыдущей задачи (3), но вывести только клиентов, потративших за период не больше 1000 рублей 50 копеек
WITH Orders_CTE AS (
	SELECT DISTINCT c.[Name]
				   ,SUM(co.AmountInRub) OVER(PARTITION BY c.[Id]) AS [OrderSumInRub]
	FROM dbo.Client c
	INNER JOIN dbo.ClientOrder co ON co.ClientId = c.Id
	WHERE co.[Datetime] >= '20200801' AND co.[Datetime] <= '20200831'
)
SELECT * FROM Orders_CTE oc
WHERE oc.OrderSumInRub <= 1000.50
ORDER BY oc.[OrderSumInRub] DESC;

/*-----TABLES DROPPING-----*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClientOrder]') AND type in (N'U'))
DROP TABLE [dbo].[ClientOrder];
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Client]') AND type in (N'U'))
DROP TABLE [dbo].[Client];
GO