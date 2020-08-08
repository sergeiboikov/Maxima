--https://docs.google.com/document/d/14ZJicYHeSojDLkSMLGPW8laAjy6qEMQKOjDiDfobHpQ/edit
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

/* Задание
        1. Составить запрос, который вернет наименования клиентов (идентификатор возвращаться не должен), сделавших хотя бы один заказ за последний месяц и
    сумму всех заказов для каждого клиента за этот же период, отсортировать так, чтобы клиенты потратившие больше были наверху
        2. Условия из предыдущей задачи (1), но учесть, что могут быть клиенты с неуникальными наименованиями
        3. Условия из предыдущей задачи (2), но также вывести клиентов, которые не сделали ни одного заказа за указанный период
        4. Условия из предыдущей задачи (3), но вывести только клиентов, потративших за период не больше 1000 рублей 50 копеек
*/
