SELECT pr.procedure_name, 
       pr.subprogram_id, 
       ar.in_out, 
       ar.argument_name,
       ar.data_type 
  FROM all_procedures pr, 
       all_arguments ar
 WHERE pr.subprogram_id <> 0
  AND pr.object_type IN ('PACKAGE', 'PROCEDURE', 'FUNCTION')
  AND pr.owner = ?
  AND pr.procedure_name = ?
  AND pr.object_id = ar.object_id
ORDER BY pr.subprogram_id, ar.position