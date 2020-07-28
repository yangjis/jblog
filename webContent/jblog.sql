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

create sequence seq_users_no increment by 1 start with 1 nocache;
create sequence seq_category_no increment by 1 start with 1 nocache;
create sequence seq_post_no increment by 1 start with 1 nocache;
create sequence seq_comments_no increment by 1 start with 1 nocache;

