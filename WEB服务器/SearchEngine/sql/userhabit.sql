DROP DATABASE IF EXISTS SearchEngine;
CREATE DATABASE SearchEngine;

use SearchEngine;

DROP TABLE IF EXISTS Tbl_Keyword;
CREATE TABLE Tbl_Keyword
(
	id INT NOT NULL AUTO_INCREMENT,
	word CHAR(40),
	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS Tbl_Hot;
CREATE TABLE Tbl_Hot
(
	id INT NOT NULL,
	timestamp INT(20) NOT NULL,
	FOREIGN KEY (id) REFERENCES Tbl_Keyword(id)
);

DROP TABLE IF EXISTS Tbl_KeyRelation;
CREATE TABLE Tbl_KeyRelation
(
	aid INT NOT NULL,
	bid INT NOT NULL,
	FOREIGN KEY (aid) REFERENCES Tbl_Keyword(id),
	FOREIGN KEY (bid) REFERENCES Tbl_Keyword(id)
);


INSERT INTO Tbl_Keyword VALUES(1,'集美大学');
INSERT INTO Tbl_Keyword VALUES(2,'计算机工程学院');
INSERT INTO Tbl_Keyword VALUES(3,'集美大学图书馆');
INSERT INTO Tbl_Keyword VALUES(4,'集美大学教务处');
INSERT INTO Tbl_Keyword VALUES(5,'集美大学网络中心');
INSERT INTO Tbl_Keyword VALUES(6,'集美大学诚毅学院');
INSERT INTO Tbl_Keyword VALUES(7,'计算机工程学院');
INSERT INTO Tbl_Keyword VALUES(8,'集美大学招生办');
INSERT INTO Tbl_Keyword VALUES(9,'郑如滨');
INSERT INTO Tbl_Keyword VALUES(10,'余元辉');
INSERT INTO Tbl_Keyword VALUES(11,'洪联系');
INSERT INTO Tbl_Keyword VALUES(12,'陈和风');
INSERT INTO Tbl_Keyword VALUES(13,'张敏');
INSERT INTO Tbl_Keyword VALUES(14,'严晓杰');
INSERT INTO Tbl_Keyword VALUES(15,'学生就业网');
INSERT INTO Tbl_Keyword VALUES(16,'集大');
INSERT INTO Tbl_Keyword VALUES(17,'集大名人榜');

DROP VIEW IF EXISTS View_Hot_torder;
CREATE VIEW View_Hot_torder
AS
SELECT * 
FROM Tbl_Hot
ORDER BY timestamp DESC;

DROP VIEW IF EXISTS View_Hot_temp;
CREATE VIEW View_Hot_temp
AS
SELECT id id,count(*) n 
FROM View_Hot_torder
GROUP BY id 
ORDER BY n DESC;


DROP VIEW IF EXISTS View_Hot;
CREATE VIEW View_Hot 
AS 
SELECT word hotword 
FROM Tbl_Keyword AS a,View_Hot_temp AS b 
WHERE a.id=b.id limit 0,6;

DROP VIEW IF EXISTS view_keyrelation;

INSERT INTO Tbl_Hot VALUES(1,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(2,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(3,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(4,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(5,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(6,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(7,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(8,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(9,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(10,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(11,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(12,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(13,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(14,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(15,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(16,unix_timestamp());
INSERT INTO Tbl_Hot VALUES(17,unix_timestamp());

INSERT INTO Tbl_KeyRelation VALUES(1,2);
INSERT INTO Tbl_KeyRelation VALUES(1,3);
INSERT INTO Tbl_KeyRelation VALUES(1,4);
INSERT INTO Tbl_KeyRelation VALUES(1,5);
INSERT INTO Tbl_KeyRelation VALUES(1,6);
INSERT INTO Tbl_KeyRelation VALUES(1,7);
INSERT INTO Tbl_KeyRelation VALUES(1,8);
INSERT INTO Tbl_KeyRelation VALUES(2,1);
INSERT INTO Tbl_KeyRelation VALUES(2,3);
INSERT INTO Tbl_KeyRelation VALUES(3,4);
INSERT INTO Tbl_KeyRelation VALUES(4,5);
INSERT INTO Tbl_KeyRelation VALUES(5,6);
INSERT INTO Tbl_KeyRelation VALUES(6,7);
INSERT INTO Tbl_KeyRelation VALUES(7,8);
INSERT INTO Tbl_KeyRelation VALUES(3,2);
INSERT INTO Tbl_KeyRelation VALUES(3,1);
INSERT INTO Tbl_KeyRelation VALUES(3,4);
INSERT INTO Tbl_KeyRelation VALUES(3,5);
INSERT INTO Tbl_KeyRelation VALUES(3,6);
INSERT INTO Tbl_KeyRelation VALUES(3,7);
INSERT INTO Tbl_KeyRelation VALUES(3,8);
INSERT INTO Tbl_KeyRelation VALUES(17,9);
INSERT INTO Tbl_KeyRelation VALUES(17,10);
INSERT INTO Tbl_KeyRelation VALUES(17,11);
INSERT INTO Tbl_KeyRelation VALUES(17,12);
INSERT INTO Tbl_KeyRelation VALUES(17,13);

create procedure hot_add(id int)
begin
	insert into tbl_hot values(id,unix_timestamp())
end;
	
	
	

