-- Создание функции логирования изменений по трем атрибутам.
CREATE OR REPLACE function audit_user_changes() RETURNS TRIGGER as $$
 DECLARE
 BEGIN 
     IF NEW.name IS DISTINCT FROM OLD.name THEN
	 INSERT INTO user_audit(user_id, field_changed, old_value, new_value, changed_by)
	 VALUES (OLD.id, 'name', OLD.name, NEW.name, current_user);
 END IF;
 BEGIN 
     IF NEW.email IS DISTINCT FROM OLD.email THEN
	 INSERT INTO user_audit(user_id, field_changed, old_value, new_value, changed_by)
	 VALUES (OLD.id, 'email', OLD.email, NEW.email, current_user);
 END IF;
 BEGIN 
     IF NEW.role IS DISTINCT FROM OLD.role THEN
	 INSERT INTO user_audit(user_id, field_changed, old_value, new_value, changed_by)
	 VALUES (OLD.id, 'role', OLD.role, NEW.role, current_user);
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;
