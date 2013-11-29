SELECT procedure_name 
  FROM all_procedures 
 WHERE owner = ? 
   AND object_type IN ('PACKAGE', 'PROCEDURE', 'FUNCTION')