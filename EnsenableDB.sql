toc.dat                                                                                             0000600 0004000 0002000 00000102332 14324074653 0014450 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       2                	    z        	   ensenable    14.5    14.5 Y    O           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         P           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         Q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         R           1262    16395 	   ensenable    DATABASE     i   CREATE DATABASE ensenable WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Guatemala.1252';
    DROP DATABASE ensenable;
                postgres    false         ?            1255    16533    add_release_date_function()    FUNCTION     ?   CREATE FUNCTION public.add_release_date_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.release_date := NOW();
	RETURN NEW;
END $$;
 2   DROP FUNCTION public.add_release_date_function();
       public          postgres    false                    1255    16698    fn_after_insert_activity()    FUNCTION     ?   CREATE FUNCTION public.fn_after_insert_activity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
		INSERT INTO lectures (id_activity, nombre_lecture, yt_link, purpose, preguntas_apoyo, texto1)
		VALUES (0,'','','','','');
		RETURN NEW;
END $$;
 1   DROP FUNCTION public.fn_after_insert_activity();
       public          postgres    false                     1255    16677    fn_get_activity(integer)    FUNCTION     ]  CREATE FUNCTION public.fn_get_activity(pid_activity integer) RETURNS TABLE(id_activity integer, id_course integer, name_activity character varying, instructions character varying, num_activity integer)
    LANGUAGE sql
    AS $_$
	SELECT id_activity, id_course, name_activity, instructions, num_activity
	FROM activities WHERE id_activity = $1
$_$;
 <   DROP FUNCTION public.fn_get_activity(pid_activity integer);
       public          postgres    false         ?            1255    16676    fn_list_activities(integer)    FUNCTION     v  CREATE FUNCTION public.fn_list_activities(id_course integer) RETURNS TABLE(id_activity integer, id_course integer, name_activity character varying, instructions character varying, num_activity integer)
    LANGUAGE sql
    AS $_$
	SELECT id_activity, id_course, name_activity, instructions, num_activity
	FROM activities WHERE id_course = $1
	ORDER BY num_activity ASC
$_$;
 <   DROP FUNCTION public.fn_list_activities(id_course integer);
       public          postgres    false                    1255    16697    fn_list_empty_lectures()    FUNCTION     J  CREATE FUNCTION public.fn_list_empty_lectures() RETURNS TABLE(id_lecture integer, id_activity integer, nombre_lecture character varying, yt_link character varying, purpose character varying, preguntas_apoyo character varying, texto1 character varying)
    LANGUAGE sql
    AS $$
	SELECT * FROM lectures WHERE id_activity = 0;
$$;
 /   DROP FUNCTION public.fn_list_empty_lectures();
       public          postgres    false         ?            1259    24838 
   activities    TABLE     ?   CREATE TABLE public.activities (
    id_activity integer NOT NULL,
    id_lecture integer,
    name_activity character varying(100) NOT NULL,
    instructions character varying(300) NOT NULL,
    num_questions integer,
    num_activity integer
);
    DROP TABLE public.activities;
       public         heap    postgres    false         ?            1255    24850    fn_listar_activities()    FUNCTION     ?   CREATE FUNCTION public.fn_listar_activities() RETURNS SETOF public.activities
    LANGUAGE sql
    AS $$
	SELECT * FROM activities 
$$;
 -   DROP FUNCTION public.fn_listar_activities();
       public          postgres    false    217         ?            1259    24866    answers    TABLE     ?   CREATE TABLE public.answers (
    id_answer integer NOT NULL,
    id_question integer,
    answer character varying(100),
    is_correct boolean,
    num_answer integer
);
    DROP TABLE public.answers;
       public         heap    postgres    false         ?            1255    24878    fn_listar_answer()    FUNCTION     ?   CREATE FUNCTION public.fn_listar_answer() RETURNS SETOF public.answers
    LANGUAGE sql
    AS $$
	SELECT * FROM answers ORDER BY num_answer ASC
$$;
 )   DROP FUNCTION public.fn_listar_answer();
       public          postgres    false    221         ?            1259    16544    courses    TABLE     f  CREATE TABLE public.courses (
    id_course integer NOT NULL,
    name_course character varying(100) NOT NULL,
    subject character varying(100) NOT NULL,
    description character varying(250) NOT NULL,
    author character varying(100) NOT NULL,
    id_user integer,
    release_date timestamp without time zone DEFAULT now(),
    is_published boolean
);
    DROP TABLE public.courses;
       public         heap    postgres    false         ?            1255    16595    fn_listar_cursos()    FUNCTION     }   CREATE FUNCTION public.fn_listar_cursos() RETURNS SETOF public.courses
    LANGUAGE sql
    AS $$
	SELECT * FROM courses
$$;
 )   DROP FUNCTION public.fn_listar_cursos();
       public          postgres    false    212         ?            1259    24809    lectures    TABLE       CREATE TABLE public.lectures (
    id_lecture integer NOT NULL,
    id_course integer,
    nombre_lecture character varying(200),
    yt_link character varying(150),
    purpose character varying(200),
    preguntas_apoyo character varying(100),
    texto1 character varying(500)
);
    DROP TABLE public.lectures;
       public         heap    postgres    false         ?            1255    24822    fn_listar_lectures()    FUNCTION     ?   CREATE FUNCTION public.fn_listar_lectures() RETURNS SETOF public.lectures
    LANGUAGE sql
    AS $$
	SELECT * FROM lectures 
$$;
 +   DROP FUNCTION public.fn_listar_lectures();
       public          postgres    false    215         ?            1259    24852 	   questions    TABLE     ?   CREATE TABLE public.questions (
    id_question integer NOT NULL,
    id_activity integer,
    question character varying(200),
    num_question integer
);
    DROP TABLE public.questions;
       public         heap    postgres    false         ?            1255    24879    fn_listar_questions()    FUNCTION     ?   CREATE FUNCTION public.fn_listar_questions() RETURNS SETOF public.questions
    LANGUAGE sql
    AS $$
	SELECT * FROM questions ORDER BY num_question ASC
