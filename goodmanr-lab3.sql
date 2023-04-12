-- BAKERY-1
UPDATE goods
SET Price = Price - 2
WHERE Flavor = 'Lemon' and Food = 'Cake' OR Flavor = 'Napoleon' and Food = 'Cake';

-- BAKERY-2
UPDATE goods
SET Price = Price + (0.15 * Price)
WHERE (Flavor = 'Apricot' OR Flavor = 'Chocolate') AND Price < 5.95;

-- BAKERY-3
DROP TABLE IF EXISTS payments;

CREATE TABLE payments(
    Receipt INTEGER NOT NULL,
    Amount DECIMAL(5,2) NOT NULL,
    PaymentSettled DATETIME,
    PaymentType VARCHAR(20) NOT NULL,
    UNIQUE(Receipt,Amount)
);

ALTER TABLE payments
ADD FOREIGN KEY(Receipt) REFERENCES receipts(RNumber);

-- BAKERY-4
create trigger weekends before insert on items

for each row
begin

 DECLARE goodsFood varchar(100); 
 DECLARE goodsFlavor varchar(100); 
 DECLARE receiptsDate date;
 
 SELECT Food INTO goodsFood FROM goods WHERE GId = new.Item;
 SELECT Flavor INTO goodsFlavor FROM goods WHERE GId = new.Item;
 SELECT SaleDate INTO receiptsDate FROM receipts WHERE RNumber = new.Receipt;

    if  (
            ((dayname(receiptsDate) = 'Saturday') or (dayname(receiptsDate) = 'Sunday')) and
            (goodsFood = 'Meringue' or goodsFlavor = 'Almond')
        ) then
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'No meringues until Monday';
 
    end if;
    end;



-- AIRLINES-1
create trigger differentSourceAndDest before insert on flights

for each row
begin

 DECLARE flights_source varchar(100);
 DECLARE flights_dest varchar(100);
 
 SET flights_source = new.SourceAirport;
 SET flights_dest = new.DestAirport;

 if (new.SourceAirport = new.DestAirport) then
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Source Airport and Destination Airportmust must not be the same';
 
 end if;
 end;


-- AIRLINES-2


ALTER TABLE airlines
    DROP COLUMN Partner;

ALTER TABLE airlines 
ADD COLUMN Partner VARCHAR(100) UNIQUE;

ALTER TABLE airlines 
ADD FOREIGN KEY (Partner) REFERENCES airlines(Abbreviation);

  


-- DROP TRIGGER partnership_2
-- SHOW TRIGGERS;

CREATE TRIGGER partnership BEFORE UPDATE ON airlines
FOR EACH ROW
BEGIN
  IF (NEW.Partner = OLD.Partner and NEW.Partner != null) or (NEW.Partner = OLD.Abbreviation) then
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "Error updating airline partnership";
  END IF;
END

CREATE TRIGGER partnership_2 BEFORE INSERT ON airlines
FOR EACH ROW
BEGIN
  IF  (NEW.Partner = NEW.Abbreviation) then
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "Error updating airline partnership";
  end if;
END

update airlines set Partner = 'JetBlue' where Abbreviation = 'Southwest';
update airlines set Partner = 'Southwest' where Abbreviation = 'JetBlue';

-- SELECT * FROM airlines;





-- KATZENJAMMER-1
ALTER TABLE Instruments
MODIFY Instrument VARCHAR(100);
    
UPDATE Instruments
SET Instrument = 'awesome bass balalaika'
WHERE Instrument = 'bass balalaika';

UPDATE Instruments
SET Instrument = 'acoustic guitar'
WHERE Instrument = 'guitar';

-- KATZENJAMMER-2
DELETE FROM Vocals WHERE !((Bandmate = 1) and (Type <> 'lead'));

