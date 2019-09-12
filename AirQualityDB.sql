--空气质量监测
--创建数据库
IF EXISTS (SELECT * FROM sysdatabases WHERE name='AirQualityDB')
DROP DATABASE [AirQualityDB];

GO

CREATE DATABASE [AirQualityDB]
ON PRIMARY 
(
NAME='AirQualityDB.mdf',
FILENAME='F:\DB\AirQualityDB.mdf',
SIZE=8,
MAXSIZE=64,
FILEGROWTH=2
)
LOG ON
(
NAME='AirQualityDB_log.ldf',
FILENAME='F:\DB\AirQualityDB_log.ldf',
SIZE=8,
MAXSIZE=64,
FILEGROWTH=2
);

GO

USE [AirQualityDB];

--创建监测站信息表
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='StationInfo')
DROP TABLE [StationInfo];
CREATE TABLE [StationInfo]
(
[StationID] INT PRIMARY KEY IDENTITY,
[StationName] NVARCHAR(20) NOT NULL
);

GO

--创建空气质量监测信息表
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='AirQualityInfo')
DROP TABLE [AirQualityInfo];
CREATE TABLE [AirQualityInfo]
(
[AirQualityID] INT PRIMARY KEY IDENTITY,
[StationID] INT NOT NULL,
[InputName] NVARCHAR(20) NOT NULL,
[StartDate] DATETIME NOT NULL,
[EndDate] DATETIME NOT NULL,
[PM] INT NOT NULL,
[Level] INT NOT NULL,
[Notes] NVARCHAR(50)
);

GO

--主外键约束
ALTER TABLE [AirQualityInfo] ADD CONSTRAINT fk_stationId FOREIGN KEY (StationID)
REFERENCES [StationInfo](StationID);

--监测站信息表插入测试数据
INSERT INTO [StationInfo]([StationName])
VALUES
('海淀区一号监测站'),
('海淀区二号监测站'),
('海淀区三号监测站');

--空气质量监测信息表插入测试数据
INSERT INTO [AirQualityInfo]([StationID],[InputName],[StartDate],[EndDate],[PM],[Level],[Notes])
VALUES
('1','张三',GETDATE(),'2019-09-12',10,1,'无'),
('2','李四',GETDATE(),'2019-09-13',20,2,'无'),
('3','王五',GETDATE(),'2019-09-15',30,2,'无');

--查询监测站表信息
SELECT * FROM [StationInfo];

--查询空气监测信息表信息
SELECT * FROM [AirQualityInfo];




