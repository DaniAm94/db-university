-- Selezionare tutti gli studenti nati nel 1990 (160)
SELECT
    *
FROM
    `STUDENTS`
WHERE
    YEAR(`DATE_OF_BIRTH`) = 1990;

-- Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT
    *
FROM
    `COURSES`
WHERE
    `CFU`>10;

-- Selezionare tutti gli studenti che hanno più di 30 anni
SELECT
    *
FROM
    `STUDENTS`
WHERE
    `DATE_OF_BIRTH` <= "1993-03-01"
ORDER BY
    `DATE_OF_BIRTH` DESC;

-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT
    *
FROM
    `COURSES`
WHERE
    `PERIOD`= "I semestre"
    AND `YEAR` = 1;

-- Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT
    *
FROM
    `EXAMS`
WHERE
    `DATE` = "2020-06-20"
    AND `HOUR` > "14:00:00";

-- Selezionare tutti i corsi di laurea magistrale (38)
SELECT
    *
FROM
    `DEGREES`
WHERE
    `LEVEL` = "magistrale";

-- Da quanti dipartimenti è composta l'università? (12)
SELECT
    COUNT(`ID`) AS `NUM_DIPARTIMENTI`
FROM
    `DEPARTMENTS`;

-- Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT
    COUNT(`ID`) AS `NUM_INSEGNANTI_SENZA_TELEFONO`
FROM
    `TEACHERS`
WHERE
    `PHONE` IS NULL;

-- Contare quanti iscritti ci sono stati ogni anno
SELECT
    COUNT(`ID`)            AS `NUM_ISCRITTI`,
    YEAR(`ENROLMENT_DATE`) AS `ANNO`
FROM
    `STUDENTS`
GROUP BY
    `ANNO`;

-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT
    COUNT(`ID`)      AS `NUM_UFFICI`,
    `OFFICE_ADDRESS` AS `INDIRIZZO_UFFICIO`
FROM
    `TEACHERS`
GROUP BY
    `INDIRIZZO_UFFICIO`;

-- Calcolare la media dei voti di ogni appello d'esame
-- inclusi voti insufficienti
SELECT
    ROUND(AVG(`VOTE`)) AS `MEDIA_VOTI`,
    `EXAM_ID`          AS `ID_ESAME`
FROM
    `EXAM_STUDENT`
GROUP BY
    `ID_ESAME`;

-- solo voti sufficienti
SELECT
    ROUND(AVG(`VOTE`)) AS `MEDIA_VOTI`,
    `EXAM_ID`          AS `ID_ESAME`
FROM
    `EXAM_STUDENT`
WHERE
    `VOTE` >= 18
GROUP BY
    `ID_ESAME`;

-- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT
    COUNT(`ID`)     AS `NUM_CORSI_DI_LAUREA`,
    `DEPARTMENT_ID` AS `ID_DIPARTIMENTO`
FROM
    `DEGREES`
GROUP BY
    `ID_DIPARTIMENTO`;

-- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT
    S.*,
    `D`.`NAME` AS 'nome corso di laurea'
FROM
    `STUDENTS` AS S
    JOIN `DEGREES` AS D
    ON `S`.`DEGREE_ID` = `D`.`ID`
WHERE
    `D`.`NAME` = 'Corso di Laurea in Economia';

-- Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT
    `DEG`.`NAME` AS 'Corsi di laurea del Dipartimento di Neuroscienze'
FROM
    `DEGREES` AS DEG
    JOIN `DEPARTMENTS` AS DEP
    ON `DEG`.`DEPARTMENT_ID` = `DEP`.`ID`
WHERE
    `DEP`.`NAME` = 'Dipartimento di Neuroscienze';

-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT
    `C`.`NAME` AS 'Nome corso',
    `T`.`ID` AS 'ID insegnante',
    `T`.`NAME` AS 'Nome insegnante',
    `T`.`SURNAME` AS 'Cognome insegnante'
FROM
    `COURSES` AS C
    JOIN `COURSE_TEACHER` AS CT
    ON `C`.`ID` = `CT`.`COURSE_ID`
    JOIN `TEACHERS` AS T
    ON T.`ID` = `CT`.`TEACHER_ID`
WHERE
    `T`.`SURNAME` = 'Amato'
    AND `T`.`NAME` = 'Fulvio';

-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT
    `S`.`REGISTRATION_NUMBER` AS 'matricola',
    `S`.`SURNAME` AS `COGNOME_STUDENTE`,
    `S`.`NAME` AS `NOME_STUDENTE`,
    `DEG`.`NAME` AS 'corso_di_laurea',
    `DEP`.`NAME` AS 'nome_dipartimento'
FROM
    `STUDENTS` AS S
    JOIN `DEGREES` AS DEG
    ON `S`.`DEGREE_ID` = `DEG`.`ID`
    JOIN `DEPARTMENTS` AS DEP
    ON `DEG`.`DEPARTMENT_ID` = `DEP`.`ID`
ORDER BY
    `COGNOME_STUDENTE`,
    `NOME_STUDENTE`;

-- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT
    `D`.`NAME` AS 'nome corso di laurea',
    `C`.`NAME` AS 'nome corso',
    `T`.`NAME` AS 'nome insegnante',
    `T`.`SURNAME` AS 'cognome insegnante'
FROM
    `DEGREES` AS D
    JOIN `COURSES` AS C
    ON `D`.`ID` = `C`.`DEGREE_ID`
    JOIN `COURSE_TEACHER` AS CT
    ON `C`.`ID` = `CT`.`COURSE_ID`
    JOIN `TEACHERS` AS T
    ON `T`.`ID` = `CT`.`TEACHER_ID`;

-- Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT
    `T`.`NAME` AS 'nome docente',
    `T`.`SURNAME` AS 'cognome insegnante',
    `DEP`.`NAME` AS 'nome dipartimento',
    `DEP`.`ID` AS 'id dipartimento'
FROM
    `TEACHERS` AS T
    JOIN `COURSE_TEACHER` AS CT
    ON `T`.`ID` = `CT`.`TEACHER_ID`
    JOIN `COURSES` AS C
    ON `C`.`ID` = `CT`.`COURSE_ID`
    JOIN `DEGREES` AS DEG
    ON `DEG`.`ID` = `C`.`DEGREE_ID`
    JOIN `DEPARTMENTS` AS DEP
    ON `DEP`.`ID` = `DEG`.`DEPARTMENT_ID`
WHERE
    `DEP`.`NAME` = 'Dipartimento di Matematica';

-- BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT
    `S`.`REGISTRATION_NUMBER` AS `MATRICOLA`,
    `S`.`NAME` AS 'nome studente',
    `S`.`SURNAME` AS 'cognome studente',
    `C`.`NAME` AS 'nome materia',
    COUNT(ES.VOTE) AS 'tentativi',
    MAX(ES.`VOTE`) AS `VOTO_MASSIMO`
FROM
    `STUDENTS` AS S
    JOIN `EXAM_STUDENT` AS ES
    ON `S`.`ID` = `ES`.`STUDENT_ID`
    JOIN `EXAMS` AS E
    ON `E`.`ID` = `ES`.`EXAM_ID`
    JOIN `COURSES` AS C
    ON `C`.`ID` = `E`.`COURSE_ID`
GROUP BY
    `S`.`ID`,
    `C`.`NAME`
HAVING
    `VOTO_MASSIMO` >= 18;