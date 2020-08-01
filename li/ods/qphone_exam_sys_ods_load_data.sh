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
--table paper \
--hive-import \
--hive-table qphone_exam_sys_ods.paper \
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

/opt/apps/sqoop-1.4.6-cdh5.7.6/bin/sqoop import \
--connect jdbc:mysql://qphone03:3306/qianfeng \
--username root \
--password 123456 \
--table answer_paper \
--hive-import \
--hive-table qphone_exam_sys_ods.answer_paper \
--delete-target-dir \
--fields-terminated-by '\001' \
--num-mappers 1 \
--as-textfile
