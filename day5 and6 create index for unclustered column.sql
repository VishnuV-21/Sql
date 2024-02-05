Explain ANALYZE SELECT name FROM store.shippers
where name='Satterfield LLC';
-- creating index for unclustered column increases the performance when searching .
create index name_index on store.shippers (name);

