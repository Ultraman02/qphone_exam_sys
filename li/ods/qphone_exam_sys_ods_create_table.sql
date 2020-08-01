CREATE DATABASE IF NOT EXISTS `qphone_exam_sys_ods`;
USE `qphone_exam_sys_ods`;

-- 创建 ods 层的 category 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`category`(
  `id` int,
  `name` string,
  `outline_json` string,
  `subject_id` string,
  `subject_name` string,
  `remark` string,
  `del` string,
  `modifier_id` string,
  `modifier_name` string,
  `modify_time` string,
  `creator_id` string,
  `creator_name` string,
  `create_time` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建 ods 层的 question_type 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`question_type`(
  `id` int,
  `type` int,
  `name` string,
  `is_objective` int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建 ods 层的 question_difficulty 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`question_difficulty`(
  `id` int,
  `difficulty` int,
  `name` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建 ods 层的 question 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`question`(
  `id` int,
  `category_id` int,
  `question_type_id` int,
  `question_difficulty_id` int,
  `state` int,
  `content` string,
  `right_answer` string,
  `analyse` string,
  `del` int,
  `modifier_id` int,
  `modifier_name` string,
  `modify_time` string,
  `creator_id` int,
  `creator_name` string,
  `create_time` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建 ods 层的 question_option 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`question_option`(
  `id` int,
  `content` string,
  `sort` int,
  `question_id` int,
  `is_right` int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建 ods 层的 paper_template 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`paper_template`(
  `id` int,
  `name` string,
  `subject_id` int,
  `subject_name` string,
  `state` int,
  `total_mark` int,
  `del` int,
  `modifier_id` int,
  `modifier_name` string,
  `modify_time` string,
  `creator_id` int,
  `creator_name` string,
  `create_time` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建 ods 层的 paper_template_category_ref 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`paper_template_category_ref`(
  `id` int,
  `paper_template_id` int,
  `category_id` int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建 ods 层的 paper_template_part 表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`paper_template_part`(
  `id` int,
  `paper_template_id` int,
  `question_type_id` int,
  `per_question_mark` int,
  `sort` int,
  `selected` int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS TEXTFILE
;

-- 创建ods层的paper_template_part_question_number试卷模板题型组成各难度题数表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`paper_template_part_question_number` (
  `id` int,
  `paper_template_part_id` int,
  `question_difficulty_id` int,
  `question_number` int
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

-- 创建ods层的exam试卷表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`exam` (
  `id` int,
  `name` string,
  `paper_template_id` int,
  `subject_id` int,
  `subject_name` string,
  `limit_minute` int,
  `pass_score` int,
  `full_mark` int,
  `volume_num` int,
  `remark` string,
  `state` int,
  `del` int,
  `start_time` string,
  `modifier_id` int,
  `modifier_name` string,
  `modify_time` string,
  `creator_id` int,
  `creator_name` string,
  `create_time` string,
  `publish` int
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

-- 创建ods层的exam_class_ref表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`exam_class_ref` (
  `id` int,
  `exam_id` int,
  `class_id` int,
  `class_name` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

-- 创建ods层的paper试卷表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`paper` (
  `id` int,
  `exam_id` int,
  `is_objective` int,
  `is_subjective` int,
  `creator_id` int,
  `creator_name` string,
  `create_time` string
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

-- 创建ods层的paper_question试卷试题
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`paper_question` (
  `id` int,
  `paper_id` int,
  `question_id` int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

-- 创建ods层的answer_paper答卷表
CREATE TABLE IF NOT EXISTS `qphone_exam_sys_ods`.`answer_paper` (
  `id` int,
  `exam_id` int,
  `paper_id` int,
  `examinee_id` int,
  `examinee_name` string,
  `examinee_num` string,
  `class_id` int,
  `class_name` string,
  `start_date` string,
  `exam_time` string,
  `submit_time` string,
  `objective_mark` int,
  `subject_mark` int,
  `subject_smart_mark` int,
  `check_state` int,
  `teacher_id` int,
  `objective_answer_json` string,
  `subject_answer_json` string,
  `subject_check_json` string,
  `objective_check_json` string,
  `evaluation_opinions` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;
