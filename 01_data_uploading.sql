CREATE DATABASE IF NOT EXISTS gad7_project
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE gad7_project;
SELECT DATABASE();

DROP TABLE IF EXISTS gad7_responses;

CREATE TABLE gad7_responses (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id),

  score INT NULL,
  type1 INT NULL,
  age VARCHAR(255) NULL,
  gender VARCHAR(10) NULL,
  marriage VARCHAR(20) NULL,
  education VARCHAR(30) NULL,
  occupation VARCHAR(120) NULL,
  income VARCHAR(50) NULL,

  q40  TINYINT NULL,
  q50  TINYINT NULL,
  q60  TINYINT NULL,
  q70  TINYINT NULL,
  q80  TINYINT NULL,
  q90  TINYINT NULL,
  q100 TINYINT NULL,

  q130 VARCHAR(50) NULL,
  q570 VARCHAR(20) NULL,

  q500 TEXT NULL,
  q510 TEXT NULL,
  q520 TEXT NULL,
  q530 TEXT NULL,
  q540 TEXT NULL,
  q560 TEXT NULL,
  q580 TEXT NULL,

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS gad7_raw;

CREATE TABLE gad7_raw (
  user_id VARCHAR(128),
  partner_openid VARCHAR(128),
  partner_id VARCHAR(64),
  type0 VARCHAR(50),
  model_result_risk VARCHAR(50),
  model_result_type1 VARCHAR(50),
  scores VARCHAR(255),
  from_ip VARCHAR(255),
  survey_id VARCHAR(64),

  `21` VARCHAR(30),
  `10` TEXT,
  `30` VARCHAR(20),
  `32` VARCHAR(20),
  `33` VARCHAR(30),
  `35` VARCHAR(120),
  `36` VARCHAR(50),

  `40` VARCHAR(10),
  `50` VARCHAR(10),
  `60` VARCHAR(10),
  `70` VARCHAR(10),
  `80` VARCHAR(10),
  `90` VARCHAR(10),
  `100` VARCHAR(10),

  `130` VARCHAR(50),
  `570` VARCHAR(20),

  `110` TEXT,
  `500` TEXT,
  `510` TEXT,
  `520` TEXT,
  `530` TEXT,
  `540` TEXT,
  `560` TEXT,
  `580` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

TRUNCATE TABLE gad7_raw;

LOAD DATA LOCAL INFILE 'C:/temp/GAD7.csv'
INTO TABLE gad7_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

USE gad7_project;

SELECT COUNT(*) AS n FROM gad7_raw;

TRUNCATE TABLE gad7_responses;

INSERT INTO gad7_responses (
  score, type1, age, gender, marriage, education, occupation, income,
  q40, q50, q60, q70, q80, q90, q100,
  q130, q570,
  q500, q510, q520, q530, q540, q560, q580
)
SELECT
  NULLIF(model_result_risk,'')  AS score,
  NULLIF(model_result_type1,'') AS type1,
  NULLIF(`21`,'') AS age,
  NULLIF(`30`,'') AS gender,
  NULLIF(`32`,'') AS marriage,
  NULLIF(`33`,'') AS education,
  NULLIF(`35`,'') AS occupation,
  NULLIF(`36`,'') AS income,

  NULLIF(`40`,'')  AS q40,
  NULLIF(`50`,'')  AS q50,
  NULLIF(`60`,'')  AS q60,
  NULLIF(`70`,'')  AS q70,
  NULLIF(`80`,'')  AS q80,
  NULLIF(`90`,'')  AS q90,
  NULLIF(`100`,'') AS q100,

  NULLIF(`130`,'') AS q130,
  NULLIF(`570`,'') AS q570,

  NULLIF(`500`,'') AS q500,
  NULLIF(`510`,'') AS q510,
  NULLIF(`520`,'') AS q520,
  NULLIF(`530`,'') AS q530,
  NULLIF(`540`,'') AS q540,
  NULLIF(`560`,'') AS q560,
  NULLIF(`580`,'') AS q580
FROM gad7_raw;
