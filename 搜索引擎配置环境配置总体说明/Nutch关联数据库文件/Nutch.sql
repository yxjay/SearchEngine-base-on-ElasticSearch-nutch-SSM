CREATE DATABASE nutch DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;

use nutch

CREATE TABLE `webpage` (
`id` varchar(767) NOT NULL,
`headers` blob,
`text` longtext DEFAULT NULL,
`status` int(11) DEFAULT NULL,
`markers` blob,
`parseStatus` blob,
`modifiedTime` bigint(20) DEFAULT NULL,
`prevModifiedTime` bigint(20) DEFAULT NULL,
`score` float DEFAULT NULL,
`typ` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
`batchId` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
`baseUrl` varchar(767) DEFAULT NULL,
`content` longblob,
`title` varchar(2048) DEFAULT NULL,
`reprUrl` varchar(767) DEFAULT NULL,
`fetchInterval` int(11) DEFAULT NULL,
`prevFetchTime` bigint(20) DEFAULT NULL,
`inlinks` mediumblob,
`prevSignature` blob,
`outlinks` mediumblob,
`fetchTime` bigint(20) DEFAULT NULL,
`retriesSinceFetch` int(11) DEFAULT NULL,
`protocolStatus` blob,
`signature` blob,
`metadata` blob,
PRIMARY KEY (`id`)
) ENGINE=InnoDB
ROW_FORMAT=COMPRESSED
DEFAULT CHARSET=utf8mb4;