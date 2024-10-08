USE [master]
GO
/****** Object:  Database [IndustryConnectWeek2]    Script Date: 29/09/2024 20:40:26 ******/
CREATE DATABASE [IndustryConnectWeek2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IndustryConnectWeek2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\IndustryConnectWeek2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IndustryConnectWeek2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\IndustryConnectWeek2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [IndustryConnectWeek2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IndustryConnectWeek2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ARITHABORT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IndustryConnectWeek2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IndustryConnectWeek2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [IndustryConnectWeek2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IndustryConnectWeek2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET RECOVERY FULL 
GO
ALTER DATABASE [IndustryConnectWeek2] SET  MULTI_USER 
GO
ALTER DATABASE [IndustryConnectWeek2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IndustryConnectWeek2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IndustryConnectWeek2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IndustryConnectWeek2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [IndustryConnectWeek2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [IndustryConnectWeek2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'IndustryConnectWeek2', N'ON'
GO
ALTER DATABASE [IndustryConnectWeek2] SET QUERY_STORE = OFF
GO
USE [IndustryConnectWeek2]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateAge]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE FUNCTION [dbo].[CalculateAge] (@DateOfBirth datetime)
RETURNS int
AS BEGIN

RETURN
     CONVERT(int,ROUND(DATEDIFF(hour,@DateOfBirth,GETDATE())/8766.0,0))
    
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetCustomerAmount]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetCustomerAmount] (@CustomerId int)
returns money
as
begin
--declare @amount money;

return (select sum(price) from CustomerSales where [Customer Id] = @CustomerId);

--return @amount
end
GO
/****** Object:  Table [dbo].[Product]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Active] [bit] NULL,
	[Price] [money] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[ProductId] [int] NULL,
	[DateSold] [datetime] NULL,
	[StoreId] [int] NULL,
 CONSTRAINT [PK_Sale] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NULL,
	[Address] [varchar](100) NULL,
 CONSTRAINT [PK_Customer_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerSales]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[CustomerSales]
as
select c.Id as 'Customer Id', c.FirstName, c.LastName, s.DateSold, p.[Name], p.Price
, [dbo].[GetCustomerAmount](c.Id) as 'Total Purchases',CONCAT(c.FirstName, ' ', c.LastName) as 'Full Name'
	from Customer c
		left join 
			Sale s on 
				c.Id = s.CustomerId
					left join 
						Product p on
							s.ProductId = p.Id 

GO
/****** Object:  Table [dbo].[Store]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Address] [nvarchar](250) NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [Name], [Address]) VALUES (2, N'Piyu', N'Dublin')
INSERT [dbo].[Customer] ([Id], [Name], [Address]) VALUES (3, N'Sumit', N'Sangli')
INSERT [dbo].[Customer] ([Id], [Name], [Address]) VALUES (4, N'Santosh', N'Ireland')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer1] ON 

INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (1, N'Andy', N'Mckelvey')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (2, N'Callum', N'Jones')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (3, N'Abigail', N'Smith')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (4, N'sumit', N'sokashi')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (5, N'sumit ', N'sokashi')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (6, N'akshay', N'bhosale')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (8, N'virat', N'kohali')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (9, N'xyz', N'azs')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (10, N'amsd', N'sqrq')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (11, N'robert ', N'downey')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (12, N'will ', N'smith')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (13, N'will', N'smith')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (14, N'will', N'smith')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (15, N'will', N'smith')
INSERT [dbo].[Customer1] ([Id], [Name], [Address]) VALUES (16, N'afgh', N'asdf')
SET IDENTITY_INSERT [dbo].[Customer1] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (1, N'Washing Machine', NULL, NULL, 200.0000)
INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (2, N'Television', N'Television', 1, 450.0000)
INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (3, N'Toaster', NULL, NULL, 45.5900)
INSERT [dbo].[Product] ([Id], [Name], [Description], [Active], [Price]) VALUES (4, N'Kettle', NULL, 1, 15.0000)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Sale] ON 

INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (1, 2, 2, CAST(N'2024-06-03T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (2, 2, 1, CAST(N'2024-06-03T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Sale] ([Id], [CustomerId], [ProductId], [DateSold], [StoreId]) VALUES (4, 4, 2, CAST(N'2024-06-03T00:00:00.000' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[Sale] OFF
GO
SET IDENTITY_INSERT [dbo].[Store] ON 

INSERT [dbo].[Store] ([Id], [Name], [Address]) VALUES (1, N'Store', N'Mumbai')
INSERT [dbo].[Store] ([Id], [Name], [Address]) VALUES (3, N'Store 2', N'Aus')
SET IDENTITY_INSERT [dbo].[Store] OFF
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Sale_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer1] ([Id])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_Sale_Customer]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Sale_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_Sale_Product]
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 29/09/2024 20:40:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertProduct] @Name nvarchar(100), @Price money
as
begin
insert into [dbo].[Product]([Name], Price, Active)
values
(@Name,@Price,1)

end
GO
USE [master]
GO
ALTER DATABASE [IndustryConnectWeek2] SET  READ_WRITE 
GO
