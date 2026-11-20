DROP TABLE IF EXISTS AUDITCOUNT;
DROP TABLE IF EXISTS STORAGE;
DROP TABLE IF EXISTS SUPPLIERPRODUCT;
DROP TABLE IF EXISTS POCONTAINS;
DROP TABLE IF EXISTS PURCHASEORDER;
DROP TABLE IF EXISTS STOCKAUDIT;
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS SUPPLIER;
DROP TABLE IF EXISTS WAREHOUSE;
DROP TABLE IF EXISTS CATEGORY;

CREATE TABLE CATEGORY (
    id int PRIMARY KEY,
    name text NOT NULL,
    description text
);

CREATE TABLE PRODUCT (
    id int PRIMARY KEY,
    sku text NOT NULL,
    name text NOT NULL,
    brand text,
    unit_cost int NOT NULL,
    reorder_threshold int NOT NULL,
    cid int NOT NULL REFERENCES CATEGORY(id)
);

CREATE TABLE SUPPLIER (
    id int PRIMARY KEY,
    name text NOT NULL,
    contact_name text,
    email text NOT NULL,
    phone text
);

CREATE TABLE WAREHOUSE (
    id int PRIMARY KEY,
    name text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL
);

CREATE TABLE PURCHASEORDER (
    id int PRIMARY KEY,
    order_date date NOT NULL,
    expected_date date,
    received_date date,
    status text NOT NULL,
    sid int NOT NULL REFERENCES SUPPLIER(id),
    wid int NOT NULL REFERENCES WAREHOUSE(id)
);

CREATE TABLE STOCKAUDIT (
    id int PRIMARY KEY,
    audit_date date NOT NULL,
    status text NOT NULL,
    wid int NOT NULL REFERENCES WAREHOUSE(id)
);

CREATE TABLE SUPPLIERPRODUCT (
    sid int NOT NULL REFERENCES SUPPLIER(id),
    pid int NOT NULL REFERENCES PRODUCT(id),
    supplier_price int NOT NULL,
    lead_time_days int NOT NULL,
    PRIMARY KEY (sid, pid)
);

CREATE TABLE POCONTAINS (
    po_id int NOT NULL REFERENCES PURCHASEORDER(id),
    pid int NOT NULL REFERENCES PRODUCT(id),
    qty_ordered int NOT NULL,
    qty_received int NOT NULL,
    unit_price int NOT NULL,
    PRIMARY KEY (po_id, pid)
);

CREATE TABLE STORAGE (
    pid int NOT NULL REFERENCES PRODUCT(id),
    wid int NOT NULL REFERENCES WAREHOUSE(id),
    aisle text,
    shelf text,
    qty_on_hand int NOT NULL,
    PRIMARY KEY (pid, wid)
);

CREATE TABLE AUDITCOUNT (
    a_id int NOT NULL REFERENCES STOCKAUDIT(id),
    pid int NOT NULL REFERENCES PRODUCT(id),
    system_qty int NOT NULL,
    counted_qty int NOT NULL,
    PRIMARY KEY (a_id, pid)
);