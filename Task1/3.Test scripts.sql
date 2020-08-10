USE MaximaDB;
GO

--«апрос 1
with Candidate as (
    select d.Name as DeveloperName, d.[Level],
            (
                case 
                    when exists (select * from dbo.DeveloperLanguage as dl where dl.Developer = d.Id and dl.[Language] in ('C#', 'Java', 'Delphi')) then 1 
                    else 0 
                end +
                iif(ddbt.Id is null, 0, 1) +
                iif(dlt.Id is null, 0, 1)
            ) as Advantage 
        from dbo.Developer as d
        inner join dbo.Company as c on c.Id = d.Company
        inner join dbo.City as ct on ct.Id = d.ActualCity
        inner join dbo.DeveloperDBMS as ddb on ddb.Developer = d.Id
        inner join dbo.DeveloperLanguage as dl on dl.Developer = d.Id and dl.[Language] = 'T-SQL'
        inner join dbo.DBMS as db on db.Id = ddb.DBMS
        left join dbo.DeveloperDBMSTag as ddbt on ddbt.DeveloperDBMS = ddb.Id and ddbt.Tag = 'AlwaysOn'
        left join dbo.DeveloperLanguageTag as dlt on dlt.DeveloperLanguage = dl.Id and dlt.IsWriter = 1 and dlt.Tag = 'MOT'
        where 
            ct.Name = 'Kazan' and c.Name != 'Maxima' and 
            db.Name = 'MS SQL Server' and ddb.[Version] in (2008, 2012, 2014, 2016) and
            (select count(*) from dbo.DeveloperDBMSTag as ddbt where ddbt.DeveloperDBMS = ddb.Id and ddbt.Tag in ('OLTP', 'lock', 'transaction', 'optimization', 'admin')) >= 4 and
            (
                select count(*)
                    from dbo.DeveloperLanguageTag as dlt
                    where dlt.DeveloperLanguage = dl.Id and dlt.IsWriter = 1 and dlt.Tag in ('index', 'procedure', 'function', 'trigger', 'view')
            ) > 3 and
            d.ExperienceInYears >= 2
)
select top(1) DeveloperName as You
    from Candidate
    order by [Level] + Advantage desc
/*
    ¬ качестве тестового задани€: пришлите скрипт создани€ базы данных, представленных в запросе таблиц, заполнени€ таблиц данными.
    Ќе стесн€йтесь использовать индексы и extended properties. 
    ≈ще два варианта запроса: один - через представление, другой - с использованием row_number.
    ќжидаетс€, что все запросы вернут ваше им€ :-).
*/

--«апрос 2 (через представление)
SELECT TOP(1) DeveloperName AS You
FROM dbo.vw_Candidates 
ORDER BY [Level] + Advantage DESC

--«апрос 3 (с использованием row_number)
SELECT DeveloperName AS You
FROM (SELECT DeveloperName, ROW_NUMBER() OVER (ORDER BY [Level] + Advantage DESC) AS rn 
	  FROM dbo.vw_Candidates) c
WHERE c.rn = 1
