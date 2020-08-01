CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dwd`.`paper_question_dim` (
  id int,
  exam_id-->exam
  paper_id-->paper
  question_id-->paper_question-->question
  category_id-->category
  question_type_id-->question_id--
  question_difficulty_id-->question_difficulty
)

CREATE TABLE IF NOT EXISTS `qphone_exam_sys_dws`.`paper_question_info` (
  id int,
  exam_id int,
  stage_name string, -->category's name
  paper_id int, --> paper_question
  is_subjective int, -->paper 只有73号考试是1 其他全是0
  question_id int, -->paper_question
  question_type int, -->question-->question_type
  question_type_is_objective int, -->question-->question_type
  question_difficulty int, -->question-->question_difficulty
  subject_id int,
  subject_name string, -->学科id 和 学科名，均来自category's outline_json
  right_answer string, -->question
)