 SELECT co.column_name
FROM all_cons_columns co,
     all_constraints cs
WHERE co.owner                = ?
  AND co.table_name           = ?
  AND cs.owner                = co.owner
  AND cs.table_name           = co.table_name
  AND cs.constraint_name      = co.constraint_name
  AND cs.constraint_type     IN ('P', 'R')
  AND cs.constraint_type NOT IN ('C')
ORDER BY cs.index_name