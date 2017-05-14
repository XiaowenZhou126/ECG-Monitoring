--
-- File generated with SQLiteStudio v3.1.1 on 周日 5月 14 13:18:44 2017
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: ageRange_adult
DROP TABLE IF EXISTS ageRange_adult;

CREATE TABLE ageRange_adult (
    ECG_data TEXT (10),
    sex      TEXT (4)  CHECK (sex = "男" OR 
                              sex = "女"),
    status   TEXT (10),
    suggest  TEXT (80),
    PRIMARY KEY (
        ECG_data,
        sex
    )
);

INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('小于40', '女', '严重过低', '您的窦性心动过缓，请及时就医');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('40至60之间', '女', '过低', '您的心率过低，请适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('60至100之间', '女', '正常', '您的心率正常，请继续保持');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('100至160之间', '女', '过高', '您的心率过高，请适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('大于160', '女', '严重过高', '您的窦性心动过速，请及时就医');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('小于40', '男', '严重过低', '您的窦性心动过缓，请及时就医');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('40至60之间', '男', '过低', '您的心率过低，请适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('60至100之间', '男', '正常', '您的心率正常，请继续保持');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('100至160之间', '男', '过高', '您的心率过高，请适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_adult (ECG_data, sex, status, suggest) VALUES ('大于160', '男', '严重过高', '您的窦性心动过速，请及时就医');

-- Table: ageRange_baby
DROP TABLE IF EXISTS ageRange_baby;

CREATE TABLE ageRange_baby (
    ECG_data TEXT (10),
    sex      TEXT (4)  CHECK (sex = "男" OR 
                              sex = "女"),
    status   TEXT (10),
    suggest  TEXT (80),
    PRIMARY KEY (
        ECG_data,
        sex
    )
);

INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('小于100', '女', '严重过低', 'Baby窦性心动过缓，请及时就医');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('100至110之间', '女', '过低', 'Baby心动过低，请注意');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('110至130之间', '女', '正常', 'Baby心率正常，请继续保持');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('130至140之间', '女', '过高', 'Baby心率过高，请注意');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('大于140', '女', '严重过高', 'Baby窦性心动过速，请及时就医');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('小于100', '男', '严重过低', 'Baby窦性心动过缓，请及时就医');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('100至110之间', '男', '过低', 'Baby心动过低，请注意');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('110至130之间', '男', '正常', 'Baby心率正常，请继续保持');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('130至140之间', '男', '过高', 'Baby心率过高，请注意');
INSERT INTO ageRange_baby (ECG_data, sex, status, suggest) VALUES ('大于140', '男', '严重过高', 'Baby窦性心动过速，请及时就医');

-- Table: ageRange_children
DROP TABLE IF EXISTS ageRange_children;

CREATE TABLE ageRange_children (
    ECG_data TEXT (10),
    sex      TEXT (4)  CHECK (sex = "男" OR 
                              sex = "女"),
    status   TEXT (10),
    suggest  TEXT (80),
    PRIMARY KEY (
        ECG_data,
        sex
    )
);

INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('小于80', '女', '严重过低', '该女童窦性心动过缓，请及时就医');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('80至90之间', '女', '过低', '该女童心动过低，请注意');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('90至100之间', '女', '正常', '该女童心率正常，请继续保持');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('100至130之间', '女', '过高', '该女童心动过高，请注意');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('大于130', '女', '严重过高', '该女童窦性心动过速，请及时就医');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('小于80', '男', '严重过低', '该男童窦性心动过缓，请及时就医');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('80至90之间', '男', '过低', '该该男童心动过低，请注意');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('90至100之间', '男', '正常', '该男童心率正常，请继续保持');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('100至130之间', '男', '过高', '该男童心动过高，请注意');
INSERT INTO ageRange_children (ECG_data, sex, status, suggest) VALUES ('大于130', '男', '严重过高', '该男童窦性心动过速，请及时就医');

-- Table: ageRange_newborn
DROP TABLE IF EXISTS ageRange_newborn;

CREATE TABLE ageRange_newborn (
    ECG_data TEXT (10),
    sex      TEXT (4)  CHECK (sex = "男" OR 
                              sex = "女"),
    status   TEXT (10),
    suggest  TEXT (80),
    PRIMARY KEY (
        ECG_data,
        sex
    )
);

INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('小于100', '女', '严重过低', '新生儿（女）窦性心动过缓，请及时就医');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('100至120之间', '女', '过低', '新生儿（女）心率过低，请注意');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('120至140之间', '女', '正常', '新生儿（女）心率正常，请继续保持');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('140至160之间', '女', '过高', '新生儿（女）心率过高，请注意');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('大于160', '女', '严重过高', '新生儿（女）窦性心动过速，请及时就医');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('小于100', '男', '严重过低', '新生儿（男）窦性心动过缓，请及时就医');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('100至120之间', '男', '过低', '新生儿（男）心率过低，请注意');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('120至140之间', '男', '正常', '新生儿（男）心率正常，请继续保持');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('140至160之间', '男', '过高', '新生儿（男）心率过高，请注意');
INSERT INTO ageRange_newborn (ECG_data, sex, status, suggest) VALUES ('大于160', '男', '严重过高', '新生儿（男）窦性心动过速，请及时就医');

-- Table: ageRange_oldMan
DROP TABLE IF EXISTS ageRange_oldMan;

CREATE TABLE ageRange_oldMan (
    ECG_data TEXT (10),
    sex      TEXT (4)  CHECK (sex = "男" OR 
                              sex = "女"),
    status   TEXT (10),
    suggest  TEXT (80),
    PRIMARY KEY (
        ECG_data,
        sex
    )
);

INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('小于40', '女', '严重过低', '您的窦性心动过缓，请及时就医');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('40至60之间', '女', '过低', '您的心率过低，请注意进行适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('60至100之间', '女', '正常', '您的心率正常，请继续保持');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('100至160之间', '女', '过高', '您的心率过高，请注意进行适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('大于160', '女', '严重过高', '您的窦性心动过速，请及时就医');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('小于40', '男', '严重过低', '您的窦性心动过缓，请及时就医');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('40至60之间', '男', '过低', '您的心率过低，请注意进行适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('60至100之间', '男', '正常', '您的心率正常，请继续保持');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('100至160之间', '男', '过高', '您的心率过高，请注意进行适当运动、保持心态平和良好的生活习惯');
INSERT INTO ageRange_oldMan (ECG_data, sex, status, suggest) VALUES ('大于160', '男', '严重过高', '您的窦性心动过速，请及时就医');

-- Table: ageRange_youngChildren
DROP TABLE IF EXISTS ageRange_youngChildren;

CREATE TABLE ageRange_youngChildren (
    ECG_data TEXT (10),
    sex      TEXT (4)  CHECK (sex = "男" OR 
                              sex = "女"),
    status   TEXT (10),
    suggest  TEXT (80),
    PRIMARY KEY (
        ECG_data,
        sex
    )
);

INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('小于100', '女', '严重过低', '女孩窦性心动过缓，请及时就医');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('100至110之间', '女', '过低', '女孩心动过低，请注意');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('110至120之间', '女', '正常', '女孩心率正常，请继续保持');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('120至140之间', '女', '过高', '女孩心率过高，请注意');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('大于140', '女', '严重过高', '女孩窦性心动过速，请及时就医');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('小于100', '男', '严重过低', '男孩窦性心动过缓，请及时就医');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('100至110之间', '男', '过低', '男孩心动过低，请注意');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('110至120之间', '男', '正常', '男孩心率正常，请继续保持');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('120至140之间', '男', '过高', '男孩心率过高，请注意');
INSERT INTO ageRange_youngChildren (ECG_data, sex, status, suggest) VALUES ('大于140', '男', '严重过高', '男孩窦性心动过速，请及时就医');

-- Table: ageTable
DROP TABLE IF EXISTS ageTable;

CREATE TABLE ageTable (
    ageRange  TEXT (10) PRIMARY KEY,
    tableName TEXT      CHECK (tableName LIKE "ageRange_%") 
);

INSERT INTO ageTable (ageRange, tableName) VALUES ('新生儿', 'ageRange_neonate');
INSERT INTO ageTable (ageRange, tableName) VALUES ('1岁以下', 'ageRange_baby');
INSERT INTO ageTable (ageRange, tableName) VALUES ('2-3岁之间', 'ageRange_youngChildren');
INSERT INTO ageTable (ageRange, tableName) VALUES ('4-6岁之间', 'ageRange_children');
INSERT INTO ageTable (ageRange, tableName) VALUES ('7-59岁之间', 'ageRange_adult');
INSERT INTO ageTable (ageRange, tableName) VALUES ('60岁以上', 'ageRange_oldMan');

-- Table: persionInfo
DROP TABLE IF EXISTS persionInfo;

CREATE TABLE persionInfo (
    id            INTEGER   PRIMARY KEY
                            CHECK (id = 1),
    name          TEXT (30),
    sex           TEXT (4)  CHECK (sex = "男" OR 
                                   sex = "女"),
    date_of_birth DATE,
    age           TEXT (10) 
);

INSERT INTO persionInfo (id, name, sex, date_of_birth, age) VALUES (1, 'bob', '男', '1997-08-04', '63');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
