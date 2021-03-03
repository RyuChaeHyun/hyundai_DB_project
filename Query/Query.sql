--1. 각 차량별 매출
SELECT car.car_modelname as 자동차_모델명, count(contract.car_modelname)*contract.price as 총매출
FROM car, contract
WHERE car.car_modelname = contract.car_modelname
GROUP BY car.car_modelname, contract.price
ORDER BY COUNT(contract.car_modelname)*contract.price DESC;

-- 2. 판매 실적
SELECT salesemployee_id AS 판매자ID, concat(lname,fname) AS 판매자명, Count(salesemployee_id) AS 판매량, SUM(price) AS 총_판매가격
FROM contract,employee
WHERE salesemployee_id = employee_id
GROUP BY salesemployee_id, lname,fname
ORDER BY 총_판매가격 DESC;

--3. 월(month)별 판매 수량
SELECT TO_CHAR(contract_date,'yyyy-mm') AS month, COUNT(*) AS 판매수량
FROM contract 
GROUP BY TO_CHAR(contract_date,'yyyy-mm')
ORDER BY TO_CHAR(contract_date,'yyyy-mm');

-- 4.자동차 제작에 참여중인 인원 수
SELECT CAR_MODELNAME AS 자동차_모델명, COUNT(engineer_id) AS 작업중인_엔지니어_수
FROM production
GROUP BY car_modelname
ORDER BY car_modelname;

--5. 특정 enginner가 작업중인 차량을 함께 작업하고 있는 사람들
SELECT distinct engineer_id AS 엔지니어ID, car_modelname AS 자동차_모델명
FROM production
WHERE car_modelname IN
(SELECT car_modelname FROM production WHERE Engineer_ID='E020')
MINUS
SELECT engineer_id AS 엔지니어ID, car_modelname AS 자동차_모델명
FROM production
WHERE Engineer_ID='E020';

-- 6. 해당 부품이 사용되는 자동차의 모델명
SELECT car_modelname AS 자동차_모델명, up_modelname AS 부품이름
FROM production
ORDER BY car_modelname, up_modelname;

--7. 해당 부품을 구매하기 위해 이용가능한 거래처명과 거래처번호 
SELECT part.part_modelname AS 부품명,wholesale.name AS 거래처명,wholesale.Phone# AS 거래처번호 
FROM part, wholesalepart,wholesale 
WHERE part.part_modelname=wholesalepart.wp_modelname
AND wholesalepart.wholesale_license#=wholesale.license#;

-- 8.차량에 활용되는 부품의 목록
SELECT car_modelname AS 자동차_모델명, wp_modelname AS 부품_이름, price AS 가격
FROM production, wholesalepart
WHERE production.up_modelname = wholesalepart.wp_modelname
AND production.car_modelname = &SEARCHMODEL
ORDER BY price;
--주의사항: 차량 이름 입력 시 작은따옴표 함께 입력(예: 'NAME')

--9. 고객의 조건(성별 등)에 따른 선호 차량
SELECT customer.sex AS 성별, contract.car_modelname AS 자동차_모델명
FROM customer, contract
WHERE customer.customer_ssn=contract.customer_ssn
GROUP BY customer.sex, contract.car_modelname
ORDER BY customer.sex;

--10. 보험가입여부에 따른 차량 구입 횟수
SELECT customer.ins_joinstatus AS 보험가입여부, COUNT(contract.contract#) AS 차량구입횟수
FROM customer, contract
WHERE customer.customer_ssn=contract.customer_ssn
GROUP BY customer.ins_joinstatus
ORDER BY customer.ins_joinstatus;

-- 11.차량 가격별 판매량 차이
SELECT car.car_modelname AS 모델명, car.price AS 차량가격_옵션X, COUNT(contract#)AS 판매량
FROM car, contract 
WHERE car.car_modelname = contract.car_modelname
GROUP BY car.car_modelname, car.price
ORDER BY 판매량 DESC, car.price;

--12. 거래처별로, 많이 거래한 순서대로 나열
SELECT wholesale.name AS 거래처명, COUNT(wholesale_license#) AS 총거래수
FROM wholesale,wholesalepart
WHERE wholesale.license#=wholesalepart.wholesale_license# 
GROUP BY wholesale.name ORDER BY COUNT(wholesale_license#) DESC;

-- 13.거래처와 거래 가능한 물품들의 재고량
SELECT wp_modelname AS 부품_이름, SUM(quantity) AS 재고량
FROM usingpart, wholesalepart
WHERE wholesalepart.wp_modelname = usingpart.up_modelname
GROUP BY wp_modelname
ORDER BY wp_modelname;

-- 14. 연비에 따른 자동차 고르기
SELECT car_modelname, fuelefficiency 
FROM car
WHERE fuelefficiency BETWEEN 10 AND 
(SELECT MAX(fuelefficiency) FROM car)
ORDER BY fuelefficiency;

--15. 일정 대수 이상 혹은 일정 금액 이상의 차량을 구매한 고객의 SSN 명단
SELECT customer_SSN AS 고객_주민번호 FROM contract
GROUP BY customer_ssn
HAVING COUNT(customer_ssn) >= &NUM
union
SELECT customer_SSN AS 고객_주민번호 FROM contract
GROUP BY customer_ssn
HAVING SUM(price) >= &TOTALP;

--16. 올해 나온 신차 중 판매가 완료된 자동차 조회
SELECT car_modelname FROM car WHERE Modelyear=2020
INTERSECT
SELECT car_modelname FROM contract;


