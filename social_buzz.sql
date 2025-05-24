#Cleaning

select count(*)
from content
where URL = '';

delete from content
where URL = '';

select *
from reactions
where 'User ID' = ''
or Type = '';

delete
from reactions
where 'User ID' = ''
or Type = '';

delete from content
where `USER ID` = '' or Type = '';

ALTER TABLE content
DROP COLUMN URL;

SELECT *
FROM content;

ALTER TABLE content change `User ID` UserID text;
ALTER TABLE content change `Content ID` ContentID text;
ALTER TABLE content change `Type` ContentType text;

ALTER TABLE content
DROP COLUMN UserID;


ALTER TABLE reactions DROP COLUMN UserID;

#Analysis

select *
from content as c
left join reactions as r on c.ContentID=r.ContentID
right join reactiontypes as rt using (Type);

select Category, sum(Score)
from content as c
join reactions as r on c.ContentID=r.ContentID
right join reactiontypes as rt using (Type)
group by Category
order by sum(Score) desc limit 5;

create table Top_Category
select Category, sum(Score)
from content as c
join reactions as r on c.ContentID=r.ContentID
right join reactiontypes as rt using (Type)
group by Category
order by sum(Score) desc  limit 5;

select Datetime from reactions;
ALTER TABLE reactions 
ADD DatePart DATE,
ADD TimePart TIME;

UPDATE reactions 
SET 
    DatePart = DATE(Datetime),
    TimePart = TIME(Datetime);
select * from reactions;

create table Top_Months AS select
MONTH(DatePart) AS Month,
    COUNT(*) AS ActivityCount
FROM 
    reactions
GROUP BY 
    MONTH(DatePart)
ORDER BY 
    ActivityCount DESC;

select * from top_months;

create table Top_Hours AS SELECT 
    HOUR(TimePart) AS Hour,
    COUNT(*) AS ActivityCount
FROM 
    reactions
GROUP BY 
    HOUR(TimePart)
ORDER BY 
    ActivityCount DESC;

select * from top_hours;

create table Top_Reactions AS SELECT 
    Type,
    COUNT(*) AS ActivityCount
FROM 
    reactions
GROUP BY 
    Type
ORDER BY 
    ActivityCount DESC;
select * from top_reactions;

create table Top_Contents AS SELECT 
    ContentType,
    COUNT(*) AS ActivityCount
FROM 
    content
GROUP BY 
    ContentType
ORDER BY 
    ActivityCount DESC;

select * from top_contents;