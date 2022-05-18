
  ------------------------------------------------------------------
  -- How to work with sequences
  ------------------------------------------------------------------
      
  DROP TABLE members;
  DROP SEQUENCE member_id_seq;
   
CREATE TABLE members   
(
  member_id     NUMBER         DEFAULT member_id_seq.NEXTVAL PRIMARY KEY, 
  first_name    VARCHAR2(50)   NOT NULL, 
  last_name     VARCHAR2(50)   NOT NULL, 
  address       VARCHAR2(50)   NOT NULL, 
  city          VARCHAR2(25)   NOT NULL, 
  states         CHAR(2)        DEFAULT 'TX', 
  phone         VARCHAR2(20)
);
   
  
  --CREATE SEQUENCE vendor_id_seq;
  CREATE SEQUENCE member_id_seq
    START WITH 10
    INCREMENT BY 1; 
    
  --DROP SEQUENCE vendor_id_seq;
  
  
INSERT INTO members (first_name, last_name, address, city, state, phone)
VALUES ('Bart', 'Simpson', '432 Kwyjibo Dr', 'Springfield', 'IL', '578-233-9876');

INSERT INTO members (first_name, last_name, address, city, state, phone)
VALUES ('Greg', 'Fenves', '1897 Horns Blvd', 'Austin', 'TX', '');

INSERT INTO members (first_name, last_name, address, city, state, phone)
VALUES ('Melissa', 'Jefferson', '987 Looney Ln', 'Toon Town', 'NY', '');


  SELECT * from members;
  

-----------------------------------------------------------
-- How to work with indexes
------------------------------------------------------------

DROP TABLE invoices;
DROP TABLE vendors;

CREATE TABLE vendors
(
  vendor_id                     NUMBER          NOT NULL,
  vendor_name                   VARCHAR2(50)    NOT NULL,
  vendor_address1               VARCHAR2(50),
  vendor_address2               VARCHAR2(50),
  vendor_city                   VARCHAR2(50)    NOT NULL,
  vendor_state                  CHAR(2)         NOT NULL,
  vendor_zip_code               VARCHAR2(20)    NOT NULL,
  vendor_phone                  VARCHAR2(50),
  vendor_contact_last_name      VARCHAR2(50),
  vendor_contact_first_name     VARCHAR2(50),
  CONSTRAINT vendors_pk 
    PRIMARY KEY (vendor_id),
  CONSTRAINT vendors_vendor_name_uq 
    UNIQUE (vendor_name)
);

CREATE INDEX vendors_vendor_name_upper_ix 
  ON vendors (UPPER(vendor_name));

CREATE UNIQUE INDEX vendors_vendor_phone_ix 
  ON vendors (vendor_phone); 

CREATE INDEX vendors_vendor_state_ix 
  ON vendors (vendor_state);

DROP INDEX vendors_vendor_state_ix;

CREATE TABLE invoices
(
  invoice_id            NUMBER          NOT NULL, 
  vendor_id             NUMBER          NOT NULL,
  invoice_number        VARCHAR2(50)    NOT NULL,
  invoice_date          DATE            NOT NULL,
  invoice_total         NUMBER(9,2)     NOT NULL,
  payment_total         NUMBER(9,2)                 DEFAULT 0,
  credit_total          NUMBER(9,2)                 DEFAULT 0,
  terms_id              NUMBER          NOT NULL,
  invoice_due_date      DATE            NOT NULL,
  payment_date          DATE,
  CONSTRAINT invoices_pk 
    PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk_vendors
    FOREIGN KEY (vendor_id) 
    REFERENCES vendors (vendor_id)
);

CREATE INDEX invoices_vendor_id_ix
  ON invoices (vendor_id);
CREATE INDEX invoices_vendor_id_inv_no_ix
  ON invoices (vendor_id, invoice_number);
CREATE INDEX invoices_invoice_total_ix
  ON invoices (invoice_total DESC);
CREATE INDEX invoices_balance_due_ix
  ON invoices (invoice_total - payment_total - credit_total DESC);
  
  
  
  
  
  
  
  