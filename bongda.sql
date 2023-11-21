create table CAULACBO
(
MACLB varchar(5) primary key,
TENCLB nvarchar(100) not null,
MASAN varchar(5) not null
)

alter table CAULACBO
add MATINH varchar(5) not null

drop table CAULACBO

grant select on CAULACBO
to public

deny select on caulacbo to public

revoke select on caulacbo to public

