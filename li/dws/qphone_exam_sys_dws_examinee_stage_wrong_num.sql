CREATE DATABASE IF NOT EXISTS `qphone_exam_sys_dws`;
USE `qphone_exam_sys_dws`;

-- 全题型
-- 个人单次考试总正确率
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dws`.`examinee_stage_wrong_num` (
`examinee_id` int,
`examinee_name` string,
`exam_id` int,
`duration_min` int,
`stage_name` string,
`wrong_number` int,
`total_number` int
)
CLUSTERED BY(exam_id) INTO 8 buckets
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS orc
;

INSERT OVERWRITE TABLE `qphone_exam_sys_dws`.`examinee_stage_wrong_num`
SELECT
eai.`examinee_id`,
eai.`examinee_name`,
eai.`exam_id`,
A.`duration`, --> 考试时长，分钟
pqi.`stage_name`,
C.`w_num`,
B.`cnt`
FROM
(
SELECT
exam_id,
examinee_id,
count(question_id) cnt
FROM `qphone_exam_sys_dwd`.`examinee_answer_info` 
GROUP BY
exam_id, 
examinee_id
) B
JOIN
`qphone_exam_sys_dwd`.`examinee_answer_info` eai
ON
eai.`exam_id` = B.`exam_id`
AND
eai.`examinee_id` = B.`examinee_id`
JOIN
(
select
exam_id,
examinee_id,
sum(CASE WHEN eai.`is_correct` = 1 THEN 0 ELSE 1 END) w_num
from `qphone_exam_sys_dwd`.`examinee_answer_info` eai
group by
examinee_id,
exam_id
) C
ON
C.`exam_id` = eai.`exam_id`
AND
C.`examinee_id` = eai.`examinee_id`
JOIN
`qphone_exam_sys_dwd`.`paper_question_info` pqi
ON
eai.`question_id` = pqi.`question_id`
AND
pqi.`exam_id` = eai.`exam_id`
JOIN
(
SELECT
ap.`exam_id` exam_id,
ap.`examinee_id` examinee_id,
floor((unix_timestamp(ap.submit_time)-unix_timestamp(ap.start_date))/60) duration
FROM
`qphone_exam_sys_ODS`.`answer_paper` ap
) A
ON
A.`exam_id` = eai.`exam_id` AND A.`examinee_id` = eai.`examinee_id`
GROUP BY
eai.`examinee_id`,
eai.`examinee_name`,
eai.`exam_id`,
pqi.`stage_name`,
A.`duration`,
eai.`paper_id`,
C.`w_num`,
B.`cnt`
;