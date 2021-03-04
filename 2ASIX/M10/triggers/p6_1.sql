CREATE OR REPLACE FUNCTION evaluar()
RETURNS trigger AS
$$
DECLARE
    sql1 text := '';
    reg record;
    id_provatecnica int;
    id_pacient int;
BEGIN
    sql1 := 'select * from provestecnica where idprovatenica =' || NEW.idprovatenica;
    for reg in EXECUTE(sql1)
    LOOP
        id_provatecnica := reg.idprovatenica;
    END LOOP;

    sql1 := 'select * from analitiques where idanalitica =' || NEW.idanalitica;
    FOR reg in EXECUTE(sql1)
    LOOP
        id_pacient := reg.idpacient;
    END LOOP;

    IF grau_perill(id_provatecnica,id_pacient,NEW.resultats) = '2' or resultats(id_provatecnica,id_pacient,NEW.resultats) = '3'
    THEN
        INSERT INTO resultats_patologics SELECT NEW.idresultat , now() , user;
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER in_alarmes 
BEFORE INSERT OR UPDATE ON resultats FOR EACH 
ROW EXECUTE PROCEDURE posar_a_alarmes();