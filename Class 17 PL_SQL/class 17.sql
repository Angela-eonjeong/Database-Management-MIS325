--#1 
--(a) 
SELECT SUM(invoice_total - payment_total - credit_total) balance_due
FROM invoices 
WHERE vendor_id = 95;

--(b) 
DECLARE
  sum_balance_due_var NUMBER(9, 2);
BEGIN
  SELECT SUM(invoice_total - payment_total - credit_total) balance_due
  INTO sum_balance_due_var
  FROM invoices 
  WHERE vendor_id = 95;
  IF sum_balance_due_var > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Balance due: $' || 
                          ROUND(sum_balance_due_var, 2));
  ELSE
    DBMS_OUTPUT.PUT_LINE('Balance paid in full');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/

--(c) 
SET SERVEROUTPUT ON;
DECLARE
  sum_balance_due_var NUMBER(9, 2);
BEGIN
  SELECT SUM(invoice_total - payment_total - credit_total) balance_due
  INTO sum_balance_due_var
  FROM invoices 
  WHERE vendor_id = 34;
  IF sum_balance_due_var > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Balance due: $' || 
                          ROUND(sum_balance_due_var, 2));
  ELSE
    DBMS_OUTPUT.PUT_LINE('Balance paid in full');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/

--#2 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, my name is Angela');
 END;
/   


--#3
--(a) 
DECLARE
  max_invoice_total  invoices.invoice_total%TYPE;
  min_invoice_total  invoices.invoice_total%TYPE;
  percent_difference NUMBER;
  count_invoice_id   NUMBER;
  vendor_id_var      NUMBER := 95;
BEGIN  
  SELECT MAX(invoice_total), MIN(invoice_total), COUNT(invoice_id)
  INTO max_invoice_total, min_invoice_total, count_invoice_id
  FROM invoices WHERE vendor_id = vendor_id_var;
  percent_difference := 
      (max_invoice_total - min_invoice_total) / min_invoice_total * 100;

  DBMS_OUTPUT.PUT_LINE('Maximum invoice: $' || max_invoice_total);
  DBMS_OUTPUT.PUT_LINE('Minimum invoice: $' || min_invoice_total);
  DBMS_OUTPUT.PUT_LINE('Percent difference: %' || ROUND(percent_difference, 2));
  DBMS_OUTPUT.PUT_LINE('Number of invoices: ' || count_invoice_id);
END;
/


--(b) 
DECLARE MyAge Number := 23 ; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, my name is Angela');
    DBMS_OUTPUT.PUT_LINE('I am' || ' ' || MyAge ||  ' ' || 'years old');
 END;
/  


--#4 
--(a) 
SET DEFINE ON;
DECLARE MyAge Number := &user_defined_age;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, my name is Angela');
    DBMS_OUTPUT.PUT_LINE('I am' || ' ' || MyAge ||  ' ' || 'years old');
 END;
/  


--#5 
DECLARE 
    Vendor_Y_Phone_Num number;
    Vendor_N_Phone_Num number;
    percent_need_update number;

Begin
    select count(distinct vendor_id) as not_missing
    into Vendor_Y_Phone_Num
    from vendors where vendor_phone is not null;

    select count(distinct vendor_id) as missing 
    into Vendor_N_Phone_Num
    from vendors where vendor_phone is null;
 
percent_need_update := 
      Vendor_N_Phone_Num / (Vendor_Y_Phone_Num + Vendor_N_Phone_Num) * 100;
   
    DBMS_OUTPUT.PUT_LINE( Vendor_Y_Phone_Num || ' vendors have a phone on file');
    DBMS_OUTPUT.PUT_LINE( Vendor_N_Phone_Num || ' vendors do not have a phone on file');
    DBMS_OUTPUT.PUT_LINE('percent_need_update: %' || ROUND(percent_need_update, 2));
 
 END;
/  


-- #6 IF 
DECLARE 
    Vendor_Y_Phone_Num number;
    Vendor_N_Phone_Num number;
    percent_need_update number;

Begin
    select count(distinct vendor_id) as not_missing
    into Vendor_Y_Phone_Num
    from vendors where vendor_phone is not null;

    select count(distinct vendor_id) as missing 
    into Vendor_N_Phone_Num
    from vendors where vendor_phone is null;
 
percent_need_update := 
      Vendor_N_Phone_Num / (Vendor_Y_Phone_Num + Vendor_N_Phone_Num) * 100;
   
    IF percent_need_update > 10 Then  
        DBMS_OUTPUT.PUT_LINE ('ALERT: Time to update vendor phone');
    ELSE 
        DBMS_OUTPUT.PUT_LINE( 'Vendor phone: no need to update');
    End If; 


 END;
