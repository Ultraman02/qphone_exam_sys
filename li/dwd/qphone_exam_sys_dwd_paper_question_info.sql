CREATE DATABASE IF NOT EXISTS `qphone_exam_sys_dwd`;
USE `qphone_exam_sys_dwd`;

-- 创建 试卷-试题 维度表paper_question_dim
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dwd`.`paper_question_dim` (
  id int,
  paper_id int,
  question_id int,
  category_id int,
  question_type_id int,
  question_difficulty_id int
)
PARTITIONED by (exam_id int)
CLUSTERED BY(id) INTO 8 buckets
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

--paper_question_dim插入数据
INSERT OVERWRITE TABLE `qphone_exam_sys_dwd`.`paper_question_dim`
PARTITION(`exam_id`)
SELECT
row_number() over(sort by p.`exam_id`, p.`id`, pq.`question_id`),
p.`id`,
pq.`question_id`,
ca.`id`,
qt.`id`,
qd.`id`,
p.`exam_id`
FROM
`qphone_exam_sys_ods`.`exam` ex
JOIN
`qphone_exam_sys_ods`.`paper` p
ON
ex.`id` = p.`exam_id`
JOIN
`qphone_exam_sys_ods`.`paper_question` pq
ON
p.`id` = pq.`paper_id`
JOIN
`qphone_exam_sys_ods`.`question` q
ON
q.`id` = pq.`question_id`
JOIN
`qphone_exam_sys_ods`.`category` ca
ON
ca.`id` = q.`category_id`
JOIN
`qphone_exam_sys_ods`.`question_type` qt
ON
qt.`id` = q.`question_type_id`
JOIN
`qphone_exam_sys_ods`.`question_difficulty` qd
ON
qd.`id` = q.`question_difficulty_id`
;

CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dwd`.`paper_question_info` (
  id int,
  stage_name string, -->category's name
  paper_id int, --> paper_question
  paper_is_subjective int, -->paper 只有73号考试是1 其他全是0
  question_id int, -->paper_question
  question_type_name string, -->question-->question_type
  question_type_is_objective int, -->question-->question_type
  question_difficulty_name string, -->question-->question_difficulty
  subject_name string, -->学科名，来自category's outline_json
  outline string, -->大纲（即知识点），来自category's outline_json
  right_answer string -->question
)
PARTITIONED by (exam_id int)
CLUSTERED BY(id) INTO 8 buckets
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

INSERT OVERWRITE TABLE `qphone_exam_sys_dwd`.`paper_question_info`
PARTITION(`exam_id`)
SELECT
row_number() over(sort by pqd.`exam_id`, pqd.`paper_id`, pqd.`question_id`),
ca.`name`,
pqd.`paper_id`,
p.`is_subjective`,
pqd.`question_id`,
qt.`name`,
qt.`is_objective`,
qd.`name`,
qphone_exam_sys_dwd.parse_outline_subject(ca.`outline_json`),
qphone_exam_sys_dwd.parse_outline_section(ca.`outline_json`),
q.`right_answer`,
pqd.`exam_id`
FROM
`qphone_exam_sys_dwd`.`paper_question_dim` pqd
JOIN
`qphone_exam_sys_ods`.`category` ca
ON
pqd.`category_id` = ca.`id`
JOIN
`qphone_exam_sys_ods`.`paper` p
ON
pqd.`paper_id` = p.`id`
JOIN
`qphone_exam_sys_ods`.`question_type` qt
ON
pqd.`question_type_id` = qt.`id`
JOIN
`qphone_exam_sys_ods`.`question_difficulty` qd
ON
pqd.`question_difficulty_id` = qd.`id`
JOIN
`qphone_exam_sys_ods`.`question` q
ON
pqd.`question_id` = q.`id`
;

-- 关于ca.`outline`的解析
-- hive> create function qphone_exam_sys_dwd.parse_outline_subject as 'udf.ParseOutlineSubject' using jar 'hdfs://qphone01:8020/jar/dw_project_exam_sys/parse.jar';
-- hive> create function qphone_exam_sys_dwd.parse_outline_section as 'udf.ParseOutlineSection' using jar 'hdfs://qphone01:8020/jar/dw_project_exam_sys/parse.jar';
-- select 
-- qphone_exam_sys_dwd.parse_outline_subject(outline_json), 
-- qphone_exam_sys_dwd.parse_outline_section(outline_json) 
-- from qphone_exam_sys_ods.category;
-- [{"id":50,"name":"Python","pId":0},{"id":77,"name":"web前端","pId":50},{"id":78,"name":"Linux&数据库","pId":50}]