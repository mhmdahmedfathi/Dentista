USE DENTISTA;

insert into store(STORE_NAME, EMAIL, PASSWORD, PHONE_NUMBER, CREDIT_CARD_NUMBER) VALUES ("Carfour", "Carfour@gmail.com", "Carfour1234@", "01128396620", "4117319982553144");

SELECT * FROM Store;


INSERT INTO PRODUCT(PRODUCT_NAME, CATEGORY, BRAND, DESCRIPTION, PRICE, SELLING_PRICE, IMAGE_URL, Number_of_Units, STORE_ID)
VALUES ("Ablimoul", "Medicine", "Dentista", "For Headache", 10, 15, "https://www.medicinep.com/wp-content/uploads/2016/04/Abimol.jpg", 10,1);

SELECT * FROM PRODUCT;
SELECT * FROM DENTIST;
SELECT * FROM DENTISTCART;
SELECT SUM(P.SELLING_PRICE * DC.Number_Units) FROM PRODUCT AS P, DENTISTCART AS DC WHERE DC.PRODUCT_ID = P.PRODUCT_ID AND DC.DENTIST_ID = 1;
SELECT * FROM DENTIST_COMMENT;

SELECT SUM(P.SELLING_PRICE * (SELECT Number_Units FROM DENTISTCART where dentist_id = 1) ) from PRODUCT as P WHERE P.PRODUCT_ID = 2;
SELECT SUM(P.SELLING_PRICE * DC.Number_Units) as TOTAL_PRICE FROM PRODUCT as P, DENTISTCART as DC WHERE DC.DENTIST_ID = 1 and P.Product_Id = 2;


SELECT * FROM VIRTUAL_BANK;
INSERT INTO VIRTUAL_BANK VALUES('4117826654332133', 'Yousef', 'Gamal', 'yousef.gamal.it@gmail.com', 'y2o9u5s2e0f00', '4851158411556', '068', 7, 2021, 20000);

UPDATE DENTIST SET DENTIST_CREDIT_CARD_NUMBER = '4117826654332133' WHERE DENTIST_EMAIL = 'yousef.gamal.it@gmail.com' ;

INSERT INTO DENTISTCART VALUES (1, 2, 10);
DELETE FROM ORDERS WHERE ORDER_ID = 1;
INSERT INTO ORDERS(ORDER_ID, DENTIST_ID, TOTAL_COST, SHIPMENT_STATUS) VALUES (1, 1, 500, 'SHIPPING');
SELECT VB.CREDIT FROM VIRTUAL_BANK AS VB, DENTIST AS D WHERE VB.CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = 1);

UPDATE VIRTUAL_BANK SET CREDIT = 250000 WHERE CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = 1);

select * from orders;
SELECT * FROM ORDERs WHERE SHIPMENT_STATUS LIKE "%CHECk%";

Update Product SET Rate = 0, NO_OF_REVIEWERS = 0 WHERE PRODUCT_ID = 1;

SELECT NO_OF_REVIEWERS FROM PRODUCT WHERE PRODUCT_ID = 1;





SELECT @NEW_RATE;

SET @NOREVIEWS = (SELECT NO_OF_REVIEWERS FROM PRODUCT WHERE PRODUCT_ID = 1);
SET @RATING = (SELECT RATE FROM PRODUCT WHERE PRODUCT_ID = 1);
SET @NEW_RATE = (@RATING * @NOREVIEWS + 0) / (@NOREVIEWS + 1); 
UPDATE PRODUCT SET RATE = @NEW_RATE, NO_OF_REVIEWERS = @NOREVIEWS + 1 WHERE PRODUCT_ID = 1;

SELECT * FROM PRODUCT;


CREATE EVENT Eve_tbl_Students_Temp_Insert
ON SCHEDULE EVERY 1 MINUTE
DO
INSERT INTO ORDERS( DENTIST_ID, TOTAL_COST, SHIPMENT_STATUS) VALUES ( 1, 1000, 'SHIPPING');

SELECT * FROM LOGIN_DATA;

DROP EVENT Eve_tbl_Students_Temp_Insert;


INSERT INTO ORDERS(DENTIST_ID, TOTAL_COST, SHIPMENT_STATUS) VALUES(1, (SELECT SELLING_PRICE FROM PRODUCT WHERE PRODUCT_ID = 1) * 2 , 'Checking');

ALTER TABLE PRODUCT ADD FULLTEXT(PRODUCT_NAME, DESCRIPTION);

ALTER TABLE SCEDULE_PRODUCT ADD NoUnits INT  DEFAULT 0;

ALTER TABLE SCEDULE_PRODUCT MODIFY COLUMN DURATION INT;

SELECT * FROM PRODUCT WHERE MATCH (PRODUCT_NAME) AGAINST ('chair' IN NATURAL LANGUAGE MODE);

SET @Prev_Credit = (50 + (SELECT CREDIT FROM VIRTUAL_BANK WHERE CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = 1) ) );

UPDATE VIRTUAL_BANK SET CREDIT = @Prev_Credit  WHERE CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = 1);



SELECT * FROM PRODUCT WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM SCEDULE_PRODUCT WHERE DENTIST_ID = 1);