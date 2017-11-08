USE IST359_M002_nlbrown

-- Lab 7 Postlab --

-- create guest user --
CREATE USER guestuser
    FROM login guestuser
   
-- grant permission --
GRANT SELECT, INSERT ON fudgemart_employees TO guestuser

-- revoke --
REVOKE SELECT, INSERT, UPDATE, DELETE ON fudgemart_employees TO guestuser
GRANT SELECT ON v_fudgemart_employee_managers TO guestuser

-- drop user --
DROP USER guestuser

GRANT SELECT ON v_fudgemart_vendors TO guestuser

GRANT SELECT, INSERT ON colors TO guestuser

GRANT EXECUTE ON p_add_two_colors TO guestuser