$$;
 ,   DROP FUNCTION public.fn_listar_questions();
       public          postgres    false    219         ?            1255    16596    fn_obtenerdetalles(integer)    FUNCTION     ?   CREATE FUNCTION public.fn_obtenerdetalles(id_course integer) RETURNS SETOF public.courses
    LANGUAGE sql
    AS $_$
	SELECT * FROM courses WHERE id_course = $1
$_$;
 <   DROP FUNCTION public.fn_obtenerdetalles(id_course integer);
       public          postgres    false    212         ?            1255    16443 <   fn_validate_user_login(character varying, character varying)    FUNCTION     	  CREATE FUNCTION public.fn_validate_user_login(user_email character varying, user_password character varying) RETURNS TABLE(bandera integer)
    LANGUAGE sql
    AS $_$
	SELECT COUNT(user_email) FROM users WHERE LOWER(user_email)=LOWER($1) AND user_password=$2
$_$;
 l   DROP FUNCTION public.fn_validate_user_login(user_email character varying, user_password character varying);
       public          postgres    false         ?            1255    16444 )   fn_validate_user_regis(character varying)    FUNCTION     ?   CREATE FUNCTION public.fn_validate_user_regis(user_email character varying) RETURNS TABLE(bandera integer)
    LANGUAGE sql
    AS $_$
	SELECT COUNT(user_email) FROM users WHERE LOWER(user_email)=LOWER($1)
$_$;
 K   DROP FUNCTION public.fn_validate_user_regis(user_email character varying);
       public          postgres    false         ?            1255    16643    fn_view_subscriptions(integer)    FUNCTION     ?   CREATE FUNCTION public.fn_view_subscriptions(id_user integer) RETURNS TABLE(cursos integer)
    LANGUAGE sql
    AS $_$
	SELECT id_course FROM course_subscriptions WHERE id_user=$1
$_$;
 =   DROP FUNCTION public.fn_view_subscriptions(id_user integer);
       public          postgres    false         ?            1259    16463    users    TABLE     =  CREATE TABLE public.users (
    id_user integer NOT NULL,
    user_name character varying(50),
    user_firstlastname character varying(50),
    user_secondlastname character varying(50),
    user_email character varying(50),
    user_password character varying(50),
    user_role integer,
    user_status boolean
);
    DROP TABLE public.users;
       public         heap    postgres    false         ?            1255    16486    fn_view_user(integer)    FUNCTION     ?   CREATE FUNCTION public.fn_view_user(id_user integer) RETURNS SETOF public.users
    LANGUAGE sql
    AS $_$
	SELECT * FROM users WHERE id_user=$1
$_$;
 4   DROP FUNCTION public.fn_view_user(id_user integer);
       public          postgres    false    210         ?            1255    16470    fn_view_users()    FUNCTION     ?   CREATE FUNCTION public.fn_view_users() RETURNS SETOF public.users
    LANGUAGE sql
    AS $$
	SELECT * FROM users ORDER BY id_user ASC
