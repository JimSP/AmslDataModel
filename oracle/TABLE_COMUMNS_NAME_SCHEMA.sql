SELECT c.table_name, c.column_name, c.data_type 
  FROM all_tab_columns c 
 WHERE c.owner = ? 
   AND c.table_name = ?