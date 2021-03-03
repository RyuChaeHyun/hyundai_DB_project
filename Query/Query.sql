--1. �� ������ ����
SELECT car.car_modelname as �ڵ���_�𵨸�, count(contract.car_modelname)*contract.price as �Ѹ���
FROM car, contract
WHERE car.car_modelname = contract.car_modelname
GROUP BY car.car_modelname, contract.price
ORDER BY COUNT(contract.car_modelname)*contract.price DESC;

-- 2. �Ǹ� ����
SELECT salesemployee_id AS �Ǹ���ID, concat(lname,fname) AS �Ǹ��ڸ�, Count(salesemployee_id) AS �Ǹŷ�, SUM(price) AS ��_�ǸŰ���
FROM contract,employee
WHERE salesemployee_id = employee_id
GROUP BY salesemployee_id, lname,fname
ORDER BY ��_�ǸŰ��� DESC;

--3. ��(month)�� �Ǹ� ����
SELECT TO_CHAR(contract_date,'yyyy-mm') AS month, COUNT(*) AS �Ǹż���
FROM contract 
GROUP BY TO_CHAR(contract_date,'yyyy-mm')
ORDER BY TO_CHAR(contract_date,'yyyy-mm');

-- 4.�ڵ��� ���ۿ� �������� �ο� ��
SELECT CAR_MODELNAME AS �ڵ���_�𵨸�, COUNT(engineer_id) AS �۾�����_�����Ͼ�_��
FROM production
GROUP BY car_modelname
ORDER BY car_modelname;

--5. Ư�� enginner�� �۾����� ������ �Բ� �۾��ϰ� �ִ� �����
SELECT distinct engineer_id AS �����Ͼ�ID, car_modelname AS �ڵ���_�𵨸�
FROM production
WHERE car_modelname IN
(SELECT car_modelname FROM production WHERE Engineer_ID='E020')
MINUS
SELECT engineer_id AS �����Ͼ�ID, car_modelname AS �ڵ���_�𵨸�
FROM production
WHERE Engineer_ID='E020';

-- 6. �ش� ��ǰ�� ���Ǵ� �ڵ����� �𵨸�
SELECT car_modelname AS �ڵ���_�𵨸�, up_modelname AS ��ǰ�̸�
FROM production
ORDER BY car_modelname, up_modelname;

--7. �ش� ��ǰ�� �����ϱ� ���� �̿밡���� �ŷ�ó��� �ŷ�ó��ȣ 
SELECT part.part_modelname AS ��ǰ��,wholesale.name AS �ŷ�ó��,wholesale.Phone# AS �ŷ�ó��ȣ 
FROM part, wholesalepart,wholesale 
WHERE part.part_modelname=wholesalepart.wp_modelname
AND wholesalepart.wholesale_license#=wholesale.license#;

-- 8.������ Ȱ��Ǵ� ��ǰ�� ���
SELECT car_modelname AS �ڵ���_�𵨸�, wp_modelname AS ��ǰ_�̸�, price AS ����
FROM production, wholesalepart
WHERE production.up_modelname = wholesalepart.wp_modelname
AND production.car_modelname = &SEARCHMODEL
ORDER BY price;
--���ǻ���: ���� �̸� �Է� �� ��������ǥ �Բ� �Է�(��: 'NAME')

--9. ���� ����(���� ��)�� ���� ��ȣ ����
SELECT customer.sex AS ����, contract.car_modelname AS �ڵ���_�𵨸�
FROM customer, contract
WHERE customer.customer_ssn=contract.customer_ssn
GROUP BY customer.sex, contract.car_modelname
ORDER BY customer.sex;

--10. ���谡�Կ��ο� ���� ���� ���� Ƚ��
SELECT customer.ins_joinstatus AS ���谡�Կ���, COUNT(contract.contract#) AS ��������Ƚ��
FROM customer, contract
WHERE customer.customer_ssn=contract.customer_ssn
GROUP BY customer.ins_joinstatus
ORDER BY customer.ins_joinstatus;

-- 11.���� ���ݺ� �Ǹŷ� ����
SELECT car.car_modelname AS �𵨸�, car.price AS ��������_�ɼ�X, COUNT(contract#)AS �Ǹŷ�
FROM car, contract 
WHERE car.car_modelname = contract.car_modelname
GROUP BY car.car_modelname, car.price
ORDER BY �Ǹŷ� DESC, car.price;

--12. �ŷ�ó����, ���� �ŷ��� ������� ����
SELECT wholesale.name AS �ŷ�ó��, COUNT(wholesale_license#) AS �Ѱŷ���
FROM wholesale,wholesalepart
WHERE wholesale.license#=wholesalepart.wholesale_license# 
GROUP BY wholesale.name ORDER BY COUNT(wholesale_license#) DESC;

-- 13.�ŷ�ó�� �ŷ� ������ ��ǰ���� ���
SELECT wp_modelname AS ��ǰ_�̸�, SUM(quantity) AS ���
FROM usingpart, wholesalepart
WHERE wholesalepart.wp_modelname = usingpart.up_modelname
GROUP BY wp_modelname
ORDER BY wp_modelname;

-- 14. ���� ���� �ڵ��� ����
SELECT car_modelname, fuelefficiency 
FROM car
WHERE fuelefficiency BETWEEN 10 AND 
(SELECT MAX(fuelefficiency) FROM car)
ORDER BY fuelefficiency;

--15. ���� ��� �̻� Ȥ�� ���� �ݾ� �̻��� ������ ������ ���� SSN ���
SELECT customer_SSN AS ��_�ֹι�ȣ FROM contract
GROUP BY customer_ssn
HAVING COUNT(customer_ssn) >= &NUM
union
SELECT customer_SSN AS ��_�ֹι�ȣ FROM contract
GROUP BY customer_ssn
HAVING SUM(price) >= &TOTALP;

--16. ���� ���� ���� �� �ǸŰ� �Ϸ�� �ڵ��� ��ȸ
SELECT car_modelname FROM car WHERE Modelyear=2020
INTERSECT
SELECT car_modelname FROM contract;


