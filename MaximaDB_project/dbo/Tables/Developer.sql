CREATE TABLE [dbo].[Developer] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (255) NOT NULL,
    [Level]             TINYINT        NULL,
    [Company]           INT            NULL,
    [ActualCity]        INT            NOT NULL,
    [ExperienceInYears] TINYINT        NOT NULL,
    [sysCreatedAt]      DATETIME       CONSTRAINT [DF_Developer_sysCreatedAt] DEFAULT (getutcdate()) NULL,
    [sysChangedAt]      DATETIME       CONSTRAINT [DF_Developer_sysChangedAt] DEFAULT (getutcdate()) NULL,
    [sysCreatedBy]      INT            CONSTRAINT [DF_Developer_sysCreatedBy] DEFAULT ((-1)) NULL,
    [sysChangedBy]      INT            CONSTRAINT [DF_Developer_sysChangedBy] DEFAULT ((-1)) NULL,
    CONSTRAINT [PK_Developer_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);



