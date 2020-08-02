set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table `qphone_exam_sys_ods`.`answer_paper`
partition(exam_id) 
select * from `qphone_exam_sys_ods`.`answer_paper_tmp`;

insert overwrite table `qphone_exam_sys_ods`.`paper`
partition(exam_id) 
select * from `qphone_exam_sys_ods`.`paper_tmp`;

-- drop table qphone_exam_sys_ods.answer_paper_tmp;
-- drop table qphone_exam_sys_ods.paper_tmp;
