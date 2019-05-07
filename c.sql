 with a1 as (select table_name as nom, ordinal_position as position, column_name as nom_colonne, data_type as type_colonne, 
 is_nullable as peut_etre_null, is_updatable as peut_etre_modifie, character_maximum_length as chaine_longueur_max
 from information_schema.columns where table_schema
 not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1')),
 
 a2 as (SELECT table_catalog as base, table_schema as schema, table_name as nom
 FROM INFORMATION_SCHEMA.TABLES 
 where table_schema not in ('pg_catalog', 'information_schema', 'pg_toast', 'pg_toast_temp1', 'pg_temp1'))
 
 
 select a1.position, a1.nom_colonne, a1.type_colonne, a1.peut_etre_null,
 a1.peut_etre_modifie, a1.chaine_longueur_max, a2.base, a2.schema, a2.nom from a1 full join a2 on a1.nom=a2.nom 
 order by a2.base, a2.schema, a2.nom, a1.position;
