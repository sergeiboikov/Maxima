CREATE TABLE [dbo].[DeveloperDBMS] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Developer]    INT           NOT NULL,
    [DBMS]         INT           NOT NULL,
    [Version]      NVARCHAR (20) NULL,
    [sysCreatedAt] DATETIME      CONSTRAINT [DF_DeveloperDBMS_sysCreatedAt] DEFAULT (getutcdate()) NULL,
    [sysChangedAt] DATETIME      CONSTRAINT [DF_DeveloperDBMS_sysChangedAt] DEFAULT (getutcdate()) NULL,
    [sysCreatedBy] INT           CONSTRAINT [DF_DeveloperDBMS_sysCreatedBy] DEFAULT ((-1)) NULL,
    [sysChangedBy] INT           CONSTRAINT [DF_DeveloperDBMS_sysChangedBy] DEFAULT ((-1)) NULL,
    CONSTRAINT [PK_DeveloperDBMS_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_DeveloperDBMS_DBMS] FOREIGN KEY ([DBMS]) REFERENCES [dbo].[DBMS] ([Id]),
    CONSTRAINT [FK_DeveloperDBMS_Developer] FOREIGN KEY ([Developer]) REFERENCES [dbo].[Developer] ([Id]),
    CONSTRAINT [UC_DeveloperDBMS_Version] UNIQUE NONCLUSTERED ([Developer] ASC, [DBMS] ASC, [Version] ASC)
);



