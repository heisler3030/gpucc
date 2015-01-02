-- Correct baseline PG nonsense to get a UTF8 DB:
--      http://stackoverflow.com/questions/16736891/pgerror-error-new-encoding-utf8-is-incompatible

UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE template1;
CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8';
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
\c template1
VACUUM FREEZE;


-- Create Databases
CREATE DATABASE "gpucc" ENCODING = 'utf8';
CREATE DATABASE "travis_ci_test" ENCODING = 'utf8';