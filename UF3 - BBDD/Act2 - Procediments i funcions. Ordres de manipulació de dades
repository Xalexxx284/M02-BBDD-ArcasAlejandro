/* -------------------------------------------------- ACTIVITAT 2 ---------------------------------------------------- */

/* --- EXEMPLES ---------------------------------------------------------------------------------------------------- */

--Exemple 1 ------
-- Funció que introduirem un department_id i retornarà el nom del departament.
CREATE FUNCTION return_nom_dept(departments.department_id%type) RETURNS varchar AS
$$
DECLARE
	nom_dept departments.department_name%type;
BEGIN
	SELECT department_name
	INTO nom_dept
	FROM departments
	WHERE department_id = $1;
RETURN nom_dept;
END;
$$ LANGUAGE plpgsql;

--Exemple 2 ------
-- Funció que introduirem un department_id i retornarà el nom del departament. En aquest cas farem servir paràmetres de sortida. Per aquest motiu la clàusula RETURN no necessita tenir una expressió associada
CREATE FUNCTION return_nom_dept_2(departments.department_id%type, OUT VARCHAR) AS
$$

BEGIN
	SELECT department_name
	INTO $2
	FROM departments
	WHERE department_id = $1;
RETURN;
END;
$$ LANGUAGE plpgsql;

select return_nom_dept_2(20);

--Exemple 3 ------
--Funció que li donem un id d'empleat i retornarà tota la informació d'aquest empleat;

CREATE FUNCTION return_empleat(employees.employee_id%type) RETURNS employees AS
$$
DECLARE
	EMP employees;
BEGIN
	SELECT *
	INTO emp
	FROM employees
	WHERE employee_id = $1;
RETURN  emp;
END;
$$ LANGUAGE plpgsql;

select return_empleat(120);

--Exemple 4 ------
--Funció que li donem un id d'empleat  i retornarà només la informació que desitgem d'aquest empleat.;

CREATE or replace FUNCTION return_empleat2(employees.employee_id%type) RETURNS varchar AS
$$
DECLARE
	EMP record;
BEGIN
	SELECT *
	INTO emp
	FROM employees
	WHERE employee_id = $1;
RETURN  emp.first_name;
END;
$$ LANGUAGE plpgsql;

select return_empleat2(120);

--Exemple 5 ------
--Mateix exemple que el 4, però fem servir un tipus de dada composta que conté només el nom i el salari.;

CREATE or replace FUNCTION return_empleat3(employees.employee_id%type) RETURNS mini_empleat AS
$$
DECLARE
	EMP mini_empleat;
BEGIN
	SELECT first_name, salary
	INTO emp
	FROM employees
	WHERE employee_id = $1;
RETURN  emp;
END;
$$ LANGUAGE plpgsql;

select return_empleat3(120);

--Exemple 6 ------
--Funció que retorna tots els empleats d'un departament;


CREATE or replace FUNCTION return_emp_dept(employees.department_id%type) RETURNS SETOF employees AS
$$
DECLARE
	EMP employees;
BEGIN
	for emp in SELECT * FROM employees WHERE department_id= $1 loop
		RETURN  NEXT emp;
		raise notice 'info %', emp;
	END LOOP;
	--RETURN; -- OPCIONAL
END;
$$ LANGUAGE plpgsql;

select  return_emp_dept(30);

--Exemple 7 ------
--Mateix que l'exercici anterior, però amb RETURN QUERY;

CREATE or replace FUNCTION return_emp_dept2(employees.department_id%type) RETURNS SETOF employees AS
$$
DECLARE
	EMP employees;
BEGIN
	RETURN QUERY SELECT * FROM employees WHERE department_id= $1;
		raise notice 'info %', emp;
	--RETURN; -- OPCIONAL
END;
$$ LANGUAGE plpgsql;

select  return_emp_dept2(30);
