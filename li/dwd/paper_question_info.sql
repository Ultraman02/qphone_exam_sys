CREATE DATABASE IF NOT EXISTS `qphone_exam_sys_dwd`;
USE `qphone_exam_sys_dwd`;

-- 创建 试卷-试题 维度表paper_question_dim
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dwd`.`paper_question_dim` (
  id int,
  exam_id-->exam
  paper_id-->paper
  question_id-->paper_question-->question
  category_id-->category
  question_type_id-->question_id--
  question_difficulty_id-->question_difficulty
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dwd`.`paper_question_dim` (
  id int,
  exam_id int,
  paper_id int,
  question_id int,
  category_id int,
  question_type_id int,
  question_difficulty_id int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

--paper_question_dim插入数据
INSERT OVERWRITE TABLE `qphone_exam_sys_dwd`.`paper_question_dim`
SELECT
row_number() over(sort by exam_id, paper_id, question_id),
ex.`id`,
p.`id`,
pq.`question_id`,
ca.`id`,
qt.`id`,
qd.`id`
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

CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dws`.`paper_question_info` (
  id int,
  exam_id int,
  stage_name string, -->category's name
  paper_id int, --> paper_question
  is_subjective int, -->paper 只有73号考试是1 其他全是0
  question_id int, -->paper_question
  question_type_name string, -->question-->question_type
  question_type_is_objective int, -->question-->question_type
  question_difficulty_name string, -->question-->question_difficulty
  subject_name string, -->学科名，来自category's outline_json
  outline string, -->大纲（即知识点），来自category's outline_json
  right_answer string, -->question
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

INSERT OVERWRITE TABLE `qphone_exam_sys_dws`.`paper_question_info`
SELECT
row_number() over(sort by pqd.`exam_id`, pqd.`paper_id`, pqd.`question_id`),
pqd.`exam_id`,
ca.`name`,
pqd.`paper_id`,
p.`is_subjective`,
pqd.`question_id`,
qt.`name`,
qt.`is_objective`,
qd.`name`,
ca.`subject_name`,  
UDF------，这个和上面那么字段要从json中查
q.`right_answer`
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


[{"id":50,"name":"Python","pId":0},{"id":77,"name":"web前端","pId":50},{"id":78,"name":"Linux&数据库","pId":50}]