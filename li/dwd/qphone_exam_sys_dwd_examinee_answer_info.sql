CREATE DATABASE IF NOT EXISTS `qphone_exam_sys_dwd`;

CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dwd`.`examinee_answer_info` (
	`id` int,
    `examinee_id` int,
    `examinee_name` string,
	`paper_id` int,
	`question_id` int,
	`user_answer` string,
	`user_score` int,
	`is_correct` int
)
PARTITIONED BY (`exam_id` int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

-- 创建分析 answer_json 的函数
-- create function qphone_exam_sys_dwd.parse_useranswer as 'udtf.ParseUserAnswer' using jar 'hdfs://qphone01:8020/jar/dw_project_exam_sys/parse.jar';

INSERT OVERWRITE TABLE `qphone_exam_sys_dwd`.`examinee_answer_info`
PARTITION(`exam_id`)
SELECT
row_number() over(sort by ap.`examinee_id`, ap.`exam_id`, parse_answer.`qid`),
ap.`examinee_id`,
ap.`examinee_name`,
ap.`paper_id`,
parse_answer.`qid`,
parse_answer.`answer`,
parse_answer.`score`,
CASE WHEN parse_answer.`score` > 0 THEN 1 ELSE 0 END,
ap.`exam_id`
FROM
`qphone_exam_sys_ods`.`answer_paper` ap
JOIN
`qphone_exam_sys_ods`.`paper` p
ON
ap.`paper_id` = p.`id`
JOIN
(
select ap1.`examinee_id` eid, A.c1 qid, A.c2 answer, A.c3 score
from `qphone_exam_sys_ods`.`answer_paper` ap1
lateral view qphone_exam_sys_dwd.parse_useranswer(ap1.`objective_answer_json`) A as `c1`, `c2`, `c3`
UNION ALL
select ap2.`examinee_id` eid, B.c1 qid, B.c2 answer, B.c3 score
from `qphone_exam_sys_ods`.`answer_paper` ap2
lateral view qphone_exam_sys_dwd.parse_useranswer(ap2.`subject_answer_json`) B as `c1`, `c2`, `c3`
) parse_answer
ON
parse_answer.`eid` = ap.`examinee_id`
;