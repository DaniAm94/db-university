-- Selezionare tutti gli studenti nati nel 1990 (160)
SELECT *
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990;

-- Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT *
FROM `courses`
WHERE `cfu`>10;

-- Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * 
FROM `students`
WHERE `date_of_birth` <= "1993-03-01"
ORDER BY `date_of_birth` DESC;

-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * 
FROM `courses`
WHERE `period`= "I semestre"
AND `year` = 1;

-- Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * 
FROM `exams` 
WHERE `date` = "2020-06-20"
AND `hour` > "14:00:00";

-- Selezionare tutti i corsi di laurea magistrale (38)
SELECT * 
FROM `degrees`
WHERE `level` = "magistrale";

-- Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(id) as num_dipartimenti
FROM `departments`;

-- Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(id) as num_insegnanti_senza_telefono
FROM `teachers`
WHERE `phone` IS NULL;

-- Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(id) as num_iscritti, YEAR(`enrolment_date`) as anno
FROM `students`
GROUP BY anno;

-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(id) as num_uffici, `office_address` as indirizzo_ufficio
FROM `teachers`
GROUP BY indirizzo_ufficio;

-- Calcolare la media dei voti di ogni appello d'esame
-- inclusi voti insufficienti 
select ROUND(AVG(`vote`)) as media_voti, exam_id as id_esame
FROM `exam_student`
GROUP BY id_esame;
-- solo voti sufficienti
select ROUND(AVG(`vote`)) as media_voti, exam_id as id_esame
FROM `exam_student`
WHERE `vote` >= 18
GROUP BY id_esame;

-- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(id) as num_corsi_di_laurea, department_id as id_dipartimento
FROM `degrees`
GROUP BY id_dipartimento;