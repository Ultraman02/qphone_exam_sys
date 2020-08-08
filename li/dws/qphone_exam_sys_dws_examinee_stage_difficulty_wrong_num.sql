CREATE DATABASE IF NOT EXISTS `qphone_exam_sys_dws`;
USE `qphone_exam_sys_dws`;

-- 全题型
-- 个人单次考试 各难度 正确率
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dws`.`examinee_stage_difficulty_wrong_num` (
`examinee_id` int,
`examinee_name` string,
`exam_id` int,
`stage_name` string,
`difficulty_type_name` string,
`wrong_number` int,
`total_number` int
)
CLUSTERED BY(exam_id) INTO 8 buckets
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS orc
;

INSERT OVERWRITE TABLE `qphone_exam_sys_dws`.`examinee_stage_difficulty_wrong_num`
SELECT
eai.`examinee_id`,
eai.`examinee_name`,
eai.`exam_id`,
c.`name`,
qd.`name`,
A.`w_cnt`,
A.`cnt`
FROM
`qphone_exam_sys_dwd`.`examinee_answer_info` eai
JOIN
`qphone_exam_sys_dwd`.`paper_question_dim` pqd
ON
eai.`question_id` = pqd.`question_id`
JOIN
`qphone_exam_sys_ods`.`category` c
ON
pqd.`category_id` = c.`id`
JOIN
`qphone_exam_sys_ods`.`question_difficulty` qd
ON
pqd.`question_difficulty_id` = qd.`id`
JOIN
(
SELECT
eai.`exam_id` `exam_id`,
pqi.`question_difficulty_name` `question_difficulty_name`,
eai.`examinee_id` `examinee_id`,
sum(CASE WHEN eai.`is_correct` = 1 THEN 0 ELSE 1 END) w_cnt,
count(eai.`question_id`) cnt
FROM
`qphone_exam_sys_dwd`.`examinee_answer_info` eai
JOIN
`qphone_exam_sys_dwd`.`paper_question_info` pqi
ON
eai.`question_id` = pqi.`question_id`
AND
eai.`exam_id` = pqi.`exam_id`
AND
eai.`exam_id` = pqi.`exam_id`
GROUP BY
eai.`exam_id`,
pqi.`question_difficulty_name`,
eai.`examinee_id`
) A
ON
eai.`exam_id` = A.`exam_id`
AND
qd.`name` = A.`question_difficulty_name`
