



Project: Livestock Production & Productivity Analysis System



1. PARENT TABLES (Create these first)
CREATE TABLE farm_units (
    unit_id VARCHAR2(20) CONSTRAINT pk_farm_units PRIMARY KEY,
    unit_name VARCHAR2(50) CONSTRAINT nn_unit_name NOT NULL,
    location VARCHAR2(50) CONSTRAINT nn_location NOT NULL
) TABLESPACE livestock_data;

CREATE TABLE breed (
    breed_id NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_breed PRIMARY KEY,
    breed_name VARCHAR2(50) CONSTRAINT uq_breed_name UNIQUE,
    species VARCHAR2(30) DEFAULT 'Cattle'
) TABLESPACE livestock_data;

CREATE TABLE veterinarian (
    vet_id NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_vet PRIMARY KEY,
    vet_name VARCHAR2(50) CONSTRAINT nn_vet_name NOT NULL,
    license_number VARCHAR2(30) CONSTRAINT uq_vet_license UNIQUE
) TABLESPACE livestock_data;

2. CHILD TABLES
CREATE TABLE livestock_registry (
    tag_id VARCHAR2(20) CONSTRAINT pk_registry PRIMARY KEY,
    breed_id NUMBER CONSTRAINT nn_reg_breed NOT NULL,
    unit_id VARCHAR2(20) CONSTRAINT nn_reg_unit NOT NULL,
    birth_date DATE,
    gender VARCHAR2(10),
    sire_id VARCHAR2(20),
    dam_id VARCHAR2(20)
) TABLESPACE livestock_data;

CREATE TABLE production_log (
    log_id NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_prod_log PRIMARY KEY,
    tag_id VARCHAR2(20) CONSTRAINT nn_prod_tag NOT NULL,
    log_date DATE CONSTRAINT nn_prod_date NOT NULL,
    milk_yield NUMBER(6,2),
    meat_yield NUMBER(6,2),
    CONSTRAINT uq_prod_cow_date UNIQUE (tag_id, log_date)
) TABLESPACE livestock_data;

CREATE TABLE health_interventions (
    intervention_id NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_health PRIMARY KEY,
    tag_id VARCHAR2(20) CONSTRAINT nn_health_tag NOT NULL,
    vet_id NUMBER,
    intervention_date DATE CONSTRAINT nn_health_date NOT NULL,
    treatment VARCHAR2(100),
    dosage VARCHAR2(50)
) TABLESPACE livestock_data;

CREATE TABLE breeding_log (
    breeding_id NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_breeding PRIMARY KEY,
    dam_id VARCHAR2(20) CONSTRAINT nn_breed_dam NOT NULL,
    sire_id VARCHAR2(20),
    insemination_date DATE CONSTRAINT nn_insem_date NOT NULL,
    pregnancy_check_date DATE,
    expected_birth_date DATE
) TABLESPACE livestock_data;

CREATE TABLE feed_consumption (
    feed_log_id NUMBER GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_feed PRIMARY KEY,
    unit_id VARCHAR2(20) CONSTRAINT nn_feed_unit NOT NULL,
    feed_date DATE CONSTRAINT nn_feed_date NOT NULL,
    feed_type VARCHAR2(50),
    amount_kg NUMBER(6,2),
    cost NUMBER(8,2)
) TABLESPACE livestock_data;
