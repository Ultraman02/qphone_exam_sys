#!/bin/bash

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table category \
--hive-import \
--hive-table qphone_exam_sys_ods.category \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table question_type \
--hive-import \
--hive-table qphone_exam_sys_ods.question_type \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table question_difficulty \
--hive-import \
--hive-table qphone_exam_sys_ods.question_difficulty \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table question \
--hive-import \
--hive-table qphone_exam_sys_ods.question \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table question_option \
--hive-import \
--hive-table qphone_exam_sys_ods.question_option \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template \
--hive-import \
--hive-table qphone_exam_sys_ods.paper_template \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template_category_ref \
--hive-import \
--hive-table qphone_exam_sys_ods.paper_template_category_ref \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template_part \
--hive-import \
--hive-table qphone_exam_sys_ods.paper_template_part \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template_part_question_number \
--hive-import \
--hive-table qphone_exam_sys_ods.paper_template_part_question_number \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table exam \
--hive-import \
--hive-table qphone_exam_sys_ods.exam \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table exam_class_ref \
--hive-import \
--hive-table qphone_exam_sys_ods.exam_class_ref \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table paper_question \
--hive-import \
--hive-table qphone_exam_sys_ods.paper_question \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile

# 分区导入
# -------------先将数据导入到临时表
/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--hive-import \
--hive-table qphone_exam_sys_ods.answer_paper_tmp \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile \
--query "select id, paper_id, examinee_id, examinee_name, examinee_num, class_id, class_name, start_date, exam_time, submit_time, objective_mark, subject_mark, subject_smart_mark, check_state, teacher_id, objective_answer_json, subject_answer_json, subject_check_json, objective_check_json, evaluation_opinions, exam_id from answer_paper where \$CONDITIONS" \
--target-dir '/user/hive/warehouse/qphone_exam_sys_ods.db/paper_answer_tmp'

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--query "select id, is_objective, is_subjective, creator_id, creator_name, create_time, exam_id from paper where \$CONDITIONS" \
--target-dir '/user/hive/warehouse/qphone_exam_sys_ods.db/paper_tmp' \
--hive-import \
--hive-table qphone_exam_sys_ods.paper_tmp \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile