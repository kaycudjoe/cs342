-- Load the Calvin LifeWork database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&calvinLW\drop         
commit;
-- Reload the table declarations.
@&calvinLW\schema
commit;
-- Load the table data.
@&calvinLW\data
commit;
-- Add constraints that cannot be added before the data.
--@&calvinLW\constraints
--commit;