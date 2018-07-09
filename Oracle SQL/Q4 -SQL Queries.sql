-- 4a

SELECT e.pName.title || '. ' ||  e.pName.firstName || ' ' || e.pName.surName || ' lives in ' || e.pAddress.city
AS "First name contains 'on'"
FROM tEmployee e
WHERE INSTR(e.pName.firstName,'on') > 0
AND
e.pAddress.city = 'Glasgow';

-- 4b

SELECT COUNT (TSAVINGACC.ACCID) AS "Saving accounts @ each branch",
e.pAddress.street || ' ' || e.pAddress.city || ' ' || e.pAddress.postcode AS "Address of Branch"
FROM TBRANCH e
INNER JOIN TSAVINGACC
ON e.BID = TSAVINGACC.BID
GROUP BY e.pAddress.street || ' ' || e.pAddress.city || ' ' || e.pAddress.postcode;

-- 4c

SELECT c.pName.firstName AS "First Name", c.pName.surname AS "Surname", s.BALANCE AS "Highest Balance", s.BID AS "Branch ID", a.LIMITOFFREEOD AS "Free overdraft limit"
FROM TSAVINGACC s
INNER JOIN TCUSTOMER c
ON s.CID = c.CID
INNER JOIN TCURRENTACC a
ON a.CID = s.CID
WHERE NOT EXISTS
(SELECT sa.BALANCE, sa.BID FROM TSAVINGACC sa WHERE s.BID = sa.BID AND s.BALANCE < sa.BALANCE);

-- 4d

SELECT c.pName.firstName AS "First Name",
  c.pName.SurName AS "Surname", c.pAddress.street || ' ' || c.pAddress.city || ' ' || c.pAddress.postcode AS " Work Address", 
  e.pAddress.street || ' ' || e.pAddress.city || ' ' || e.pAddress.postcode AS " Branch Address - Account open"
FROM TEMPLOYEE c
INNER JOIN TBRANCH e
ON c.BID = e.BID;

-- 4e

SELECT c.pName.firstName AS "First Name",
  c.pName.SurName        AS "Surname",
  s.LIMITOFFREEOD        AS "Free overdraft limit",
  s.BID                  AS "Branch ID",
  b.BALANCE     AS "Savings Account Balance"
FROM TSAVINGACC b
INNER JOIN TCURRENTACC s
ON b.ACCID = s.ACCID
INNER JOIN TCUSTOMER c
ON c.CID = s.CID
WHERE NOT EXISTS
(SELECT sa.LIMITOFFREEOD, sa.BID FROM TCURRENTACC sa WHERE s.BID = sa.BID AND s.LIMITOFFREEOD < sa.LIMITOFFREEOD);


-- 4f

SELECT
  c.pName.firstName || ' ' || c.pName.surName as "Name",
  c.mobile1 as "Mobile No.1",
  c.mobile2 as "Mobile No.2"
FROM
  TCUSTOMER c
WHERE
  mobile1 != '00000000000'
  AND
  mobile2 != '00000000000'
  AND
    (
      mobile1 LIKE '0770%'
      OR
      mobile2 LIKE '0770%'
    ); 
