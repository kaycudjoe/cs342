-- Load the Calvin LifeWork database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&kec32\drop         
commit;
-- Reload the table declarations.
@&kec32\schema
commit;
-- Load the table data.
@&kec32\data
commit;
-- Add constraints that cannot be added before the data.
--@&kec32\constraints
--commit;