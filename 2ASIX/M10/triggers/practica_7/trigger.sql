CREATE OR REPLACE FUNCTION insert_log()
RETURNS TRIGGER AS
$$
DECLARE
    id int;
BEGIN
    IF TG_OP = 'DELETE'
    THEN
        IF TG_TABLE_NAME = 'resultats'
        THEN
            id = OLD.idresultat;
        ELSE
            IF TG_TABLE_NAME = 'analitiques'
            THEN
                id = OLD.idanalitica;
            END IF;
        END IF;
    ELSE
        IF TG_TABLE_NAME = 'resultats'
        THEN
            id = NEW.idresultat;
        ELSE
            IF TG_TABLE_NAME = 'analitiques'
            THEN
                id = NEW.idanalitica;
            END IF;
        END IF;
    END IF;
    
    INSERT INTO logs (user,data_mod,nom_taula,op_feta,id) VALUES (user,NOW(),TG_TABLE_NAME,TG_OP,id);
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER logs
AFTER INSERT OR UPDATE OR DELETE ON resultats FOR EACH 
ROW EXECUTE PROCEDURE insert_log();

CREATE TRIGGER logs
AFTER INSERT OR UPDATE OR DELETE ON analitiques FOR EACH 
ROW EXECUTE PROCEDURE insert_log();