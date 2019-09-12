--�����������
--�������ݿ�
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

--�������վ��Ϣ��
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='StationInfo')
DROP TABLE [StationInfo];
CREATE TABLE [StationInfo]
(
[StationID] INT PRIMARY KEY IDENTITY,
[StationName] NVARCHAR(20) NOT NULL
);

GO

--�����������������Ϣ��
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

--�����Լ��
ALTER TABLE [AirQualityInfo] ADD CONSTRAINT fk_stationId FOREIGN KEY (StationID)
REFERENCES [StationInfo](StationID);

--���վ��Ϣ������������
INSERT INTO [StationInfo]([StationName])
VALUES
('������һ�ż��վ'),
('���������ż��վ'),
('���������ż��վ');

--�������������Ϣ������������
INSERT INTO [AirQualityInfo]([StationID],[InputName],[StartDate],[EndDate],[PM],[Level],[Notes])
VALUES
('1','����',GETDATE(),'2019-09-12',10,1,'��'),
('2','����',GETDATE(),'2019-09-13',20,2,'��'),
('3','����',GETDATE(),'2019-09-15',30,2,'��');

--��ѯ���վ����Ϣ
SELECT * FROM [StationInfo];

--��ѯ���������Ϣ����Ϣ
SELECT * FROM [AirQualityInfo];




