USE MaximaDB;
GO

/*-----Drop constraints-----*/
ALTER TABLE [dbo].[DeveloperDBMS]			DROP CONSTRAINT [FK_DeveloperDBMS_DBMS];
ALTER TABLE [dbo].[DeveloperDBMS]			DROP CONSTRAINT [FK_DeveloperDBMS_Developer];
ALTER TABLE [dbo].[DeveloperDBMSTag]		DROP CONSTRAINT [FK_DeveloperDBMSTag_DeveloperDBMS];
ALTER TABLE [dbo].[DeveloperLanguage]		DROP CONSTRAINT [FK_DeveloperLanguage_Developer];
ALTER TABLE [dbo].[DeveloperLanguageTag]	DROP CONSTRAINT [FK_DeveloperLanguageTag_DeveloperLanguage];

/*-----Truncate tables-----*/
TRUNCATE TABLE [dbo].[City];
TRUNCATE TABLE [dbo].[Company];
TRUNCATE TABLE [dbo].[DBMS];
TRUNCATE TABLE [dbo].[Developer];
TRUNCATE TABLE [dbo].[DeveloperDBMS];
TRUNCATE TABLE [dbo].[DeveloperDBMSTag];
TRUNCATE TABLE [dbo].[DeveloperLanguage];
TRUNCATE TABLE [dbo].[DeveloperLanguageTag];

/*-----Add constraints-----*/
ALTER TABLE [dbo].[DeveloperDBMS] 
                         WITH CHECK ADD CONSTRAINT [FK_DeveloperDBMS_DBMS] FOREIGN KEY ([DBMS])
                         REFERENCES [dbo].[DBMS] ([Id]);
ALTER TABLE [dbo].[DeveloperDBMS] 
                         WITH CHECK ADD CONSTRAINT [FK_DeveloperDBMS_Developer] FOREIGN KEY ([Developer])
                         REFERENCES [dbo].[Developer] ([Id]);
ALTER TABLE [dbo].[DeveloperDBMSTag] 
                         WITH CHECK ADD CONSTRAINT [FK_DeveloperDBMSTag_DeveloperDBMS] FOREIGN KEY ([DeveloperDBMS])
                         REFERENCES [dbo].[DeveloperDBMS] ([Id]);
ALTER TABLE [dbo].[DeveloperLanguage] 
                         WITH CHECK ADD CONSTRAINT [FK_DeveloperLanguage_Developer] FOREIGN KEY ([Developer])
                         REFERENCES [dbo].[Developer] ([Id]);
ALTER TABLE [dbo].[DeveloperLanguageTag] 
                         WITH CHECK ADD CONSTRAINT [FK_DeveloperLanguageTag_DeveloperLanguage] FOREIGN KEY ([DeveloperLanguage])
                         REFERENCES [dbo].[DeveloperLanguage] ([Id]);

/*-----Seeding tables-----*/
INSERT INTO [dbo].[City] ([Name])
     VALUES
            ('Saratov')
		   ,('Kazan');
GO

INSERT INTO [dbo].[Company] ([Name])
     VALUES
            ('Maxima')
		   ,('EPAM')
		   ,('Luxoft')
		   ,('Yandex');
GO

INSERT INTO [dbo].[DBMS] ([Name])
     VALUES
            ('MS SQL Server')
		   ,('Oracle')
		   ,('MySQL')
		   ,('MongoDB');
GO

INSERT INTO [dbo].[Developer] ([Name], [Level], [Company], [ActualCity], [ExperienceInYears])
     VALUES
            ('Sergei Boikov',  3, 2, 2, 10)
		   ,('Sergei Ivanov',  3, 1, 2, 2)
		   ,('Sergei Petrov',  3, 1, 1, 1)
		   ,('Sergei Maximov', 3, 1, 1, 10);
GO

INSERT INTO [dbo].[DeveloperDBMS] ([Developer], [DBMS], [Version])
     VALUES
            (1, 1, 2012)
		   ,(1, 1, 2014)
		   ,(1, 1, 2017)
		   ,(1, 1, 2016)
		   ,(1, 1, 2019)
		   ,(1, 2, 19)
		   ,(2, 2, 19)
		   ,(3, 3, 8)
		   ,(4, 4, 4);
GO

INSERT INTO [dbo].[DeveloperDBMSTag] ([DeveloperDBMS], [Tag])
     VALUES
            (4, 'OLTP')
		   ,(4, 'lock')
		   ,(4, 'transaction')
		   ,(4, 'optimization')
		   ,(6, 'admin')
		   ,(7, 'optimization')
		   ,(8, 'lock');
GO

INSERT INTO [dbo].[DeveloperLanguage] ([Developer], [Language])
     VALUES
            (1, 'T-SQL')
		   ,(1, 'Java')
		   ,(1, 'Python')
		   ,(2, 'T-SQL')
		   ,(3, 'T-SQL')
		   ,(4, 'T-SQL');
GO

INSERT INTO [dbo].[DeveloperLanguageTag] ([DeveloperLanguage], [IsWriter], [Tag])
     VALUES
            (1, 1,    'index')
		   ,(1, 1,    'procedure')
		   ,(1, 1,    'function')
		   ,(1, 1,    'trigger')
		   ,(1, 1,    'view')
		   ,(1, 1,    'MOT')
		   ,(1, 0,    'AlwaysOn')
		   ,(2, 0,    'trigger')
		   ,(3, NULL, 'procedure')
		   ,(4, NULL, 'index');
GO