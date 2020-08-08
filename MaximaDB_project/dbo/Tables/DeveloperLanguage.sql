CREATE TABLE [dbo].[DeveloperLanguage] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Developer]    INT           NOT NULL,
    [Language]     NVARCHAR (50) NOT NULL,
    [sysCreatedAt] DATETIME      CONSTRAINT [DF_DeveloperLanguage_sysCreatedAt] DEFAULT (getutcdate()) NULL,
    [sysChangedAt] DATETIME      CONSTRAINT [DF_DeveloperLanguage_sysChangedAt] DEFAULT (getutcdate()) NULL,
    [sysCreatedBy] INT           CONSTRAINT [DF_DeveloperLanguage_sysCreatedBy] DEFAULT ((-1)) NULL,
    [sysChangedBy] INT           CONSTRAINT [DF_DeveloperLanguage_sysChangedBy] DEFAULT ((-1)) NULL,
    CONSTRAINT [PK_DeveloperLanguage_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_DeveloperLanguage_Developer] FOREIGN KEY ([Developer]) REFERENCES [dbo].[Developer] ([Id]),
    CONSTRAINT [UC_DeveloperLanguage] UNIQUE NONCLUSTERED ([Developer] ASC, [Language] ASC)
);




GO
CREATE NONCLUSTERED INDEX [IX_DeveloperLanguage_Language]
    ON [dbo].[DeveloperLanguage]([Language] ASC);