$$;
 &   DROP FUNCTION public.fn_view_users();
       public          postgres    false    210                    1255    24849 S   sp_create_activity(integer, character varying, character varying, integer, integer) 	   PROCEDURE     V  CREATE PROCEDURE public.sp_create_activity(IN id_lecture integer, IN name_activity character varying, IN instructions character varying, IN num_questions integer, IN num_activity integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO activities (id_lecture, name_activity, instructions, num_questions,num_activity)	VALUES ($1, $2, $3, $4,$5)
$_$;
 ?   DROP PROCEDURE public.sp_create_activity(IN id_lecture integer, IN name_activity character varying, IN instructions character varying, IN num_questions integer, IN num_activity integer);
       public          postgres    false         	           1255    24877 >   sp_create_answer(integer, character varying, boolean, integer) 	   PROCEDURE       CREATE PROCEDURE public.sp_create_answer(IN id_question integer, IN answer character varying, IN is_correct boolean, IN num_answer integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO answers (id_question, answer,  is_correct,num_answer)	VALUES ($1, $2, $3, $4)
$_$;
 ?   DROP PROCEDURE public.sp_create_answer(IN id_question integer, IN answer character varying, IN is_correct boolean, IN num_answer integer);
       public          postgres    false         ?            1255    16598 e   sp_create_course(character varying, character varying, character varying, character varying, integer) 	   PROCEDURE     `  CREATE PROCEDURE public.sp_create_course(IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying, IN id_user integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO courses (name_course, subject, description, author,id_user, is_published)
	VALUES ($1, $2, $3, $4, $5, false)
$_$;
 ?   DROP PROCEDURE public.sp_create_course(IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying, IN id_user integer);
       public          postgres    false                    1255    24823 y   sp_create_lecture(integer, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE public.sp_create_lecture(IN id_course integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying)
    LANGUAGE sql
    AS $_$
	INSERT INTO lectures (id_course, nombre_lecture, yt_link, purpose, preguntas_apoyo, texto1)
	VALUES ($1, $2, $3, $4, $5, $6)
$_$;
 ?   DROP PROCEDURE public.sp_create_lecture(IN id_course integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying);
       public          postgres    false                    1255    24864 7   sp_create_question(integer, character varying, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_create_question(IN id_activity integer, IN question character varying, IN num_question integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO questions (id_activity, question, num_question)	VALUES ($1, $2, $3)
$_$;
 z   DROP PROCEDURE public.sp_create_question(IN id_activity integer, IN question character varying, IN num_question integer);
       public          postgres    false                    1255    16679    sp_delete_activity(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_delete_activity(IN p_id_activity integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM activities WHERE id_activity = $1
$_$;
 D   DROP PROCEDURE public.sp_delete_activity(IN p_id_activity integer);
       public          postgres    false         ?            1255    16650    sp_delete_course(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_delete_course(IN p_id_course integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM courses WHERE id_course = $1
$_$;
 @   DROP PROCEDURE public.sp_delete_course(IN p_id_course integer);
       public          postgres    false         ?            1255    16410    sp_delete_user(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_delete_user(IN id_user integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM users WHERE id_user = $1
$_$;
 :   DROP PROCEDURE public.sp_delete_user(IN id_user integer);
       public          postgres    false         ?            1255    16640 '   sp_desubscribe_course(integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_desubscribe_course(IN id_user integer, IN id_course integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM course_subscriptions WHERE id_user = $1 AND id_course=$2
$_$;
 W   DROP PROCEDURE public.sp_desubscribe_course(IN id_user integer, IN id_course integer);
       public          postgres    false         ?            1255    16475    sp_insert_user(character varying, character varying, character varying, character varying, character varying, integer, boolean) 	   PROCEDURE     m  CREATE PROCEDURE public.sp_insert_user(IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean)
    LANGUAGE sql
    AS $_$
	INSERT INTO users VALUES(DEFAULT,$1,$2,$3,LOWER($4),$5,$6,$7)
$_$;
   DROP PROCEDURE public.sp_insert_user(IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean);
       public          postgres    false                    1255    16678 S   sp_modify_activity(integer, integer, character varying, character varying, integer) 	   PROCEDURE     3  CREATE PROCEDURE public.sp_modify_activity(IN id_activity integer, IN id_course integer, IN name_activity character varying, IN instructions character varying, IN num_activity integer)
    LANGUAGE sql
    AS $_$
	UPDATE activities SET
		name_activity = $3,
		instructions = $4
	WHERE id_activity = $1
$_$;
 ?   DROP PROCEDURE public.sp_modify_activity(IN id_activity integer, IN id_course integer, IN name_activity character varying, IN instructions character varying, IN num_activity integer);
       public          postgres    false         ?            1255    16536 e   sp_modify_course(integer, character varying, character varying, character varying, character varying) 	   PROCEDURE     Y  CREATE PROCEDURE public.sp_modify_course(IN p_id_course integer, IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying)
    LANGUAGE sql
    AS $_$
	UPDATE courses SET
		name_course = $2,
		subject = $3,
		description = $4,
		author = $5
	WHERE id_course = $1
$_$;
 ?   DROP PROCEDURE public.sp_modify_course(IN p_id_course integer, IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying);
       public          postgres    false                    1255    16700 ?   sp_modify_lecture(integer, integer, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE public.sp_modify_lecture(IN id_lecture integer, IN id_activity integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying)
    LANGUAGE sql
    AS $_$
	UPDATE lectures SET
		id_activity = $2,
		nombre_lecture = $3,
		yt_link = $4,
		purpose = $5,
		preguntas_apoyo = $6,
		texto1= $7
	WHERE id_lecture = $1
$_$;
 ?   DROP PROCEDURE public.sp_modify_lecture(IN id_lecture integer, IN id_activity integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying);
       public          postgres    false         ?            1255    16540    sp_publish_course(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_publish_course(IN p_id_course integer)
    LANGUAGE sql
    AS $_$
	UPDATE courses
	SET is_published = true
	WHERE id_course = $1
$_$;
 A   DROP PROCEDURE public.sp_publish_course(IN p_id_course integer);
       public          postgres    false         ?            1255    16639 %   sp_subscribe_course(integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_subscribe_course(IN id_user integer, IN id_course integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO course_subscriptions VALUES($1,$2)
$_$;
 U   DROP PROCEDURE public.sp_subscribe_course(IN id_user integer, IN id_course integer);
       public          postgres    false         ?            1255    16541    sp_unpublish_course(integer) 	   PROCEDURE     ?   CREATE PROCEDURE public.sp_unpublish_course(IN p_id_course integer)
    LANGUAGE sql
    AS $_$
	UPDATE courses
	SET is_published = false
	WHERE id_course = $1
$_$;
 C   DROP PROCEDURE public.sp_unpublish_course(IN p_id_course integer);
       public          postgres    false         ?            1255    16473 ?   sp_update_user(integer, character varying, character varying, character varying, character varying, character varying, integer, boolean) 	   PROCEDURE     ?  CREATE PROCEDURE public.sp_update_user(IN id_user integer, IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean)
    LANGUAGE sql
    AS $_$
	UPDATE users SET user_name = $2, user_firstlastname = $3, user_secondlastname = $4, user_email = $5, user_password = $6, user_role = $7, user_status = $8 WHERE id_user = $1
$_$;
    DROP PROCEDURE public.sp_update_user(IN id_user integer, IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean);
       public          postgres    false         ?            1259    24837    activities_id_activity_seq    SEQUENCE     ?   CREATE SEQUENCE public.activities_id_activity_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.activities_id_activity_seq;
       public          postgres    false    217         S           0    0    activities_id_activity_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.activities_id_activity_seq OWNED BY public.activities.id_activity;
          public          postgres    false    216         ?            1259    24865    answers_id_answer_seq    SEQUENCE     ?   CREATE SEQUENCE public.answers_id_answer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.answers_id_answer_seq;
       public          postgres    false    221         T           0    0    answers_id_answer_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.answers_id_answer_seq OWNED BY public.answers.id_answer;
          public          postgres    false    220         ?            1259    16626    course_subscriptions    TABLE     Y   CREATE TABLE public.course_subscriptions (
    id_user integer,
    id_course integer
);
 (   DROP TABLE public.course_subscriptions;
       public         heap    postgres    false         ?            1259    16543    courses_id_course_seq    SEQUENCE     ?   CREATE SEQUENCE public.courses_id_course_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.courses_id_course_seq;
       public          postgres    false    212         U           0    0    courses_id_course_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.courses_id_course_seq OWNED BY public.courses.id_course;
          public          postgres    false    211         ?            1259    24808    lectures_id_lecture_seq    SEQUENCE     ?   CREATE SEQUENCE public.lectures_id_lecture_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.lectures_id_lecture_seq;
       public          postgres    false    215         V           0    0    lectures_id_lecture_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.lectures_id_lecture_seq OWNED BY public.lectures.id_lecture;
          public          postgres    false    214         ?            1259    24851    questions_id_question_seq    SEQUENCE     ?   CREATE SEQUENCE public.questions_id_question_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.questions_id_question_seq;
       public          postgres    false    219         W           0    0    questions_id_question_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.questions_id_question_seq OWNED BY public.questions.id_question;
          public          postgres    false    218         ?            1259    16462    users_id_user_seq    SEQUENCE     ?   CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_id_user_seq;
       public          postgres    false    210         X           0    0    users_id_user_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;
          public          postgres    false    209         ?           2604    24841    activities id_activity    DEFAULT     ?   ALTER TABLE ONLY public.activities ALTER COLUMN id_activity SET DEFAULT nextval('public.activities_id_activity_seq'::regclass);
 E   ALTER TABLE public.activities ALTER COLUMN id_activity DROP DEFAULT;
       public          postgres    false    216    217    217         ?           2604    24869    answers id_answer    DEFAULT     v   ALTER TABLE ONLY public.answers ALTER COLUMN id_answer SET DEFAULT nextval('public.answers_id_answer_seq'::regclass);
 @   ALTER TABLE public.answers ALTER COLUMN id_answer DROP DEFAULT;
       public          postgres    false    220    221    221         ?           2604    16547    courses id_course    DEFAULT     v   ALTER TABLE ONLY public.courses ALTER COLUMN id_course SET DEFAULT nextval('public.courses_id_course_seq'::regclass);
 @   ALTER TABLE public.courses ALTER COLUMN id_course DROP DEFAULT;
       public          postgres    false    211    212    212         ?           2604    24812    lectures id_lecture    DEFAULT     z   ALTER TABLE ONLY public.lectures ALTER COLUMN id_lecture SET DEFAULT nextval('public.lectures_id_lecture_seq'::regclass);
 B   ALTER TABLE public.lectures ALTER COLUMN id_lecture DROP DEFAULT;
       public          postgres    false    214    215    215         ?           2604    24855    questions id_question    DEFAULT     ~   ALTER TABLE ONLY public.questions ALTER COLUMN id_question SET DEFAULT nextval('public.questions_id_question_seq'::regclass);
 D   ALTER TABLE public.questions ALTER COLUMN id_question DROP DEFAULT;
       public          postgres    false    219    218    219         ?           2604    16466    users id_user    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    210    209    210         H          0    24838 
   activities 
   TABLE DATA           w   COPY public.activities (id_activity, id_lecture, name_activity, instructions, num_questions, num_activity) FROM stdin;
    public          postgres    false    217       3400.dat L          0    24866    answers 
   TABLE DATA           Y   COPY public.answers (id_answer, id_question, answer, is_correct, num_answer) FROM stdin;
    public          postgres    false    221       3404.dat D          0    16626    course_subscriptions 
   TABLE DATA           B   COPY public.course_subscriptions (id_user, id_course) FROM stdin;
    public          postgres    false    213       3396.dat C          0    16544    courses 
   TABLE DATA           |   COPY public.courses (id_course, name_course, subject, description, author, id_user, release_date, is_published) FROM stdin;
    public          postgres    false    212       3395.dat F          0    24809    lectures 
   TABLE DATA           t   COPY public.lectures (id_lecture, id_course, nombre_lecture, yt_link, purpose, preguntas_apoyo, texto1) FROM stdin;
    public          postgres    false    215       3398.dat J          0    24852 	   questions 
   TABLE DATA           U   COPY public.questions (id_question, id_activity, question, num_question) FROM stdin;
    public          postgres    false    219       3402.dat A          0    16463    users 
   TABLE DATA           ?   COPY public.users (id_user, user_name, user_firstlastname, user_secondlastname, user_email, user_password, user_role, user_status) FROM stdin;
    public          postgres    false    210       3393.dat Y           0    0    activities_id_activity_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.activities_id_activity_seq', 7, true);
          public          postgres    false    216         Z           0    0    answers_id_answer_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.answers_id_answer_seq', 8, true);
          public          postgres    false    220         [           0    0    courses_id_course_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.courses_id_course_seq', 12, true);
          public          postgres    false    211         \           0    0    lectures_id_lecture_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.lectures_id_lecture_seq', 7, true);
          public          postgres    false    214         ]           0    0    questions_id_question_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.questions_id_question_seq', 5, true);
          public          postgres    false    218         ^           0    0    users_id_user_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_id_user_seq', 13, true);
          public          postgres    false    209         ?           2606    24843    activities activities_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id_activity);
 D   ALTER TABLE ONLY public.activities DROP CONSTRAINT activities_pkey;
       public            postgres    false    217         ?           2606    24871    answers answers_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id_answer);
 >   ALTER TABLE ONLY public.answers DROP CONSTRAINT answers_pkey;
       public            postgres    false    221         ?           2606    16552    courses courses_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id_course);
 >   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_pkey;
       public            postgres    false    212         ?           2606    24816    lectures lectures_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.lectures
    ADD CONSTRAINT lectures_pkey PRIMARY KEY (id_lecture);
 @   ALTER TABLE ONLY public.lectures DROP CONSTRAINT lectures_pkey;
       public            postgres    false    215         ?           2606    24857    questions questions_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id_question);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_pkey;
       public            postgres    false    219         ?           2606    16468    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    210         ?           2620    16594     courses add_release_date_trigger    TRIGGER     ?   CREATE TRIGGER add_release_date_trigger BEFORE INSERT ON public.courses FOR EACH ROW EXECUTE FUNCTION public.add_release_date_function();
 9   DROP TRIGGER add_release_date_trigger ON public.courses;
       public          postgres    false    225    212         ?           2606    24858    questions fk_id_activity    FK CONSTRAINT     ?   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_id_activity FOREIGN KEY (id_activity) REFERENCES public.activities(id_activity);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT fk_id_activity;
       public          postgres    false    3240    219    217         ?           2606    16645 !   course_subscriptions fk_id_course    FK CONSTRAINT     ?   ALTER TABLE ONLY public.course_subscriptions
    ADD CONSTRAINT fk_id_course FOREIGN KEY (id_course) REFERENCES public.courses(id_course) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.course_subscriptions DROP CONSTRAINT fk_id_course;
       public          postgres    false    213    3236    212         ?           2606    24817    lectures fk_id_course    FK CONSTRAINT        ALTER TABLE ONLY public.lectures
    ADD CONSTRAINT fk_id_course FOREIGN KEY (id_course) REFERENCES public.courses(id_course);
 ?   ALTER TABLE ONLY public.lectures DROP CONSTRAINT fk_id_course;
       public          postgres    false    212    3236    215         ?           2606    24844    activities fk_id_lecture    FK CONSTRAINT     ?   ALTER TABLE ONLY public.activities
    ADD CONSTRAINT fk_id_lecture FOREIGN KEY (id_lecture) REFERENCES public.lectures(id_lecture);
 B   ALTER TABLE ONLY public.activities DROP CONSTRAINT fk_id_lecture;
       public          postgres    false    3238    215    217         ?           2606    24872    answers fk_id_question    FK CONSTRAINT     ?   ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_id_question FOREIGN KEY (id_question) REFERENCES public.questions(id_question);
 @   ALTER TABLE ONLY public.answers DROP CONSTRAINT fk_id_question;
       public          postgres    false    219    3242    221         ?           2606    16553    courses fk_id_user    FK CONSTRAINT     v   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_id_user FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 <   ALTER TABLE ONLY public.courses DROP CONSTRAINT fk_id_user;
       public          postgres    false    3234    210    212         ?           2606    16629    course_subscriptions fk_id_user    FK CONSTRAINT     ?   ALTER TABLE ONLY public.course_subscriptions
    ADD CONSTRAINT fk_id_user FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 I   ALTER TABLE ONLY public.course_subscriptions DROP CONSTRAINT fk_id_user;
       public          postgres    false    210    3234    213                                                                                                                                                                                                                                                                                                              3400.dat                                                                                            0000600 0004000 0002000 00000000364 14324074653 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	Resolver ecuaciones	Resuleva u deje procedimientos	4	1
2	6	Resolver ecuacionesdwe	dwedwe	2	2
3	6	dewdw	dwdww	12	2
4	6	dewdw	dwdww	12	2
5	6	scs	cscs	12	12
6	6	sasw	swqq	1	1
7	7	Actividad 1	Resulve las siguientes preguntas teoricas.	5	1
\.


                                                                                                                                                                                                                                                                            3404.dat                                                                                            0000600 0004000 0002000 00000000270 14324074653 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	x2	t	1
2	1	x3	f	2
3	1	wedwedwed	f	3
4	3	x2	t	1
5	5	Una colección ordenada de datos	t	1
6	5	Una funcion.	f	2
7	5	Es un tipo de matriz	t	3
8	5	Es un tipo de dato primitivo	f	4
\.


                                                                                                                                                                                                                                                                                                                                        3396.dat                                                                                            0000600 0004000 0002000 00000000005 14324074653 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3395.dat                                                                                            0000600 0004000 0002000 00000000617 14324074653 0014271 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        9	Fisica	fisica 2	fisica basica 2 mru	Hector Aguirre	4	2022-10-18 01:50:08.328839	t
10	mate	mate 1	matetefacil	Nicolas Aguirre	3	2022-10-18 01:50:53.009051	t
12	Programacion	Computacion	Aprenderemos a programar en python programas basicos utilizando estructuras de datos.	Nicolas Aguirre	3	2022-10-18 13:17:17.275201	t
11	mate	mate 2	mate 2 facil	Nicolas Aguirre	3	2022-10-18 01:51:08.548761	t
\.


                                                                                                                 3398.dat                                                                                            0000600 0004000 0002000 00000001310 14324074653 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	10	holaaaaa1	link1	prueba	dedeed	dedededada
2	9	holaaaaa2	12dwedwedw	prueba111	fdewweew1	dewdwdwdwe1
3	9	dedewdw	wdwdwdw	edwed	wdwdwdw	ewdwewdw
4	9	dqdqdq	dqdqdq	dqdqdq	dqdqwdq	dqdqd
5	9	refwefw	fewfwef	wfwfw	fwfwf	wfwef
6	10	ededwdwed	wdwedwedwd	wdweedwdwd	dedede	dedwdwe
7	12	Arreglos	https://www.youtube.com/embed/BwW3t17wt5E	Introduccion al manejo de los arreglos y sus funciones.	¿Conoces mejor el uso de los arreglos?	Un arreglo (matriz) es una colección ordenada de datos (tanto primitivos u objetos dependiendo del lenguaje). Los arreglos (matrices) se emplean para almacenar multiples valores en una sola variable, frente a las variables que sólo pueden almacenar un valor (por cada variable)
\.


                                                                                                                                                                                                                                                                                                                        3402.dat                                                                                            0000600 0004000 0002000 00000000174 14324074653 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	porque eres asi	1
2	4	porque eres asi	1
3	5	porque eres asi	1212
4	5	porque eres asi	12
5	7	¿Que es un arreglo?	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                    3393.dat                                                                                            0000600 0004000 0002000 00000001116 14324074653 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	admin	admin	admin	admin@admin.com	admin123	1	f
5	pepe	hgh	da	eqeqeq@gmail.com	123	2	f
6	Isabella	Aguirre	Villafañe	isabelaguir@gmail.com	isa	3	f
4	Hector	Aguirre	Primero	haguirre@colombina.com	nico	2	t
7	Allison	Villfañe	Torress	vallisonvillafane@gmail.com	mono	2	f
9	aa	aa	aa	aa@aa.com	aa	2	f
10	pep	epe	pepe	pepe@pepe.com	pepe	2	f
8	de	dee	edee	dada@gmail.com	12	2	t
11	ffff	ffff	ffff	ffff@gmail.com	ffff	3	t
12	Dominicano	Ramirez	Rodriguez	dad@gmail.com	d	3	f
3	Nicolas	Aguirre	Villafañe	nico03aguirre@gmail.com	simon	2	f
13	Nicolas	Aguirre	Villafañe	nico0@gmail.com	1234	2	f
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                  restore.sql                                                                                         0000600 0004000 0002000 00000072350 14324074653 0015403 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE ensenable;
--
-- Name: ensenable; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE ensenable WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Guatemala.1252';


ALTER DATABASE ensenable OWNER TO postgres;

\connect ensenable

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: add_release_date_function(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_release_date_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.release_date := NOW();
	RETURN NEW;
END $$;


ALTER FUNCTION public.add_release_date_function() OWNER TO postgres;

--
-- Name: fn_after_insert_activity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_after_insert_activity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
		INSERT INTO lectures (id_activity, nombre_lecture, yt_link, purpose, preguntas_apoyo, texto1)
		VALUES (0,'','','','','');
		RETURN NEW;
END $$;


ALTER FUNCTION public.fn_after_insert_activity() OWNER TO postgres;

--
-- Name: fn_get_activity(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_get_activity(pid_activity integer) RETURNS TABLE(id_activity integer, id_course integer, name_activity character varying, instructions character varying, num_activity integer)
    LANGUAGE sql
    AS $_$
	SELECT id_activity, id_course, name_activity, instructions, num_activity
	FROM activities WHERE id_activity = $1
$_$;


ALTER FUNCTION public.fn_get_activity(pid_activity integer) OWNER TO postgres;

--
-- Name: fn_list_activities(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_list_activities(id_course integer) RETURNS TABLE(id_activity integer, id_course integer, name_activity character varying, instructions character varying, num_activity integer)
    LANGUAGE sql
    AS $_$
	SELECT id_activity, id_course, name_activity, instructions, num_activity
	FROM activities WHERE id_course = $1
	ORDER BY num_activity ASC
$_$;


ALTER FUNCTION public.fn_list_activities(id_course integer) OWNER TO postgres;

--
-- Name: fn_list_empty_lectures(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_list_empty_lectures() RETURNS TABLE(id_lecture integer, id_activity integer, nombre_lecture character varying, yt_link character varying, purpose character varying, preguntas_apoyo character varying, texto1 character varying)
    LANGUAGE sql
    AS $$
	SELECT * FROM lectures WHERE id_activity = 0;
$$;


ALTER FUNCTION public.fn_list_empty_lectures() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities (
    id_activity integer NOT NULL,
    id_lecture integer,
    name_activity character varying(100) NOT NULL,
    instructions character varying(300) NOT NULL,
    num_questions integer,
    num_activity integer
);


ALTER TABLE public.activities OWNER TO postgres;

--
-- Name: fn_listar_activities(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_activities() RETURNS SETOF public.activities
    LANGUAGE sql
    AS $$
	SELECT * FROM activities 
$$;


ALTER FUNCTION public.fn_listar_activities() OWNER TO postgres;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers (
    id_answer integer NOT NULL,
    id_question integer,
    answer character varying(100),
    is_correct boolean,
    num_answer integer
);


ALTER TABLE public.answers OWNER TO postgres;

--
-- Name: fn_listar_answer(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_answer() RETURNS SETOF public.answers
    LANGUAGE sql
    AS $$
	SELECT * FROM answers ORDER BY num_answer ASC
$$;


ALTER FUNCTION public.fn_listar_answer() OWNER TO postgres;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id_course integer NOT NULL,
    name_course character varying(100) NOT NULL,
    subject character varying(100) NOT NULL,
    description character varying(250) NOT NULL,
    author character varying(100) NOT NULL,
    id_user integer,
    release_date timestamp without time zone DEFAULT now(),
    is_published boolean
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: fn_listar_cursos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_cursos() RETURNS SETOF public.courses
    LANGUAGE sql
    AS $$
	SELECT * FROM courses
$$;


ALTER FUNCTION public.fn_listar_cursos() OWNER TO postgres;

--
-- Name: lectures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lectures (
    id_lecture integer NOT NULL,
    id_course integer,
    nombre_lecture character varying(200),
    yt_link character varying(150),
    purpose character varying(200),
    preguntas_apoyo character varying(100),
    texto1 character varying(500)
);


ALTER TABLE public.lectures OWNER TO postgres;

--
-- Name: fn_listar_lectures(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_lectures() RETURNS SETOF public.lectures
    LANGUAGE sql
    AS $$
	SELECT * FROM lectures 
$$;


ALTER FUNCTION public.fn_listar_lectures() OWNER TO postgres;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id_question integer NOT NULL,
    id_activity integer,
    question character varying(200),
    num_question integer
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: fn_listar_questions(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_questions() RETURNS SETOF public.questions
    LANGUAGE sql
    AS $$
	SELECT * FROM questions ORDER BY num_question ASC
$$;


ALTER FUNCTION public.fn_listar_questions() OWNER TO postgres;

--
-- Name: fn_obtenerdetalles(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_obtenerdetalles(id_course integer) RETURNS SETOF public.courses
    LANGUAGE sql
    AS $_$
	SELECT * FROM courses WHERE id_course = $1
$_$;


ALTER FUNCTION public.fn_obtenerdetalles(id_course integer) OWNER TO postgres;

--
-- Name: fn_validate_user_login(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_validate_user_login(user_email character varying, user_password character varying) RETURNS TABLE(bandera integer)
    LANGUAGE sql
    AS $_$
	SELECT COUNT(user_email) FROM users WHERE LOWER(user_email)=LOWER($1) AND user_password=$2
$_$;


ALTER FUNCTION public.fn_validate_user_login(user_email character varying, user_password character varying) OWNER TO postgres;

--
-- Name: fn_validate_user_regis(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_validate_user_regis(user_email character varying) RETURNS TABLE(bandera integer)
    LANGUAGE sql
    AS $_$
	SELECT COUNT(user_email) FROM users WHERE LOWER(user_email)=LOWER($1)
$_$;


ALTER FUNCTION public.fn_validate_user_regis(user_email character varying) OWNER TO postgres;

--
-- Name: fn_view_subscriptions(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_view_subscriptions(id_user integer) RETURNS TABLE(cursos integer)
    LANGUAGE sql
    AS $_$
	SELECT id_course FROM course_subscriptions WHERE id_user=$1
$_$;


ALTER FUNCTION public.fn_view_subscriptions(id_user integer) OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_user integer NOT NULL,
    user_name character varying(50),
    user_firstlastname character varying(50),
    user_secondlastname character varying(50),
    user_email character varying(50),
    user_password character varying(50),
    user_role integer,
    user_status boolean
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: fn_view_user(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_view_user(id_user integer) RETURNS SETOF public.users
    LANGUAGE sql
    AS $_$
	SELECT * FROM users WHERE id_user=$1
$_$;


ALTER FUNCTION public.fn_view_user(id_user integer) OWNER TO postgres;

--
-- Name: fn_view_users(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_view_users() RETURNS SETOF public.users
    LANGUAGE sql
    AS $$
	SELECT * FROM users ORDER BY id_user ASC
$$;


ALTER FUNCTION public.fn_view_users() OWNER TO postgres;

--
-- Name: sp_create_activity(integer, character varying, character varying, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_create_activity(IN id_lecture integer, IN name_activity character varying, IN instructions character varying, IN num_questions integer, IN num_activity integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO activities (id_lecture, name_activity, instructions, num_questions,num_activity)	VALUES ($1, $2, $3, $4,$5)
$_$;


ALTER PROCEDURE public.sp_create_activity(IN id_lecture integer, IN name_activity character varying, IN instructions character varying, IN num_questions integer, IN num_activity integer) OWNER TO postgres;

--
-- Name: sp_create_answer(integer, character varying, boolean, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_create_answer(IN id_question integer, IN answer character varying, IN is_correct boolean, IN num_answer integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO answers (id_question, answer,  is_correct,num_answer)	VALUES ($1, $2, $3, $4)
$_$;


ALTER PROCEDURE public.sp_create_answer(IN id_question integer, IN answer character varying, IN is_correct boolean, IN num_answer integer) OWNER TO postgres;

--
-- Name: sp_create_course(character varying, character varying, character varying, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_create_course(IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying, IN id_user integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO courses (name_course, subject, description, author,id_user, is_published)
	VALUES ($1, $2, $3, $4, $5, false)
$_$;


ALTER PROCEDURE public.sp_create_course(IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying, IN id_user integer) OWNER TO postgres;

--
-- Name: sp_create_lecture(integer, character varying, character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_create_lecture(IN id_course integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying)
    LANGUAGE sql
    AS $_$
	INSERT INTO lectures (id_course, nombre_lecture, yt_link, purpose, preguntas_apoyo, texto1)
	VALUES ($1, $2, $3, $4, $5, $6)
$_$;


ALTER PROCEDURE public.sp_create_lecture(IN id_course integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying) OWNER TO postgres;

--
-- Name: sp_create_question(integer, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_create_question(IN id_activity integer, IN question character varying, IN num_question integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO questions (id_activity, question, num_question)	VALUES ($1, $2, $3)
$_$;


ALTER PROCEDURE public.sp_create_question(IN id_activity integer, IN question character varying, IN num_question integer) OWNER TO postgres;

--
-- Name: sp_delete_activity(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_activity(IN p_id_activity integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM activities WHERE id_activity = $1
$_$;


ALTER PROCEDURE public.sp_delete_activity(IN p_id_activity integer) OWNER TO postgres;

--
-- Name: sp_delete_course(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_course(IN p_id_course integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM courses WHERE id_course = $1
$_$;


ALTER PROCEDURE public.sp_delete_course(IN p_id_course integer) OWNER TO postgres;

--
-- Name: sp_delete_user(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_delete_user(IN id_user integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM users WHERE id_user = $1
$_$;


ALTER PROCEDURE public.sp_delete_user(IN id_user integer) OWNER TO postgres;

--
-- Name: sp_desubscribe_course(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_desubscribe_course(IN id_user integer, IN id_course integer)
    LANGUAGE sql
    AS $_$
	DELETE FROM course_subscriptions WHERE id_user = $1 AND id_course=$2
$_$;


ALTER PROCEDURE public.sp_desubscribe_course(IN id_user integer, IN id_course integer) OWNER TO postgres;

--
-- Name: sp_insert_user(character varying, character varying, character varying, character varying, character varying, integer, boolean); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_insert_user(IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean)
    LANGUAGE sql
    AS $_$
	INSERT INTO users VALUES(DEFAULT,$1,$2,$3,LOWER($4),$5,$6,$7)
$_$;


ALTER PROCEDURE public.sp_insert_user(IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean) OWNER TO postgres;

--
-- Name: sp_modify_activity(integer, integer, character varying, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_modify_activity(IN id_activity integer, IN id_course integer, IN name_activity character varying, IN instructions character varying, IN num_activity integer)
    LANGUAGE sql
    AS $_$
	UPDATE activities SET
		name_activity = $3,
		instructions = $4
	WHERE id_activity = $1
$_$;


ALTER PROCEDURE public.sp_modify_activity(IN id_activity integer, IN id_course integer, IN name_activity character varying, IN instructions character varying, IN num_activity integer) OWNER TO postgres;

--
-- Name: sp_modify_course(integer, character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_modify_course(IN p_id_course integer, IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying)
    LANGUAGE sql
    AS $_$
	UPDATE courses SET
		name_course = $2,
		subject = $3,
		description = $4,
		author = $5
	WHERE id_course = $1
$_$;


ALTER PROCEDURE public.sp_modify_course(IN p_id_course integer, IN p_name_course character varying, IN p_subject character varying, IN p_description character varying, IN p_author character varying) OWNER TO postgres;

--
-- Name: sp_modify_lecture(integer, integer, character varying, character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_modify_lecture(IN id_lecture integer, IN id_activity integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying)
    LANGUAGE sql
    AS $_$
	UPDATE lectures SET
		id_activity = $2,
		nombre_lecture = $3,
		yt_link = $4,
		purpose = $5,
		preguntas_apoyo = $6,
		texto1= $7
	WHERE id_lecture = $1
$_$;


ALTER PROCEDURE public.sp_modify_lecture(IN id_lecture integer, IN id_activity integer, IN nombre_lecture character varying, IN yt_link character varying, IN purpose character varying, IN preguntas_apoyo character varying, IN texto1 character varying) OWNER TO postgres;

--
-- Name: sp_publish_course(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_publish_course(IN p_id_course integer)
    LANGUAGE sql
    AS $_$
	UPDATE courses
	SET is_published = true
	WHERE id_course = $1
$_$;


ALTER PROCEDURE public.sp_publish_course(IN p_id_course integer) OWNER TO postgres;

--
-- Name: sp_subscribe_course(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_subscribe_course(IN id_user integer, IN id_course integer)
    LANGUAGE sql
    AS $_$
	INSERT INTO course_subscriptions VALUES($1,$2)
$_$;


ALTER PROCEDURE public.sp_subscribe_course(IN id_user integer, IN id_course integer) OWNER TO postgres;

--
-- Name: sp_unpublish_course(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_unpublish_course(IN p_id_course integer)
    LANGUAGE sql
    AS $_$
	UPDATE courses
	SET is_published = false
	WHERE id_course = $1
$_$;


ALTER PROCEDURE public.sp_unpublish_course(IN p_id_course integer) OWNER TO postgres;

--
-- Name: sp_update_user(integer, character varying, character varying, character varying, character varying, character varying, integer, boolean); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sp_update_user(IN id_user integer, IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean)
    LANGUAGE sql
    AS $_$
	UPDATE users SET user_name = $2, user_firstlastname = $3, user_secondlastname = $4, user_email = $5, user_password = $6, user_role = $7, user_status = $8 WHERE id_user = $1
$_$;


ALTER PROCEDURE public.sp_update_user(IN id_user integer, IN user_name character varying, IN user_firstlastname character varying, IN user_secondlastname character varying, IN user_email character varying, IN user_password character varying, IN user_role integer, IN user_status boolean) OWNER TO postgres;

--
-- Name: activities_id_activity_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_id_activity_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activities_id_activity_seq OWNER TO postgres;

--
-- Name: activities_id_activity_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_id_activity_seq OWNED BY public.activities.id_activity;


--
-- Name: answers_id_answer_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answers_id_answer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_answer_seq OWNER TO postgres;

--
-- Name: answers_id_answer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answers_id_answer_seq OWNED BY public.answers.id_answer;


--
-- Name: course_subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_subscriptions (
    id_user integer,
    id_course integer
);


ALTER TABLE public.course_subscriptions OWNER TO postgres;

--
-- Name: courses_id_course_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_course_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_course_seq OWNER TO postgres;

--
-- Name: courses_id_course_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_id_course_seq OWNED BY public.courses.id_course;


--
-- Name: lectures_id_lecture_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lectures_id_lecture_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lectures_id_lecture_seq OWNER TO postgres;

--
-- Name: lectures_id_lecture_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lectures_id_lecture_seq OWNED BY public.lectures.id_lecture;


--
-- Name: questions_id_question_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_question_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_question_seq OWNER TO postgres;

--
-- Name: questions_id_question_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_question_seq OWNED BY public.questions.id_question;


--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_user_seq OWNER TO postgres;

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;


--
-- Name: activities id_activity; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities ALTER COLUMN id_activity SET DEFAULT nextval('public.activities_id_activity_seq'::regclass);


--
-- Name: answers id_answer; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers ALTER COLUMN id_answer SET DEFAULT nextval('public.answers_id_answer_seq'::regclass);


--
-- Name: courses id_course; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id_course SET DEFAULT nextval('public.courses_id_course_seq'::regclass);


--
-- Name: lectures id_lecture; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectures ALTER COLUMN id_lecture SET DEFAULT nextval('public.lectures_id_lecture_seq'::regclass);


--
-- Name: questions id_question; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id_question SET DEFAULT nextval('public.questions_id_question_seq'::regclass);


--
-- Name: users id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activities (id_activity, id_lecture, name_activity, instructions, num_questions, num_activity) FROM stdin;
\.
COPY public.activities (id_activity, id_lecture, name_activity, instructions, num_questions, num_activity) FROM '$$PATH$$/3400.dat';

--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answers (id_answer, id_question, answer, is_correct, num_answer) FROM stdin;
\.
COPY public.answers (id_answer, id_question, answer, is_correct, num_answer) FROM '$$PATH$$/3404.dat';

--
-- Data for Name: course_subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_subscriptions (id_user, id_course) FROM stdin;
\.
COPY public.course_subscriptions (id_user, id_course) FROM '$$PATH$$/3396.dat';

--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id_course, name_course, subject, description, author, id_user, release_date, is_published) FROM stdin;
\.
COPY public.courses (id_course, name_course, subject, description, author, id_user, release_date, is_published) FROM '$$PATH$$/3395.dat';

--
-- Data for Name: lectures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lectures (id_lecture, id_course, nombre_lecture, yt_link, purpose, preguntas_apoyo, texto1) FROM stdin;
\.
COPY public.lectures (id_lecture, id_course, nombre_lecture, yt_link, purpose, preguntas_apoyo, texto1) FROM '$$PATH$$/3398.dat';

--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id_question, id_activity, question, num_question) FROM stdin;
\.
COPY public.questions (id_question, id_activity, question, num_question) FROM '$$PATH$$/3402.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_user, user_name, user_firstlastname, user_secondlastname, user_email, user_password, user_role, user_status) FROM stdin;
\.
COPY public.users (id_user, user_name, user_firstlastname, user_secondlastname, user_email, user_password, user_role, user_status) FROM '$$PATH$$/3393.dat';

--
-- Name: activities_id_activity_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activities_id_activity_seq', 7, true);


--
-- Name: answers_id_answer_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answers_id_answer_seq', 8, true);


--
-- Name: courses_id_course_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_course_seq', 12, true);


--
-- Name: lectures_id_lecture_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lectures_id_lecture_seq', 7, true);


--
-- Name: questions_id_question_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_question_seq', 5, true);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_user_seq', 13, true);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id_activity);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id_answer);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id_course);


--
-- Name: lectures lectures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectures
    ADD CONSTRAINT lectures_pkey PRIMARY KEY (id_lecture);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id_question);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- Name: courses add_release_date_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER add_release_date_trigger BEFORE INSERT ON public.courses FOR EACH ROW EXECUTE FUNCTION public.add_release_date_function();


--
-- Name: questions fk_id_activity; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_id_activity FOREIGN KEY (id_activity) REFERENCES public.activities(id_activity);


--
-- Name: course_subscriptions fk_id_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_subscriptions
    ADD CONSTRAINT fk_id_course FOREIGN KEY (id_course) REFERENCES public.courses(id_course) ON DELETE CASCADE;


--
-- Name: lectures fk_id_course; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectures
    ADD CONSTRAINT fk_id_course FOREIGN KEY (id_course) REFERENCES public.courses(id_course);


--
-- Name: activities fk_id_lecture; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT fk_id_lecture FOREIGN KEY (id_lecture) REFERENCES public.lectures(id_lecture);


--
-- Name: answers fk_id_question; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_id_question FOREIGN KEY (id_question) REFERENCES public.questions(id_question);


--
-- Name: courses fk_id_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_id_user FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- Name: course_subscriptions fk_id_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_subscriptions
    ADD CONSTRAINT fk_id_user FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        