CREATE TABLE [dbo].[DeveloperLanguageTag] (
    [Id]                INT           IDENTITY (1, 1) NOT NULL,
    [DeveloperLanguage] INT           NOT NULL,
    [IsWriter]          BIT           NULL,
    [Tag]               NVARCHAR (50) NOT NULL,
    [sysCreatedAt]      DATETIME      CONSTRAINT [DF_DeveloperLanguageTag_sysCreatedAt] DEFAULT (getutcdate()) NULL,
    [sysChangedAt]      DATETIME      CONSTRAINT [DF_DeveloperLanguageTag_sysChangedAt] DEFAULT (getutcdate()) NULL,
    [sysCreatedBy]      INT           CONSTRAINT [DF_DeveloperLanguageTag_sysCreatedBy] DEFAULT ((-1)) NULL,
    [sysChangedBy]      INT           CONSTRAINT [DF_DeveloperLanguageTag_sysChangedBy] DEFAULT ((-1)) NULL,
    CONSTRAINT [PK_DeveloperLanguageTag_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_DeveloperLanguageTag_DeveloperLanguage] FOREIGN KEY ([DeveloperLanguage]) REFERENCES [dbo].[DeveloperLanguage] ([Id]),
    CONSTRAINT [UC_DeveloperLanguageTag] UNIQUE NONCLUSTERED ([DeveloperLanguage] ASC, [Tag] ASC)
);




GO
CREATE NONCLUSTERED INDEX [IX_DeveloperLanguageTag_Tag]
    ON [dbo].[DeveloperLanguageTag]([Tag] ASC);

