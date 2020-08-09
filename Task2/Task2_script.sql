/*-----TABLES CREATING-----*/
create table dbo.Client (
    Id int not null identity -- ������������� �������
        constraint PK_Client primary key clustered,
    [Name] varchar(128) not null -- ������������ �������
);
go

create table dbo.ClientOrder (
    Id int not null identity -- ������������� ������
        constraint PK_ClientOrder primary key clustered,
    ClientId int not null -- ������������� �������
        constraint FK_ClientOrder_Client foreign key (ClientId) references dbo.Client (Id),
    [Datetime] datetime2(7) not null, -- ����/����� ������
    AmountInRub decimal(19,2) not null -- ����� ������
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
/* �������
1. ��������� ������, ������� ������ ������������ �������� (������������� ������������ �� ������), ��������� ���� �� ���� ����� �� ��������� ����� �
    ����� ���� ������� ��� ������� ������� �� ���� �� ������, ������������� ���, ����� ������� ����������� ������ ���� �������

2. ������� �� ���������� ������ (1), �� ������, ��� ����� ���� ������� � ������������� ��������������
*/
SELECT DISTINCT c.[Name]
			   ,SUM(co.AmountInRub) OVER(PARTITION BY c.[Id]) AS [OrderSumInRub]
FROM dbo.Client c
INNER JOIN dbo.ClientOrder co ON co.ClientId = c.Id
WHERE co.[Datetime] >= '20200801' AND co.[Datetime] <= '20200831'
ORDER BY [OrderSumInRub] DESC;

-- 3. ������� �� ���������� ������ (2), �� ����� ������� ��������, ������� �� ������� �� ������ ������ �� ��������� ������
SELECT DISTINCT c.[Name]
			   ,ISNULL(SUM(co.AmountInRub) OVER(PARTITION BY c.[Id]), 0) AS [OrderSumInRub]
FROM dbo.Client c
LEFT JOIN dbo.ClientOrder co ON co.ClientId = c.Id
	AND co.[Datetime] >= '20200801' AND co.[Datetime] <= '20200831'
ORDER BY [OrderSumInRub] DESC;

-- 4. ������� �� ���������� ������ (3), �� ������� ������ ��������, ����������� �� ������ �� ������ 1000 ������ 50 ������
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