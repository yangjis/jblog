create table users(
    userNo      number,
    id          varchar2(50) UNIQUE not null,
    userName    varchar2(100) not null,
    password    varchar2(50) not null,
    joinDate    date not null,
    CONSTRAINT PK_userno PRIMARY KEY (userno)
);

create table blog(
    id          varchar2(50),
    blogTitle   varchar2(200)not null,
    logoFile    varchar2(200),
    PRIMARY KEY (id),
    CONSTRAINT c_id_fk foreign key(id)
    REFERENCES users(id)
);
select id, blogTitle, logoFile from blog where id = 'ekseks';
create table category(
    cateNo          number,
    id              varchar2(50),
    cateName        varchar2(200) not null,
    description     varchar2(500),
    regDate         date not null,
    PRIMARY KEY (cateNo),
    CONSTRAINT c_categoryId_fk foreign key(id)
    REFERENCES blog(id)
);
insert into category values(seq_category_no.nextval, 'ekseks','자바라잡잡', '자바칩나라에 놀러온 초코칩공주이야기', sysdate);
select cateNo
from(select max(cateNo) cateNo, id from category 
where id= 'ekseks'
group by id);

select cateNo, id, cateName,description, regDate from category where cateNo = 4 and id='ekseks';

update blog set logoFile = 'default';
select * from blog;
create table post(
    postNo          number,
    cateNo          number ,
    postTitle       varchar2(300) not null,
    postContent     varchar2(4000),
    regDate         date not null,
    PRIMARY KEY (postNo),
    CONSTRAINT c_cateNo_fk foreign key(cateNo)
    REFERENCES category(cateNo)
);

select cateNo, id, cateName,regDate from category where id = 'ekseks';
select max(cateNo) from category where id = 'ekseks';
select cateNo, id, cateName,regDate from category where id = 'ekseks' order by regDate desc;

select p.postNo, p.cateNo, p.postTitle, p.postContent, p.regDate
from post p, category c 
where p.cateNo = c.cateNo 
and c.id = 'ekseks'
and p.cateNo = 1;
select * from blog where id='ekseks';
update blog set blogTitle = '나만의 블로그', logoFile = '' where id = 'ekseks';
select u.userNo userNo, u.id id, u.userName userName, u.joinDate joinDate, b.blogTitle blogTitle from users u, blog b where u.id = b.id and u.id='ekseks' and u.password='1234';
select max(cateNo) from category where id = 'ekseks';
select u.userNo userNo, 
			   u.id id,
			   u.userName userName, 
			   u.joinDate joinDate,
			   b.blogTitle blogTitle 
		from users u, blog b 
		where u.id(+) = b.id
		and u.id='ekseks'
		and u.password='1234';


create table comments(
    cmtNo       number,
    postNo      number,
    userNo      number,
    cmtContent  varchar2(1000) not null,
    regDate     date not null,
    PRIMARY KEY (cmtNo),
    CONSTRAINT c_postNo_fk foreign key(postNo)
    REFERENCES post(postNo),
    CONSTRAINT c_userNo_fk foreign key(userNo)
    REFERENCES users(userNo)
);

select c.cateNo, 
        c.id, 
        c.cateName, 
        c.description, 
        c.regDate,
        p.postNumber
from category c, (select count(postNo) postNumber ,cateNo from post GROUP BY cateNo)p
where c.cateNo = p.cateNo(+)
and id = 'ekseks' 
order by regDate desc;



select * from post;

create sequence seq_users_no increment by 1 start with 1 nocache;
create sequence seq_category_no increment by 1 start with 1 nocache;
create sequence seq_post_no increment by 1 start with 1 nocache;
create sequence seq_comments_no increment by 1 start with 1 nocache;

select userNo,id from users where id = 'ekseks';
select count(*) from users where id='ekseks' and password='1234';
select u.*, c.*, p.*, b.* from users u, category c, post p, blog b where u.id(+) = b.id and b.id = c.id and c.cateNo = p.cateNo and u.id='ekseks';

select u.userNo, u.id, u.userName, u.joinDate,
       b.blogTitle, b.logoFile,
       c.cateNo, c.cateName,
       p.postNo, p.postTitle,p.postContent, p.regDate
from users u, blog b, category c, post p
where u.id = b.id
and b.id = c.id
and c.cateNo = p.cateNo;

select u.userNo userNo, u.id id, u.userName userName, u.joinDate joinDate, 
       b.blogTitle blogTitle, b.logoFile logoFile,
       c.cateNo cateNo, c.cateName cateName,
       p.postNo postNo, p.postTitle postTitle, p.regDate regDate
from users u, blog b, category c, post p
where u.id = b.id
and b.id = c.id
and c.cateNo = p.cateNo(+)
and u.id = 'ekseks'
and u.password = '1234';




select cateNo
			from(select max(cateNo) cateNo, id from category 
			where id= 'ekseks'
			group by id);

delete from category where id = 'ekseks' and cateNo=12;

select * from post;

select postNo, cateNo, postTitle, postContent, regDate from post where cateNo=13 and postNo=(select max(postNo) from post);
select postNo, cateNo, postTitle, postContent, regDate from post where cateNo = '13';
 

select max(cateNo) max from category where id = 'ekseks';

select postNo, cateNo, postTitle, postContent, to_char(regDate, 'YYYY/MM/dd') from post where cateNo = 13 order by regDate desc;

insert into post values(seq_post_no.nextval, 8, '첫번째 글','첫번째 내용', sysdate);



select * from blog;
select * from category;