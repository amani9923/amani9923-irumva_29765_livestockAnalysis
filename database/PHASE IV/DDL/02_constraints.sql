

Project: Livestock Production  Productivity Analysis System



Foreign Keys & Delete Rules
ALTER TABLE livestock_registry ADD CONSTRAINT fk_reg_breed FOREIGN KEY (breed_id) REFERENCES breed(breed_id) ON DELETE NO ACTION;
ALTER TABLE livestock_registry ADD CONSTRAINT fk_reg_unit FOREIGN KEY (unit_id) REFERENCES farm_units(unit_id) ON DELETE CASCADE;
ALTER TABLE livestock_registry ADD CONSTRAINT fk_reg_sire FOREIGN KEY (sire_id) REFERENCES livestock_registry(tag_id) ON DELETE SET NULL;
ALTER TABLE livestock_registry ADD CONSTRAINT fk_reg_dam FOREIGN KEY (dam_id) REFERENCES livestock_registry(tag_id) ON DELETE SET NULL;

ALTER TABLE production_log ADD CONSTRAINT fk_prod_registry FOREIGN KEY (tag_id) REFERENCES livestock_registry(tag_id) ON DELETE CASCADE;

ALTER TABLE health_interventions ADD CONSTRAINT fk_health_registry FOREIGN KEY (tag_id) REFERENCES livestock_registry(tag_id) ON DELETE CASCADE;
ALTER TABLE health_interventions ADD CONSTRAINT fk_health_vet FOREIGN KEY (vet_id) REFERENCES veterinarian(vet_id) ON DELETE SET NULL;

ALTER TABLE breeding_log ADD CONSTRAINT fk_breed_dam FOREIGN KEY (dam_id) REFERENCES livestock_registry(tag_id) ON DELETE CASCADE;
ALTER TABLE breeding_log ADD CONSTRAINT fk_breed_sire FOREIGN KEY (sire_id) REFERENCES livestock_registry(tag_id) ON DELETE SET NULL;

ALTER TABLE feed_consumption ADD CONSTRAINT fk_feed_unit FOREIGN KEY (unit_id) REFERENCES farm_units(unit_id) ON DELETE CASCADE;
 Check Constraints
ALTER TABLE livestock_registry ADD CONSTRAINT ck_registry_gender CHECK (gender IN ('Male', 'Female')) ENABLE VALIDATE;
ALTER TABLE production_log ADD CONSTRAINT ck_prod_milk CHECK (milk_yield >= 0) ENABLE VALIDATE;
ALTER TABLE production_log ADD CONSTRAINT ck_prod_meat CHECK (meat_yield >= 0) ENABLE VALIDATE;
ALTER TABLE feed_consumption ADD CONSTRAINT ck_feed_amount CHECK (amount_kg > 0) ENABLE VALIDATE;