/

--#7 For 
--(a)

Begin
    For i IN 1..6 Loop 
    DBMS_OUTPUT.PUT_LINE( 'i: ' || i );
    End Loop; 
End;
/ 

--(b) 

Begin
    For i IN 1..6 Loop 
        IF mod(i,2)=0 Then 
            DBMS_OUTPUT.PUT_LINE( 'i: ' || i );
        Else
            null;
        End if;
    End Loop; 
End;
/ 


--#8 Dynamic 
--(a) 

DECLARE
  dynamic_sql VARCHAR2(400);
  term_id_var number;
  invoice_id_var number;
  
BEGIN
    term_id_var := &term_id;
    invoice_id_var := &invoice_id;
    dynamic_sql := 'UPDATE invoices ' ||
                 'SET terms_id = ' || term_id_var || ' ' ||
                 'WHERE invoice_id = ' || invoice_id_var;

  DBMS_OUTPUT.PUT_LINE(dynamic_sql);
    Execute immediate dynamic_sql;
END;
/

--#9 Bulk Collect 
--(a) 

DECLARE 
    TYPE names_table IS TABLE OF VARCHAR2(40); 
    vendor_names	names_table;      --bulk collect will dynamic set the length of your list/array as it is collected
BEGIN 
    SELECT vendor_name 
    BULK COLLECT INTO vendor_names 
    FROM vendors
    WHERE rownum <= 10 ORDER BY vendor_id
    ;     

    FOR i IN 1..vendor_names.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Vendor name ' || i || ': ' ||
                          vendor_names(i));
    END LOOP;
END;
/
--(b) 

DECLARE 
    TYPE names_table IS TABLE OF VARCHAR2(40); 
    vendor_names	names_table;      --bulk collect will dynamic set the length of your list/array as it is collected
    Type payments_table is table of number;
    payments_amounts  payments_table;
BEGIN 
    SELECT vendor_name 
    BULK COLLECT INTO vendor_names 
    FROM vendors
    WHERE rownum <= 10 ORDER BY vendor_id;     

    SELECT payment_total
    BULK COLLECT INTO payments_amounts 
    FROM invoices
    WHERE rownum <= 20 ORDER BY vendor_id;     

    FOR i IN 1..payments_amounts.COUNT LOOP
        If payments_amounts(i) > 0 Then
            DBMS_OUTPUT.PUT_LINE('Payment amount ' || i || ': ' ||
                          payments_amounts(i));
        End if;
    END LOOP;
END;
/
--#10 Cursor 
-- (a) 
DECLARE 
    CURSOR invoices_cursor IS
        SELECT invoice_id, invoice_total 
        FROM invoices 
        WHERE invoice_total - payment_total - credit_total > 0;
    
    invoice_row invoices%ROWTYPE; 

BEGIN
    FOR invoice_row IN invoices_cursor LOOP

        IF (invoice_row.invoice_total > 5000) THEN 
            UPDATE invoices 
            SET credit_total = credit_total - (invoice_total * .05) 
            WHERE invoice_id = invoice_row.invoice_id;
            
            DBMS_OUTPUT.PUT_LINE('Credit_total increased by 10% ($' || 
                ROUND((invoice_row.invoice_total *.05),2) || 
                ') for invoice ' || invoice_row.invoice_id);
        ELSIF (invoice_row.invoice_total > 1000) THEN 
            UPDATE invoices 
            SET credit_total = credit_total - (invoice_total * .1) 
            WHERE invoice_id = invoice_row.invoice_id;
            
            DBMS_OUTPUT.PUT_LINE('Credit_total increased by  5% ($' || ROUND((invoice_row.invoice_total *.1),2) || ') for invoice ' || invoice_row.invoice_id);
            
        END IF;
    END LOOP; 

END;
/

--(b)
DECLARE 
    CURSOR vendor_cursor IS
        SELECT vendor_id, vendor_name, vendor_state, vendor_phone
        FROM vendors
        WHERE vendor_phone is null; 
        
    vendor_row vendors%ROWTYPE; 

BEGIN
    FOR vendor_row IN vendor_cursor LOOP

        IF (vendor_row.vendor_state in ('CA','OH') ) THEN 
            UPDATE vendors
            SET vendor_phone = 'Update immediately' 
            WHERE vendor_id = vendor_row.vendor_id;
            
        END IF;
    END LOOP; 

END;
/

--#11

BEGIN  
    insert into terms VALUES (1,'Net due 10', 10);
    DBMS_OUTPUT.PUT_LINE('1 row inserted.');
EXCEPTION
    when dup_val_on_index then
    DBMS_output.put_line( 'duplicate value');
    
END;
/

