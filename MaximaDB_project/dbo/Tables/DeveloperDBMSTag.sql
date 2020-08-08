CREATE TABLE [dbo].[DeveloperDBMSTag] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [Tag]           NVARCHAR (255) NOT NULL,
    [DeveloperDBMS] INT            NOT NULL,
    [sysCreatedAt]  DATETIME       CONSTRAINT [DF_DeveloperDBMSTag_sysCreatedAt] DEFAULT (getutcdate()) NULL,
    [sysChangedAt]  DATETIME       CONSTRAINT [DF_DeveloperDBMSTag_sysChangedAt] DEFAULT (getutcdate()) NULL,
    [sysCreatedBy]  INT            CONSTRAINT [DF_DeveloperDBMSTag_sysCreatedBy] DEFAULT ((-1)) NULL,
    [sysChangedBy]  INT            CONSTRAINT [DF_DeveloperDBMSTag_sysChangedBy] DEFAULT ((-1)) NULL,
    CONSTRAINT [PK_DeveloperDBMSTag_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_DeveloperDBMSTag_DeveloperDBMS] FOREIGN KEY ([DeveloperDBMS]) REFERENCES [dbo].[DeveloperDBMS] ([Id]),
    CONSTRAINT [UC_DeveloperDBMSTag] UNIQUE NONCLUSTERED ([DeveloperDBMS] ASC, [Tag] ASC)
);




GO
CREATE NONCLUSTERED INDEX [IX_DeveloperDBMSTag_Tag]
    ON [dbo].[DeveloperDBMSTag]([Tag] ASC);

