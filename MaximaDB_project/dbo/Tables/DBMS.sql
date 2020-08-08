CREATE TABLE [dbo].[DBMS] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (50) NOT NULL,
    [sysCreatedAt] DATETIME      CONSTRAINT [DF_DBMS_sysCreatedAt] DEFAULT (getutcdate()) NULL,
    [sysChangedAt] DATETIME      CONSTRAINT [DF_DBMS_sysChangedAt] DEFAULT (getutcdate()) NULL,
    [sysCreatedBy] INT           CONSTRAINT [DF_DBMS_sysCreatedBy] DEFAULT ((-1)) NULL,
    [sysChangedBy] INT           CONSTRAINT [DF_DBMS_sysChangedBy] DEFAULT ((-1)) NULL,
    CONSTRAINT [PK_DBMS_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UC_DBMS_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);



