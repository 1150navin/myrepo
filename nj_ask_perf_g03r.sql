SELECT 
    t1.COUNTY_CODE,
    t1.COUNTY_NAME,
    t1.DISTRICT_CODE,
    t1.DISTRICT_NAME,
    t1.SCHOOL_CODE,
    t1.SCHOOL_NAME,
    t1.SCHOOL_GRADESPAN,
    t3.SCHOOL_GRADE ,
    t2.TESTPRG,
    t2.SUBJECT ACADEMIC_SUBJECT,
    t3.CLASS_SIZE,
    t2.TPP,
    t2.TP,
    t2.TAP,
    round(0.01*t2.TPP*t3.CLASS_SIZE) TPP_ACTUAL,
    round(0.01*t2.TP*t3.CLASS_SIZE) TP_ACTUAL,
    t3.CLASS_SIZE - (round(0.01*t2.TPP*t3.CLASS_SIZE)+round(0.01*t2.TP*t3.CLASS_SIZE))  TAP_ACTUAL
FROM
    nj_edu.sch_header t1
        JOIN
    nj_edu.assessment t2 ON (t1.COUNTY_CODE = t2.COUNTY_CODE
        AND t1.DISTRICT_CODE = t2.DISTRICT_CODE
        AND t1.SCHOOL_CODE = t2.SCHOOL_CODE)
JOIN nj_edu.ct_enrollment t3 on (t1.COUNTY_CODE = t3.COUNTY_CODE
        AND t1.DISTRICT_CODE = t3.DISTRICT_CODE
        AND t1.SCHOOL_CODE = t3.SCHOOL_CODE)        
WHERE
        t3.SCHOOL_GRADE = 'GRADE03'
        AND t2.TESTPRG = 'NJASK3'
        and t2.SUBJECT = 'M'
order by t2.TAP desc