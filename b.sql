 with S1 as (select table_name as nom, count(constraint_type) as nb_contrainte_de_valeur from information_schema.table_constraints 
 where constraint_schema
 not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1')
 and constraint_type = 'CHECK' group by table_name),
 
 S2 as (select table_name as nom, count(constraint_type) as nb_contrainte_unicite from information_schema.table_constraints 
 where constraint_schema
 not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1')
 and constraint_type = 'UNIQUE' group by table_name),
 
 S3 as (select table_name as nom, count(constraint_type) as nb_contrainte_cle_primaire from information_schema.table_constraints 
 where constraint_schema
 not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1')
 and constraint_type = 'PRIMARY KEY' group by table_name),
 
S4 as (select table_name as nom, count(constraint_type) as nb_contrainte_cle_etrangere from information_schema.table_constraints 
 where constraint_schema
 not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1')
 and constraint_type = 'FOREIGN KEY' group by table_name),
 
 S5 as (SELECT table_catalog as base, table_schema as schema, table_name as nom,
		table_type as type, is_insertable_into as peut_t_on_y_inserer_des_donnes 
 FROM INFORMATION_SCHEMA.TABLES 
 where table_schema not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1')),
 
 S6 as (select table_name as nom, count(column_name) as nb_colonnes from information_schema.columns 
 where table_schema not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1')
 group by table_name)
 
select S1.nb_contrainte_de_valeur, S2.nb_contrainte_unicite, S3.nb_contrainte_cle_primaire, S4.nb_contrainte_cle_etrangere, S6.nb_colonnes, S5.base, S5.schema, S5.nom, S5.type, S5.peut_t_on_y_inserer_des_donnes 
 from S1 full join S2 on S1.nom=S2.nom 
full JOIN S3 on S2.nom=S3.nom 
full JOIN S4 on S3.nom=S4.nom 
full JOIN S5 on S4.nom=S5.nom 
full JOIN S6 on S5.nom=S6.nom 
order by S5.base, S5.schema, S5.nom;
