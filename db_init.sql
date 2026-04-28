--
-- PostgreSQL database dump
--

\restrict dHeysdjj6B7EwVbzXvIWOF3uC3Y4W8iDKXHIkRFGvAePpxwpxpOiuC1GLjcCuF2

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

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
-- Name: db; Type: SCHEMA; Schema: -; Owner: schedule_user
--

CREATE SCHEMA db;


ALTER SCHEMA db OWNER TO schedule_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_customuser; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.account_customuser (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser smallint NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff smallint NOT NULL,
    is_active smallint NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    full_name character varying(100),
    job_title character varying(100),
    level integer,
    role character varying(100),
    gender character varying(20),
    type_of_user integer,
    pregnant smallint,
    can_be_scheduled smallint,
    holiday_rest_num integer,
    holiday_rest_num_used integer,
    special_rest_num integer,
    special_rest_num_used integer,
    eid character varying(100),
    hour_required double precision,
    hour_realized double precision,
    onboard_date date,
    compensatory_rest integer,
    department_id integer,
    starting_month integer
);


ALTER TABLE db.account_customuser OWNER TO schedule_user;

--
-- Name: account_customuser_groups; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.account_customuser_groups (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE db.account_customuser_groups OWNER TO schedule_user;

--
-- Name: account_customuser_user_permissions; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.account_customuser_user_permissions (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE db.account_customuser_user_permissions OWNER TO schedule_user;

--
-- Name: account_department; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.account_department (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    detail character varying(100) NOT NULL,
    limit_pre_schedule integer NOT NULL,
    deadline_pre_schedule integer NOT NULL,
    reset integer NOT NULL,
    law_rule integer NOT NULL,
    schedule_rule integer NOT NULL,
    admin_in_schedule smallint NOT NULL,
    same_day_notice integer NOT NULL,
    date_start date NOT NULL,
    start_of_week integer NOT NULL,
    can_rest_redday integer,
    overtime_rule integer,
    month_cycle integer
);


ALTER TABLE db.account_department OWNER TO schedule_user;

--
-- Name: account_departmentmanager; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.account_departmentmanager (
    id integer NOT NULL,
    department_id integer,
    manager_one_id integer,
    manager_two_id integer
);


ALTER TABLE db.account_departmentmanager OWNER TO schedule_user;

--
-- Name: account_liscense; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.account_liscense (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    date date NOT NULL,
    due date NOT NULL,
    source character varying(25) NOT NULL,
    liscense_pic character varying(100),
    liscense_pic_2 character varying(100),
    user_id integer
);


ALTER TABLE db.account_liscense OWNER TO schedule_user;

--
-- Name: auth_group; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE db.auth_group OWNER TO schedule_user;

--
-- Name: auth_group_permissions; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE db.auth_group_permissions OWNER TO schedule_user;

--
-- Name: auth_permission; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE db.auth_permission OWNER TO schedule_user;

--
-- Name: date_h_calendar; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.date_h_calendar (
    id integer NOT NULL,
    date date NOT NULL,
    attribute json NOT NULL,
    locked smallint NOT NULL,
    red_day smallint NOT NULL
);


ALTER TABLE db.date_h_calendar OWNER TO schedule_user;

--
-- Name: demand_demandofstation; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.demand_demandofstation (
    id integer NOT NULL,
    level integer NOT NULL,
    config1 integer NOT NULL,
    config2 integer NOT NULL,
    shift_id integer,
    station_id integer
);


ALTER TABLE db.demand_demandofstation OWNER TO schedule_user;

--
-- Name: demand_demandusertable; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.demand_demandusertable (
    id integer NOT NULL,
    demand_id integer,
    user_id integer
);


ALTER TABLE db.demand_demandusertable OWNER TO schedule_user;

--
-- Name: django_admin_log; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL
);


ALTER TABLE db.django_admin_log OWNER TO schedule_user;

--
-- Name: django_content_type; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE db.django_content_type OWNER TO schedule_user;

--
-- Name: django_migrations; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE db.django_migrations OWNER TO schedule_user;

--
-- Name: django_session; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE db.django_session OWNER TO schedule_user;

--
-- Name: notifications_notification; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.notifications_notification (
    id integer NOT NULL,
    level character varying(20) NOT NULL,
    unread smallint NOT NULL,
    actor_object_id character varying(255) NOT NULL,
    verb character varying(255) NOT NULL,
    description text,
    target_object_id character varying(255),
    action_object_object_id character varying(255),
    "timestamp" timestamp with time zone NOT NULL,
    public smallint NOT NULL,
    action_object_content_type_id integer,
    actor_content_type_id integer NOT NULL,
    recipient_id integer NOT NULL,
    target_content_type_id integer,
    deleted smallint NOT NULL,
    emailed smallint NOT NULL,
    data text
);


ALTER TABLE db.notifications_notification OWNER TO schedule_user;

--
-- Name: remarks_preresultremark; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.remarks_preresultremark (
    id integer NOT NULL,
    content_id integer,
    result_id integer
);


ALTER TABLE db.remarks_preresultremark OWNER TO schedule_user;

--
-- Name: remarks_remarksquare; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.remarks_remarksquare (
    id integer NOT NULL,
    content character varying(100),
    department_id integer
);


ALTER TABLE db.remarks_remarksquare OWNER TO schedule_user;

--
-- Name: remarks_resultremark; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.remarks_resultremark (
    id integer NOT NULL,
    content_id integer,
    result_id integer
);


ALTER TABLE db.remarks_resultremark OWNER TO schedule_user;

--
-- Name: remarks_userremark; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.remarks_userremark (
    id integer NOT NULL,
    month integer,
    content text,
    user_id integer
);


ALTER TABLE db.remarks_userremark OWNER TO schedule_user;

--
-- Name: reservation_promiseshift; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.reservation_promiseshift (
    id integer NOT NULL,
    date date NOT NULL,
    shift_type integer,
    hours integer,
    remark character varying(100) NOT NULL,
    user_id integer
);


ALTER TABLE db.reservation_promiseshift OWNER TO schedule_user;

--
-- Name: reservation_reservation; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.reservation_reservation (
    id integer NOT NULL,
    date date NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE db.reservation_reservation OWNER TO schedule_user;

--
-- Name: result_afterresult; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.result_afterresult (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE db.result_afterresult OWNER TO schedule_user;

--
-- Name: result_exchangeapplication; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.result_exchangeapplication (
    id integer NOT NULL,
    date_start date,
    date_end date,
    application_status integer NOT NULL,
    remark character varying(100),
    user_apply_id integer,
    user_receive_id integer,
    created_at timestamp with time zone,
    deleted smallint,
    is_confirm smallint,
    shift_apply_id integer,
    shift_receive_id integer,
    station_apply_id integer,
    station_receive_id integer
);


ALTER TABLE db.result_exchangeapplication OWNER TO schedule_user;

--
-- Name: result_historyresult; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.result_historyresult (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE db.result_historyresult OWNER TO schedule_user;

--
-- Name: result_preresult; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.result_preresult (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE db.result_preresult OWNER TO schedule_user;

--
-- Name: result_result; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.result_result (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE db.result_result OWNER TO schedule_user;

--
-- Name: result_timeadjustment; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.result_timeadjustment (
    id integer NOT NULL,
    date date,
    hours integer NOT NULL,
    adjustment_type integer NOT NULL,
    adjustment_item integer NOT NULL,
    remark character varying(100) NOT NULL,
    user_id integer
);


ALTER TABLE db.result_timeadjustment OWNER TO schedule_user;

--
-- Name: shift_shift; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.shift_shift (
    id integer NOT NULL,
    name character varying(100),
    shift_type integer,
    start_time time(6) without time zone,
    end_time time(6) without time zone,
    work_hours double precision,
    department_id integer,
    code character varying(10) NOT NULL
);


ALTER TABLE db.shift_shift OWNER TO schedule_user;

--
-- Name: station_station; Type: TABLE; Schema: db; Owner: schedule_user
--

CREATE TABLE db.station_station (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    department_id integer
);


ALTER TABLE db.station_station OWNER TO schedule_user;

--
-- Name: account_customuser; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.account_customuser (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    full_name character varying(100),
    job_title character varying(100),
    level integer,
    role character varying(100),
    gender character varying(20),
    type_of_user integer,
    pregnant boolean,
    can_be_scheduled boolean,
    holiday_rest_num integer,
    holiday_rest_num_used integer,
    special_rest_num integer,
    special_rest_num_used integer,
    eid character varying(100),
    hour_required double precision,
    hour_realized double precision,
    onboard_date date,
    compensatory_rest integer,
    starting_month integer,
    department_id integer
);


ALTER TABLE public.account_customuser OWNER TO schedule_user;

--
-- Name: account_customuser_groups; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.account_customuser_groups (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.account_customuser_groups OWNER TO schedule_user;

--
-- Name: account_customuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.account_customuser_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_customuser_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_customuser_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.account_customuser ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_customuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_customuser_user_permissions; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.account_customuser_user_permissions (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.account_customuser_user_permissions OWNER TO schedule_user;

--
-- Name: account_customuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.account_customuser_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_customuser_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_department; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.account_department (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    detail character varying(100) NOT NULL,
    limit_pre_schedule integer NOT NULL,
    deadline_pre_schedule integer NOT NULL,
    reset integer NOT NULL,
    law_rule integer NOT NULL,
    schedule_rule integer NOT NULL,
    admin_in_schedule boolean NOT NULL,
    same_day_notice integer NOT NULL,
    date_start date NOT NULL,
    start_of_week integer NOT NULL,
    can_rest_redday integer,
    overtime_rule integer,
    month_cycle integer
);


ALTER TABLE public.account_department OWNER TO schedule_user;

--
-- Name: account_department_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.account_department ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_departmentmanager; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.account_departmentmanager (
    id integer NOT NULL,
    department_id integer,
    manager_one_id integer,
    manager_two_id integer
);


ALTER TABLE public.account_departmentmanager OWNER TO schedule_user;

--
-- Name: account_departmentmanager_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.account_departmentmanager ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_departmentmanager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_liscense; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.account_liscense (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    date date NOT NULL,
    due date NOT NULL,
    source character varying(25) NOT NULL,
    liscense_pic character varying(100),
    liscense_pic_2 character varying(100),
    user_id integer
);


ALTER TABLE public.account_liscense OWNER TO schedule_user;

--
-- Name: account_liscense_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.account_liscense ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_liscense_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO schedule_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO schedule_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO schedule_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO schedule_user;

--
-- Name: date_h_calendar; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.date_h_calendar (
    id integer NOT NULL,
    date date NOT NULL,
    attribute jsonb NOT NULL,
    locked boolean NOT NULL,
    red_day boolean NOT NULL
);


ALTER TABLE public.date_h_calendar OWNER TO schedule_user;

--
-- Name: date_h_calendar_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.date_h_calendar ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.date_h_calendar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: demand_demandofstation; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.demand_demandofstation (
    id integer NOT NULL,
    level integer NOT NULL,
    config1 integer NOT NULL,
    config2 integer NOT NULL,
    shift_id integer,
    station_id integer
);


ALTER TABLE public.demand_demandofstation OWNER TO schedule_user;

--
-- Name: demand_demandofstation_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.demand_demandofstation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.demand_demandofstation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: demand_demandusertable; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.demand_demandusertable (
    id integer NOT NULL,
    demand_id integer,
    user_id integer
);


ALTER TABLE public.demand_demandusertable OWNER TO schedule_user;

--
-- Name: demand_demandusertable_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.demand_demandusertable ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.demand_demandusertable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO schedule_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO schedule_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO schedule_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO schedule_user;

--
-- Name: notifications_notification; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.notifications_notification (
    id integer NOT NULL,
    level character varying(20) NOT NULL,
    unread boolean NOT NULL,
    actor_object_id character varying(255) NOT NULL,
    verb character varying(255) NOT NULL,
    description text,
    target_object_id character varying(255),
    action_object_object_id character varying(255),
    "timestamp" timestamp with time zone NOT NULL,
    public boolean NOT NULL,
    action_object_content_type_id integer,
    actor_content_type_id integer NOT NULL,
    recipient_id integer NOT NULL,
    target_content_type_id integer,
    deleted boolean NOT NULL,
    emailed boolean NOT NULL,
    data text
);


ALTER TABLE public.notifications_notification OWNER TO schedule_user;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.notifications_notification ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notifications_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: remarks_preresultremark; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.remarks_preresultremark (
    id integer NOT NULL,
    content_id integer,
    result_id integer
);


ALTER TABLE public.remarks_preresultremark OWNER TO schedule_user;

--
-- Name: remarks_preresultremark_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.remarks_preresultremark ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.remarks_preresultremark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: remarks_remarksquare; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.remarks_remarksquare (
    id integer NOT NULL,
    content character varying(100),
    department_id integer
);


ALTER TABLE public.remarks_remarksquare OWNER TO schedule_user;

--
-- Name: remarks_remarksquare_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.remarks_remarksquare ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.remarks_remarksquare_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: remarks_resultremark; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.remarks_resultremark (
    id integer NOT NULL,
    content_id integer,
    result_id integer
);


ALTER TABLE public.remarks_resultremark OWNER TO schedule_user;

--
-- Name: remarks_resultremark_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.remarks_resultremark ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.remarks_resultremark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: remarks_userremark; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.remarks_userremark (
    id integer NOT NULL,
    month integer,
    content text,
    user_id integer
);


ALTER TABLE public.remarks_userremark OWNER TO schedule_user;

--
-- Name: remarks_userremark_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.remarks_userremark ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.remarks_userremark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reservation_promiseshift; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.reservation_promiseshift (
    id integer NOT NULL,
    date date NOT NULL,
    shift_type integer,
    hours integer,
    remark character varying(100) NOT NULL,
    user_id integer
);


ALTER TABLE public.reservation_promiseshift OWNER TO schedule_user;

--
-- Name: reservation_promiseshift_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.reservation_promiseshift ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reservation_promiseshift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reservation_reservation; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.reservation_reservation (
    id integer NOT NULL,
    date date NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.reservation_reservation OWNER TO schedule_user;

--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.reservation_reservation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reservation_reservation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: result_afterresult; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.result_afterresult (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE public.result_afterresult OWNER TO schedule_user;

--
-- Name: result_afterresult_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.result_afterresult ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.result_afterresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: result_exchangeapplication; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.result_exchangeapplication (
    id integer NOT NULL,
    date_start date,
    date_end date,
    application_status integer NOT NULL,
    remark character varying(100),
    created_at timestamp with time zone,
    is_confirm boolean,
    deleted boolean,
    shift_apply_id integer,
    shift_receive_id integer,
    station_apply_id integer,
    station_receive_id integer,
    user_apply_id integer,
    user_receive_id integer
);


ALTER TABLE public.result_exchangeapplication OWNER TO schedule_user;

--
-- Name: result_exchangeapplication_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.result_exchangeapplication ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.result_exchangeapplication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: result_historyresult; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.result_historyresult (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE public.result_historyresult OWNER TO schedule_user;

--
-- Name: result_historyresult_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.result_historyresult ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.result_historyresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: result_preresult; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.result_preresult (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE public.result_preresult OWNER TO schedule_user;

--
-- Name: result_preresult_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.result_preresult ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.result_preresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: result_result; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.result_result (
    id integer NOT NULL,
    date date,
    shift_id integer,
    station_id integer,
    user_id integer
);


ALTER TABLE public.result_result OWNER TO schedule_user;

--
-- Name: result_result_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.result_result ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.result_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: result_timeadjustment; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.result_timeadjustment (
    id integer NOT NULL,
    date date,
    hours integer NOT NULL,
    adjustment_type integer NOT NULL,
    adjustment_item integer NOT NULL,
    remark character varying(100) NOT NULL,
    user_id integer
);


ALTER TABLE public.result_timeadjustment OWNER TO schedule_user;

--
-- Name: result_timeadjustment_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.result_timeadjustment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.result_timeadjustment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shift_shift; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.shift_shift (
    id integer NOT NULL,
    name character varying(100),
    shift_type integer,
    code character varying(10) NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    work_hours double precision,
    department_id integer
);


ALTER TABLE public.shift_shift OWNER TO schedule_user;

--
-- Name: shift_shift_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.shift_shift ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.shift_shift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: station_station; Type: TABLE; Schema: public; Owner: schedule_user
--

CREATE TABLE public.station_station (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    department_id integer
);


ALTER TABLE public.station_station OWNER TO schedule_user;

--
-- Name: station_station_id_seq; Type: SEQUENCE; Schema: public; Owner: schedule_user
--

ALTER TABLE public.station_station ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.station_station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: account_customuser; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.account_customuser (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, full_name, job_title, level, role, gender, type_of_user, pregnant, can_be_scheduled, holiday_rest_num, holiday_rest_num_used, special_rest_num, special_rest_num_used, eid, hour_required, hour_realized, onboard_date, compensatory_rest, department_id, starting_month) FROM stdin;
42	pbkdf2_sha256$180000$Y2yut6K7PSX1$jtl+JZrkAV3z9z0YdxkQpSQgPEeayyQnuK0JGIHZq5c=	2020-10-06 15:10:54.319795+00	1	circlepen			lyle.lai@redfalcon-hpc.com	1	1	2020-09-14 05:34:29.376024+00	YiJu Lai	職稱	3	manager	male	1	0	0	10	0	10	0	20190022	100	0	\N	0	4	1
43	pbkdf2_sha256$180000$8vLuu9SQNhDe$8OqJAvaB4BTnjP4f/tsR24pNd7+7O7OYJx0gpL9D/vA=	2020-10-06 10:32:08.596208+00	0	N55639			test@mail.com	1	1	2020-09-14 05:34:49.181485+00	江○華	7B護理長	5	user	female	2	0	1	10	0	10	0	N55639	0	0	2019-10-02	0	4	1
44	pbkdf2_sha256$180000$xwWMAtrUQG3i$aKYhLtyLdxj+FHN6LLbx1Qtfm0p91NRuDejjSANatmE=	2020-09-16 03:30:17.834397+00	0	N00000			test@mail.com	1	1	2020-09-14 05:34:49.331882+00	吳○榕	7A護理長	5	user	female	2	0	1	10	0	10	0	N00000	0	0	2019-10-02	0	4	1
45	pbkdf2_sha256$180000$zqdppHjDrbJl$W0hiJr4AKchaIMeHOTS2ZMVNz+bZEGUUopwdnyNQBUA=	2020-10-05 14:02:05.988319+00	0	N30185			test@mail.com	1	1	2020-09-14 05:34:49.481875+00	何○惠	護理師	1	manager	female	1	0	0	10	0	10	0	N30185	0	0	2018-12-10	0	4	1
46	pbkdf2_sha256$180000$ummUgtLeu9ho$APx9kRYCMjnw9Q8/Vkrgl2YPypwswxnmx4JiLWN00h8=	2020-10-05 14:02:31.202259+00	0	N31268			test@mail.com	0	1	2020-09-14 05:34:49.632836+00	蕭○庭	護理師	1	user	female	1	0	1	10	0	10	0	N31268	0	0	2017-05-22	0	4	1
47	pbkdf2_sha256$180000$nHADfuk9ZF60$2Qsyn0UwuAkPJJfHbWVXb/9SiztmZyr3vmHsxWGPWiQ=	2020-10-06 10:39:44.763808+00	0	N55072			test@mail.com	0	1	2020-09-14 05:34:49.781956+00	趙○萍	護理師	1	user	female	1	0	1	10	0	10	0	N55072	0	0	2018-08-13	0	4	1
48	pbkdf2_sha256$180000$L90SqboxziGO$q6MoGZXxxiZjePwK1M5hxr5sPn8OgvsEYkz5iNd0ABw=	2020-09-18 09:45:55.71421+00	0	N55185			test@mail.com	0	1	2020-09-14 05:34:49.933519+00	廖○欣	護理師	2	user	female	1	0	0	10	0	10	0	N55185	0	0	2018-12-10	0	4	1
49	pbkdf2_sha256$180000$2T6oeoVnNtYr$XN09Nven2pqgqm4zzMO/aUmfzgiwlZPC9xCWNl4JQNs=	2020-09-30 04:55:41.048044+00	0	N55480			test@mail.com	0	1	2020-09-14 05:34:50.08268+00	蘇○君	護理師	1	user	female	0	0	1	10	0	10	0	N55480	0	0	2019-07-10	0	4	1
50	pbkdf2_sha256$180000$PHAWlozXD1Qb$9Aid0Et4ZYnChZZr7JlMVRt8kFg1oPLuO1NeOfu+VqQ=	2020-09-30 06:33:32.470669+00	0	N55502			test@mail.com	0	1	2020-09-14 05:34:50.233449+00	竺○卉	護理師	1	user	female	0	0	1	10	0	10	0	N55502	0	0	2019-07-29	0	4	1
51	pbkdf2_sha256$180000$kxhd1mUMRVBW$yaYGF1LGZwoGJvRd1bjSfwnMTfJbtUnwjQKcArBuL44=	2020-09-30 06:34:22.984091+00	0	N55567			test@mail.com	0	1	2020-09-14 05:34:50.386172+00	徐○馨	護理師	1	user	female	0	0	1	10	0	10	0	N55567	0	0	2019-08-26	0	4	1
52	pbkdf2_sha256$180000$oOGUwFfpZ5Fb$RXLa3/AzOgF+Uowequv03jo29160GZDYOb9fbVJaiho=	\N	0	N55616			test@mail.com	0	1	2020-09-14 05:34:50.537485+00	范○涵	護理師	1	user	female	1	0	0	10	0	10	0	N55616	0	0	2019-09-09	0	4	1
53	pbkdf2_sha256$180000$fY7jrIrSzijE$NmJcfsaIh8I6LH2S6bvSjbqJFO9kP4usj6uhejJp5v4=	2020-09-14 08:26:08.947393+00	0	N55705			test@mail.com	0	1	2020-09-14 05:34:50.686875+00	吳○蕙	護理師	1	user	female	0	0	1	10	0	10	0	N55705	0	0	2019-12-16	0	4	1
54	pbkdf2_sha256$180000$Qc2aZ72B1558$66hmK84DdF2lC+fHkwOttzglxC2yvvKhvSCWJHtwGOg=	2020-09-14 08:20:38.611683+00	0	N55777			test@mail.com	0	1	2020-09-14 05:34:50.838076+00	謝○如	護理師	1	user	female	0	0	1	10	0	10	0	N55777	0	0	2020-05-11	0	4	1
55	pbkdf2_sha256$180000$k7YfKSC1ozgW$CZ+xTfa4VTW0FiXTnO7sGMFbV3SHfb71bshQy3/QXyE=	2020-09-14 08:27:01.74122+00	0	N55776			test@mail.com	0	1	2020-09-14 05:34:50.98675+00	姚○伶	護理師	1	user	female	0	0	1	10	0	10	0	N55776	0	0	2020-05-11	0	4	1
56	pbkdf2_sha256$180000$tycvNxZQIJ7H$ROD0pYtnLYn9ehyV0jd+z+/5W00lQXRCP1HERGVXuKw=	2020-09-14 08:27:12.502813+00	0	N55764			test@mail.com	0	1	2020-09-14 05:34:51.137723+00	李○鑫	護理師	1	user	female	1	0	1	10	0	10	0	N55764	0	0	2020-05-11	0	4	1
57	pbkdf2_sha256$180000$ZcWDCnMTjQpg$gtnqzlH5lOcPI5uQijT7jKoPYa+oJHhbs6kAC2NA0xE=	2020-09-14 08:28:48.809182+00	0	N55792			test@mail.com	0	1	2020-09-14 05:34:51.286644+00	陳○甄	新進護理師	1	user	female	0	0	1	10	0	10	0	N55792	0	0	2020-06-01	0	4	1
58	pbkdf2_sha256$180000$683R2SikBKpH$QRyuzcW1usgJm/qsxmw4//Zvstso00SAQlIV8pXmS6g=	2020-09-21 08:39:23.226125+00	0	N55798			test@mail.com	0	1	2020-09-14 05:34:51.452696+00	謝○蓉	新進護理師	1	user	female	3	0	0	10	0	10	0	N55798	0	0	2020-06-08	0	4	1
59	pbkdf2_sha256$180000$6fMIUoq06wXH$Uono5hMtZsXVg9vWVdA0bvdGN/i2Gid4vd7ibv5FsTk=	2020-10-06 10:32:28.818473+00	0	N55812			test@mail.com	0	1	2020-09-14 05:34:51.615354+00	蔡○亭	新進護理師	1	user	female	3	0	0	10	0	10	0	N55812	0	0	2020-06-28	0	4	1
60	pbkdf2_sha256$180000$asFNabhz6gR7$dW1MAoW2nGUSdh7xDA5hmPyCraDzynuJ91KjcuZ7CKk=	2020-09-14 08:26:51.785465+00	0	N55822			test@mail.com	0	1	2020-09-14 05:34:51.76657+00	陳○瑋	新進護理師	1	user	female	1	0	1	10	0	10	0	N55822	0	0	2020-07-06	0	4	1
61	pbkdf2_sha256$180000$3jjBYCwqxd1L$JmJ0+8lKgYR78GB9KTMEP3RBuJCo7h/rPNRMurMRxrE=	\N	0	N55823			test@mail.com	0	1	2020-09-14 05:34:51.915729+00	吳○盈	新進護理師	1	user	female	3	0	0	10	0	10	0	N55823	0	0	2020-07-06	0	4	1
62	pbkdf2_sha256$180000$gMyillnffrJN$KGZAEiSQM/d9qCZ4ImzDcPTGlPKu78ANcmowgQuSAi8=	2020-09-14 08:30:03.010935+00	0	N55098			test@mail.com	0	1	2020-09-14 05:34:52.066491+00	阮○婷	護理師	1	user	female	1	0	1	10	0	10	0	N55098	0	0	2018-10-08	0	4	1
63	pbkdf2_sha256$180000$YCFPmvMDNrZD$g+R61YFWFuSV4GORcoc7bRwWAoQDpwpmam7y6l/fylU=	2020-09-30 03:54:10.288209+00	0	N55336			test@mail.com	0	1	2020-09-14 05:34:52.215269+00	鄭○勻	護理師	1	user	female	0	0	1	10	0	10	0	N55336	0	0	2019-04-01	0	4	1
64	pbkdf2_sha256$180000$KOQsGt9TeATl$Bv1wQCrtNdO1q27P4k2T1rwApYsYEWgH4cTcgN7PN4w=	2020-09-14 08:29:17.83704+00	0	N55376			test@mail.com	0	1	2020-09-14 05:34:52.36687+00	陳○昕	護理師	1	user	female	0	0	1	10	0	10	0	N55376	0	0	2019-04-22	0	4	1
65	pbkdf2_sha256$180000$onHbztYprQG5$/tw1HDtytF7oOS9/xOhvfAWPyWdYnIw12mJA785nLgM=	2020-09-14 08:29:09.117182+00	0	N55539			test@mail.com	0	1	2020-09-14 05:34:52.515849+00	黃○芳	護理師	1	user	female	0	0	1	10	0	10	0	N55539	0	0	2019-08-19	0	4	1
66	pbkdf2_sha256$180000$T8n7Q7MWel5c$VtPRShzqIoLMClugnV5M2Tcvxatv0GStJi7SLLVDTNE=	2020-09-30 04:03:04.000303+00	0	N55562			test@mail.com	0	1	2020-09-14 05:34:52.666666+00	遲○婷	護理師	1	user	female	0	0	1	10	0	10	0	N55562	0	0	2019-08-26	0	4	1
67	pbkdf2_sha256$180000$axRxeN6SA676$FlJATruPD6/Nqkjw/TfIBP2SGpbm+DL94WpVgm2i+lw=	2020-09-14 08:27:22.533551+00	0	N55679			test@mail.com	0	1	2020-09-14 05:34:52.816068+00	魏○恬	護理師	1	user	female	0	0	1	10	0	10	0	N55679	0	0	2019-11-04	0	4	1
68	pbkdf2_sha256$180000$owQgmTwIk3qg$7JS9o3fkrf0TzOmLi6DGMR3o5D2HD6XEf+lvmhifs7w=	2020-09-14 08:25:57.891948+00	0	N55767			test@mail.com	0	1	2020-09-14 05:34:52.966717+00	黃○茹	護理師	1	user	female	1	0	1	10	0	10	0	N55767	0	0	2020-04-20	0	4	1
69	pbkdf2_sha256$180000$TylHET2HCCiM$pEXjhZW+dR7qDoha3q6d+9rpKw23Vnq0RO7boGYQDMA=	2020-09-14 08:30:13.998561+00	0	N55095			test@mail.com	0	1	2020-09-14 05:34:53.115919+00	曾○琳	護理師	1	user	female	1	0	1	10	0	10	0	N55095	0	0	2018-10-01	0	4	1
70	pbkdf2_sha256$180000$BP0RPhQQZ4l1$S/vr/dd1oN5Oa8ZFA6uOj6A58PAmGRq26daekubUL2A=	\N	0	N55121			test@mail.com	0	1	2020-09-14 05:34:53.266459+00	師○亭	護理師	1	user	female	0	0	0	10	0	10	0	N55121	0	0	2018-11-05	0	4	1
71	pbkdf2_sha256$180000$35FUePiziwMx$ylfW0Us6jkRjd1x4B2zg79YINnQEJHoajdMyhsr0g7I=	2020-09-14 08:29:27.68645+00	0	N55337			test@mail.com	0	1	2020-09-14 05:34:53.417031+00	陳○宇	護理師	1	user	male	0	0	1	10	0	10	0	N55337	0	0	2019-10-25	0	4	1
72	pbkdf2_sha256$180000$2sGBCY1vjnVA$BoaAtO0aAibBXxlfw+MqDtiCL+uurTPeIPjMCMjcfxs=	\N	0	N55429			test@mail.com	0	1	2020-09-14 05:34:53.567902+00	何○昤	護理師	1	user	female	0	0	0	10	0	10	0	N55429	0	0	2019-06-03	0	4	1
73	pbkdf2_sha256$180000$7bMpSYWRyWVr$wJ8FxKHqU7g3YHADeGxoc1PnXD3E38wSGGn5xxN8xE8=	2020-09-14 08:27:43.16223+00	0	N55503			test@mail.com	0	1	2020-09-14 05:34:53.716665+00	林○亭	護理師	1	user	female	0	0	1	10	0	10	0	N55503	0	0	2019-07-29	0	4	1
74	pbkdf2_sha256$180000$BrKxNBlIxyiL$UA2giLeLbczboI75voCI06Bv9r42oHQuwwYqfuvNmxU=	\N	0	New001			test@mail.com	0	1	2020-09-14 05:34:53.867574+00	沈○靜	新進護理師	1	user	female	3	0	1	10	0	10	0	New001	0	0	2020-09-01	0	4	1
75	pbkdf2_sha256$180000$44VBzL0onCML$D7bjxel7MPJiXeF6JM2ZK587H0moGeklYNPEXyV8q9g=	\N	0	New002			test@mail.com	0	1	2020-09-14 05:34:54.017386+00	古○儒	新進護理師	1	user	female	3	0	1	10	0	10	0	New002	0	0	2020-09-01	0	4	1
76	pbkdf2_sha256$180000$obaSC261Cdo5$M0Pesmv0f8ydP0ULbcPBzosrGATftuKQBOO6ek06fuw=	\N	0	New003			test@mail.com	0	1	2020-09-14 05:34:54.168222+00	黃○雅	新進護理師	1	user	female	3	0	1	10	0	10	0	New003	0	0	2020-09-01	0	4	1
77	pbkdf2_sha256$180000$1QhuW79Kmk0r$pn0Hyw9Gpz+gp2tXLN0+Gfz5eyPIa7cGEfs/DtR/TTg=	\N	0	New004			test@mail.com	0	1	2020-09-14 05:34:54.317642+00	陳○澐	新進護理師	1	user	female	3	0	1	10	0	10	0	New004	0	0	2020-09-01	0	4	1
78	pbkdf2_sha256$180000$0NSOiPl4hX8d$2rQjimwuWSFnhiNbINTkdcd3HGZ3co3nnv/vHZmjiy4=	2020-09-30 03:43:30.305282+00	0	N7287			test@mail.com	0	1	2020-09-14 05:34:54.497147+00	董○盈	護理師	1	user	female	0	0	1	10	0	10	0	N7287	0	0	2020-09-01	0	4	1
79	pbkdf2_sha256$180000$UrMNlylDUHto$effx3DQ8bOKB16zjexHiWr07aEpkaMQQE7A1VR5Ui44=	2020-09-14 08:28:26.309533+00	0	N25917			test@mail.com	0	1	2020-09-14 05:34:54.64609+00	陳○頻	護理師	1	user	female	0	0	1	10	0	10	0	N25917	0	0	2020-09-01	0	4	1
80	pbkdf2_sha256$180000$yF3tcKq0Hzxb$1k2UFh9i2XnrOIhqfC7kchKARrwzDXtpK0LPZZ+D/Ww=	2020-09-14 08:27:56.588769+00	0	N55476			test@mail.com	0	1	2020-09-14 05:34:54.797022+00	宋○綺	護理師	2	user	female	1	0	1	10	0	10	0	N55476	0	0	2019-07-01	0	4	1
\.


--
-- Data for Name: account_customuser_groups; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.account_customuser_groups (id, customuser_id, group_id) FROM stdin;
\.


--
-- Data for Name: account_customuser_user_permissions; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.account_customuser_user_permissions (id, customuser_id, permission_id) FROM stdin;
\.


--
-- Data for Name: account_department; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.account_department (id, name, detail, limit_pre_schedule, deadline_pre_schedule, reset, law_rule, schedule_rule, admin_in_schedule, same_day_notice, date_start, start_of_week, can_rest_redday, overtime_rule, month_cycle) FROM stdin;
4	7AB	7AB病房	6	19	0	2	1	0	5	2020-09-01	1	10	0	1
\.


--
-- Data for Name: account_departmentmanager; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.account_departmentmanager (id, department_id, manager_one_id, manager_two_id) FROM stdin;
3	4	42	45
\.


--
-- Data for Name: account_liscense; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.account_liscense (id, name, date, due, source, liscense_pic, liscense_pic_2, user_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_customuser
22	Can change user	6	change_customuser
23	Can delete user	6	delete_customuser
24	Can view user	6	view_customuser
25	Can add department	7	add_department
26	Can change department	7	change_department
27	Can delete department	7	delete_department
28	Can view department	7	view_department
29	Can add liscense	8	add_liscense
30	Can change liscense	8	change_liscense
31	Can delete liscense	8	delete_liscense
32	Can view liscense	8	view_liscense
33	Can add department manager	9	add_departmentmanager
34	Can change department manager	9	change_departmentmanager
35	Can delete department manager	9	delete_departmentmanager
36	Can view department manager	9	view_departmentmanager
37	Can add time adjustment	10	add_timeadjustment
38	Can change time adjustment	10	change_timeadjustment
39	Can delete time adjustment	10	delete_timeadjustment
40	Can view time adjustment	10	view_timeadjustment
41	Can add result	11	add_result
42	Can change result	11	change_result
43	Can delete result	11	delete_result
44	Can view result	11	view_result
45	Can add pre result	12	add_preresult
46	Can change pre result	12	change_preresult
47	Can delete pre result	12	delete_preresult
48	Can view pre result	12	view_preresult
49	Can add history result	13	add_historyresult
50	Can change history result	13	change_historyresult
51	Can delete history result	13	delete_historyresult
52	Can view history result	13	view_historyresult
53	Can add exchange application	14	add_exchangeapplication
54	Can change exchange application	14	change_exchangeapplication
55	Can delete exchange application	14	delete_exchangeapplication
56	Can view exchange application	14	view_exchangeapplication
57	Can add after result	15	add_afterresult
58	Can change after result	15	change_afterresult
59	Can delete after result	15	delete_afterresult
60	Can view after result	15	view_afterresult
61	Can add station	16	add_station
62	Can change station	16	change_station
63	Can delete station	16	delete_station
64	Can view station	16	view_station
65	Can add demand of station	17	add_demandofstation
66	Can change demand of station	17	change_demandofstation
67	Can delete demand of station	17	delete_demandofstation
68	Can view demand of station	17	view_demandofstation
69	Can add demand user table	18	add_demandusertable
70	Can change demand user table	18	change_demandusertable
71	Can delete demand user table	18	delete_demandusertable
72	Can view demand user table	18	view_demandusertable
73	Can add shift	19	add_shift
74	Can change shift	19	change_shift
75	Can delete shift	19	delete_shift
76	Can view shift	19	view_shift
77	Can add h_ calendar	20	add_h_calendar
78	Can change h_ calendar	20	change_h_calendar
79	Can delete h_ calendar	20	delete_h_calendar
80	Can view h_ calendar	20	view_h_calendar
81	Can add remark square	21	add_remarksquare
82	Can change remark square	21	change_remarksquare
83	Can delete remark square	21	delete_remarksquare
84	Can view remark square	21	view_remarksquare
85	Can add result remark	22	add_resultremark
86	Can change result remark	22	change_resultremark
87	Can delete result remark	22	delete_resultremark
88	Can view result remark	22	view_resultremark
89	Can add pre result remark	23	add_preresultremark
90	Can change pre result remark	23	change_preresultremark
91	Can delete pre result remark	23	delete_preresultremark
92	Can view pre result remark	23	view_preresultremark
93	Can add user remark	24	add_userremark
94	Can change user remark	24	change_userremark
95	Can delete user remark	24	delete_userremark
96	Can view user remark	24	view_userremark
97	Can add reservation	25	add_reservation
98	Can change reservation	25	change_reservation
99	Can delete reservation	25	delete_reservation
100	Can view reservation	25	view_reservation
101	Can add promise shift	26	add_promiseshift
102	Can change promise shift	26	change_promiseshift
103	Can delete promise shift	26	delete_promiseshift
104	Can view promise shift	26	view_promiseshift
105	Can add notification	27	add_notification
106	Can change notification	27	change_notification
107	Can delete notification	27	delete_notification
108	Can view notification	27	view_notification
\.


--
-- Data for Name: date_h_calendar; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.date_h_calendar (id, date, attribute, locked, red_day) FROM stdin;
1561	2020-01-01	{"4": "1"}	0	0
1562	2020-01-02	{"4": "1"}	0	0
1563	2020-01-03	{"4": "1"}	0	0
1564	2020-01-04	{"4": "2"}	0	1
1565	2020-01-05	{"4": "2"}	0	1
1566	2020-01-06	{"4": "1"}	0	0
1567	2020-01-07	{"4": "1"}	0	0
1568	2020-01-08	{"4": "1"}	0	0
1569	2020-01-09	{"4": "1"}	0	0
1570	2020-01-10	{"4": "1"}	0	0
1571	2020-01-11	{"4": "2"}	0	1
1572	2020-01-12	{"4": "2"}	0	1
1573	2020-01-13	{"4": "1"}	0	0
1574	2020-01-14	{"4": "1"}	0	0
1575	2020-01-15	{"4": "1"}	0	0
1576	2020-01-16	{"4": "1"}	0	0
1577	2020-01-17	{"4": "1"}	0	0
1578	2020-01-18	{"4": "2"}	0	1
1579	2020-01-19	{"4": "2"}	0	1
1580	2020-01-20	{"4": "1"}	0	0
1581	2020-01-21	{"4": "1"}	0	0
1582	2020-01-22	{"4": "1"}	0	0
1583	2020-01-23	{"4": "1"}	0	0
1584	2020-01-24	{"4": "1"}	0	0
1585	2020-01-25	{"4": "2"}	0	1
1586	2020-01-26	{"4": "2"}	0	1
1587	2020-01-27	{"4": "1"}	0	0
1588	2020-01-28	{"4": "1"}	0	0
1589	2020-01-29	{"4": "1"}	0	0
1590	2020-01-30	{"4": "1"}	0	0
1591	2020-01-31	{"4": "1"}	0	0
1592	2020-02-01	{"4": "2"}	0	1
1593	2020-02-02	{"4": "2"}	0	1
1594	2020-02-03	{"4": "1"}	0	0
1595	2020-02-04	{"4": "1"}	0	0
1596	2020-02-05	{"4": "1"}	0	0
1597	2020-02-06	{"4": "1"}	0	0
1598	2020-02-07	{"4": "1"}	0	0
1599	2020-02-08	{"4": "2"}	0	1
1600	2020-02-09	{"4": "2"}	0	1
1601	2020-02-10	{"4": "1"}	0	0
1602	2020-02-11	{"4": "1"}	0	0
1603	2020-02-12	{"4": "1"}	0	0
1604	2020-02-13	{"4": "1"}	0	0
1605	2020-02-14	{"4": "1"}	0	0
1606	2020-02-15	{"4": "2"}	0	1
1607	2020-02-16	{"4": "2"}	0	1
1608	2020-02-17	{"4": "1"}	0	0
1609	2020-02-18	{"4": "1"}	0	0
1610	2020-02-19	{"4": "1"}	0	0
1611	2020-02-20	{"4": "1"}	0	0
1612	2020-02-21	{"4": "1"}	0	0
1613	2020-02-22	{"4": "2"}	0	1
1614	2020-02-23	{"4": "2"}	0	1
1615	2020-02-24	{"4": "1"}	0	0
1616	2020-02-25	{"4": "1"}	0	0
1617	2020-02-26	{"4": "1"}	0	0
1618	2020-02-27	{"4": "1"}	0	0
1619	2020-02-28	{"4": "1"}	0	0
1620	2020-02-29	{"4": "2"}	0	1
1621	2020-03-01	{"4": "2"}	0	1
1622	2020-03-02	{"4": "1"}	0	0
1623	2020-03-03	{"4": "1"}	0	0
1624	2020-03-04	{"4": "1"}	0	0
1625	2020-03-05	{"4": "1"}	0	0
1626	2020-03-06	{"4": "1"}	0	0
1627	2020-03-07	{"4": "2"}	0	1
1628	2020-03-08	{"4": "2"}	0	1
1629	2020-03-09	{"4": "1"}	0	0
1630	2020-03-10	{"4": "1"}	0	0
1631	2020-03-11	{"4": "1"}	0	0
1632	2020-03-12	{"4": "1"}	0	0
1633	2020-03-13	{"4": "1"}	0	0
1634	2020-03-14	{"4": "2"}	0	1
1635	2020-03-15	{"4": "2"}	0	1
1636	2020-03-16	{"4": "1"}	0	0
1637	2020-03-17	{"4": "1"}	0	0
1638	2020-03-18	{"4": "1"}	0	0
1639	2020-03-19	{"4": "1"}	0	0
1640	2020-03-20	{"4": "1"}	0	0
1641	2020-03-21	{"4": "2"}	0	1
1642	2020-03-22	{"4": "2"}	0	1
1643	2020-03-23	{"4": "1"}	0	0
1644	2020-03-24	{"4": "1"}	0	0
1645	2020-03-25	{"4": "1"}	0	0
1646	2020-03-26	{"4": "1"}	0	0
1647	2020-03-27	{"4": "1"}	0	0
1648	2020-03-28	{"4": "2"}	0	1
1649	2020-03-29	{"4": "2"}	0	1
1650	2020-03-30	{"4": "1"}	0	0
1651	2020-03-31	{"4": "1"}	0	0
1652	2020-04-01	{"4": "1"}	0	0
1653	2020-04-02	{"4": "1"}	0	0
1654	2020-04-03	{"4": "1"}	0	0
1655	2020-04-04	{"4": "2"}	0	1
1656	2020-04-05	{"4": "2"}	0	1
1657	2020-04-06	{"4": "1"}	0	0
1658	2020-04-07	{"4": "1"}	0	0
1659	2020-04-08	{"4": "1"}	0	0
1660	2020-04-09	{"4": "1"}	0	0
1661	2020-04-10	{"4": "1"}	0	0
1662	2020-04-11	{"4": "2"}	0	1
1663	2020-04-12	{"4": "2"}	0	1
1664	2020-04-13	{"4": "1"}	0	0
1665	2020-04-14	{"4": "1"}	0	0
1666	2020-04-15	{"4": "1"}	0	0
1667	2020-04-16	{"4": "1"}	0	0
1668	2020-04-17	{"4": "1"}	0	0
1669	2020-04-18	{"4": "2"}	0	1
1670	2020-04-19	{"4": "2"}	0	1
1671	2020-04-20	{"4": "1"}	0	0
1672	2020-04-21	{"4": "1"}	0	0
1673	2020-04-22	{"4": "1"}	0	0
1674	2020-04-23	{"4": "1"}	0	0
1675	2020-04-24	{"4": "1"}	0	0
1676	2020-04-25	{"4": "2"}	0	1
1677	2020-04-26	{"4": "2"}	0	1
1678	2020-04-27	{"4": "1"}	0	0
1679	2020-04-28	{"4": "1"}	0	0
1680	2020-04-29	{"4": "1"}	0	0
1681	2020-04-30	{"4": "1"}	0	0
1682	2020-05-01	{"4": "1"}	0	0
1683	2020-05-02	{"4": "2"}	0	1
1684	2020-05-03	{"4": "2"}	0	1
1685	2020-05-04	{"4": "1"}	0	0
1686	2020-05-05	{"4": "1"}	0	0
1687	2020-05-06	{"4": "1"}	0	0
1688	2020-05-07	{"4": "1"}	0	0
1689	2020-05-08	{"4": "1"}	0	0
1690	2020-05-09	{"4": "2"}	0	1
1691	2020-05-10	{"4": "2"}	0	1
1692	2020-05-11	{"4": "1"}	0	0
1693	2020-05-12	{"4": "1"}	0	0
1694	2020-05-13	{"4": "1"}	0	0
1695	2020-05-14	{"4": "1"}	0	0
1696	2020-05-15	{"4": "1"}	0	0
1697	2020-05-16	{"4": "2"}	0	1
1698	2020-05-17	{"4": "2"}	0	1
1699	2020-05-18	{"4": "1"}	0	0
1700	2020-05-19	{"4": "1"}	0	0
1701	2020-05-20	{"4": "1"}	0	0
1702	2020-05-21	{"4": "1"}	0	0
1703	2020-05-22	{"4": "1"}	0	0
1704	2020-05-23	{"4": "2"}	0	1
1705	2020-05-24	{"4": "2"}	0	1
1706	2020-05-25	{"4": "1"}	0	0
1707	2020-05-26	{"4": "1"}	0	0
1708	2020-05-27	{"4": "1"}	0	0
1709	2020-05-28	{"4": "1"}	0	0
1710	2020-05-29	{"4": "1"}	0	0
1711	2020-05-30	{"4": "2"}	0	1
1712	2020-05-31	{"4": "2"}	0	1
1713	2020-06-01	{"4": "1"}	0	0
1714	2020-06-02	{"4": "1"}	0	0
1715	2020-06-03	{"4": "1"}	0	0
1716	2020-06-04	{"4": "1"}	0	0
1717	2020-06-05	{"4": "1"}	0	0
1718	2020-06-06	{"4": "2"}	0	1
1719	2020-06-07	{"4": "2"}	0	1
1720	2020-06-08	{"4": "1"}	0	0
1721	2020-06-09	{"4": "1"}	0	0
1722	2020-06-10	{"4": "1"}	0	0
1723	2020-06-11	{"4": "1"}	0	0
1724	2020-06-12	{"4": "1"}	0	0
1725	2020-06-13	{"4": "2"}	0	1
1726	2020-06-14	{"4": "2"}	0	1
1727	2020-06-15	{"4": "1"}	0	0
1728	2020-06-16	{"4": "1"}	0	0
1729	2020-06-17	{"4": "1"}	0	0
1730	2020-06-18	{"4": "1"}	0	1
1731	2020-06-19	{"4": "1"}	0	0
1732	2020-06-20	{"4": "2"}	0	1
1733	2020-06-21	{"4": "2"}	0	1
1734	2020-06-22	{"4": "1"}	0	0
1735	2020-06-23	{"4": "1"}	0	0
1736	2020-06-24	{"4": "1"}	0	0
1737	2020-06-25	{"4": "1"}	0	0
1738	2020-06-26	{"4": "1"}	0	0
1739	2020-06-27	{"4": "2"}	0	1
1740	2020-06-28	{"4": "2"}	0	1
1741	2020-06-29	{"4": "1"}	0	0
1742	2020-06-30	{"4": "1"}	0	0
1743	2020-07-01	{"4": "1"}	0	0
1744	2020-07-02	{"4": "1"}	0	0
1745	2020-07-03	{"4": "1"}	0	0
1746	2020-07-04	{"4": "2"}	0	1
1747	2020-07-05	{"4": "2"}	0	1
1748	2020-07-06	{"4": "1"}	0	0
1749	2020-07-07	{"4": "1"}	0	0
1750	2020-07-08	{"4": "1"}	0	0
1751	2020-07-09	{"4": "1"}	0	0
1752	2020-07-10	{"4": "1"}	0	0
1753	2020-07-11	{"4": "2"}	0	1
1754	2020-07-12	{"4": "2"}	0	1
1755	2020-07-13	{"4": "1"}	0	0
1756	2020-07-14	{"4": "1"}	0	0
1757	2020-07-15	{"4": "1"}	0	0
1758	2020-07-16	{"4": "1"}	0	0
1759	2020-07-17	{"4": "1"}	0	0
1760	2020-07-18	{"4": "2"}	0	1
1761	2020-07-19	{"4": "2"}	0	1
1762	2020-07-20	{"4": "1"}	0	0
1763	2020-07-21	{"4": "1"}	0	0
1764	2020-07-22	{"4": "1"}	0	0
1765	2020-07-23	{"4": "1"}	0	0
1766	2020-07-24	{"4": "1"}	0	0
1767	2020-07-25	{"4": "2"}	0	1
1768	2020-07-26	{"4": "2"}	0	1
1769	2020-07-27	{"4": "1"}	0	0
1770	2020-07-28	{"4": "1"}	0	0
1771	2020-07-29	{"4": "1"}	0	0
1772	2020-07-30	{"4": "1"}	0	0
1773	2020-07-31	{"4": "1"}	0	0
1774	2020-08-01	{"4": "2"}	0	1
1775	2020-08-02	{"4": "2"}	0	1
1776	2020-08-03	{"4": "1"}	0	0
1777	2020-08-04	{"4": "1"}	0	0
1778	2020-08-05	{"4": "1"}	0	0
1779	2020-08-06	{"4": "1"}	0	0
1780	2020-08-07	{"4": "1"}	0	0
1781	2020-08-08	{"4": "2"}	0	1
1782	2020-08-09	{"4": "2"}	0	1
1783	2020-08-10	{"4": "1"}	0	0
1784	2020-08-11	{"4": "1"}	0	0
1785	2020-08-12	{"4": "1"}	0	0
1786	2020-08-13	{"4": "1"}	0	0
1787	2020-08-14	{"4": "1"}	0	0
1788	2020-08-15	{"4": "2"}	0	1
1789	2020-08-16	{"4": "2"}	0	1
1790	2020-08-17	{"4": "1"}	0	0
1791	2020-08-18	{"4": "1"}	0	0
1792	2020-08-19	{"4": "1"}	0	0
1793	2020-08-20	{"4": "1"}	0	0
1794	2020-08-21	{"4": "1"}	0	0
1795	2020-08-22	{"4": "2"}	0	1
1796	2020-08-23	{"4": "2"}	0	1
1797	2020-08-24	{"4": "1"}	0	0
1798	2020-08-25	{"4": "1"}	0	0
1799	2020-08-26	{"4": "1"}	0	0
1800	2020-08-27	{"4": "1"}	0	0
1801	2020-08-28	{"4": "1"}	0	0
1802	2020-08-29	{"4": "2"}	0	1
1803	2020-08-30	{"4": "2"}	0	1
1804	2020-08-31	{"4": "1"}	0	0
1805	2020-09-01	{"4": "1"}	0	1
1806	2020-09-02	{"4": "1"}	0	0
1807	2020-09-03	{"4": "1"}	0	0
1808	2020-09-04	{"4": "1"}	0	0
1809	2020-09-05	{"4": "1"}	0	1
1810	2020-09-06	{"4": "0"}	0	1
1811	2020-09-07	{"4": "1"}	0	0
1812	2020-09-08	{"4": "1"}	0	0
1813	2020-09-09	{"4": "1"}	0	0
1814	2020-09-10	{"4": "1"}	0	0
1815	2020-09-11	{"4": "1"}	0	0
1816	2020-09-12	{"4": "1"}	0	1
1817	2020-09-13	{"4": "1"}	0	1
1818	2020-09-14	{"4": "2"}	0	0
1819	2020-09-15	{"4": "2"}	0	0
1820	2020-09-16	{"4": "2"}	0	0
1821	2020-09-17	{"4": "2"}	0	0
1822	2020-09-18	{"4": "2"}	0	0
1823	2020-09-19	{"4": "2"}	0	1
1824	2020-09-20	{"4": "2"}	0	1
1825	2020-09-21	{"4": "2"}	0	0
1826	2020-09-22	{"4": "2"}	0	0
1827	2020-09-23	{"4": "2"}	0	0
1828	2020-09-24	{"4": "2"}	0	0
1829	2020-09-25	{"4": "2"}	0	0
1830	2020-09-26	{"4": "2"}	0	1
1831	2020-09-27	{"4": "2"}	0	1
1832	2020-09-28	{"4": "2"}	0	0
1833	2020-09-29	{"4": "2"}	0	0
1834	2020-09-30	{"4": "2"}	0	0
1835	2020-10-01	{"4": "1"}	0	0
1836	2020-10-02	{"4": "1"}	0	0
1837	2020-10-03	{"4": "2"}	0	1
1838	2020-10-04	{"4": "2"}	0	1
1839	2020-10-05	{"4": "1"}	0	0
1840	2020-10-06	{"4": "1"}	0	0
1841	2020-10-07	{"4": "1"}	0	0
1842	2020-10-08	{"4": "1"}	0	0
1843	2020-10-09	{"4": "1"}	0	0
1844	2020-10-10	{"4": "2"}	0	1
1845	2020-10-11	{"4": "2"}	0	1
1846	2020-10-12	{"4": "1"}	0	0
1847	2020-10-13	{"4": "1"}	0	0
1848	2020-10-14	{"4": "1"}	0	0
1849	2020-10-15	{"4": "1"}	0	0
1850	2020-10-16	{"4": "1"}	0	0
1851	2020-10-17	{"4": "2"}	0	1
1852	2020-10-18	{"4": "2"}	0	1
1853	2020-10-19	{"4": "1"}	0	0
1854	2020-10-20	{"4": "1"}	0	0
1855	2020-10-21	{"4": "1"}	0	0
1856	2020-10-22	{"4": "1"}	0	0
1857	2020-10-23	{"4": "1"}	0	0
1858	2020-10-24	{"4": "2"}	0	1
1859	2020-10-25	{"4": "2"}	0	1
1860	2020-10-26	{"4": "1"}	0	0
1861	2020-10-27	{"4": "1"}	0	0
1862	2020-10-28	{"4": "1"}	0	0
1863	2020-10-29	{"4": "1"}	0	0
1864	2020-10-30	{"4": "1"}	0	0
1865	2020-10-31	{"4": "2"}	0	1
1866	2020-11-01	{"4": "1"}	0	1
1867	2020-11-02	{"4": "1"}	0	0
1868	2020-11-03	{"4": "1"}	0	0
1869	2020-11-04	{"4": "1"}	0	0
1870	2020-11-05	{"4": "1"}	0	0
1871	2020-11-06	{"4": "1"}	0	0
1872	2020-11-07	{"4": "1"}	0	1
1873	2020-11-08	{"4": "1"}	0	1
1874	2020-11-09	{"4": "1"}	0	0
1875	2020-11-10	{"4": "1"}	0	0
1876	2020-11-11	{"4": "1"}	0	0
1877	2020-11-12	{"4": "1"}	0	0
1878	2020-11-13	{"4": "1"}	0	0
1879	2020-11-14	{"4": "2"}	0	1
1880	2020-11-15	{"4": "2"}	0	1
1881	2020-11-16	{"4": "2"}	0	0
1882	2020-11-17	{"4": "2"}	0	0
1883	2020-11-18	{"4": "2"}	0	0
1884	2020-11-19	{"4": "2"}	0	0
1885	2020-11-20	{"4": "2"}	0	0
1886	2020-11-21	{"4": "2"}	0	1
1887	2020-11-22	{"4": "2"}	0	1
1888	2020-11-23	{"4": "2"}	0	0
1889	2020-11-24	{"4": "2"}	0	0
1890	2020-11-25	{"4": "2"}	0	0
1891	2020-11-26	{"4": "2"}	0	0
1892	2020-11-27	{"4": "2"}	0	0
1893	2020-11-28	{"4": "2"}	0	1
1894	2020-11-29	{"4": "2"}	0	1
1895	2020-11-30	{"4": "2"}	0	0
1896	2020-12-01	{"4": "1"}	0	0
1897	2020-12-02	{"4": "1"}	0	0
1898	2020-12-03	{"4": "1"}	0	0
1899	2020-12-04	{"4": "1"}	0	0
1900	2020-12-05	{"4": "1"}	0	1
1901	2020-12-06	{"4": "1"}	0	1
1902	2020-12-07	{"4": "1"}	0	0
1903	2020-12-08	{"4": "1"}	0	0
1904	2020-12-09	{"4": "1"}	0	0
1905	2020-12-10	{"4": "1"}	0	0
1906	2020-12-11	{"4": "1"}	0	0
1907	2020-12-12	{"4": "1"}	0	1
1908	2020-12-13	{"4": "1"}	0	1
1909	2020-12-14	{"4": "1"}	0	0
1910	2020-12-15	{"4": "1"}	0	0
1911	2020-12-16	{"4": "2"}	0	0
1912	2020-12-17	{"4": "2"}	0	0
1913	2020-12-18	{"4": "2"}	0	0
1914	2020-12-19	{"4": "2"}	0	1
1915	2020-12-20	{"4": "2"}	0	1
1916	2020-12-21	{"4": "2"}	0	0
1917	2020-12-22	{"4": "2"}	0	0
1918	2020-12-23	{"4": "2"}	0	0
1919	2020-12-24	{"4": "2"}	0	0
1920	2020-12-25	{"4": "2"}	0	0
1921	2020-12-26	{"4": "2"}	0	1
1922	2020-12-27	{"4": "2"}	0	1
1923	2020-12-28	{"4": "2"}	0	0
1924	2020-12-29	{"4": "2"}	0	0
1925	2020-12-30	{"4": "2"}	0	0
1926	2020-12-31	{"4": "2"}	0	0
1927	2021-01-01	{"4": "0"}	0	1
1928	2021-01-02	{"4": "1"}	0	1
1929	2021-01-03	{"4": "1"}	0	1
1930	2021-01-04	{"4": "1"}	0	0
1931	2021-01-05	{"4": "1"}	0	0
1932	2021-01-06	{"4": "1"}	0	0
1933	2021-01-07	{"4": "1"}	0	0
1934	2021-01-08	{"4": "1"}	0	0
1935	2021-01-09	{"4": "1"}	0	1
1936	2021-01-10	{"4": "1"}	0	1
1937	2021-01-11	{"4": "1"}	0	0
1938	2021-01-12	{"4": "1"}	0	0
1939	2021-01-13	{"4": "1"}	0	0
1940	2021-01-14	{"4": "2"}	0	0
1941	2021-01-15	{"4": "2"}	0	0
1942	2021-01-16	{"4": "2"}	0	1
1943	2021-01-17	{"4": "2"}	0	1
1944	2021-01-18	{"4": "2"}	0	0
1945	2021-01-19	{"4": "2"}	0	0
1946	2021-01-20	{"4": "2"}	0	0
1947	2021-01-21	{"4": "2"}	0	0
1948	2021-01-22	{"4": "2"}	0	0
1949	2021-01-23	{"4": "2"}	0	1
1950	2021-01-24	{"4": "2"}	0	1
1951	2021-01-25	{"4": "2"}	0	0
1952	2021-01-26	{"4": "2"}	0	0
1953	2021-01-27	{"4": "2"}	0	0
1954	2021-01-28	{"4": "2"}	0	0
1955	2021-01-29	{"4": "2"}	0	0
1956	2021-01-30	{"4": "2"}	0	1
1957	2021-01-31	{"4": "2"}	0	1
1958	2021-02-01	{"4": "1"}	0	0
1959	2021-02-02	{"4": "1"}	0	0
1960	2021-02-03	{"4": "1"}	0	0
1961	2021-02-04	{"4": "1"}	0	0
1962	2021-02-05	{"4": "1"}	0	0
1963	2021-02-06	{"4": "1"}	0	1
1964	2021-02-07	{"4": "1"}	0	1
1965	2021-02-08	{"4": "1"}	0	0
1966	2021-02-09	{"4": "1"}	0	0
1967	2021-02-10	{"4": "1"}	0	0
1968	2021-02-11	{"4": "1"}	0	1
1969	2021-02-12	{"4": "0"}	0	1
1970	2021-02-13	{"4": "0"}	0	1
1971	2021-02-14	{"4": "0"}	0	1
1972	2021-02-15	{"4": "2"}	0	1
1973	2021-02-16	{"4": "2"}	0	1
1974	2021-02-17	{"4": "2"}	0	0
1975	2021-02-18	{"4": "2"}	0	0
1976	2021-02-19	{"4": "2"}	0	0
1977	2021-02-20	{"4": "2"}	0	1
1978	2021-02-21	{"4": "2"}	0	1
1979	2021-02-22	{"4": "2"}	0	0
1980	2021-02-23	{"4": "2"}	0	0
1981	2021-02-24	{"4": "2"}	0	0
1982	2021-02-25	{"4": "2"}	0	0
1983	2021-02-26	{"4": "2"}	0	0
1984	2021-02-27	{"4": "2"}	0	1
1985	2021-02-28	{"4": "2"}	0	1
1986	2021-03-01	{"4": "1"}	0	0
1987	2021-03-02	{"4": "1"}	0	0
1988	2021-03-03	{"4": "1"}	0	0
1989	2021-03-04	{"4": "1"}	0	0
1990	2021-03-05	{"4": "1"}	0	0
1991	2021-03-06	{"4": "2"}	0	1
1992	2021-03-07	{"4": "2"}	0	1
1993	2021-03-08	{"4": "1"}	0	0
1994	2021-03-09	{"4": "1"}	0	0
1995	2021-03-10	{"4": "1"}	0	0
1996	2021-03-11	{"4": "1"}	0	0
1997	2021-03-12	{"4": "1"}	0	0
1998	2021-03-13	{"4": "2"}	0	1
1999	2021-03-14	{"4": "2"}	0	1
2000	2021-03-15	{"4": "1"}	0	0
2001	2021-03-16	{"4": "1"}	0	0
2002	2021-03-17	{"4": "1"}	0	0
2003	2021-03-18	{"4": "1"}	0	0
2004	2021-03-19	{"4": "1"}	0	0
2005	2021-03-20	{"4": "2"}	0	1
2006	2021-03-21	{"4": "2"}	0	1
2007	2021-03-22	{"4": "1"}	0	0
2008	2021-03-23	{"4": "1"}	0	0
2009	2021-03-24	{"4": "1"}	0	0
2010	2021-03-25	{"4": "1"}	0	0
2011	2021-03-26	{"4": "1"}	0	0
2012	2021-03-27	{"4": "2"}	0	1
2013	2021-03-28	{"4": "2"}	0	1
2014	2021-03-29	{"4": "1"}	0	0
2015	2021-03-30	{"4": "1"}	0	0
2016	2021-03-31	{"4": "1"}	0	0
2017	2021-04-01	{"4": "1"}	0	0
2018	2021-04-02	{"4": "1"}	0	0
2019	2021-04-03	{"4": "1"}	0	1
2020	2021-04-04	{"4": "1"}	0	1
2021	2021-04-05	{"4": "1"}	0	0
2022	2021-04-06	{"4": "1"}	0	0
2023	2021-04-07	{"4": "1"}	0	0
2024	2021-04-08	{"4": "1"}	0	0
2025	2021-04-09	{"4": "1"}	0	0
2026	2021-04-10	{"4": "1"}	0	1
2027	2021-04-11	{"4": "1"}	0	1
2028	2021-04-12	{"4": "1"}	0	0
2029	2021-04-13	{"4": "1"}	0	0
2030	2021-04-14	{"4": "2"}	0	0
2031	2021-04-15	{"4": "2"}	0	0
2032	2021-04-16	{"4": "2"}	0	0
2033	2021-04-17	{"4": "2"}	0	1
2034	2021-04-18	{"4": "2"}	0	1
2035	2021-04-19	{"4": "2"}	0	0
2036	2021-04-20	{"4": "2"}	0	0
2037	2021-04-21	{"4": "2"}	0	0
2038	2021-04-22	{"4": "2"}	0	0
2039	2021-04-23	{"4": "2"}	0	0
2040	2021-04-24	{"4": "2"}	0	1
2041	2021-04-25	{"4": "2"}	0	1
2042	2021-04-26	{"4": "2"}	0	0
2043	2021-04-27	{"4": "2"}	0	0
2044	2021-04-28	{"4": "2"}	0	0
2045	2021-04-29	{"4": "2"}	0	0
2046	2021-04-30	{"4": "2"}	0	0
2047	2021-05-01	{"4": "2"}	0	1
2048	2021-05-02	{"4": "2"}	0	1
2049	2021-05-03	{"4": "1"}	0	0
2050	2021-05-04	{"4": "1"}	0	0
2051	2021-05-05	{"4": "1"}	0	0
2052	2021-05-06	{"4": "1"}	0	0
2053	2021-05-07	{"4": "1"}	0	0
2054	2021-05-08	{"4": "2"}	0	1
2055	2021-05-09	{"4": "2"}	0	1
2056	2021-05-10	{"4": "1"}	0	0
2057	2021-05-11	{"4": "1"}	0	0
2058	2021-05-12	{"4": "1"}	0	0
2059	2021-05-13	{"4": "1"}	0	0
2060	2021-05-14	{"4": "1"}	0	0
2061	2021-05-15	{"4": "2"}	0	1
2062	2021-05-16	{"4": "2"}	0	1
2063	2021-05-17	{"4": "1"}	0	0
2064	2021-05-18	{"4": "1"}	0	0
2065	2021-05-19	{"4": "1"}	0	0
2066	2021-05-20	{"4": "1"}	0	0
2067	2021-05-21	{"4": "1"}	0	0
2068	2021-05-22	{"4": "2"}	0	1
2069	2021-05-23	{"4": "2"}	0	1
2070	2021-05-24	{"4": "1"}	0	0
2071	2021-05-25	{"4": "1"}	0	0
2072	2021-05-26	{"4": "1"}	0	0
2073	2021-05-27	{"4": "1"}	0	0
2074	2021-05-28	{"4": "1"}	0	0
2075	2021-05-29	{"4": "2"}	0	1
2076	2021-05-30	{"4": "2"}	0	1
2077	2021-05-31	{"4": "1"}	0	0
2078	2021-06-01	{"4": "1"}	0	0
2079	2021-06-02	{"4": "1"}	0	0
2080	2021-06-03	{"4": "1"}	0	0
\.


--
-- Data for Name: demand_demandofstation; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.demand_demandofstation (id, level, config1, config2, shift_id, station_id) FROM stdin;
17	1	8	9	80	13
18	2	0	0	80	13
19	1	5	6	81	13
20	2	0	0	81	13
21	1	4	5	83	13
22	2	0	0	83	13
\.


--
-- Data for Name: demand_demandusertable; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.demand_demandusertable (id, demand_id, user_id) FROM stdin;
32	17	64
33	17	65
34	17	51
35	17	57
36	17	71
37	17	78
38	17	79
40	18	47
41	18	69
42	18	46
43	19	63
44	19	67
45	19	73
47	19	66
48	19	55
49	20	56
54	21	53
55	21	54
56	22	68
59	21	49
60	21	50
62	20	62
65	22	80
66	22	60
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-09-18 08:33:09.831813+00	7	上課	3		21	42
2	2020-09-18 08:33:09.835336+00	6	上課	3		21	42
3	2020-09-18 08:33:09.83827+00	5	上課	3		21	42
4	2020-09-21 06:20:31.306835+00	84	國定假日	1	[{"added": {}}]	19	42
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.django_content_type (id, app_label, model) FROM stdin;
6	account	customuser
7	account	department
9	account	departmentmanager
8	account	liscense
1	admin	logentry
3	auth	group
2	auth	permission
4	contenttypes	contenttype
20	date	h_calendar
17	demand	demandofstation
18	demand	demandusertable
27	notifications	notification
23	remarks	preresultremark
21	remarks	remarksquare
22	remarks	resultremark
24	remarks	userremark
26	reservation	promiseshift
25	reservation	reservation
15	result	afterresult
14	result	exchangeapplication
13	result	historyresult
12	result	preresult
11	result	result
10	result	timeadjustment
5	sessions	session
19	shift	shift
16	station	station
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-09-04 03:32:18.259435+00
2	contenttypes	0002_remove_content_type_name	2020-09-04 03:32:18.308744+00
3	auth	0001_initial	2020-09-04 03:32:18.365813+00
4	auth	0002_alter_permission_name_max_length	2020-09-04 03:32:18.546083+00
5	auth	0003_alter_user_email_max_length	2020-09-04 03:32:18.555392+00
6	auth	0004_alter_user_username_opts	2020-09-04 03:32:18.563966+00
7	auth	0005_alter_user_last_login_null	2020-09-04 03:32:18.572467+00
8	auth	0006_require_contenttypes_0002	2020-09-04 03:32:18.575935+00
9	auth	0007_alter_validators_add_error_messages	2020-09-04 03:32:18.583908+00
10	auth	0008_alter_user_username_max_length	2020-09-04 03:32:18.592616+00
11	auth	0009_alter_user_last_name_max_length	2020-09-04 03:32:18.600762+00
12	auth	0010_alter_group_name_max_length	2020-09-04 03:32:18.617277+00
13	auth	0011_update_proxy_permissions	2020-09-04 03:32:18.626035+00
14	account	0001_initial	2020-09-04 03:32:18.840157+00
15	account	0002_auto_20200825_1419	2020-09-04 03:32:19.106415+00
16	admin	0001_initial	2020-09-04 03:32:19.144148+00
17	admin	0002_logentry_remove_auto_add	2020-09-04 03:32:19.2303+00
18	admin	0003_logentry_add_action_flag_choices	2020-09-04 03:32:19.245018+00
19	date	0001_initial	2020-09-04 03:32:19.264848+00
20	station	0001_initial	2020-09-04 03:32:19.292999+00
21	shift	0001_initial	2020-09-04 03:32:19.354597+00
22	demand	0001_initial	2020-09-04 03:32:19.444415+00
23	notifications	0001_initial	2020-09-04 03:32:19.619316+00
24	notifications	0002_auto_20150224_1134	2020-09-04 03:32:19.840357+00
25	notifications	0003_notification_data	2020-09-04 03:32:19.873981+00
26	notifications	0004_auto_20150826_1508	2020-09-04 03:32:19.891685+00
27	notifications	0005_auto_20160504_1520	2020-09-04 03:32:19.909512+00
28	notifications	0006_indexes	2020-09-04 03:32:20.02911+00
29	notifications	0007_add_timestamp_index	2020-09-04 03:32:20.067254+00
30	notifications	0008_index_together_recipient_unread	2020-09-04 03:32:20.099776+00
31	result	0001_initial	2020-09-04 03:32:20.367792+00
32	remarks	0001_initial	2020-09-04 03:32:20.962698+00
33	remarks	0002_auto_20200824_1822	2020-09-04 03:32:21.157289+00
34	reservation	0001_initial	2020-09-04 03:32:21.242109+00
35	reservation	0002_auto_20200827_1447	2020-09-04 03:32:21.334819+00
36	result	0002_auto_20200827_1600	2020-09-04 03:32:21.458038+00
37	sessions	0001_initial	2020-09-04 03:32:21.476511+00
38	shift	0002_auto_20200827_1447	2020-09-04 03:32:21.503155+00
39	shift	0003_shift_code	2020-09-04 03:32:21.558262+00
40	remarks	0003_remarksquare_department	2020-09-18 08:32:09.556562+00
41	account	0003_auto_20200930_1137	2020-09-30 03:37:24.121637+00
42	result	0003_auto_20200930_1137	2020-09-30 03:37:24.220194+00
43	account	0004_customuser_starting_month	2020-10-06 09:51:44.656748+00
44	result	0004_auto_20201006_1751	2020-10-06 09:51:45.377333+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.django_session (session_key, session_data, expire_date) FROM stdin;
3gf57wzivn2f6ofkn7ooyfd7u4fsghik	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-13 01:33:40.465424+00
3xrg2yh0ne2poputxxcae4y7pu7erfhn	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-05 09:30:28.874176+00
4blq6p9u7uhz3dzkiq064v6abzs6xx3o	YTYwZDNlNDU4MmNiMjE1MjRiN2Y2ZTk4NDFhM2QwYjZjNzcxNzliOTp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDBjZDg5MDM4N2M3ODVlMmViYTYyNTJjMzI4NGExZWE5NDBmYjYzNiJ9	2020-10-06 01:44:33.844133+00
4pzxi41s3qc28sgjupafok6af9wm8wgf	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-14 03:37:51.951445+00
5d2hmqogfd8mxrx5u06385n5ur2mpgkx	NjkxMDljMmM3MTliNmM2YzhhYzAwMzczYjU0ZDZhNzc0MTU2N2VlNjp7Il9hdXRoX3VzZXJfaWQiOiI0MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMzI1N2EzZTY5MjA2ZTg1NjBiZWRiYjAwOTkxZTEwYzIzMGQwMzMwNCJ9	2020-09-28 09:40:24.800148+00
5l70fob8lmn7iqjscgrdmptk9klft64u	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-05 08:43:10.176785+00
6cj2hnwwmun62g6h8569ppm69qoomgcf	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-09-30 02:59:31.17821+00
6gsj9rbteo80na4nte0lcy8cq1kw4fdx	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-05 07:20:13.39272+00
6ren84zxtewjah5v4lk9nzwqiuvbiwwj	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-20 15:10:54.323498+00
7af3gcbi6eamjomsvg40r3m30191vnvy	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-09-29 09:26:54.78367+00
7if5siz83evqpc3xxhzht1j4m9ewx8de	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-05 07:59:30.012404+00
859yetf9tcepnr7l1osiq00beaz4ki5a	ZGM3MjBhZDQyNTUzMmY1OTlmM2EyZWI2OGVkMGZiYmZhYmZhZjYyMTp7Il9hdXRoX3VzZXJfaWQiOiI0NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTRlZTI0OTU2ZTQxMmY0YTBhZDliMjAwM2EzYjU0OTNlM2ZhMWE2YiJ9	2020-10-14 06:36:01.285937+00
8urd1ukymuse9jbuyyaxloi3vyypcb3o	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-05 08:38:03.464472+00
986863bd24ttt9w022onmvv2bt05ey18	MjRlYzE0YWM2ZDY2YjQ1YjlmNWFlZjczZmU4Nzg4YzNlMDZiOGZkYjp7Il9hdXRoX3VzZXJfaWQiOiI0NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjdjMmJjYWI3NzQ1YTc4MmRlNmY4YzRmYjFhYjc0NTg1NWRiNWQyZSJ9	2020-10-19 14:02:31.206665+00
9e1w0c78k8vog7sfbv3eeck8fr5fj4jb	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-13 01:49:02.880083+00
d6b945mw54778dl0yl2c73myda0gtopf	NDMxMzIxZTE0OWIwOTExYTVlZGI0NjFmMTZhNTQ1N2FiODk3YmM2Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZTJlNDIwM2JkODkxYjc2NjQyMmFiZGJmMWExZTYxMmZhMmVkYWFhIn0=	2020-09-24 02:18:11.795595+00
fcwlq2xxpz2hlu1agbltym610pbgo8tj	ZDc0MGE1ODM4ZWFkZGZkMTVhNmRmZTNkZTUwNmQ3YTMzMDAxYzBiNDp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ODllODdhM2JlZWU2MGMzZDgxZTg5ZjZmMTIxOGJmNWY5NWI3Nzk0In0=	2020-09-22 11:02:31.537876+00
g7ahn1emnnqjfhy724v70d9ctds59i6b	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-05 05:36:14.53162+00
hpfvwxcjr3xnq9ct5cy01ftc6sr2l2rz	NDMxMzIxZTE0OWIwOTExYTVlZGI0NjFmMTZhNTQ1N2FiODk3YmM2Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZTJlNDIwM2JkODkxYjc2NjQyMmFiZGJmMWExZTYxMmZhMmVkYWFhIn0=	2020-09-26 07:20:32.017664+00
huy1km6903g3bexn1dlxdd7zx6dbo1ii	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-19 03:01:32.798482+00
ijjzvgn7nro0dl01glv3qezeqdgw9q5m	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-02 09:36:50.97833+00
j2o7ah3996dwlue0b7ssjibi1bq3fpms	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-13 09:03:34.155046+00
kh94m2qa3bc8kpaqj1sjdgb2mk0g281g	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-02 09:43:49.348151+00
kwdklo5yoa1vwrz250w9ujxxdtjxs55w	NDMxMzIxZTE0OWIwOTExYTVlZGI0NjFmMTZhNTQ1N2FiODk3YmM2Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZTJlNDIwM2JkODkxYjc2NjQyMmFiZGJmMWExZTYxMmZhMmVkYWFhIn0=	2020-09-23 04:48:22.950354+00
ljyn0jkgm6z595t6o7j4muo6033b5456	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-19 13:46:51.106363+00
ly4op8uohjptne4mjj1loafd75powhnk	NjA4NWNjMzRkNzE0MmViYmEyNWZlYjU2ZDk4NzdhMmFlN2FmMzY0Zjp7Il9hdXRoX3VzZXJfaWQiOiIzOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNGZmMzcwN2RmNmE3NTVmNjY5OWQ1YzllZjZhNGYxMTllYzE2MmViMiJ9	2020-09-21 09:59:51.514009+00
mhm3xhezmedm1vofsjvdbxjnj13c1f4u	MzBkYThiMDMyYzI3NTAwZjEzZTUxYzNjOTRjYTNjOTY2NjVkZTM4ZDp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5YmQ0OTI0ODliODFkMzMxOGE5OTg3N2ExODQxYTVhOTA1YjM4MTM0In0=	2020-09-21 10:38:33.837044+00
mxths7nosq5pmdf5ofrcgrmxwim7kji7	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-19 14:16:02.631179+00
nc45ui5joatln9e3sx6jyv8ybfx5khu2	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-05 07:59:07.340313+00
obkxz90hhvle9ah939fwdrma2xaan7hn	NDMxMzIxZTE0OWIwOTExYTVlZGI0NjFmMTZhNTQ1N2FiODk3YmM2Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZTJlNDIwM2JkODkxYjc2NjQyMmFiZGJmMWExZTYxMmZhMmVkYWFhIn0=	2020-09-22 11:18:46.932782+00
p4pvc296vdvm0lqrc1exlu61h7p9slva	NDMxMzIxZTE0OWIwOTExYTVlZGI0NjFmMTZhNTQ1N2FiODk3YmM2Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZTJlNDIwM2JkODkxYjc2NjQyMmFiZGJmMWExZTYxMmZhMmVkYWFhIn0=	2020-09-23 09:51:18.187503+00
r5555qnwf25cpkcucf30bng16zjbegbx	MjYxZDY4YzdiM2M3ODA1MDFlNTllZmU2NmI5NmY3MmEwNTg1OGE3MDp7Il9hdXRoX3VzZXJfaWQiOiI1OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDg5NjgzZTRjZGQwNjZjZGYzYWZkYzljOGJjYmJiMzRmMGY4MjJlMyJ9	2020-10-20 10:32:28.821487+00
u3ratpalyypwwv6uvtlqf5kedjkw2bqw	YTYwZDNlNDU4MmNiMjE1MjRiN2Y2ZTk4NDFhM2QwYjZjNzcxNzliOTp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDBjZDg5MDM4N2M3ODVlMmViYTYyNTJjMzI4NGExZWE5NDBmYjYzNiJ9	2020-10-06 03:17:27.99794+00
v1p93ue9or3a8cagelkc2ox1fcri9dld	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-14 09:08:48.869487+00
vi6hiisjsh2w6gd6fx8eqm0pc9crd5fx	Yjg1NWQxYTEzNTdjMjllMjkyNzk2NTQwOTY4NDA1ODYxZTljYjc3MDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NzY0ZWVlY2QyNzJlYTBkYTg1MTlkYjRjMWY1YWMyMWJhMzhjNTAyIn0=	2020-09-23 04:07:40.80196+00
wihedbqh6tsajntdbiyebsz64td6d7j5	ZGM3MjBhZDQyNTUzMmY1OTlmM2EyZWI2OGVkMGZiYmZhYmZhZjYyMTp7Il9hdXRoX3VzZXJfaWQiOiI0NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTRlZTI0OTU2ZTQxMmY0YTBhZDliMjAwM2EzYjU0OTNlM2ZhMWE2YiJ9	2020-10-20 10:39:44.7668+00
x9obopojf92ij4nhp2i0zb5iyx6wj022	Njk0YjQyNGI4NWQyNDVmNzFhOTg2YWE1ODRmYjgzNjAyNDg0OWI1MDp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg1OThlMGNhMDA5OWNiYTNiMzQzMDU2NzEwY2I5YWRiYzk5ZjhhMyJ9	2020-10-06 02:19:22.078552+00
y3p7eryv9c3vr57ppawlhcwvnor193dz	MzBkYThiMDMyYzI3NTAwZjEzZTUxYzNjOTRjYTNjOTY2NjVkZTM4ZDp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5YmQ0OTI0ODliODFkMzMxOGE5OTg3N2ExODQxYTVhOTA1YjM4MTM0In0=	2020-09-23 00:49:05.351322+00
\.


--
-- Data for Name: notifications_notification; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.notifications_notification (id, level, unread, actor_object_id, verb, description, target_object_id, action_object_object_id, "timestamp", public, action_object_content_type_id, actor_content_type_id, recipient_id, target_content_type_id, deleted, emailed, data) FROM stdin;
391	info	0	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	42	\N	0	0	\N
392	info	0	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	43	\N	0	0	\N
393	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	44	\N	0	0	\N
394	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	45	\N	0	0	\N
395	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	46	\N	0	0	\N
396	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	47	\N	0	0	\N
397	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	48	\N	0	0	\N
398	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	49	\N	0	0	\N
399	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	50	\N	0	0	\N
400	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	51	\N	0	0	\N
401	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	52	\N	0	0	\N
402	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	53	\N	0	0	\N
403	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	54	\N	0	0	\N
404	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	55	\N	0	0	\N
405	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	56	\N	0	0	\N
406	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	57	\N	0	0	\N
407	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	58	\N	0	0	\N
408	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	59	\N	0	0	\N
409	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	60	\N	0	0	\N
410	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	61	\N	0	0	\N
411	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	62	\N	0	0	\N
412	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	63	\N	0	0	\N
413	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	64	\N	0	0	\N
414	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	65	\N	0	0	\N
415	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	66	\N	0	0	\N
416	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	67	\N	0	0	\N
417	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	68	\N	0	0	\N
418	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	69	\N	0	0	\N
419	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	70	\N	0	0	\N
420	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	71	\N	0	0	\N
421	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	72	\N	0	0	\N
422	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	73	\N	0	0	\N
423	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	74	\N	0	0	\N
424	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	75	\N	0	0	\N
425	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	76	\N	0	0	\N
426	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	77	\N	0	0	\N
427	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	78	\N	0	0	\N
428	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	79	\N	0	0	\N
429	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-14 08:40:54.170199+00	1	\N	6	80	\N	0	0	\N
430	info	0	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	42	\N	0	0	\N
431	info	0	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	43	\N	0	0	\N
432	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	44	\N	0	0	\N
433	info	0	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	45	\N	0	0	\N
434	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	46	\N	0	0	\N
435	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	47	\N	0	0	\N
436	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	48	\N	0	0	\N
437	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	49	\N	0	0	\N
438	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	50	\N	0	0	\N
439	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	51	\N	0	0	\N
440	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	52	\N	0	0	\N
441	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	53	\N	0	0	\N
442	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	54	\N	0	0	\N
443	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	55	\N	0	0	\N
444	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	56	\N	0	0	\N
445	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	57	\N	0	0	\N
446	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	58	\N	0	0	\N
447	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	59	\N	0	0	\N
448	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	60	\N	0	0	\N
449	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	61	\N	0	0	\N
450	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	62	\N	0	0	\N
451	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	63	\N	0	0	\N
452	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	64	\N	0	0	\N
453	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	65	\N	0	0	\N
454	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	66	\N	0	0	\N
455	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	67	\N	0	0	\N
456	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	68	\N	0	0	\N
457	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	69	\N	0	0	\N
458	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	70	\N	0	0	\N
459	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	71	\N	0	0	\N
460	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	72	\N	0	0	\N
461	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	73	\N	0	0	\N
462	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	74	\N	0	0	\N
463	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	75	\N	0	0	\N
464	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	76	\N	0	0	\N
465	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	77	\N	0	0	\N
466	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	78	\N	0	0	\N
467	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	79	\N	0	0	\N
468	info	1	42	下個月班表發佈了！	/results	\N	\N	2020-09-17 01:57:31.643598+00	1	\N	6	80	\N	0	0	\N
\.


--
-- Data for Name: remarks_preresultremark; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.remarks_preresultremark (id, content_id, result_id) FROM stdin;
\.


--
-- Data for Name: remarks_remarksquare; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.remarks_remarksquare (id, content, department_id) FROM stdin;
4	上課	\N
8	aaa	4
9	bbbb2	4
10	cccc	4
\.


--
-- Data for Name: remarks_resultremark; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.remarks_resultremark (id, content_id, result_id) FROM stdin;
\.


--
-- Data for Name: remarks_userremark; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.remarks_userremark (id, month, content, user_id) FROM stdin;
\.


--
-- Data for Name: reservation_promiseshift; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.reservation_promiseshift (id, date, shift_type, hours, remark, user_id) FROM stdin;
8	2020-10-16	0	4		45
9	2020-09-22	3	4		45
10	2020-10-30	7	8		45
11	2020-09-29	0	4		45
12	2020-09-30	7	8		45
14	2020-09-23	3	3	白班	46
16	2020-11-01	0	4		46
17	2020-11-01	0	3		45
18	2020-11-01	1	4		47
\.


--
-- Data for Name: reservation_reservation; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.reservation_reservation (id, date, user_id) FROM stdin;
144	2020-09-17	47
145	2020-09-18	47
146	2020-09-06	69
147	2020-09-07	69
148	2020-09-08	69
149	2020-09-14	69
150	2020-09-08	62
151	2020-09-09	62
152	2020-09-14	62
153	2020-09-06	46
154	2020-09-13	46
155	2020-09-14	46
156	2020-09-19	46
157	2020-09-20	46
160	2020-09-21	64
161	2020-09-22	64
162	2020-09-10	65
163	2020-09-11	65
164	2020-09-10	51
165	2020-09-11	51
166	2020-09-29	57
167	2020-09-30	57
168	2020-09-13	78
169	2020-09-19	78
170	2020-09-22	78
172	2020-09-06	79
173	2020-09-07	79
174	2020-09-08	79
175	2020-09-29	63
176	2020-09-30	63
179	2020-09-11	80
180	2020-09-12	80
182	2020-09-10	73
183	2020-09-10	66
184	2020-09-15	66
185	2020-09-14	67
186	2020-09-08	56
187	2020-09-09	56
188	2020-09-19	55
189	2020-09-20	55
190	2020-09-17	60
191	2020-09-18	60
192	2020-09-25	45
193	2020-09-26	45
197	2020-09-10	49
198	2020-09-16	49
199	2020-09-17	49
200	2020-09-13	50
201	2020-09-14	50
203	2020-09-20	53
204	2020-09-21	53
205	2020-09-25	68
206	2020-09-26	68
208	2020-09-09	54
209	2020-09-13	54
210	2020-11-09	54
211	2020-11-13	54
212	2020-11-25	68
213	2020-11-26	68
214	2020-11-20	53
215	2020-11-21	53
216	2020-11-13	50
217	2020-11-14	50
218	2020-11-10	49
219	2020-11-16	49
220	2020-11-17	49
221	2020-11-25	45
222	2020-11-26	45
223	2020-11-17	60
224	2020-11-18	60
225	2020-11-19	55
226	2020-11-20	55
227	2020-11-08	56
228	2020-11-09	56
229	2020-11-14	67
230	2020-11-10	66
231	2020-11-15	66
232	2020-11-10	73
235	2020-11-11	80
236	2020-11-12	80
237	2020-11-29	63
238	2020-11-30	63
239	2020-11-06	79
240	2020-11-07	79
241	2020-11-08	79
242	2020-11-13	78
243	2020-11-19	78
244	2020-11-22	78
245	2020-11-29	57
246	2020-11-30	57
247	2020-11-10	51
248	2020-11-11	51
249	2020-11-10	65
250	2020-11-11	65
251	2020-11-21	64
252	2020-11-22	64
253	2020-11-10	71
254	2020-11-11	71
255	2020-09-10	71
256	2020-09-11	71
257	2020-11-06	46
258	2020-11-13	46
259	2020-11-14	46
260	2020-11-19	46
261	2020-11-20	46
262	2020-11-08	62
263	2020-11-09	62
264	2020-11-14	62
265	2020-11-06	69
266	2020-11-07	69
267	2020-11-08	69
268	2020-11-14	69
269	2020-11-17	47
270	2020-11-18	47
304	2020-10-05	47
305	2020-10-07	47
\.


--
-- Data for Name: result_afterresult; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.result_afterresult (id, date, shift_id, station_id, user_id) FROM stdin;
\.


--
-- Data for Name: result_exchangeapplication; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.result_exchangeapplication (id, date_start, date_end, application_status, remark, user_apply_id, user_receive_id, created_at, deleted, is_confirm, shift_apply_id, shift_receive_id, station_apply_id, station_receive_id) FROM stdin;
1	2020-10-03	2020-10-04	3	\N	50	63	2020-09-30 04:02:44.446135+00	0	1	\N	\N	\N	\N
2	2020-10-09	2020-10-10	2	鄭○勻: it's not mine	50	66	2020-09-30 04:02:38.004756+00	0	0	\N	\N	\N	\N
3	2020-10-03	2020-10-04	0	\N	66	50	2020-09-30 04:05:14.236864+00	0	0	\N	\N	\N	\N
\.


--
-- Data for Name: result_historyresult; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.result_historyresult (id, date, shift_id, station_id, user_id) FROM stdin;
\.


--
-- Data for Name: result_preresult; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.result_preresult (id, date, shift_id, station_id, user_id) FROM stdin;
102780	2021-04-01	80	13	62
102781	2021-04-02	80	13	62
102782	2021-04-03	63	13	62
102783	2021-04-04	64	14	62
102784	2021-04-05	80	13	62
102785	2021-04-06	80	13	62
102786	2021-04-07	80	13	62
102787	2021-04-08	63	14	62
102788	2021-04-09	63	13	62
102789	2021-04-10	80	13	62
102790	2021-04-11	80	13	62
102791	2021-04-12	80	13	62
102792	2021-04-13	80	13	62
102793	2021-04-14	80	13	62
102794	2021-04-15	80	13	62
102795	2021-04-16	64	14	62
102796	2021-04-17	80	13	62
102797	2021-04-18	80	13	62
102798	2021-04-19	80	13	62
102799	2021-04-20	64	13	62
102800	2021-04-21	80	13	62
102801	2021-04-22	80	13	62
102802	2021-04-23	80	13	62
102803	2021-04-24	80	13	62
102804	2021-04-25	63	14	62
102805	2021-04-26	80	13	62
102806	2021-04-27	80	13	62
102807	2021-04-28	80	13	62
102808	2021-04-29	80	13	62
102809	2021-04-30	80	13	62
102810	2021-04-01	80	13	47
102811	2021-04-02	80	13	47
102812	2021-04-03	80	13	47
102813	2021-04-04	80	13	47
102814	2021-04-05	64	14	47
102815	2021-04-06	63	14	47
102816	2021-04-07	80	13	47
102817	2021-04-08	80	13	47
102818	2021-04-09	80	13	47
102819	2021-04-10	63	14	47
102820	2021-04-11	64	14	47
102821	2021-04-12	63	14	47
102822	2021-04-13	80	13	47
102823	2021-04-14	80	13	47
102824	2021-04-15	80	13	47
102825	2021-04-16	80	13	47
102826	2021-04-17	80	13	47
102827	2021-04-18	80	13	47
102828	2021-04-19	64	14	47
102829	2021-04-20	80	13	47
102830	2021-04-21	80	13	47
102831	2021-04-22	80	13	47
102832	2021-04-23	80	13	47
102833	2021-04-24	80	13	47
102834	2021-04-25	64	13	47
102835	2021-04-26	80	13	47
102836	2021-04-27	80	13	47
102837	2021-04-28	80	13	47
102838	2021-04-29	80	13	47
102839	2021-04-30	63	14	47
102840	2021-04-01	64	14	69
102841	2021-04-02	63	14	69
102842	2021-04-03	63	14	69
102843	2021-04-04	80	13	69
102844	2021-04-05	80	13	69
102845	2021-04-06	80	13	69
102846	2021-04-07	64	14	69
102847	2021-04-08	63	14	69
102848	2021-04-09	80	13	69
102849	2021-04-10	80	13	69
102850	2021-04-11	80	13	69
102851	2021-04-12	80	13	69
102852	2021-04-13	80	13	69
102853	2021-04-14	80	13	69
102854	2021-04-15	64	14	69
102855	2021-04-16	80	13	69
102856	2021-04-17	80	13	69
102857	2021-04-18	80	13	69
102858	2021-04-19	80	13	69
102859	2021-04-20	63	14	69
102860	2021-04-21	80	13	69
102861	2021-04-22	80	13	69
102862	2021-04-23	80	13	69
102863	2021-04-24	80	13	69
102864	2021-04-25	80	13	69
102865	2021-04-26	80	13	69
102866	2021-04-27	64	14	69
102867	2021-04-28	80	13	69
102868	2021-04-29	80	13	69
102869	2021-04-30	80	13	69
102870	2021-04-01	64	14	46
102871	2021-04-02	63	14	46
102872	2021-04-03	80	13	46
102873	2021-04-04	80	13	46
102874	2021-04-05	80	13	46
102875	2021-04-06	80	13	46
102876	2021-04-07	80	13	46
102877	2021-04-08	80	13	46
102878	2021-04-09	64	14	46
102879	2021-04-10	80	13	46
102880	2021-04-11	80	13	46
102881	2021-04-12	80	13	46
102882	2021-04-13	63	14	46
102883	2021-04-14	80	13	46
102884	2021-04-15	80	13	46
102885	2021-04-16	80	13	46
102886	2021-04-17	64	14	46
102887	2021-04-18	80	13	46
102888	2021-04-19	80	13	46
102889	2021-04-20	80	13	46
102890	2021-04-21	80	13	46
102891	2021-04-22	80	13	46
102892	2021-04-23	80	13	46
102893	2021-04-24	64	14	46
102894	2021-04-25	80	13	46
102895	2021-04-26	80	13	46
102896	2021-04-27	80	13	46
102897	2021-04-28	80	13	46
102898	2021-04-29	63	14	46
102899	2021-04-30	80	13	46
102900	2021-04-01	64	13	64
102901	2021-04-02	80	13	64
102902	2021-04-03	80	13	64
102903	2021-04-04	64	13	64
102904	2021-04-05	80	13	64
102905	2021-04-06	64	14	64
102906	2021-04-07	63	14	64
102907	2021-04-08	80	13	64
102908	2021-04-09	80	13	64
102909	2021-04-10	80	13	64
102910	2021-04-11	63	14	64
102911	2021-04-12	80	13	64
102912	2021-04-13	80	13	64
102913	2021-04-14	80	13	64
102914	2021-04-15	80	13	64
102915	2021-04-16	80	13	64
102916	2021-04-17	80	13	64
102917	2021-04-18	63	14	64
102918	2021-04-19	80	13	64
102919	2021-04-20	80	13	64
102920	2021-04-21	80	13	64
102921	2021-04-22	80	13	64
102922	2021-04-23	80	13	64
102923	2021-04-24	64	14	64
102924	2021-04-25	80	13	64
102925	2021-04-26	80	13	64
102926	2021-04-27	80	13	64
102927	2021-04-28	80	13	64
102928	2021-04-29	63	13	64
102929	2021-04-30	80	13	64
102930	2021-04-01	80	13	65
102931	2021-04-02	80	13	65
102932	2021-04-03	80	13	65
102933	2021-04-04	64	14	65
102934	2021-04-05	63	14	65
102935	2021-04-06	80	13	65
102936	2021-04-07	80	13	65
102937	2021-04-08	80	13	65
102938	2021-04-09	80	13	65
102939	2021-04-10	80	13	65
102940	2021-04-11	64	14	65
102941	2021-04-12	63	14	65
102942	2021-04-13	63	14	65
102943	2021-04-14	80	13	65
102944	2021-04-15	80	13	65
102945	2021-04-16	80	13	65
102946	2021-04-17	80	13	65
102947	2021-04-18	80	13	65
102948	2021-04-19	64	13	65
102949	2021-04-20	80	13	65
102950	2021-04-21	80	13	65
102951	2021-04-22	80	13	65
102952	2021-04-23	80	13	65
102953	2021-04-24	80	13	65
102954	2021-04-25	80	13	65
102955	2021-04-26	64	14	65
102956	2021-04-27	80	13	65
102957	2021-04-28	80	13	65
102958	2021-04-29	80	13	65
102959	2021-04-30	80	13	65
102960	2021-04-01	64	14	51
102961	2021-04-02	63	14	51
102962	2021-04-03	80	13	51
102963	2021-04-04	80	13	51
102964	2021-04-05	80	13	51
102965	2021-04-06	80	13	51
102966	2021-04-07	80	13	51
102967	2021-04-08	80	13	51
102968	2021-04-09	64	14	51
102969	2021-04-10	63	13	51
102970	2021-04-11	80	13	51
102971	2021-04-12	80	13	51
102972	2021-04-13	80	13	51
102973	2021-04-14	80	13	51
102974	2021-04-15	80	13	51
102975	2021-04-16	64	14	51
102976	2021-04-17	80	13	51
102977	2021-04-18	80	13	51
102978	2021-04-19	80	13	51
102979	2021-04-20	80	13	51
102980	2021-04-21	80	13	51
102981	2021-04-22	64	14	51
102982	2021-04-23	63	14	51
102983	2021-04-24	80	13	51
102984	2021-04-25	80	13	51
102985	2021-04-26	80	13	51
102986	2021-04-27	80	13	51
102987	2021-04-28	63	14	51
102988	2021-04-29	80	13	51
102989	2021-04-30	80	13	51
102990	2021-04-01	80	13	57
102991	2021-04-02	63	13	57
102992	2021-04-03	64	14	57
102993	2021-04-04	80	13	57
102994	2021-04-05	80	13	57
102995	2021-04-06	63	14	57
102996	2021-04-07	80	13	57
102997	2021-04-08	80	13	57
102998	2021-04-09	80	13	57
102999	2021-04-10	80	13	57
103000	2021-04-11	80	13	57
103001	2021-04-12	80	13	57
103002	2021-04-13	64	14	57
103003	2021-04-14	63	14	57
103004	2021-04-15	80	13	57
103005	2021-04-16	80	13	57
103006	2021-04-17	80	13	57
103007	2021-04-18	80	13	57
103008	2021-04-19	80	13	57
103009	2021-04-20	80	13	57
103010	2021-04-21	63	14	57
103011	2021-04-22	80	13	57
103012	2021-04-23	80	13	57
103013	2021-04-24	80	13	57
103014	2021-04-25	80	13	57
103015	2021-04-26	80	13	57
103016	2021-04-27	80	13	57
103017	2021-04-28	64	14	57
103018	2021-04-29	80	13	57
103019	2021-04-30	80	13	57
103020	2021-04-01	80	13	71
103021	2021-04-02	80	13	71
103022	2021-04-03	64	14	71
103023	2021-04-04	80	13	71
103024	2021-04-05	80	13	71
103025	2021-04-06	80	13	71
103026	2021-04-07	80	13	71
103027	2021-04-08	80	13	71
103028	2021-04-09	80	13	71
103029	2021-04-10	63	14	71
103030	2021-04-11	80	13	71
103031	2021-04-12	80	13	71
103032	2021-04-13	80	13	71
103033	2021-04-14	80	13	71
103034	2021-04-15	64	14	71
103035	2021-04-16	80	13	71
103036	2021-04-17	80	13	71
103037	2021-04-18	80	13	71
103038	2021-04-19	80	13	71
103039	2021-04-20	80	13	71
103040	2021-04-21	80	13	71
103041	2021-04-22	64	14	71
103042	2021-04-23	80	13	71
103043	2021-04-24	80	13	71
103044	2021-04-25	80	13	71
103045	2021-04-26	80	13	71
103046	2021-04-27	80	13	71
103047	2021-04-28	64	13	71
103048	2021-04-29	63	14	71
103049	2021-04-30	63	13	71
103050	2021-04-01	80	13	78
103051	2021-04-02	80	13	78
103052	2021-04-03	80	13	78
103053	2021-04-04	64	14	78
103054	2021-04-05	63	14	78
103055	2021-04-06	80	13	78
103056	2021-04-07	80	13	78
103057	2021-04-08	63	14	78
103058	2021-04-09	80	13	78
103059	2021-04-10	80	13	78
103060	2021-04-11	80	13	78
103061	2021-04-12	64	14	78
103062	2021-04-13	80	13	78
103063	2021-04-14	80	13	78
103064	2021-04-15	80	13	78
103065	2021-04-16	80	13	78
103066	2021-04-17	63	13	78
103067	2021-04-18	80	13	78
103068	2021-04-19	80	13	78
103069	2021-04-20	80	13	78
103070	2021-04-21	80	13	78
103071	2021-04-22	80	13	78
103072	2021-04-23	63	14	78
103073	2021-04-24	80	13	78
103074	2021-04-25	80	13	78
103075	2021-04-26	64	14	78
103076	2021-04-27	80	13	78
103077	2021-04-28	80	13	78
103078	2021-04-29	80	13	78
103079	2021-04-30	80	13	78
103080	2021-04-01	64	14	79
103081	2021-04-02	63	14	79
103082	2021-04-03	80	13	79
103083	2021-04-04	80	13	79
103084	2021-04-05	80	13	79
103085	2021-04-06	80	13	79
103086	2021-04-07	64	14	79
103087	2021-04-08	80	13	79
103088	2021-04-09	80	13	79
103089	2021-04-10	80	13	79
103090	2021-04-11	80	13	79
103091	2021-04-12	80	13	79
103092	2021-04-13	80	13	79
103093	2021-04-14	64	14	79
103094	2021-04-15	80	13	79
103095	2021-04-16	80	13	79
103096	2021-04-17	80	13	79
103097	2021-04-18	63	14	79
103098	2021-04-19	80	13	79
103099	2021-04-20	80	13	79
103100	2021-04-21	64	14	79
103101	2021-04-22	80	13	79
103102	2021-04-23	80	13	79
103103	2021-04-24	80	13	79
103104	2021-04-25	80	13	79
103105	2021-04-26	80	13	79
103106	2021-04-27	63	13	79
103107	2021-04-28	80	13	79
103108	2021-04-29	80	13	79
103109	2021-04-30	63	14	79
103110	2021-04-01	81	13	80
103111	2021-04-02	81	13	80
103112	2021-04-03	81	13	80
103113	2021-04-04	64	14	80
103114	2021-04-05	81	13	80
103115	2021-04-06	81	13	80
103116	2021-04-07	81	13	80
103117	2021-04-08	81	13	80
103118	2021-04-09	81	13	80
103119	2021-04-10	63	13	80
103120	2021-04-11	64	14	80
103121	2021-04-12	81	13	80
103122	2021-04-13	81	13	80
103123	2021-04-14	63	14	80
103124	2021-04-15	63	14	80
103125	2021-04-16	81	13	80
103126	2021-04-17	81	13	80
103127	2021-04-18	81	13	80
103128	2021-04-19	64	13	80
103129	2021-04-20	83	13	80
103130	2021-04-21	83	13	80
103131	2021-04-22	83	13	80
103132	2021-04-23	83	13	80
103133	2021-04-24	83	13	80
103134	2021-04-25	83	13	80
103135	2021-04-26	63	13	80
103136	2021-04-27	64	14	80
103137	2021-04-28	83	13	80
103138	2021-04-29	83	13	80
103139	2021-04-30	83	13	80
103140	2021-04-01	81	13	56
103141	2021-04-02	81	13	56
103142	2021-04-03	81	13	56
103143	2021-04-04	81	13	56
103144	2021-04-05	63	13	56
103145	2021-04-06	64	14	56
103146	2021-04-07	81	13	56
103147	2021-04-08	81	13	56
103148	2021-04-09	63	13	56
103149	2021-04-10	81	13	56
103150	2021-04-11	81	13	56
103151	2021-04-12	64	14	56
103152	2021-04-13	81	13	56
103153	2021-04-14	81	13	56
103154	2021-04-15	81	13	56
103155	2021-04-16	63	14	56
103156	2021-04-17	81	13	56
103157	2021-04-18	81	13	56
103158	2021-04-19	81	13	56
103159	2021-04-20	81	13	56
103160	2021-04-21	81	13	56
103161	2021-04-22	63	14	56
103162	2021-04-23	81	13	56
103163	2021-04-24	81	13	56
103164	2021-04-25	81	13	56
103165	2021-04-26	81	13	56
103166	2021-04-27	81	13	56
103167	2021-04-28	64	13	56
103168	2021-04-29	81	13	56
103169	2021-04-30	81	13	56
103170	2021-04-01	81	13	60
103171	2021-04-02	63	13	60
103172	2021-04-03	81	13	60
103173	2021-04-04	81	13	60
103174	2021-04-05	81	13	60
103175	2021-04-06	81	13	60
103176	2021-04-07	64	14	60
103177	2021-04-08	63	13	60
103178	2021-04-09	81	13	60
103179	2021-04-10	81	13	60
103180	2021-04-11	81	13	60
103181	2021-04-12	81	13	60
103182	2021-04-13	64	14	60
103183	2021-04-14	81	13	60
103184	2021-04-15	81	13	60
103185	2021-04-16	81	13	60
103186	2021-04-17	63	14	60
103187	2021-04-18	63	14	60
103188	2021-04-19	81	13	60
103189	2021-04-20	81	13	60
103190	2021-04-21	81	13	60
103191	2021-04-22	81	13	60
103192	2021-04-23	81	13	60
103193	2021-04-24	81	13	60
103194	2021-04-25	63	14	60
103195	2021-04-26	81	13	60
103196	2021-04-27	81	13	60
103197	2021-04-28	81	13	60
103198	2021-04-29	81	13	60
103199	2021-04-30	81	13	60
103200	2021-04-01	64	14	63
103201	2021-04-02	81	13	63
103202	2021-04-03	81	13	63
103203	2021-04-04	81	13	63
103204	2021-04-05	81	13	63
103205	2021-04-06	81	13	63
103206	2021-04-07	81	13	63
103207	2021-04-08	64	14	63
103208	2021-04-09	63	14	63
103209	2021-04-10	63	14	63
103210	2021-04-11	63	14	63
103211	2021-04-12	81	13	63
103212	2021-04-13	81	13	63
103213	2021-04-14	81	13	63
103214	2021-04-15	64	14	63
103215	2021-04-16	81	13	63
103216	2021-04-17	81	13	63
103217	2021-04-18	81	13	63
103218	2021-04-19	81	13	63
103219	2021-04-20	63	14	63
103220	2021-04-21	81	13	63
103221	2021-04-22	81	13	63
103222	2021-04-23	81	13	63
103223	2021-04-24	81	13	63
103224	2021-04-25	81	13	63
103225	2021-04-26	81	13	63
103226	2021-04-27	64	14	63
103227	2021-04-28	80	13	63
103228	2021-04-29	80	13	63
103229	2021-04-30	80	13	63
103230	2021-04-01	80	13	67
103231	2021-04-02	80	13	67
103232	2021-04-03	80	13	67
103233	2021-04-04	80	13	67
103234	2021-04-05	63	14	67
103235	2021-04-06	63	14	67
103236	2021-04-07	63	14	67
103237	2021-04-08	81	13	67
103238	2021-04-09	81	13	67
103239	2021-04-10	81	13	67
103240	2021-04-11	81	13	67
103241	2021-04-12	64	14	67
103242	2021-04-13	63	14	67
103243	2021-04-14	81	13	67
103244	2021-04-15	81	13	67
103245	2021-04-16	81	13	67
103246	2021-04-17	81	13	67
103247	2021-04-18	81	13	67
103248	2021-04-19	64	14	67
103249	2021-04-20	81	13	67
103250	2021-04-21	81	13	67
103251	2021-04-22	81	13	67
103252	2021-04-23	81	13	67
103253	2021-04-24	64	14	67
103254	2021-04-25	81	13	67
103255	2021-04-26	81	13	67
103256	2021-04-27	81	13	67
103257	2021-04-28	81	13	67
103258	2021-04-29	81	13	67
103259	2021-04-30	81	13	67
103260	2021-04-01	80	13	73
103261	2021-04-02	80	13	73
103262	2021-04-03	63	14	73
103263	2021-04-04	63	14	73
103264	2021-04-05	81	13	73
103265	2021-04-06	81	13	73
103266	2021-04-07	81	13	73
103267	2021-04-08	64	14	73
103268	2021-04-09	81	13	73
103269	2021-04-10	81	13	73
103270	2021-04-11	81	13	73
103271	2021-04-12	63	14	73
103272	2021-04-13	81	13	73
103273	2021-04-14	81	13	73
103274	2021-04-15	81	13	73
103275	2021-04-16	64	14	73
103276	2021-04-17	81	13	73
103277	2021-04-18	81	13	73
103278	2021-04-19	81	13	73
103279	2021-04-20	81	13	73
103280	2021-04-21	81	13	73
103281	2021-04-22	81	13	73
103282	2021-04-23	64	14	73
103283	2021-04-24	81	13	73
103284	2021-04-25	81	13	73
103285	2021-04-26	81	13	73
103286	2021-04-27	81	13	73
103287	2021-04-28	81	13	73
103288	2021-04-29	81	13	73
103289	2021-04-30	63	14	73
103290	2021-04-01	81	13	66
103291	2021-04-02	81	13	66
103292	2021-04-03	81	13	66
103293	2021-04-04	81	13	66
103294	2021-04-05	64	14	66
103295	2021-04-06	63	14	66
103296	2021-04-07	81	13	66
103297	2021-04-08	81	13	66
103298	2021-04-09	63	14	66
103299	2021-04-10	81	13	66
103300	2021-04-11	81	13	66
103301	2021-04-12	81	13	66
103302	2021-04-13	64	14	66
103303	2021-04-14	63	13	66
103304	2021-04-15	81	13	66
103305	2021-04-16	81	13	66
103306	2021-04-17	63	14	66
103307	2021-04-18	81	13	66
103308	2021-04-19	81	13	66
103309	2021-04-20	81	13	66
103310	2021-04-21	64	14	66
103311	2021-04-22	81	13	66
103312	2021-04-23	81	13	66
103313	2021-04-24	81	13	66
103314	2021-04-25	81	13	66
103315	2021-04-26	64	14	66
103316	2021-04-27	81	13	66
103317	2021-04-28	81	13	66
103318	2021-04-29	81	13	66
103319	2021-04-30	81	13	66
103320	2021-04-01	81	13	55
103321	2021-04-02	81	13	55
103322	2021-04-03	63	14	55
103323	2021-04-04	81	13	55
103324	2021-04-05	81	13	55
103325	2021-04-06	81	13	55
103326	2021-04-07	64	14	55
103327	2021-04-08	81	13	55
103328	2021-04-09	81	13	55
103329	2021-04-10	63	14	55
103330	2021-04-11	63	14	55
103331	2021-04-12	81	13	55
103332	2021-04-13	81	13	55
103333	2021-04-14	81	13	55
103334	2021-04-15	81	13	55
103335	2021-04-16	81	13	55
103336	2021-04-17	81	13	55
103337	2021-04-18	64	14	55
103338	2021-04-19	81	13	55
103339	2021-04-20	81	13	55
103340	2021-04-21	81	13	55
103341	2021-04-22	81	13	55
103342	2021-04-23	81	13	55
103343	2021-04-24	64	13	55
103344	2021-04-25	81	13	55
103345	2021-04-26	81	13	55
103346	2021-04-27	81	13	55
103347	2021-04-28	81	13	55
103348	2021-04-29	63	13	55
103349	2021-04-30	81	13	55
103350	2021-04-01	83	13	45
103351	2021-04-02	83	13	45
103352	2021-04-03	83	13	45
103353	2021-04-04	83	13	45
103354	2021-04-05	64	14	45
103355	2021-04-06	63	13	45
103356	2021-04-07	83	13	45
103357	2021-04-08	83	13	45
103358	2021-04-09	64	13	45
103359	2021-04-10	63	14	45
103360	2021-04-11	83	13	45
103361	2021-04-12	83	13	45
103362	2021-04-13	83	13	45
103363	2021-04-14	64	14	45
103364	2021-04-15	83	13	45
103365	2021-04-16	83	13	45
103366	2021-04-17	83	13	45
103367	2021-04-18	83	13	45
103368	2021-04-19	63	13	45
103369	2021-04-20	83	13	45
103370	2021-04-21	83	13	45
103371	2021-04-22	83	13	45
103372	2021-04-23	63	14	45
103373	2021-04-24	83	13	45
103374	2021-04-25	83	13	45
103375	2021-04-26	83	13	45
103376	2021-04-27	64	14	45
103377	2021-04-28	81	13	45
103378	2021-04-29	81	13	45
103379	2021-04-30	81	13	45
103380	2021-04-01	64	14	68
103381	2021-04-02	63	13	68
103382	2021-04-03	83	13	68
103383	2021-04-04	83	13	68
103384	2021-04-05	83	13	68
103385	2021-04-06	63	14	68
103386	2021-04-07	83	13	68
103387	2021-04-08	83	13	68
103388	2021-04-09	83	13	68
103389	2021-04-10	83	13	68
103390	2021-04-11	64	13	68
103391	2021-04-12	83	13	68
103392	2021-04-13	83	13	68
103393	2021-04-14	83	13	68
103394	2021-04-15	83	13	68
103395	2021-04-16	83	13	68
103396	2021-04-17	83	13	68
103397	2021-04-18	63	14	68
103398	2021-04-19	83	13	68
103399	2021-04-20	83	13	68
103400	2021-04-21	64	14	68
103401	2021-04-22	83	13	68
103402	2021-04-23	83	13	68
103403	2021-04-24	63	13	68
103404	2021-04-25	83	13	68
103405	2021-04-26	83	13	68
103406	2021-04-27	83	13	68
103407	2021-04-28	64	14	68
103408	2021-04-29	83	13	68
103409	2021-04-30	83	13	68
103410	2021-04-01	83	13	53
103411	2021-04-02	83	13	53
103412	2021-04-03	64	14	53
103413	2021-04-04	83	13	53
103414	2021-04-05	83	13	53
103415	2021-04-06	83	13	53
103416	2021-04-07	63	14	53
103417	2021-04-08	83	13	53
103418	2021-04-09	83	13	53
103419	2021-04-10	83	13	53
103420	2021-04-11	64	13	53
103421	2021-04-12	83	13	53
103422	2021-04-13	83	13	53
103423	2021-04-14	83	13	53
103424	2021-04-15	63	14	53
103425	2021-04-16	64	14	53
103426	2021-04-17	83	13	53
103427	2021-04-18	83	13	53
103428	2021-04-19	83	13	53
103429	2021-04-20	83	13	53
103430	2021-04-21	83	13	53
103431	2021-04-22	64	13	53
103432	2021-04-23	64	14	53
103433	2021-04-24	81	13	53
103434	2021-04-25	83	13	53
103435	2021-04-26	83	13	53
103436	2021-04-27	83	13	53
103437	2021-04-28	83	13	53
103438	2021-04-29	83	13	53
103439	2021-04-30	63	14	53
103440	2021-04-01	83	13	54
103441	2021-04-02	83	13	54
103442	2021-04-03	64	14	54
103443	2021-04-04	63	14	54
103444	2021-04-05	83	13	54
103445	2021-04-06	83	13	54
103446	2021-04-07	64	13	54
103447	2021-04-08	83	13	54
103448	2021-04-09	83	13	54
103449	2021-04-10	63	14	54
103450	2021-04-11	83	13	54
103451	2021-04-12	83	13	54
103452	2021-04-13	83	13	54
103453	2021-04-14	83	13	54
103454	2021-04-15	83	13	54
103455	2021-04-16	83	13	54
103456	2021-04-17	64	14	54
103457	2021-04-18	83	13	54
103458	2021-04-19	83	13	54
103459	2021-04-20	83	13	54
103460	2021-04-21	83	13	54
103461	2021-04-22	64	14	54
103462	2021-04-23	83	13	54
103463	2021-04-24	83	13	54
103464	2021-04-25	63	13	54
103465	2021-04-26	83	13	54
103466	2021-04-27	83	13	54
103467	2021-04-28	83	13	54
103468	2021-04-29	63	14	54
103469	2021-04-30	83	13	54
103470	2021-04-01	64	14	49
103471	2021-04-02	63	14	49
103472	2021-04-03	83	13	49
103473	2021-04-04	83	13	49
103474	2021-04-05	63	14	49
103475	2021-04-06	83	13	49
103476	2021-04-07	83	13	49
103477	2021-04-08	64	14	49
103478	2021-04-09	83	13	49
103479	2021-04-10	83	13	49
103480	2021-04-11	83	13	49
103481	2021-04-12	63	14	49
103482	2021-04-13	63	14	49
103483	2021-04-14	83	13	49
103484	2021-04-15	83	13	49
103485	2021-04-16	83	13	49
103486	2021-04-17	83	13	49
103487	2021-04-18	83	13	49
103488	2021-04-19	83	13	49
103489	2021-04-20	64	14	49
103490	2021-04-21	83	13	49
103491	2021-04-22	83	13	49
103492	2021-04-23	83	13	49
103493	2021-04-24	83	13	49
103494	2021-04-25	64	14	49
103495	2021-04-26	83	13	49
103496	2021-04-27	83	13	49
103497	2021-04-28	83	13	49
103498	2021-04-29	83	13	49
103499	2021-04-30	83	13	49
103500	2021-04-01	83	13	50
103501	2021-04-02	83	13	50
103502	2021-04-03	83	13	50
103503	2021-04-04	64	14	50
103504	2021-04-05	83	13	50
103505	2021-04-06	83	13	50
103506	2021-04-07	83	13	50
103507	2021-04-08	63	14	50
103508	2021-04-09	63	14	50
103509	2021-04-10	83	13	50
103510	2021-04-11	83	13	50
103511	2021-04-12	64	14	50
103512	2021-04-13	63	14	50
103513	2021-04-14	83	13	50
103514	2021-04-15	83	13	50
103515	2021-04-16	83	13	50
103516	2021-04-17	83	13	50
103517	2021-04-18	83	13	50
103518	2021-04-19	83	13	50
103519	2021-04-20	64	14	50
103520	2021-04-21	63	13	50
103521	2021-04-22	83	13	50
103522	2021-04-23	83	13	50
103523	2021-04-24	83	13	50
103524	2021-04-25	83	13	50
103525	2021-04-26	63	13	50
103526	2021-04-27	83	13	50
103527	2021-04-28	83	13	50
103528	2021-04-29	83	13	50
103529	2021-04-30	83	13	50
103530	2021-04-01	82	16	43
103531	2021-04-02	82	16	43
103532	2021-04-03	63	14	43
103533	2021-04-04	64	14	43
103534	2021-04-05	82	16	43
103535	2021-04-06	82	16	43
103536	2021-04-07	82	16	43
103537	2021-04-08	82	16	43
103538	2021-04-09	82	16	43
103539	2021-04-10	63	14	43
103540	2021-04-11	64	14	43
103541	2021-04-12	82	16	43
103542	2021-04-13	82	16	43
103543	2021-04-14	82	16	43
103544	2021-04-15	82	16	43
103545	2021-04-16	82	16	43
103546	2021-04-17	63	14	43
103547	2021-04-18	64	14	43
103548	2021-04-19	82	16	43
103549	2021-04-20	82	16	43
103550	2021-04-21	82	16	43
103551	2021-04-22	82	16	43
103552	2021-04-23	82	16	43
103553	2021-04-24	63	14	43
103554	2021-04-25	64	14	43
103555	2021-04-26	82	16	43
103556	2021-04-27	82	16	43
103557	2021-04-28	82	16	43
103558	2021-04-29	82	16	43
103559	2021-04-30	82	16	43
103560	2021-04-01	82	16	44
103561	2021-04-02	82	16	44
103562	2021-04-03	63	14	44
103563	2021-04-04	64	14	44
103564	2021-04-05	82	16	44
103565	2021-04-06	82	16	44
103566	2021-04-07	82	16	44
103567	2021-04-08	82	16	44
103568	2021-04-09	82	16	44
103569	2021-04-10	63	14	44
103570	2021-04-11	64	14	44
103571	2021-04-12	82	16	44
103572	2021-04-13	82	16	44
103573	2021-04-14	82	16	44
103574	2021-04-15	82	16	44
103575	2021-04-16	82	16	44
103576	2021-04-17	63	14	44
103577	2021-04-18	64	14	44
103578	2021-04-19	82	16	44
103579	2021-04-20	82	16	44
103580	2021-04-21	82	16	44
103581	2021-04-22	82	16	44
103582	2021-04-23	82	16	44
103583	2021-04-24	63	14	44
103584	2021-04-25	64	14	44
103585	2021-04-26	82	16	44
103586	2021-04-27	82	16	44
103587	2021-04-28	82	16	44
103588	2021-04-29	82	16	44
103589	2021-04-30	82	16	44
112557	2020-12-01	80	13	47
112558	2020-12-02	80	13	47
112559	2020-12-03	80	13	47
112560	2020-12-04	63	13	47
112561	2020-12-05	64	14	47
112562	2020-12-06	63	14	47
112563	2020-12-07	80	13	47
112564	2020-12-08	80	13	47
112565	2020-12-09	80	13	47
112566	2020-12-10	80	13	47
112567	2020-12-11	64	14	47
112568	2020-12-12	80	13	47
112569	2020-12-13	80	13	47
112570	2020-12-14	80	13	47
112571	2020-12-15	63	14	47
112572	2020-12-16	80	13	47
112573	2020-12-17	80	13	47
112574	2020-12-18	64	14	47
112575	2020-12-19	80	13	47
112576	2020-12-20	80	13	47
112577	2020-12-21	80	13	47
112578	2020-12-22	80	13	47
112579	2020-12-23	63	14	47
112580	2020-12-24	80	13	47
112581	2020-12-25	80	13	47
112582	2020-12-26	64	13	47
112583	2020-12-27	80	13	47
112584	2020-12-28	80	13	47
112585	2020-12-29	80	13	47
112586	2020-12-30	80	13	47
112587	2020-12-31	80	13	47
112588	2020-12-01	80	13	69
112589	2020-12-02	80	13	69
112590	2020-12-03	64	14	69
112591	2020-12-04	80	13	69
112592	2020-12-05	80	13	69
112593	2020-12-06	80	13	69
112594	2020-12-07	63	14	69
112595	2020-12-08	80	13	69
112596	2020-12-09	80	13	69
112597	2020-12-10	80	13	69
112598	2020-12-11	80	13	69
112599	2020-12-12	64	14	69
112600	2020-12-13	63	14	69
112601	2020-12-14	63	13	69
112602	2020-12-15	80	13	69
112603	2020-12-16	80	13	69
112604	2020-12-17	80	13	69
112605	2020-12-18	80	13	69
112606	2020-12-19	80	13	69
112607	2020-12-20	64	14	69
112608	2020-12-21	80	13	69
112609	2020-12-22	80	13	69
112610	2020-12-23	80	13	69
112611	2020-12-24	80	13	69
112612	2020-12-25	80	13	69
112613	2020-12-26	80	13	69
112614	2020-12-27	64	14	69
112615	2020-12-28	80	13	69
112616	2020-12-29	80	13	69
112617	2020-12-30	63	14	69
112618	2020-12-31	80	13	69
112619	2020-12-01	64	14	46
112620	2020-12-02	63	14	46
112621	2020-12-03	80	13	46
112622	2020-12-04	80	13	46
112623	2020-12-05	80	13	46
112624	2020-12-06	80	13	46
112625	2020-12-07	64	13	46
112626	2020-12-08	64	14	46
112627	2020-12-09	80	13	46
112628	2020-12-10	80	13	46
112629	2020-12-11	80	13	46
112630	2020-12-12	80	13	46
112631	2020-12-13	80	13	46
112632	2020-12-14	64	14	46
112633	2020-12-15	80	13	46
112634	2020-12-16	80	13	46
112635	2020-12-17	80	13	46
112636	2020-12-18	80	13	46
112637	2020-12-19	63	14	46
112638	2020-12-20	80	13	46
112639	2020-12-21	80	13	46
112640	2020-12-22	80	13	46
112641	2020-12-23	80	13	46
112642	2020-12-24	80	13	46
112643	2020-12-25	64	14	46
112644	2020-12-26	80	13	46
112645	2020-12-27	80	13	46
112646	2020-12-28	80	13	46
112647	2020-12-29	63	14	46
112648	2020-12-30	80	13	46
112649	2020-12-31	80	13	46
112650	2020-12-01	64	14	60
112651	2020-12-02	80	13	60
112652	2020-12-03	80	13	60
112653	2020-12-04	63	14	60
112654	2020-12-05	80	13	60
112655	2020-12-06	80	13	60
112656	2020-12-07	80	13	60
112657	2020-12-08	80	13	60
112658	2020-12-09	64	14	60
112659	2020-12-10	63	14	60
112660	2020-12-11	80	13	60
112661	2020-12-12	80	13	60
112662	2020-12-13	80	13	60
112663	2020-12-14	80	13	60
112664	2020-12-15	80	13	60
112665	2020-12-16	64	14	60
112666	2020-12-17	63	14	60
112667	2020-12-18	80	13	60
112668	2020-12-19	80	13	60
112669	2020-12-20	80	13	60
112670	2020-12-21	80	13	60
112671	2020-12-22	80	13	60
112672	2020-12-23	80	13	60
112673	2020-12-24	64	14	60
112674	2020-12-25	80	13	60
112675	2020-12-26	80	13	60
112676	2020-12-27	80	13	60
112677	2020-12-28	80	13	60
112678	2020-12-29	80	13	60
112679	2020-12-30	80	13	60
112680	2020-12-31	63	14	60
112681	2020-12-01	80	13	64
112682	2020-12-02	80	13	64
112683	2020-12-03	80	13	64
112684	2020-12-04	80	13	64
112685	2020-12-05	64	14	64
112686	2020-12-06	63	14	64
112687	2020-12-07	80	13	64
112688	2020-12-08	80	13	64
112689	2020-12-09	63	14	64
112690	2020-12-10	80	13	64
112691	2020-12-11	80	13	64
112692	2020-12-12	80	13	64
112693	2020-12-13	64	14	64
112694	2020-12-14	63	14	64
112695	2020-12-15	80	13	64
112696	2020-12-16	80	13	64
112697	2020-12-17	63	14	64
112698	2020-12-18	80	13	64
112699	2020-12-19	80	13	64
112700	2020-12-20	80	13	64
112701	2020-12-21	80	13	64
112702	2020-12-22	80	13	64
112703	2020-12-23	80	13	64
112704	2020-12-24	64	14	64
112705	2020-12-25	80	13	64
112706	2020-12-26	80	13	64
112707	2020-12-27	80	13	64
112708	2020-12-28	80	13	64
112709	2020-12-29	80	13	64
112710	2020-12-30	64	14	64
112711	2020-12-31	80	13	64
112712	2020-12-01	80	13	65
112713	2020-12-02	80	13	65
112714	2020-12-03	64	14	65
112715	2020-12-04	80	13	65
112716	2020-12-05	80	13	65
112717	2020-12-06	63	14	65
112718	2020-12-07	63	14	65
112719	2020-12-08	80	13	65
112720	2020-12-09	80	13	65
112721	2020-12-10	80	13	65
112722	2020-12-11	80	13	65
112723	2020-12-12	64	14	65
112724	2020-12-13	80	13	65
112725	2020-12-14	80	13	65
112726	2020-12-15	63	14	65
112727	2020-12-16	80	13	65
112728	2020-12-17	80	13	65
112729	2020-12-18	64	14	65
112730	2020-12-19	80	13	65
112731	2020-12-20	80	13	65
112732	2020-12-21	80	13	65
112733	2020-12-22	80	13	65
112734	2020-12-23	63	14	65
112735	2020-12-24	80	13	65
112736	2020-12-25	80	13	65
112737	2020-12-26	80	13	65
112738	2020-12-27	80	13	65
112739	2020-12-28	64	14	65
112740	2020-12-29	80	13	65
112741	2020-12-30	80	13	65
112742	2020-12-31	80	13	65
112743	2020-12-01	64	14	51
112744	2020-12-02	63	14	51
112745	2020-12-03	80	13	51
112746	2020-12-04	80	13	51
112747	2020-12-05	80	13	51
112748	2020-12-06	63	14	51
112749	2020-12-07	80	13	51
112750	2020-12-08	80	13	51
112751	2020-12-09	80	13	51
112752	2020-12-10	64	14	51
112753	2020-12-11	80	13	51
112754	2020-12-12	80	13	51
112755	2020-12-13	80	13	51
112756	2020-12-14	63	14	51
112757	2020-12-15	80	13	51
112758	2020-12-16	80	13	51
112759	2020-12-17	80	13	51
112760	2020-12-18	80	13	51
112761	2020-12-19	80	13	51
112762	2020-12-20	80	13	51
112763	2020-12-21	64	13	51
112764	2020-12-22	63	14	51
112765	2020-12-23	80	13	51
112766	2020-12-24	80	13	51
112767	2020-12-25	80	13	51
112768	2020-12-26	80	13	51
112769	2020-12-27	80	13	51
112770	2020-12-28	80	13	51
112771	2020-12-29	64	14	51
112772	2020-12-30	80	13	51
112773	2020-12-31	80	13	51
112774	2020-12-01	64	14	57
112775	2020-12-02	63	14	57
112776	2020-12-03	80	13	57
112777	2020-12-04	80	13	57
112778	2020-12-05	80	13	57
112779	2020-12-06	80	13	57
112780	2020-12-07	80	13	57
112781	2020-12-08	80	13	57
112782	2020-12-09	64	14	57
112783	2020-12-10	63	14	57
112784	2020-12-11	80	13	57
112785	2020-12-12	80	13	57
112786	2020-12-13	80	13	57
112787	2020-12-14	80	13	57
112788	2020-12-15	64	14	57
112789	2020-12-16	63	14	57
112790	2020-12-17	80	13	57
112791	2020-12-18	80	13	57
112792	2020-12-19	80	13	57
112793	2020-12-20	80	13	57
112794	2020-12-21	64	14	57
112795	2020-12-22	80	13	57
112796	2020-12-23	80	13	57
112797	2020-12-24	80	13	57
112798	2020-12-25	80	13	57
112799	2020-12-26	80	13	57
112800	2020-12-27	80	13	57
112801	2020-12-28	63	14	57
112802	2020-12-29	80	13	57
112803	2020-12-30	80	13	57
112804	2020-12-31	80	13	57
112805	2020-12-01	80	13	71
112806	2020-12-02	80	13	71
112807	2020-12-03	80	13	71
112808	2020-12-04	64	14	71
112809	2020-12-05	63	14	71
112810	2020-12-06	80	13	71
112811	2020-12-07	80	13	71
112812	2020-12-08	63	14	71
112813	2020-12-09	63	14	71
112814	2020-12-10	80	13	71
112815	2020-12-11	80	13	71
112816	2020-12-12	64	14	71
112817	2020-12-13	63	14	71
112818	2020-12-14	80	13	71
112819	2020-12-15	80	13	71
112820	2020-12-16	80	13	71
112821	2020-12-17	80	13	71
112822	2020-12-18	80	13	71
112823	2020-12-19	80	13	71
112824	2020-12-20	64	14	71
112825	2020-12-21	80	13	71
112826	2020-12-22	80	13	71
112827	2020-12-23	80	13	71
112828	2020-12-24	80	13	71
112829	2020-12-25	80	13	71
112830	2020-12-26	80	13	71
112831	2020-12-27	64	14	71
112832	2020-12-28	80	13	71
112833	2020-12-29	80	13	71
112834	2020-12-30	80	13	71
112835	2020-12-31	80	13	71
112836	2020-12-01	80	13	78
112837	2020-12-02	80	13	78
112838	2020-12-03	64	14	78
112839	2020-12-04	63	14	78
112840	2020-12-05	80	13	78
112841	2020-12-06	80	13	78
112842	2020-12-07	80	13	78
112843	2020-12-08	63	14	78
112844	2020-12-09	80	13	78
112845	2020-12-10	80	13	78
112846	2020-12-11	64	14	78
112847	2020-12-12	63	14	78
112848	2020-12-13	80	13	78
112849	2020-12-14	80	13	78
112850	2020-12-15	80	13	78
112851	2020-12-16	80	13	78
112852	2020-12-17	80	13	78
112853	2020-12-18	80	13	78
112854	2020-12-19	64	14	78
112855	2020-12-20	80	13	78
112856	2020-12-21	80	13	78
112857	2020-12-22	80	13	78
112858	2020-12-23	80	13	78
112859	2020-12-24	80	13	78
112860	2020-12-25	80	13	78
112861	2020-12-26	64	14	78
112862	2020-12-27	80	13	78
112863	2020-12-28	80	13	78
112864	2020-12-29	80	13	78
112865	2020-12-30	80	13	78
112866	2020-12-31	63	14	78
112867	2020-12-01	80	13	79
112868	2020-12-02	63	13	79
112869	2020-12-03	64	14	79
112870	2020-12-04	80	13	79
112871	2020-12-05	80	13	79
112872	2020-12-06	80	13	79
112873	2020-12-07	63	14	79
112874	2020-12-08	63	14	79
112875	2020-12-09	80	13	79
112876	2020-12-10	80	13	79
112877	2020-12-11	64	14	79
112878	2020-12-12	80	13	79
112879	2020-12-13	80	13	79
112880	2020-12-14	80	13	79
112881	2020-12-15	63	14	79
112882	2020-12-16	80	13	79
112883	2020-12-17	80	13	79
112884	2020-12-18	80	13	79
112885	2020-12-19	80	13	79
112886	2020-12-20	80	13	79
112887	2020-12-21	80	13	79
112888	2020-12-22	63	14	79
112889	2020-12-23	80	13	79
112890	2020-12-24	80	13	79
112891	2020-12-25	64	14	79
112892	2020-12-26	80	13	79
112893	2020-12-27	80	13	79
112894	2020-12-28	80	13	79
112895	2020-12-29	80	13	79
112896	2020-12-30	80	13	79
112897	2020-12-31	80	13	79
112898	2020-12-01	64	14	56
112899	2020-12-02	81	13	56
112900	2020-12-03	81	13	56
112901	2020-12-04	63	14	56
112902	2020-12-05	81	13	56
112903	2020-12-06	81	13	56
112904	2020-12-07	64	14	56
112905	2020-12-08	63	14	56
112906	2020-12-09	81	13	56
112907	2020-12-10	81	13	56
112908	2020-12-11	81	13	56
112909	2020-12-12	81	13	56
112910	2020-12-13	81	13	56
112911	2020-12-14	81	13	56
112912	2020-12-15	64	14	56
112913	2020-12-16	81	13	56
112914	2020-12-17	81	13	56
112915	2020-12-18	81	13	56
112916	2020-12-19	81	13	56
112917	2020-12-20	81	13	56
112918	2020-12-21	64	14	56
112919	2020-12-22	81	13	56
112920	2020-12-23	81	13	56
112921	2020-12-24	81	13	56
112922	2020-12-25	81	13	56
112923	2020-12-26	81	13	56
112924	2020-12-27	63	14	56
112925	2020-12-28	81	13	56
112926	2020-12-29	81	13	56
112927	2020-12-30	81	13	56
112928	2020-12-31	64	13	56
112929	2020-12-01	81	13	62
112930	2020-12-02	81	13	62
112931	2020-12-03	64	14	62
112932	2020-12-04	81	13	62
112933	2020-12-05	81	13	62
112934	2020-12-06	63	14	62
112935	2020-12-07	81	13	62
112936	2020-12-08	81	13	62
112937	2020-12-09	81	13	62
112938	2020-12-10	81	13	62
112939	2020-12-11	64	14	62
112940	2020-12-12	63	14	62
112941	2020-12-13	81	13	62
112942	2020-12-14	81	13	62
112943	2020-12-15	81	13	62
112944	2020-12-16	81	13	62
112945	2020-12-17	64	14	62
112946	2020-12-18	63	14	62
112947	2020-12-19	81	13	62
112948	2020-12-20	81	13	62
112949	2020-12-21	81	13	62
112950	2020-12-22	81	13	62
112951	2020-12-23	64	14	62
112952	2020-12-24	81	13	62
112953	2020-12-25	81	13	62
112954	2020-12-26	63	14	62
112955	2020-12-27	81	13	62
112956	2020-12-28	81	13	62
112957	2020-12-29	81	13	62
112958	2020-12-30	81	13	62
112959	2020-12-31	81	13	62
112960	2020-12-01	81	13	63
112961	2020-12-02	63	14	63
112962	2020-12-03	81	13	63
112963	2020-12-04	81	13	63
112964	2020-12-05	81	13	63
112965	2020-12-06	81	13	63
112966	2020-12-07	81	13	63
112967	2020-12-08	81	13	63
112968	2020-12-09	64	14	63
112969	2020-12-10	81	13	63
112970	2020-12-11	81	13	63
112971	2020-12-12	81	13	63
112972	2020-12-13	63	14	63
112973	2020-12-14	63	14	63
112974	2020-12-15	81	13	63
112975	2020-12-16	81	13	63
112976	2020-12-17	81	13	63
112977	2020-12-18	64	14	63
112978	2020-12-19	64	13	63
112979	2020-12-20	81	13	63
112980	2020-12-21	81	13	63
112981	2020-12-22	81	13	63
112982	2020-12-23	81	13	63
112983	2020-12-24	81	13	63
112984	2020-12-25	64	14	63
112985	2020-12-26	81	13	63
112986	2020-12-27	81	13	63
112987	2020-12-28	81	13	63
112988	2020-12-29	63	14	63
112989	2020-12-30	81	13	63
112990	2020-12-31	81	13	63
112991	2020-12-01	81	13	67
112992	2020-12-02	81	13	67
112993	2020-12-03	81	13	67
112994	2020-12-04	81	13	67
112995	2020-12-05	81	13	67
112996	2020-12-06	81	13	67
112997	2020-12-07	64	14	67
112998	2020-12-08	63	14	67
112999	2020-12-09	81	13	67
113000	2020-12-10	81	13	67
113001	2020-12-11	63	14	67
113002	2020-12-12	63	14	67
113003	2020-12-13	81	13	67
113004	2020-12-14	81	13	67
113005	2020-12-15	64	14	67
113006	2020-12-16	81	13	67
113007	2020-12-17	81	13	67
113008	2020-12-18	81	13	67
113009	2020-12-19	63	14	67
113010	2020-12-20	81	13	67
113011	2020-12-21	81	13	67
113012	2020-12-22	64	14	67
113013	2020-12-23	81	13	67
113014	2020-12-24	81	13	67
113015	2020-12-25	81	13	67
113016	2020-12-26	81	13	67
113017	2020-12-27	81	13	67
113018	2020-12-28	64	14	67
113019	2020-12-29	81	13	67
113020	2020-12-30	81	13	67
113021	2020-12-31	81	13	67
113022	2020-12-01	81	13	73
113023	2020-12-02	81	13	73
113024	2020-12-03	81	13	73
113025	2020-12-04	81	13	73
113026	2020-12-05	64	14	73
113027	2020-12-06	63	14	73
113028	2020-12-07	81	13	73
113029	2020-12-08	81	13	73
113030	2020-12-09	63	14	73
113031	2020-12-10	81	13	73
113032	2020-12-11	81	13	73
113033	2020-12-12	81	13	73
113034	2020-12-13	63	14	73
113035	2020-12-14	81	13	73
113036	2020-12-15	81	13	73
113037	2020-12-16	63	14	73
113038	2020-12-17	81	13	73
113039	2020-12-18	81	13	73
113040	2020-12-19	81	13	73
113041	2020-12-20	81	13	73
113042	2020-12-21	81	13	73
113043	2020-12-22	63	13	73
113044	2020-12-23	64	14	73
113045	2020-12-24	81	13	73
113046	2020-12-25	81	13	73
113047	2020-12-26	81	13	73
113048	2020-12-27	81	13	73
113049	2020-12-28	81	13	73
113050	2020-12-29	81	13	73
113051	2020-12-30	64	14	73
113052	2020-12-31	81	13	73
113053	2020-12-01	81	13	66
113054	2020-12-02	81	13	66
113055	2020-12-03	64	14	66
113056	2020-12-04	63	14	66
113057	2020-12-05	81	13	66
113058	2020-12-06	81	13	66
113059	2020-12-07	81	13	66
113060	2020-12-08	81	13	66
113061	2020-12-09	81	13	66
113062	2020-12-10	64	14	66
113063	2020-12-11	81	13	66
113064	2020-12-12	81	13	66
113065	2020-12-13	81	13	66
113066	2020-12-14	63	14	66
113067	2020-12-15	81	13	66
113068	2020-12-16	81	13	66
113069	2020-12-17	81	13	66
113070	2020-12-18	81	13	66
113071	2020-12-19	81	13	66
113072	2020-12-20	64	14	66
113073	2020-12-21	81	13	66
113074	2020-12-22	81	13	66
113075	2020-12-23	81	13	66
113076	2020-12-24	63	14	66
113077	2020-12-25	81	13	66
113078	2020-12-26	81	13	66
113079	2020-12-27	64	14	66
113080	2020-12-28	64	13	66
113081	2020-12-29	81	13	66
113082	2020-12-30	81	13	66
113083	2020-12-31	81	13	66
113084	2020-12-01	64	14	55
113085	2020-12-02	63	14	55
113086	2020-12-03	81	13	55
113087	2020-12-04	81	13	55
113088	2020-12-05	63	14	55
113089	2020-12-06	81	13	55
113090	2020-12-07	81	13	55
113091	2020-12-08	81	13	55
113092	2020-12-09	81	13	55
113093	2020-12-10	64	14	55
113094	2020-12-11	81	13	55
113095	2020-12-12	81	13	55
113096	2020-12-13	81	13	55
113097	2020-12-14	81	13	55
113098	2020-12-15	81	13	55
113099	2020-12-16	81	13	55
113100	2020-12-17	64	14	55
113101	2020-12-18	81	13	55
113102	2020-12-19	81	13	55
113103	2020-12-20	81	13	55
113104	2020-12-21	63	14	55
113105	2020-12-22	81	13	55
113106	2020-12-23	81	13	55
113107	2020-12-24	81	13	55
113108	2020-12-25	81	13	55
113109	2020-12-26	64	14	55
113110	2020-12-27	81	13	55
113111	2020-12-28	81	13	55
113112	2020-12-29	81	13	55
113113	2020-12-30	81	13	55
113114	2020-12-31	63	14	55
113115	2020-12-01	83	13	45
113116	2020-12-02	83	13	45
113117	2020-12-03	83	13	45
113118	2020-12-04	83	13	45
113119	2020-12-05	83	13	45
113120	2020-12-06	83	13	45
113121	2020-12-07	64	14	45
113122	2020-12-08	63	14	45
113123	2020-12-09	63	13	45
113124	2020-12-10	83	13	45
113125	2020-12-11	83	13	45
113126	2020-12-12	83	13	45
113127	2020-12-13	83	13	45
113128	2020-12-14	63	13	45
113129	2020-12-15	64	13	45
113130	2020-12-16	83	13	45
113131	2020-12-17	83	13	45
113132	2020-12-18	63	13	45
113133	2020-12-19	83	13	45
113134	2020-12-20	83	13	45
113135	2020-12-21	83	13	45
113136	2020-12-22	83	13	45
113137	2020-12-23	83	13	45
113138	2020-12-24	63	14	45
113139	2020-12-25	83	13	45
113140	2020-12-26	83	13	45
113141	2020-12-27	83	13	45
113142	2020-12-28	83	13	45
113143	2020-12-29	83	13	45
113144	2020-12-30	63	14	45
113145	2020-12-31	83	13	45
113146	2020-12-01	83	13	68
113147	2020-12-02	83	13	68
113148	2020-12-03	83	13	68
113149	2020-12-04	83	13	68
113150	2020-12-05	83	13	68
113151	2020-12-06	64	14	68
113152	2020-12-07	63	13	68
113153	2020-12-08	83	13	68
113154	2020-12-09	83	13	68
113155	2020-12-10	63	13	68
113156	2020-12-11	63	14	68
113157	2020-12-12	83	13	68
113158	2020-12-13	83	13	68
113159	2020-12-14	83	13	68
113160	2020-12-15	83	13	68
113161	2020-12-16	83	13	68
113162	2020-12-17	64	14	68
113163	2020-12-18	83	13	68
113164	2020-12-19	83	13	68
113165	2020-12-20	83	13	68
113166	2020-12-21	63	14	68
113167	2020-12-22	83	13	68
113168	2020-12-23	83	13	68
113169	2020-12-24	83	13	68
113170	2020-12-25	83	13	68
113171	2020-12-26	83	13	68
113172	2020-12-27	83	13	68
113173	2020-12-28	64	14	68
113174	2020-12-29	83	13	68
113175	2020-12-30	83	13	68
113176	2020-12-31	83	13	68
113177	2020-12-01	83	13	53
113178	2020-12-02	83	13	53
113179	2020-12-03	64	14	53
113180	2020-12-04	63	14	53
113181	2020-12-05	63	14	53
113182	2020-12-06	83	13	53
113183	2020-12-07	83	13	53
113184	2020-12-08	83	13	53
113185	2020-12-09	83	13	53
113186	2020-12-10	83	13	53
113187	2020-12-11	64	14	53
113188	2020-12-12	83	13	53
113189	2020-12-13	83	13	53
113190	2020-12-14	63	14	53
113191	2020-12-15	83	13	53
113192	2020-12-16	83	13	53
113193	2020-12-17	83	13	53
113194	2020-12-18	83	13	53
113195	2020-12-19	64	14	53
113196	2020-12-20	83	13	53
113197	2020-12-21	83	13	53
113198	2020-12-22	83	13	53
113199	2020-12-23	83	13	53
113200	2020-12-24	83	13	53
113201	2020-12-25	64	13	53
113202	2020-12-26	83	13	53
113203	2020-12-27	83	13	53
113204	2020-12-28	83	13	53
113205	2020-12-29	83	13	53
113206	2020-12-30	83	13	53
113207	2020-12-31	63	14	53
113208	2020-12-01	64	14	54
113209	2020-12-02	63	14	54
113210	2020-12-03	83	13	54
113211	2020-12-04	83	13	54
113212	2020-12-05	83	13	54
113213	2020-12-06	63	14	54
113214	2020-12-07	83	13	54
113215	2020-12-08	83	13	54
113216	2020-12-09	83	13	54
113217	2020-12-10	83	13	54
113218	2020-12-11	83	13	54
113219	2020-12-12	63	14	54
113220	2020-12-13	83	13	54
113221	2020-12-14	83	13	54
113222	2020-12-15	64	14	54
113223	2020-12-16	83	13	54
113224	2020-12-17	83	13	54
113225	2020-12-18	83	13	54
113226	2020-12-19	83	13	54
113227	2020-12-20	83	13	54
113228	2020-12-21	83	13	54
113229	2020-12-22	64	14	54
113230	2020-12-23	83	13	54
113231	2020-12-24	83	13	54
113232	2020-12-25	83	13	54
113233	2020-12-26	83	13	54
113234	2020-12-27	83	13	54
113235	2020-12-28	83	13	54
113236	2020-12-29	63	13	54
113237	2020-12-30	83	13	54
113238	2020-12-31	83	13	54
113239	2020-12-01	64	14	49
113240	2020-12-02	63	14	49
113241	2020-12-03	83	13	49
113242	2020-12-04	83	13	49
113243	2020-12-05	83	13	49
113244	2020-12-06	83	13	49
113245	2020-12-07	83	13	49
113246	2020-12-08	63	14	49
113247	2020-12-09	83	13	49
113248	2020-12-10	83	13	49
113249	2020-12-11	83	13	49
113250	2020-12-12	63	14	49
113251	2020-12-13	64	14	49
113252	2020-12-14	83	13	49
113253	2020-12-15	83	13	49
113254	2020-12-16	64	13	49
113255	2020-12-17	83	13	49
113256	2020-12-18	83	13	49
113257	2020-12-19	83	13	49
113258	2020-12-20	83	13	49
113259	2020-12-21	83	13	49
113260	2020-12-22	83	13	49
113261	2020-12-23	64	13	49
113262	2020-12-24	83	13	49
113263	2020-12-25	83	13	49
113264	2020-12-26	63	14	49
113265	2020-12-27	83	13	49
113266	2020-12-28	83	13	49
113267	2020-12-29	83	13	49
113268	2020-12-30	83	13	49
113269	2020-12-31	83	13	49
113270	2020-12-01	83	13	50
113271	2020-12-02	83	13	50
113272	2020-12-03	64	14	50
113273	2020-12-04	63	14	50
113274	2020-12-05	63	14	50
113275	2020-12-06	83	13	50
113276	2020-12-07	83	13	50
113277	2020-12-08	83	13	50
113278	2020-12-09	64	14	50
113279	2020-12-10	63	14	50
113280	2020-12-11	83	13	50
113281	2020-12-12	83	13	50
113282	2020-12-13	64	14	50
113283	2020-12-14	83	13	50
113284	2020-12-15	83	13	50
113285	2020-12-16	83	13	50
113286	2020-12-17	83	13	50
113287	2020-12-18	83	13	50
113288	2020-12-19	83	13	50
113289	2020-12-20	64	14	50
113290	2020-12-21	83	13	50
113291	2020-12-22	83	13	50
113292	2020-12-23	83	13	50
113293	2020-12-24	83	13	50
113294	2020-12-25	83	13	50
113295	2020-12-26	83	13	50
113296	2020-12-27	63	14	50
113297	2020-12-28	83	13	50
113298	2020-12-29	83	13	50
113299	2020-12-30	83	13	50
113300	2020-12-31	83	13	50
113301	2020-12-01	82	16	43
113302	2020-12-02	82	16	43
113303	2020-12-03	82	16	43
113304	2020-12-04	82	16	43
113305	2020-12-05	63	14	43
113306	2020-12-06	64	14	43
113307	2020-12-07	82	16	43
113308	2020-12-08	82	16	43
113309	2020-12-09	82	16	43
113310	2020-12-10	82	16	43
113311	2020-12-11	82	16	43
113312	2020-12-12	63	14	43
113313	2020-12-13	64	14	43
113314	2020-12-14	82	16	43
113315	2020-12-15	82	16	43
113316	2020-12-16	82	16	43
113317	2020-12-17	82	16	43
113318	2020-12-18	82	16	43
113319	2020-12-19	63	14	43
113320	2020-12-20	64	14	43
113321	2020-12-21	82	16	43
113322	2020-12-22	82	16	43
113323	2020-12-23	82	16	43
113324	2020-12-24	82	16	43
113325	2020-12-25	82	16	43
113326	2020-12-26	63	14	43
113327	2020-12-27	64	14	43
113328	2020-12-28	82	16	43
113329	2020-12-29	82	16	43
113330	2020-12-30	82	16	43
113331	2020-12-31	82	16	43
113332	2020-12-01	82	16	44
113333	2020-12-02	82	16	44
113334	2020-12-03	82	16	44
113335	2020-12-04	82	16	44
113336	2020-12-05	63	14	44
113337	2020-12-06	64	14	44
113338	2020-12-07	82	16	44
113339	2020-12-08	82	16	44
113340	2020-12-09	82	16	44
113341	2020-12-10	82	16	44
113342	2020-12-11	82	16	44
113343	2020-12-12	63	14	44
113344	2020-12-13	64	14	44
113345	2020-12-14	82	16	44
113346	2020-12-15	82	16	44
113347	2020-12-16	82	16	44
113348	2020-12-17	82	16	44
113349	2020-12-18	82	16	44
113350	2020-12-19	63	14	44
113351	2020-12-20	64	14	44
113352	2020-12-21	82	16	44
113353	2020-12-22	82	16	44
113354	2020-12-23	82	16	44
113355	2020-12-24	82	16	44
113356	2020-12-25	82	16	44
113357	2020-12-26	63	14	44
113358	2020-12-27	64	14	44
113359	2020-12-28	82	16	44
113360	2020-12-29	82	16	44
113361	2020-12-30	82	16	44
113362	2020-12-31	82	16	44
114976	2020-12-01	80	13	80
114977	2020-12-03	80	13	80
114978	2020-12-06	80	13	80
114979	2020-12-12	80	13	80
114980	2020-12-08	80	13	80
114981	2020-12-09	80	13	80
114982	2020-12-15	80	13	80
114983	2020-12-17	81	13	80
114984	2020-12-21	81	13	80
114985	2020-12-23	81	13	80
114986	2020-12-27	81	13	80
114987	2020-12-18	81	13	80
114988	2020-12-22	81	13	80
114989	2020-12-28	81	13	80
114990	2020-12-19	81	13	80
114991	2020-12-02	80	13	80
114992	2020-12-04	80	13	80
114993	2020-12-26	81	13	80
114994	2020-12-31	81	13	80
114995	2020-12-14	80	13	80
114996	2020-12-16	64	13	80
114997	2020-12-20	63	13	80
114998	2020-12-24	63	13	80
114999	2020-12-05	64	13	80
115000	2020-12-07	80	13	80
115001	2020-12-10	63	13	80
115002	2020-12-11	64	13	80
115003	2020-12-13	80	13	80
115004	2020-12-25	64	13	80
115005	2020-12-29	63	13	80
115006	2020-12-30	81	13	80
129632	2021-01-01	64	14	47
129633	2021-01-02	80	13	47
129634	2021-01-03	80	13	47
129635	2021-01-04	63	14	47
129636	2021-01-05	80	13	47
129637	2021-01-06	80	13	47
129638	2021-01-07	80	13	47
129639	2021-01-08	80	13	47
129640	2021-01-09	80	13	47
129641	2021-01-10	64	14	47
129642	2021-01-11	80	13	47
129643	2021-01-12	80	13	47
129644	2021-01-13	63	14	47
129645	2021-01-14	63	14	47
129646	2021-01-15	80	13	47
129647	2021-01-16	80	13	47
129648	2021-01-17	80	13	47
129649	2021-01-18	64	14	47
129650	2021-01-19	63	14	47
129651	2021-01-20	84	14	47
129652	2021-01-21	80	13	47
129653	2021-01-22	80	13	47
129654	2021-01-23	80	13	47
129655	2021-01-24	80	13	47
129656	2021-01-25	80	13	47
129657	2021-01-26	64	14	47
129658	2021-01-27	80	13	47
129659	2021-01-28	80	13	47
129660	2021-01-29	80	13	47
129661	2021-01-30	63	14	47
129662	2021-01-31	64	14	47
129663	2021-01-01	64	14	69
129664	2021-01-02	80	13	69
129665	2021-01-03	80	13	69
129666	2021-01-04	80	13	69
129667	2021-01-05	80	13	69
129668	2021-01-06	80	13	69
129669	2021-01-07	64	14	69
129670	2021-01-08	63	14	69
129671	2021-01-09	63	14	69
129672	2021-01-10	80	13	69
129673	2021-01-11	80	13	69
129674	2021-01-12	63	14	69
129675	2021-01-13	80	13	69
129676	2021-01-14	80	13	69
129677	2021-01-15	80	13	69
129678	2021-01-16	64	14	69
129679	2021-01-17	80	13	69
129680	2021-01-18	80	13	69
129681	2021-01-19	80	13	69
129682	2021-01-20	80	13	69
129683	2021-01-21	80	13	69
129684	2021-01-22	64	14	69
129685	2021-01-23	63	14	69
129686	2021-01-24	80	13	69
129687	2021-01-25	80	13	69
129688	2021-01-26	80	13	69
129689	2021-01-27	63	14	69
129690	2021-01-28	80	13	69
129691	2021-01-29	80	13	69
129692	2021-01-30	64	14	69
129693	2021-01-31	84	14	69
129694	2021-01-01	64	14	46
129695	2021-01-02	84	14	46
129696	2021-01-03	63	14	46
129697	2021-01-04	80	13	46
129698	2021-01-05	80	13	46
129699	2021-01-06	63	14	46
129700	2021-01-07	80	13	46
129701	2021-01-08	80	13	46
129702	2021-01-09	80	13	46
129703	2021-01-10	80	13	46
129704	2021-01-11	64	14	46
129705	2021-01-12	63	14	46
129706	2021-01-13	80	13	46
129707	2021-01-14	80	13	46
129708	2021-01-15	80	13	46
129709	2021-01-16	80	13	46
129710	2021-01-17	64	14	46
129711	2021-01-18	80	13	46
129712	2021-01-19	80	13	46
129713	2021-01-20	63	14	46
129714	2021-01-21	80	13	46
129715	2021-01-22	80	13	46
129716	2021-01-23	80	13	46
129717	2021-01-24	64	14	46
129718	2021-01-25	63	14	46
129719	2021-01-26	80	13	46
129720	2021-01-27	80	13	46
129721	2021-01-28	80	13	46
129722	2021-01-29	64	14	46
129723	2021-01-30	80	13	46
129724	2021-01-31	80	13	46
129725	2021-01-01	64	14	60
129726	2021-01-02	80	13	60
129727	2021-01-03	80	13	60
129728	2021-01-04	63	14	60
129729	2021-01-05	63	14	60
129730	2021-01-06	80	13	60
129731	2021-01-07	80	13	60
129732	2021-01-08	80	13	60
129733	2021-01-09	64	14	60
129734	2021-01-10	80	13	60
129735	2021-01-11	80	13	60
129736	2021-01-12	80	13	60
129737	2021-01-13	80	13	60
129738	2021-01-14	63	14	60
129739	2021-01-15	64	14	60
129740	2021-01-16	80	13	60
129741	2021-01-17	80	13	60
129742	2021-01-18	80	13	60
129743	2021-01-19	80	13	60
129744	2021-01-20	80	13	60
129745	2021-01-21	64	14	60
129746	2021-01-22	80	13	60
129747	2021-01-23	80	13	60
129748	2021-01-24	63	14	60
129749	2021-01-25	84	14	60
129750	2021-01-26	80	13	60
129751	2021-01-27	80	13	60
129752	2021-01-28	64	14	60
129753	2021-01-29	63	14	60
129754	2021-01-30	80	13	60
129755	2021-01-31	80	13	60
129756	2021-01-01	64	14	64
129757	2021-01-02	84	14	64
129758	2021-01-03	63	14	64
129759	2021-01-04	80	13	64
129760	2021-01-05	80	13	64
129761	2021-01-06	63	14	64
129762	2021-01-07	80	13	64
129763	2021-01-08	80	13	64
129764	2021-01-09	80	13	64
129765	2021-01-10	64	14	64
129766	2021-01-11	63	14	64
129767	2021-01-12	63	14	64
129768	2021-01-13	80	13	64
129769	2021-01-14	80	13	64
129770	2021-01-15	80	13	64
129771	2021-01-16	80	13	64
129772	2021-01-17	80	13	64
129773	2021-01-18	80	13	64
129774	2021-01-19	64	14	64
129775	2021-01-20	80	13	64
129776	2021-01-21	80	13	64
129777	2021-01-22	63	14	64
129778	2021-01-23	80	13	64
129779	2021-01-24	80	13	64
129780	2021-01-25	80	13	64
129781	2021-01-26	64	14	64
129782	2021-01-27	80	13	64
129783	2021-01-28	80	13	64
129784	2021-01-29	80	13	64
129785	2021-01-30	64	14	64
129786	2021-01-31	80	13	64
129787	2021-01-01	64	14	65
129788	2021-01-02	80	13	65
129789	2021-01-03	80	13	65
129790	2021-01-04	63	14	65
129791	2021-01-05	80	13	65
129792	2021-01-06	80	13	65
129793	2021-01-07	64	14	65
129794	2021-01-08	80	13	65
129795	2021-01-09	80	13	65
129796	2021-01-10	63	14	65
129797	2021-01-11	63	14	65
129798	2021-01-12	80	13	65
129799	2021-01-13	80	13	65
129800	2021-01-14	80	13	65
129801	2021-01-15	64	14	65
129802	2021-01-16	63	14	65
129803	2021-01-17	80	13	65
129804	2021-01-18	80	13	65
129805	2021-01-19	80	13	65
129806	2021-01-20	84	14	65
129807	2021-01-21	64	14	65
129808	2021-01-22	80	13	65
129809	2021-01-23	80	13	65
129810	2021-01-24	80	13	65
129811	2021-01-25	63	14	65
129812	2021-01-26	80	13	65
129813	2021-01-27	80	13	65
129814	2021-01-28	80	13	65
129815	2021-01-29	80	13	65
129816	2021-01-30	64	14	65
129817	2021-01-31	80	13	65
129818	2021-01-01	64	14	51
129819	2021-01-02	84	14	51
129820	2021-01-03	63	14	51
129821	2021-01-04	80	13	51
129822	2021-01-05	80	13	51
129823	2021-01-06	63	14	51
129824	2021-01-07	64	14	51
129825	2021-01-08	80	13	51
129826	2021-01-09	80	13	51
129827	2021-01-10	80	13	51
129828	2021-01-11	80	13	51
129829	2021-01-12	63	14	51
129830	2021-01-13	80	13	51
129831	2021-01-14	80	13	51
129832	2021-01-15	80	13	51
129833	2021-01-16	80	13	51
129834	2021-01-17	80	13	51
129835	2021-01-18	64	14	51
129836	2021-01-19	63	14	51
129837	2021-01-20	80	13	51
129838	2021-01-21	80	13	51
129839	2021-01-22	80	13	51
129840	2021-01-23	80	13	51
129841	2021-01-24	80	13	51
129842	2021-01-25	64	14	51
129843	2021-01-26	80	13	51
129844	2021-01-27	80	13	51
129845	2021-01-28	63	14	51
129846	2021-01-29	64	14	51
129847	2021-01-30	80	13	51
129848	2021-01-31	80	13	51
129849	2021-01-01	64	14	57
129850	2021-01-02	80	13	57
129851	2021-01-03	80	13	57
129852	2021-01-04	80	13	57
129853	2021-01-05	80	13	57
129854	2021-01-06	63	14	57
129855	2021-01-07	64	14	57
129856	2021-01-08	63	14	57
129857	2021-01-09	80	13	57
129858	2021-01-10	80	13	57
129859	2021-01-11	63	14	57
129860	2021-01-12	80	13	57
129861	2021-01-13	80	13	57
129862	2021-01-14	64	14	57
129863	2021-01-15	80	13	57
129864	2021-01-16	80	13	57
129865	2021-01-17	63	14	57
129866	2021-01-18	80	13	57
129867	2021-01-19	80	13	57
129868	2021-01-20	64	14	57
129869	2021-01-21	80	13	57
129870	2021-01-22	80	13	57
129871	2021-01-23	80	13	57
129872	2021-01-24	84	14	57
129873	2021-01-25	80	13	57
129874	2021-01-26	80	13	57
129875	2021-01-27	64	14	57
129876	2021-01-28	80	13	57
129877	2021-01-29	80	13	57
129878	2021-01-30	80	13	57
129879	2021-01-31	63	14	57
129880	2021-01-01	64	14	71
129881	2021-01-02	80	13	71
129882	2021-01-03	80	13	71
129883	2021-01-04	63	14	71
129884	2021-01-05	84	14	71
129885	2021-01-06	80	13	71
129886	2021-01-07	80	13	71
129887	2021-01-08	64	14	71
129888	2021-01-09	63	14	71
129889	2021-01-10	80	13	71
129890	2021-01-11	80	13	71
129891	2021-01-12	80	13	71
129892	2021-01-13	63	14	71
129893	2021-01-14	80	13	71
129894	2021-01-15	80	13	71
129895	2021-01-16	80	13	71
129896	2021-01-17	64	14	71
129897	2021-01-18	63	14	71
129898	2021-01-19	80	13	71
129899	2021-01-20	80	13	71
129900	2021-01-21	80	13	71
129901	2021-01-22	80	13	71
129902	2021-01-23	64	14	71
129903	2021-01-24	63	14	71
129904	2021-01-25	80	13	71
129905	2021-01-26	80	13	71
129906	2021-01-27	80	13	71
129907	2021-01-28	80	13	71
129908	2021-01-29	80	13	71
129909	2021-01-30	80	13	71
129910	2021-01-31	64	14	71
129911	2021-01-01	64	14	78
129912	2021-01-02	80	13	78
129913	2021-01-03	80	13	78
129914	2021-01-04	80	13	78
129915	2021-01-05	63	14	78
129916	2021-01-06	80	13	78
129917	2021-01-07	80	13	78
129918	2021-01-08	64	14	78
129919	2021-01-09	63	14	78
129920	2021-01-10	80	13	78
129921	2021-01-11	80	13	78
129922	2021-01-12	84	14	78
129923	2021-01-13	63	14	78
129924	2021-01-14	64	14	78
129925	2021-01-15	80	13	78
129926	2021-01-16	80	13	78
129927	2021-01-17	80	13	78
129928	2021-01-18	80	13	78
129929	2021-01-19	80	13	78
129930	2021-01-20	80	13	78
129931	2021-01-21	64	14	78
129932	2021-01-22	63	14	78
129933	2021-01-23	80	13	78
129934	2021-01-24	80	13	78
129935	2021-01-25	80	13	78
129936	2021-01-26	80	13	78
129937	2021-01-27	64	14	78
129938	2021-01-28	63	14	78
129939	2021-01-29	80	13	78
129940	2021-01-30	80	13	78
129941	2021-01-31	80	13	78
129942	2021-01-01	64	14	79
129943	2021-01-02	84	14	79
129944	2021-01-03	63	14	79
129945	2021-01-04	63	14	79
129946	2021-01-05	80	13	79
129947	2021-01-06	80	13	79
129948	2021-01-07	80	13	79
129949	2021-01-08	80	13	79
129950	2021-01-09	64	14	79
129951	2021-01-10	63	14	79
129952	2021-01-11	80	13	79
129953	2021-01-12	80	13	79
129954	2021-01-13	63	14	79
129955	2021-01-14	80	13	79
129956	2021-01-15	80	13	79
129957	2021-01-16	64	14	79
129958	2021-01-17	80	13	79
129959	2021-01-18	80	13	79
129960	2021-01-19	80	13	79
129961	2021-01-20	80	13	79
129962	2021-01-21	80	13	79
129963	2021-01-22	80	13	79
129964	2021-01-23	64	14	79
129965	2021-01-24	80	13	79
129966	2021-01-25	80	13	79
129967	2021-01-26	63	14	79
129968	2021-01-27	80	13	79
129969	2021-01-28	80	13	79
129970	2021-01-29	64	14	79
129971	2021-01-30	80	13	79
129972	2021-01-31	80	13	79
129973	2021-01-01	64	14	56
129974	2021-01-02	63	14	56
129975	2021-01-03	63	14	56
129976	2021-01-04	81	13	56
129977	2021-01-05	81	13	56
129978	2021-01-06	63	14	56
129979	2021-01-07	64	14	56
129980	2021-01-08	81	13	56
129981	2021-01-09	81	13	56
129982	2021-01-10	81	13	56
129983	2021-01-11	81	13	56
129984	2021-01-12	81	13	56
129985	2021-01-13	81	13	56
129986	2021-01-14	64	14	56
129987	2021-01-15	81	13	56
129988	2021-01-16	81	13	56
129989	2021-01-17	81	13	56
129990	2021-01-18	81	13	56
129991	2021-01-19	81	13	56
129992	2021-01-20	81	13	56
129993	2021-01-21	64	14	56
129994	2021-01-22	81	13	56
129995	2021-01-23	81	13	56
129996	2021-01-24	63	14	56
129997	2021-01-25	63	14	56
129998	2021-01-26	81	13	56
129999	2021-01-27	81	13	56
130000	2021-01-28	64	14	56
130001	2021-01-29	81	13	56
130002	2021-01-30	81	13	56
130003	2021-01-31	84	14	56
130004	2021-01-01	64	14	62
130005	2021-01-02	81	13	62
130006	2021-01-03	81	13	62
130007	2021-01-04	63	14	62
130008	2021-01-05	81	13	62
130009	2021-01-06	81	13	62
130010	2021-01-07	81	13	62
130011	2021-01-08	64	14	62
130012	2021-01-09	63	14	62
130013	2021-01-10	63	14	62
130014	2021-01-11	81	13	62
130015	2021-01-12	81	13	62
130016	2021-01-13	81	13	62
130017	2021-01-14	81	13	62
130018	2021-01-15	64	14	62
130019	2021-01-16	81	13	62
130020	2021-01-17	81	13	62
130021	2021-01-18	81	13	62
130022	2021-01-19	63	14	62
130023	2021-01-20	81	13	62
130024	2021-01-21	81	13	62
130025	2021-01-22	81	13	62
130026	2021-01-23	64	14	62
130027	2021-01-24	81	13	62
130028	2021-01-25	81	13	62
130029	2021-01-26	84	14	62
130030	2021-01-27	81	13	62
130031	2021-01-28	81	13	62
130032	2021-01-29	64	14	62
130033	2021-01-30	63	14	62
130034	2021-01-31	81	13	62
130035	2021-01-01	64	14	63
130036	2021-01-02	81	13	63
130037	2021-01-03	81	13	63
130038	2021-01-04	63	14	63
130039	2021-01-05	63	14	63
130040	2021-01-06	63	14	63
130041	2021-01-07	81	13	63
130042	2021-01-08	81	13	63
130043	2021-01-09	64	14	63
130044	2021-01-10	81	13	63
130045	2021-01-11	81	13	63
130046	2021-01-12	81	13	63
130047	2021-01-13	63	14	63
130048	2021-01-14	84	14	63
130049	2021-01-15	81	13	63
130050	2021-01-16	81	13	63
130051	2021-01-17	81	13	63
130052	2021-01-18	64	14	63
130053	2021-01-19	81	13	63
130054	2021-01-20	81	13	63
130055	2021-01-21	81	13	63
130056	2021-01-22	81	13	63
130057	2021-01-23	81	13	63
130058	2021-01-24	81	13	63
130059	2021-01-25	64	14	63
130060	2021-01-26	63	14	63
130061	2021-01-27	81	13	63
130062	2021-01-28	81	13	63
130063	2021-01-29	64	14	63
130064	2021-01-30	81	13	63
130065	2021-01-31	81	13	63
130066	2021-01-01	64	14	67
130067	2021-01-02	81	13	67
130068	2021-01-03	81	13	67
130069	2021-01-04	63	14	67
130070	2021-01-05	81	13	67
130071	2021-01-06	81	13	67
130072	2021-01-07	64	14	67
130073	2021-01-08	63	14	67
130074	2021-01-09	81	13	67
130075	2021-01-10	81	13	67
130076	2021-01-11	81	13	67
130077	2021-01-12	63	14	67
130078	2021-01-13	81	13	67
130079	2021-01-14	81	13	67
130080	2021-01-15	64	14	67
130081	2021-01-16	84	14	67
130082	2021-01-17	81	13	67
130083	2021-01-18	81	13	67
130084	2021-01-19	63	14	67
130085	2021-01-20	81	13	67
130086	2021-01-21	81	13	67
130087	2021-01-22	64	14	67
130088	2021-01-23	63	14	67
130089	2021-01-24	81	13	67
130090	2021-01-25	81	13	67
130091	2021-01-26	81	13	67
130092	2021-01-27	81	13	67
130093	2021-01-28	64	14	67
130094	2021-01-29	81	13	67
130095	2021-01-30	81	13	67
130096	2021-01-31	81	13	67
130097	2021-01-01	64	14	73
130098	2021-01-02	81	13	73
130099	2021-01-03	81	13	73
130100	2021-01-04	81	13	73
130101	2021-01-05	63	14	73
130102	2021-01-06	81	13	73
130103	2021-01-07	81	13	73
130104	2021-01-08	64	14	73
130105	2021-01-09	63	14	73
130106	2021-01-10	84	14	73
130107	2021-01-11	81	13	73
130108	2021-01-12	81	13	73
130109	2021-01-13	63	14	73
130110	2021-01-14	64	14	73
130111	2021-01-15	81	13	73
130112	2021-01-16	81	13	73
130113	2021-01-17	81	13	73
130114	2021-01-18	63	14	73
130115	2021-01-19	81	13	73
130116	2021-01-20	81	13	73
130117	2021-01-21	81	13	73
130118	2021-01-22	81	13	73
130119	2021-01-23	64	14	73
130120	2021-01-24	81	13	73
130121	2021-01-25	81	13	73
130122	2021-01-26	81	13	73
130123	2021-01-27	81	13	73
130124	2021-01-28	81	13	73
130125	2021-01-29	81	13	73
130126	2021-01-30	64	14	73
130127	2021-01-31	63	14	73
130128	2021-01-01	64	14	66
130129	2021-01-02	63	14	66
130130	2021-01-03	63	14	66
130131	2021-01-04	81	13	66
130132	2021-01-05	81	13	66
130133	2021-01-06	84	14	66
130134	2021-01-07	81	13	66
130135	2021-01-08	81	13	66
130136	2021-01-09	81	13	66
130137	2021-01-10	64	14	66
130138	2021-01-11	63	14	66
130139	2021-01-12	63	14	66
130140	2021-01-13	81	13	66
130141	2021-01-14	81	13	66
130142	2021-01-15	81	13	66
130143	2021-01-16	81	13	66
130144	2021-01-17	64	14	66
130145	2021-01-18	81	13	66
130146	2021-01-19	81	13	66
130147	2021-01-20	63	14	66
130148	2021-01-21	64	14	66
130149	2021-01-22	81	13	66
130150	2021-01-23	81	13	66
130151	2021-01-24	81	13	66
130152	2021-01-25	81	13	66
130153	2021-01-26	81	13	66
130154	2021-01-27	81	13	66
130155	2021-01-28	64	14	66
130156	2021-01-29	81	13	66
130157	2021-01-30	81	13	66
130158	2021-01-31	81	13	66
130159	2021-01-01	64	14	55
130160	2021-01-02	63	14	55
130161	2021-01-03	63	14	55
130162	2021-01-04	81	13	55
130163	2021-01-05	81	13	55
130164	2021-01-06	63	14	55
130165	2021-01-07	64	14	55
130166	2021-01-08	81	13	55
130167	2021-01-09	81	13	55
130168	2021-01-10	81	13	55
130169	2021-01-11	63	14	55
130170	2021-01-12	84	14	55
130171	2021-01-13	81	13	55
130172	2021-01-14	81	13	55
130173	2021-01-15	81	13	55
130174	2021-01-16	81	13	55
130175	2021-01-17	64	14	55
130176	2021-01-18	81	13	55
130177	2021-01-19	81	13	55
130178	2021-01-20	81	13	55
130179	2021-01-21	63	14	55
130180	2021-01-22	81	13	55
130181	2021-01-23	81	13	55
130182	2021-01-24	64	14	55
130183	2021-01-25	81	13	55
130184	2021-01-26	81	13	55
130185	2021-01-27	64	14	55
130186	2021-01-28	81	13	55
130187	2021-01-29	81	13	55
130188	2021-01-30	81	13	55
130189	2021-01-31	81	13	55
130190	2021-01-01	64	14	45
130191	2021-01-02	83	13	45
130192	2021-01-03	83	13	45
130193	2021-01-04	83	13	45
130194	2021-01-05	83	13	45
130195	2021-01-06	84	14	45
130196	2021-01-07	64	14	45
130197	2021-01-08	63	14	45
130198	2021-01-09	83	13	45
130199	2021-01-10	83	13	45
130200	2021-01-11	83	13	45
130201	2021-01-12	83	13	45
130202	2021-01-13	64	14	45
130203	2021-01-14	63	14	45
130204	2021-01-15	83	13	45
130205	2021-01-16	83	13	45
130206	2021-01-17	83	13	45
130207	2021-01-18	83	13	45
130208	2021-01-19	64	14	45
130209	2021-01-20	63	14	45
130210	2021-01-21	63	14	45
130211	2021-01-22	83	13	45
130212	2021-01-23	83	13	45
130213	2021-01-24	83	13	45
130214	2021-01-25	83	13	45
130215	2021-01-26	83	13	45
130216	2021-01-27	64	14	45
130217	2021-01-28	83	13	45
130218	2021-01-29	83	13	45
130219	2021-01-30	63	14	45
130220	2021-01-31	83	13	45
130221	2021-01-01	64	14	68
130222	2021-01-02	63	14	68
130223	2021-01-03	83	13	68
130224	2021-01-04	83	13	68
130225	2021-01-05	63	14	68
130226	2021-01-06	83	13	68
130227	2021-01-07	83	13	68
130228	2021-01-08	83	13	68
130229	2021-01-09	64	14	68
130230	2021-01-10	83	13	68
130231	2021-01-11	83	13	68
130232	2021-01-12	63	14	68
130233	2021-01-13	83	13	68
130234	2021-01-14	83	13	68
130235	2021-01-15	83	13	68
130236	2021-01-16	64	14	68
130237	2021-01-17	63	14	68
130238	2021-01-18	83	13	68
130239	2021-01-19	83	13	68
130240	2021-01-20	83	13	68
130241	2021-01-21	83	13	68
130242	2021-01-22	83	13	68
130243	2021-01-23	83	13	68
130244	2021-01-24	64	14	68
130245	2021-01-25	63	14	68
130246	2021-01-26	83	13	68
130247	2021-01-27	83	13	68
130248	2021-01-28	84	14	68
130249	2021-01-29	64	14	68
130250	2021-01-30	83	13	68
130251	2021-01-31	83	13	68
130252	2021-01-01	64	14	53
130253	2021-01-02	84	14	53
130254	2021-01-03	63	14	53
130255	2021-01-04	63	14	53
130256	2021-01-05	83	13	53
130257	2021-01-06	83	13	53
130258	2021-01-07	83	13	53
130259	2021-01-08	83	13	53
130260	2021-01-09	64	14	53
130261	2021-01-10	83	13	53
130262	2021-01-11	83	13	53
130263	2021-01-12	63	14	53
130264	2021-01-13	83	13	53
130265	2021-01-14	83	13	53
130266	2021-01-15	83	13	53
130267	2021-01-16	64	14	53
130268	2021-01-17	83	13	53
130269	2021-01-18	83	13	53
130270	2021-01-19	63	14	53
130271	2021-01-20	83	13	53
130272	2021-01-21	83	13	53
130273	2021-01-22	83	13	53
130274	2021-01-23	83	13	53
130275	2021-01-24	64	14	53
130276	2021-01-25	83	13	53
130277	2021-01-26	83	13	53
130278	2021-01-27	83	13	53
130279	2021-01-28	63	14	53
130280	2021-01-29	64	14	53
130281	2021-01-30	83	13	53
130282	2021-01-31	83	13	53
130283	2021-01-01	64	14	54
130284	2021-01-02	83	13	54
130285	2021-01-03	83	13	54
130286	2021-01-04	83	13	54
130287	2021-01-05	63	14	54
130288	2021-01-06	83	13	54
130289	2021-01-07	83	13	54
130290	2021-01-08	64	14	54
130291	2021-01-09	63	14	54
130292	2021-01-10	63	14	54
130293	2021-01-11	83	13	54
130294	2021-01-12	83	13	54
130295	2021-01-13	63	14	54
130296	2021-01-14	64	14	54
130297	2021-01-15	83	13	54
130298	2021-01-16	83	13	54
130299	2021-01-17	84	14	54
130300	2021-01-18	83	13	54
130301	2021-01-19	83	13	54
130302	2021-01-20	83	13	54
130303	2021-01-21	83	13	54
130304	2021-01-22	64	14	54
130305	2021-01-23	63	14	54
130306	2021-01-24	83	13	54
130307	2021-01-25	83	13	54
130308	2021-01-26	83	13	54
130309	2021-01-27	64	14	54
130310	2021-01-28	83	13	54
130311	2021-01-29	83	13	54
130312	2021-01-30	83	13	54
130313	2021-01-31	83	13	54
130314	2021-01-01	64	14	49
130315	2021-01-02	83	13	49
130316	2021-01-03	83	13	49
130317	2021-01-04	83	13	49
130318	2021-01-05	63	14	49
130319	2021-01-06	63	14	49
130320	2021-01-07	64	14	49
130321	2021-01-08	84	14	49
130322	2021-01-09	83	13	49
130323	2021-01-10	83	13	49
130324	2021-01-11	63	14	49
130325	2021-01-12	63	14	49
130326	2021-01-13	64	14	49
130327	2021-01-14	83	13	49
130328	2021-01-15	83	13	49
130329	2021-01-16	83	13	49
130330	2021-01-17	83	13	49
130331	2021-01-18	83	13	49
130332	2021-01-19	83	13	49
130333	2021-01-20	64	14	49
130334	2021-01-21	83	13	49
130335	2021-01-22	83	13	49
130336	2021-01-23	83	13	49
130337	2021-01-24	83	13	49
130338	2021-01-25	63	14	49
130339	2021-01-26	83	13	49
130340	2021-01-27	83	13	49
130341	2021-01-28	83	13	49
130342	2021-01-29	83	13	49
130343	2021-01-30	83	13	49
130344	2021-01-31	64	14	49
130345	2021-01-01	64	14	50
130346	2021-01-02	63	14	50
130347	2021-01-03	63	14	50
130348	2021-01-04	63	14	50
130349	2021-01-05	83	13	50
130350	2021-01-06	83	13	50
130351	2021-01-07	64	14	50
130352	2021-01-08	83	13	50
130353	2021-01-09	83	13	50
130354	2021-01-10	63	14	50
130355	2021-01-11	63	14	50
130356	2021-01-12	83	13	50
130357	2021-01-13	83	13	50
130358	2021-01-14	83	13	50
130359	2021-01-15	64	14	50
130360	2021-01-16	83	13	50
130361	2021-01-17	83	13	50
130362	2021-01-18	84	14	50
130363	2021-01-19	83	13	50
130364	2021-01-20	83	13	50
130365	2021-01-21	64	14	50
130366	2021-01-22	83	13	50
130367	2021-01-23	83	13	50
130368	2021-01-24	83	13	50
130369	2021-01-25	83	13	50
130370	2021-01-26	64	14	50
130371	2021-01-27	83	13	50
130372	2021-01-28	83	13	50
130373	2021-01-29	83	13	50
130374	2021-01-30	83	13	50
130375	2021-01-31	83	13	50
130376	2021-01-01	63	14	43
130377	2021-01-02	63	14	43
130378	2021-01-03	64	14	43
130379	2021-01-04	82	16	43
130380	2021-01-05	82	16	43
130381	2021-01-06	82	16	43
130382	2021-01-07	82	16	43
130383	2021-01-08	82	16	43
130384	2021-01-09	63	14	43
130385	2021-01-10	64	14	43
130386	2021-01-11	82	16	43
130387	2021-01-12	84	14	43
130388	2021-01-13	82	16	43
130389	2021-01-14	82	16	43
130390	2021-01-15	82	16	43
130391	2021-01-16	63	14	43
130392	2021-01-17	64	14	43
130393	2021-01-18	82	16	43
130394	2021-01-19	82	16	43
130395	2021-01-20	82	16	43
130396	2021-01-21	82	16	43
130397	2021-01-22	82	16	43
130398	2021-01-23	63	14	43
130399	2021-01-24	64	14	43
130400	2021-01-25	82	16	43
130401	2021-01-26	82	16	43
130402	2021-01-27	82	16	43
130403	2021-01-28	82	16	43
130404	2021-01-29	82	16	43
130405	2021-01-30	63	14	43
130406	2021-01-31	64	14	43
130407	2021-01-01	63	14	44
130408	2021-01-02	63	14	44
130409	2021-01-03	64	14	44
130410	2021-01-04	82	16	44
130411	2021-01-05	82	16	44
130412	2021-01-06	82	16	44
130413	2021-01-07	82	16	44
130414	2021-01-08	82	16	44
130415	2021-01-09	63	14	44
130416	2021-01-10	64	14	44
130417	2021-01-11	82	16	44
130418	2021-01-12	84	14	44
130419	2021-01-13	82	16	44
130420	2021-01-14	82	16	44
130421	2021-01-15	82	16	44
130422	2021-01-16	63	14	44
130423	2021-01-17	64	14	44
130424	2021-01-18	82	16	44
130425	2021-01-19	82	16	44
130426	2021-01-20	82	16	44
130427	2021-01-21	82	16	44
130428	2021-01-22	82	16	44
130429	2021-01-23	63	14	44
130430	2021-01-24	64	14	44
130431	2021-01-25	82	16	44
130432	2021-01-26	82	16	44
130433	2021-01-27	82	16	44
130434	2021-01-28	82	16	44
130435	2021-01-29	82	16	44
130436	2021-01-30	63	14	44
130437	2021-01-31	64	14	44
130438	2021-02-01	80	13	47
130439	2021-02-02	80	13	47
130440	2021-02-03	64	14	47
130441	2021-02-04	80	13	47
130442	2021-02-05	80	13	47
130443	2021-02-06	84	14	47
130444	2021-02-07	63	14	47
130445	2021-02-08	80	13	47
130446	2021-02-09	80	13	47
130447	2021-02-10	80	13	47
130448	2021-02-11	80	13	47
130449	2021-02-12	64	14	47
130450	2021-02-13	63	14	47
130451	2021-02-14	63	14	47
130452	2021-02-15	84	14	47
130453	2021-02-16	84	14	47
130454	2021-02-17	80	13	47
130455	2021-02-18	80	13	47
130456	2021-02-19	64	14	47
130457	2021-02-20	63	14	47
130458	2021-02-21	80	13	47
130459	2021-02-22	80	13	47
130460	2021-02-23	80	13	47
130461	2021-02-24	80	13	47
130462	2021-02-25	64	14	47
130463	2021-02-26	84	14	47
130464	2021-02-27	80	13	47
130465	2021-02-28	80	13	47
130466	2021-02-01	64	14	69
130467	2021-02-02	63	14	69
130468	2021-02-03	80	13	69
130469	2021-02-04	80	13	69
130470	2021-02-05	63	14	69
130471	2021-02-06	80	13	69
130472	2021-02-07	80	13	69
130473	2021-02-08	80	13	69
130474	2021-02-09	64	14	69
130475	2021-02-10	63	14	69
130476	2021-02-11	80	13	69
130477	2021-02-12	84	14	69
130478	2021-02-13	63	14	69
130479	2021-02-14	84	14	69
130480	2021-02-15	80	13	69
130481	2021-02-16	80	13	69
130482	2021-02-17	80	13	69
130483	2021-02-18	64	14	69
130484	2021-02-19	80	13	69
130485	2021-02-20	80	13	69
130486	2021-02-21	84	14	69
130487	2021-02-22	84	14	69
130488	2021-02-23	80	13	69
130489	2021-02-24	80	13	69
130490	2021-02-25	80	13	69
130491	2021-02-26	64	14	69
130492	2021-02-27	80	13	69
130493	2021-02-28	80	13	69
130494	2021-02-01	64	14	46
130495	2021-02-02	63	14	46
130496	2021-02-03	80	13	46
130497	2021-02-04	80	13	46
130498	2021-02-05	84	14	46
130499	2021-02-06	80	13	46
130500	2021-02-07	80	13	46
130501	2021-02-08	80	13	46
130502	2021-02-09	80	13	46
130503	2021-02-10	64	14	46
130504	2021-02-11	80	13	46
130505	2021-02-12	84	14	46
130506	2021-02-13	84	14	46
130507	2021-02-14	63	14	46
130508	2021-02-15	80	13	46
130509	2021-02-16	80	13	46
130510	2021-02-17	64	14	46
130511	2021-02-18	84	14	46
130512	2021-02-19	80	13	46
130513	2021-02-20	80	13	46
130514	2021-02-21	80	13	46
130515	2021-02-22	80	13	46
130516	2021-02-23	64	14	46
130517	2021-02-24	63	14	46
130518	2021-02-25	80	13	46
130519	2021-02-26	80	13	46
130520	2021-02-27	80	13	46
130521	2021-02-28	63	14	46
130522	2021-02-01	80	13	60
130523	2021-02-02	80	13	60
130524	2021-02-03	80	13	60
130525	2021-02-04	64	14	60
130526	2021-02-05	80	13	60
130527	2021-02-06	80	13	60
130528	2021-02-07	80	13	60
130529	2021-02-08	63	14	60
130530	2021-02-09	80	13	60
130531	2021-02-10	80	13	60
130532	2021-02-11	64	14	60
130533	2021-02-12	84	14	60
130534	2021-02-13	84	14	60
130535	2021-02-14	63	14	60
130536	2021-02-15	84	14	60
130537	2021-02-16	84	14	60
130538	2021-02-17	80	13	60
130539	2021-02-18	80	13	60
130540	2021-02-19	64	14	60
130541	2021-02-20	63	14	60
130542	2021-02-21	80	13	60
130543	2021-02-22	80	13	60
130544	2021-02-23	80	13	60
130545	2021-02-24	63	14	60
130546	2021-02-25	80	13	60
130547	2021-02-26	80	13	60
130548	2021-02-27	64	14	60
130549	2021-02-28	80	13	60
130550	2021-02-01	80	13	64
130551	2021-02-02	80	13	64
130552	2021-02-03	64	14	64
130553	2021-02-04	63	14	64
130554	2021-02-05	84	14	64
130555	2021-02-06	80	13	64
130556	2021-02-07	80	13	64
130557	2021-02-08	63	14	64
130558	2021-02-09	64	14	64
130559	2021-02-10	80	13	64
130560	2021-02-11	80	13	64
130561	2021-02-12	63	14	64
130562	2021-02-13	84	14	64
130563	2021-02-14	84	14	64
130564	2021-02-15	80	13	64
130565	2021-02-16	80	13	64
130566	2021-02-17	80	13	64
130567	2021-02-18	64	14	64
130568	2021-02-19	84	14	64
130569	2021-02-20	63	14	64
130570	2021-02-21	80	13	64
130571	2021-02-22	80	13	64
130572	2021-02-23	80	13	64
130573	2021-02-24	80	13	64
130574	2021-02-25	80	13	64
130575	2021-02-26	64	14	64
130576	2021-02-27	80	13	64
130577	2021-02-28	80	13	64
130578	2021-02-01	64	14	65
130579	2021-02-02	63	14	65
130580	2021-02-03	80	13	65
130581	2021-02-04	80	13	65
130582	2021-02-05	63	14	65
130583	2021-02-06	80	13	65
130584	2021-02-07	80	13	65
130585	2021-02-08	64	14	65
130586	2021-02-09	84	14	65
130587	2021-02-10	80	13	65
130588	2021-02-11	80	13	65
130589	2021-02-12	63	14	65
130590	2021-02-13	63	14	65
130591	2021-02-14	64	14	65
130592	2021-02-15	80	13	65
130593	2021-02-16	80	13	65
130594	2021-02-17	84	14	65
130595	2021-02-18	80	13	65
130596	2021-02-19	80	13	65
130597	2021-02-20	80	13	65
130598	2021-02-21	64	14	65
130599	2021-02-22	80	13	65
130600	2021-02-23	80	13	65
130601	2021-02-24	80	13	65
130602	2021-02-25	84	14	65
130603	2021-02-26	80	13	65
130604	2021-02-27	80	13	65
130605	2021-02-28	84	14	65
130606	2021-02-01	80	13	51
130607	2021-02-02	80	13	51
130608	2021-02-03	64	14	51
130609	2021-02-04	63	14	51
130610	2021-02-05	80	13	51
130611	2021-02-06	80	13	51
130612	2021-02-07	63	14	51
130613	2021-02-08	80	13	51
130614	2021-02-09	80	13	51
130615	2021-02-10	64	14	51
130616	2021-02-11	84	14	51
130617	2021-02-12	84	14	51
130618	2021-02-13	63	14	51
130619	2021-02-14	84	14	51
130620	2021-02-15	63	14	51
130621	2021-02-16	64	14	51
130622	2021-02-17	80	13	51
130623	2021-02-18	80	13	51
130624	2021-02-19	84	14	51
130625	2021-02-20	80	13	51
130626	2021-02-21	80	13	51
130627	2021-02-22	80	13	51
130628	2021-02-23	80	13	51
130629	2021-02-24	64	14	51
130630	2021-02-25	80	13	51
130631	2021-02-26	80	13	51
130632	2021-02-27	80	13	51
130633	2021-02-28	80	13	51
130634	2021-02-01	64	14	57
130635	2021-02-02	84	14	57
130636	2021-02-03	80	13	57
130637	2021-02-04	80	13	57
130638	2021-02-05	80	13	57
130639	2021-02-06	84	14	57
130640	2021-02-07	64	14	57
130641	2021-02-08	80	13	57
130642	2021-02-09	80	13	57
130643	2021-02-10	80	13	57
130644	2021-02-11	80	13	57
130645	2021-02-12	63	14	57
130646	2021-02-13	64	14	57
130647	2021-02-14	63	14	57
130648	2021-02-15	84	14	57
130649	2021-02-16	63	14	57
130650	2021-02-17	80	13	57
130651	2021-02-18	80	13	57
130652	2021-02-19	80	13	57
130653	2021-02-20	64	14	57
130654	2021-02-21	80	13	57
130655	2021-02-22	80	13	57
130656	2021-02-23	63	14	57
130657	2021-02-24	80	13	57
130658	2021-02-25	80	13	57
130659	2021-02-26	80	13	57
130660	2021-02-27	80	13	57
130661	2021-02-28	84	14	57
130662	2021-02-01	80	13	71
130663	2021-02-02	80	13	71
130664	2021-02-03	64	14	71
130665	2021-02-04	80	13	71
130666	2021-02-05	80	13	71
130667	2021-02-06	63	14	71
130668	2021-02-07	63	14	71
130669	2021-02-08	80	13	71
130670	2021-02-09	80	13	71
130671	2021-02-10	64	14	71
130672	2021-02-11	63	14	71
130673	2021-02-12	84	14	71
130674	2021-02-13	84	14	71
130675	2021-02-14	63	14	71
130676	2021-02-15	80	13	71
130677	2021-02-16	80	13	71
130678	2021-02-17	64	14	71
130679	2021-02-18	80	13	71
130680	2021-02-19	80	13	71
130681	2021-02-20	80	13	71
130682	2021-02-21	80	13	71
130683	2021-02-22	80	13	71
130684	2021-02-23	64	14	71
130685	2021-02-24	84	14	71
130686	2021-02-25	84	14	71
130687	2021-02-26	80	13	71
130688	2021-02-27	80	13	71
130689	2021-02-28	80	13	71
130690	2021-02-01	80	13	78
130691	2021-02-02	80	13	78
130692	2021-02-03	80	13	78
130693	2021-02-04	64	14	78
130694	2021-02-05	84	14	78
130695	2021-02-06	80	13	78
130696	2021-02-07	80	13	78
130697	2021-02-08	84	14	78
130698	2021-02-09	63	14	78
130699	2021-02-10	64	14	78
130700	2021-02-11	80	13	78
130701	2021-02-12	63	14	78
130702	2021-02-13	84	14	78
130703	2021-02-14	63	14	78
130704	2021-02-15	80	13	78
130705	2021-02-16	80	13	78
130706	2021-02-17	80	13	78
130707	2021-02-18	64	14	78
130708	2021-02-19	80	13	78
130709	2021-02-20	80	13	78
130710	2021-02-21	80	13	78
130711	2021-02-22	63	14	78
130712	2021-02-23	80	13	78
130713	2021-02-24	80	13	78
130714	2021-02-25	80	13	78
130715	2021-02-26	64	14	78
130716	2021-02-27	84	14	78
130717	2021-02-28	80	13	78
130718	2021-02-01	64	14	79
130719	2021-02-02	84	14	79
130720	2021-02-03	80	13	79
130721	2021-02-04	80	13	79
130722	2021-02-05	80	13	79
130723	2021-02-06	63	14	79
130724	2021-02-07	64	14	79
130725	2021-02-08	80	13	79
130726	2021-02-09	80	13	79
130727	2021-02-10	80	13	79
130728	2021-02-11	84	14	79
130729	2021-02-12	63	14	79
130730	2021-02-13	64	14	79
130731	2021-02-14	84	14	79
130732	2021-02-15	80	13	79
130733	2021-02-16	80	13	79
130734	2021-02-17	80	13	79
130735	2021-02-18	80	13	79
130736	2021-02-19	80	13	79
130737	2021-02-20	80	13	79
130738	2021-02-21	64	14	79
130739	2021-02-22	84	14	79
130740	2021-02-23	80	13	79
130741	2021-02-24	80	13	79
130742	2021-02-25	80	13	79
130743	2021-02-26	80	13	79
130744	2021-02-27	63	14	79
130745	2021-02-28	63	14	79
130746	2021-02-01	64	14	56
130747	2021-02-02	84	14	56
130748	2021-02-03	81	13	56
130749	2021-02-04	81	13	56
130750	2021-02-05	81	13	56
130751	2021-02-06	63	14	56
130752	2021-02-07	64	14	56
130753	2021-02-08	81	13	56
130754	2021-02-09	81	13	56
130755	2021-02-10	84	14	56
130756	2021-02-11	63	14	56
130757	2021-02-12	63	14	56
130758	2021-02-13	64	14	56
130759	2021-02-14	63	14	56
130760	2021-02-15	81	13	56
130761	2021-02-16	81	13	56
130762	2021-02-17	81	13	56
130763	2021-02-18	81	13	56
130764	2021-02-19	81	13	56
130765	2021-02-20	81	13	56
130766	2021-02-21	64	14	56
130767	2021-02-22	81	13	56
130768	2021-02-23	81	13	56
130769	2021-02-24	81	13	56
130770	2021-02-25	84	14	56
130771	2021-02-26	81	13	56
130772	2021-02-27	81	13	56
130773	2021-02-28	84	14	56
130774	2021-02-01	81	13	62
130775	2021-02-02	81	13	62
130776	2021-02-03	81	13	62
130777	2021-02-04	64	14	62
130778	2021-02-05	84	14	62
130779	2021-02-06	81	13	62
130780	2021-02-07	81	13	62
130781	2021-02-08	63	14	62
130782	2021-02-09	63	14	62
130783	2021-02-10	81	13	62
130784	2021-02-11	81	13	62
130785	2021-02-12	64	14	62
130786	2021-02-13	84	14	62
130787	2021-02-14	63	14	62
130788	2021-02-15	63	14	62
130789	2021-02-16	81	13	62
130790	2021-02-17	81	13	62
130791	2021-02-18	64	14	62
130792	2021-02-19	81	13	62
130793	2021-02-20	81	13	62
130794	2021-02-21	81	13	62
130795	2021-02-22	81	13	62
130796	2021-02-23	84	14	62
130797	2021-02-24	64	14	62
130798	2021-02-25	81	13	62
130799	2021-02-26	81	13	62
130800	2021-02-27	84	14	62
130801	2021-02-28	81	13	62
130802	2021-02-01	64	14	63
130803	2021-02-02	63	14	63
130804	2021-02-03	84	14	63
130805	2021-02-04	84	14	63
130806	2021-02-05	81	13	63
130807	2021-02-06	81	13	63
130808	2021-02-07	81	13	63
130809	2021-02-08	81	13	63
130810	2021-02-09	81	13	63
130811	2021-02-10	64	14	63
130812	2021-02-11	63	14	63
130813	2021-02-12	63	14	63
130814	2021-02-13	84	14	63
130815	2021-02-14	63	14	63
130816	2021-02-15	81	13	63
130817	2021-02-16	81	13	63
130818	2021-02-17	81	13	63
130819	2021-02-18	81	13	63
130820	2021-02-19	81	13	63
130821	2021-02-20	81	13	63
130822	2021-02-21	64	14	63
130823	2021-02-22	84	14	63
130824	2021-02-23	81	13	63
130825	2021-02-24	81	13	63
130826	2021-02-25	64	14	63
130827	2021-02-26	81	13	63
130828	2021-02-27	81	13	63
130829	2021-02-28	81	13	63
130830	2021-02-01	64	14	67
130831	2021-02-02	63	14	67
130832	2021-02-03	84	14	67
130833	2021-02-04	81	13	67
130834	2021-02-05	81	13	67
130835	2021-02-06	84	14	67
130836	2021-02-07	81	13	67
130837	2021-02-08	81	13	67
130838	2021-02-09	81	13	67
130839	2021-02-10	81	13	67
130840	2021-02-11	81	13	67
130841	2021-02-12	64	14	67
130842	2021-02-13	63	14	67
130843	2021-02-14	84	14	67
130844	2021-02-15	63	14	67
130845	2021-02-16	63	14	67
130846	2021-02-17	81	13	67
130847	2021-02-18	81	13	67
130848	2021-02-19	81	13	67
130849	2021-02-20	64	14	67
130850	2021-02-21	81	13	67
130851	2021-02-22	81	13	67
130852	2021-02-23	84	14	67
130853	2021-02-24	81	13	67
130854	2021-02-25	81	13	67
130855	2021-02-26	81	13	67
130856	2021-02-27	64	14	67
130857	2021-02-28	81	13	67
130858	2021-02-01	81	13	73
130859	2021-02-02	81	13	73
130860	2021-02-03	64	14	73
130861	2021-02-04	81	13	73
130862	2021-02-05	81	13	73
130863	2021-02-06	81	13	73
130864	2021-02-07	84	14	73
130865	2021-02-08	63	14	73
130866	2021-02-09	64	14	73
130867	2021-02-10	84	14	73
130868	2021-02-11	84	14	73
130869	2021-02-12	63	14	73
130870	2021-02-13	84	14	73
130871	2021-02-14	63	14	73
130872	2021-02-15	81	13	73
130873	2021-02-16	81	13	73
130874	2021-02-17	81	13	73
130875	2021-02-18	81	13	73
130876	2021-02-19	64	14	73
130877	2021-02-20	81	13	73
130878	2021-02-21	81	13	73
130879	2021-02-22	81	13	73
130880	2021-02-23	63	14	73
130881	2021-02-24	81	13	73
130882	2021-02-25	81	13	73
130883	2021-02-26	81	13	73
130884	2021-02-27	81	13	73
130885	2021-02-28	64	14	73
130886	2021-02-01	81	13	66
130887	2021-02-02	81	13	66
130888	2021-02-03	81	13	66
130889	2021-02-04	64	14	66
130890	2021-02-05	84	14	66
130891	2021-02-06	84	14	66
130892	2021-02-07	84	14	66
130893	2021-02-08	63	14	66
130894	2021-02-09	81	13	66
130895	2021-02-10	81	13	66
130896	2021-02-11	81	13	66
130897	2021-02-12	64	14	66
130898	2021-02-13	63	14	66
130899	2021-02-14	84	14	66
130900	2021-02-15	81	13	66
130901	2021-02-16	81	13	66
130902	2021-02-17	81	13	66
130903	2021-02-18	81	13	66
130904	2021-02-19	81	13	66
130905	2021-02-20	64	14	66
130906	2021-02-21	81	13	66
130907	2021-02-22	81	13	66
130908	2021-02-23	81	13	66
130909	2021-02-24	63	14	66
130910	2021-02-25	63	14	66
130911	2021-02-26	81	13	66
130912	2021-02-27	81	13	66
130913	2021-02-28	64	14	66
130914	2021-02-01	81	13	55
130915	2021-02-02	81	13	55
130916	2021-02-03	81	13	55
130917	2021-02-04	64	14	55
130918	2021-02-05	84	14	55
130919	2021-02-06	81	13	55
130920	2021-02-07	81	13	55
130921	2021-02-08	81	13	55
130922	2021-02-09	84	14	55
130923	2021-02-10	64	14	55
130924	2021-02-11	81	13	55
130925	2021-02-12	63	14	55
130926	2021-02-13	84	14	55
130927	2021-02-14	63	14	55
130928	2021-02-15	81	13	55
130929	2021-02-16	81	13	55
130930	2021-02-17	64	14	55
130931	2021-02-18	63	14	55
130932	2021-02-19	84	14	55
130933	2021-02-20	81	13	55
130934	2021-02-21	81	13	55
130935	2021-02-22	63	14	55
130936	2021-02-23	81	13	55
130937	2021-02-24	81	13	55
130938	2021-02-25	81	13	55
130939	2021-02-26	64	14	55
130940	2021-02-27	81	13	55
130941	2021-02-28	81	13	55
130942	2021-02-01	64	14	45
130943	2021-02-02	83	13	45
130944	2021-02-03	83	13	45
130945	2021-02-04	83	13	45
130946	2021-02-05	84	14	45
130947	2021-02-06	63	14	45
130948	2021-02-07	83	13	45
130949	2021-02-08	83	13	45
130950	2021-02-09	64	14	45
130951	2021-02-10	84	14	45
130952	2021-02-11	83	13	45
130953	2021-02-12	63	14	45
130954	2021-02-13	63	14	45
130955	2021-02-14	84	14	45
130956	2021-02-15	83	13	45
130957	2021-02-16	83	13	45
130958	2021-02-17	64	14	45
130959	2021-02-18	83	13	45
130960	2021-02-19	83	13	45
130961	2021-02-20	83	13	45
130962	2021-02-21	83	13	45
130963	2021-02-22	84	14	45
130964	2021-02-23	64	14	45
130965	2021-02-24	83	13	45
130966	2021-02-25	83	13	45
130967	2021-02-26	63	14	45
130968	2021-02-27	83	13	45
130969	2021-02-28	83	13	45
130970	2021-02-01	83	13	68
130971	2021-02-02	83	13	68
130972	2021-02-03	64	14	68
130973	2021-02-04	83	13	68
130974	2021-02-05	83	13	68
130975	2021-02-06	83	13	68
130976	2021-02-07	63	14	68
130977	2021-02-08	84	14	68
130978	2021-02-09	83	13	68
130979	2021-02-10	83	13	68
130980	2021-02-11	64	14	68
130981	2021-02-12	63	14	68
130982	2021-02-13	84	14	68
130983	2021-02-14	84	14	68
130984	2021-02-15	63	14	68
130985	2021-02-16	83	13	68
130986	2021-02-17	83	13	68
130987	2021-02-18	64	14	68
130988	2021-02-19	83	13	68
130989	2021-02-20	83	13	68
130990	2021-02-21	84	14	68
130991	2021-02-22	83	13	68
130992	2021-02-23	83	13	68
130993	2021-02-24	83	13	68
130994	2021-02-25	83	13	68
130995	2021-02-26	83	13	68
130996	2021-02-27	64	14	68
130997	2021-02-28	63	14	68
130998	2021-02-01	64	14	53
130999	2021-02-02	63	14	53
131000	2021-02-03	83	13	53
131001	2021-02-04	83	13	53
131002	2021-02-05	63	14	53
131003	2021-02-06	84	14	53
131004	2021-02-07	83	13	53
131005	2021-02-08	83	13	53
131006	2021-02-09	64	14	53
131007	2021-02-10	63	14	53
131008	2021-02-11	84	14	53
131009	2021-02-12	84	14	53
131010	2021-02-13	63	14	53
131011	2021-02-14	84	14	53
131012	2021-02-15	83	13	53
131013	2021-02-16	83	13	53
131014	2021-02-17	83	13	53
131015	2021-02-18	83	13	53
131016	2021-02-19	83	13	53
131017	2021-02-20	83	13	53
131018	2021-02-21	64	14	53
131019	2021-02-22	83	13	53
131020	2021-02-23	83	13	53
131021	2021-02-24	83	13	53
131022	2021-02-25	83	13	53
131023	2021-02-26	64	14	53
131024	2021-02-27	83	13	53
131025	2021-02-28	83	13	53
131026	2021-02-01	83	13	54
131027	2021-02-02	83	13	54
131028	2021-02-03	64	14	54
131029	2021-02-04	84	14	54
131030	2021-02-05	84	14	54
131031	2021-02-06	83	13	54
131032	2021-02-07	83	13	54
131033	2021-02-08	63	14	54
131034	2021-02-09	64	14	54
131035	2021-02-10	83	13	54
131036	2021-02-11	83	13	54
131037	2021-02-12	84	14	54
131038	2021-02-13	63	14	54
131039	2021-02-14	63	14	54
131040	2021-02-15	83	13	54
131041	2021-02-16	83	13	54
131042	2021-02-17	83	13	54
131043	2021-02-18	83	13	54
131044	2021-02-19	64	14	54
131045	2021-02-20	63	14	54
131046	2021-02-21	83	13	54
131047	2021-02-22	83	13	54
131048	2021-02-23	84	14	54
131049	2021-02-24	83	13	54
131050	2021-02-25	83	13	54
131051	2021-02-26	83	13	54
131052	2021-02-27	64	14	54
131053	2021-02-28	83	13	54
131054	2021-02-01	64	14	49
131055	2021-02-02	84	14	49
131056	2021-02-03	83	13	49
131057	2021-02-04	83	13	49
131058	2021-02-05	83	13	49
131059	2021-02-06	63	14	49
131060	2021-02-07	64	14	49
131061	2021-02-08	84	14	49
131062	2021-02-09	83	13	49
131063	2021-02-10	83	13	49
131064	2021-02-11	83	13	49
131065	2021-02-12	63	14	49
131066	2021-02-13	64	14	49
131067	2021-02-14	63	14	49
131068	2021-02-15	83	13	49
131069	2021-02-16	83	13	49
131070	2021-02-17	83	13	49
131071	2021-02-18	63	14	49
131072	2021-02-19	83	13	49
131073	2021-02-20	83	13	49
131074	2021-02-21	83	13	49
131075	2021-02-22	64	14	49
131076	2021-02-23	83	13	49
131077	2021-02-24	83	13	49
131078	2021-02-25	84	14	49
131079	2021-02-26	83	13	49
131080	2021-02-27	83	13	49
131081	2021-02-28	84	14	49
131082	2021-02-01	83	13	50
131083	2021-02-02	83	13	50
131084	2021-02-03	64	14	50
131085	2021-02-04	84	14	50
131086	2021-02-05	83	13	50
131087	2021-02-06	83	13	50
131088	2021-02-07	63	14	50
131089	2021-02-08	83	13	50
131090	2021-02-09	83	13	50
131091	2021-02-10	64	14	50
131092	2021-02-11	63	14	50
131093	2021-02-12	84	14	50
131094	2021-02-13	63	14	50
131095	2021-02-14	84	14	50
131096	2021-02-15	84	14	50
131097	2021-02-16	64	14	50
131098	2021-02-17	63	14	50
131099	2021-02-18	83	13	50
131100	2021-02-19	83	13	50
131101	2021-02-20	83	13	50
131102	2021-02-21	83	13	50
131103	2021-02-22	83	13	50
131104	2021-02-23	83	13	50
131105	2021-02-24	64	14	50
131106	2021-02-25	83	13	50
131107	2021-02-26	83	13	50
131108	2021-02-27	83	13	50
131109	2021-02-28	83	13	50
131110	2021-02-01	82	16	43
131111	2021-02-02	82	16	43
131112	2021-02-03	82	16	43
131113	2021-02-04	82	16	43
131114	2021-02-05	82	16	43
131115	2021-02-06	63	14	43
131116	2021-02-07	64	14	43
131117	2021-02-08	82	16	43
131118	2021-02-09	82	16	43
131119	2021-02-10	82	16	43
131120	2021-02-11	84	14	43
131121	2021-02-12	84	14	43
131122	2021-02-13	63	14	43
131123	2021-02-14	64	14	43
131124	2021-02-15	84	14	43
131125	2021-02-16	84	14	43
131126	2021-02-17	82	16	43
131127	2021-02-18	82	16	43
131128	2021-02-19	82	16	43
131129	2021-02-20	63	14	43
131130	2021-02-21	64	14	43
131131	2021-02-22	82	16	43
131132	2021-02-23	82	16	43
131133	2021-02-24	82	16	43
131134	2021-02-25	82	16	43
131135	2021-02-26	82	16	43
131136	2021-02-27	63	14	43
131137	2021-02-28	64	14	43
131138	2021-02-01	82	16	44
131139	2021-02-02	82	16	44
131140	2021-02-03	82	16	44
131141	2021-02-04	82	16	44
131142	2021-02-05	82	16	44
131143	2021-02-06	63	14	44
131144	2021-02-07	64	14	44
131145	2021-02-08	82	16	44
131146	2021-02-09	82	16	44
131147	2021-02-10	82	16	44
131148	2021-02-11	84	14	44
131149	2021-02-12	84	14	44
131150	2021-02-13	63	14	44
131151	2021-02-14	64	14	44
131152	2021-02-15	84	14	44
131153	2021-02-16	84	14	44
131154	2021-02-17	82	16	44
131155	2021-02-18	82	16	44
131156	2021-02-19	82	16	44
131157	2021-02-20	63	14	44
131158	2021-02-21	64	14	44
131159	2021-02-22	82	16	44
131160	2021-02-23	82	16	44
131161	2021-02-24	82	16	44
131162	2021-02-25	82	16	44
131163	2021-02-26	82	16	44
131164	2021-02-27	63	14	44
131165	2021-02-28	64	14	44
131166	2020-06-01	80	13	47
131167	2020-06-02	80	13	47
131168	2020-06-03	64	14	47
131169	2020-06-04	80	13	47
131170	2020-06-05	80	13	47
131171	2020-06-06	63	14	47
131172	2020-06-07	80	13	47
131173	2020-06-08	80	13	47
131174	2020-06-09	80	13	47
131175	2020-06-10	64	14	47
131176	2020-06-11	80	13	47
131177	2020-06-12	80	13	47
131178	2020-06-13	80	13	47
131179	2020-06-14	80	13	47
131180	2020-06-15	63	14	47
131181	2020-06-16	80	13	47
131182	2020-06-17	80	13	47
131183	2020-06-18	80	13	47
131184	2020-06-19	80	13	47
131185	2020-06-20	64	14	47
131186	2020-06-21	80	13	47
131187	2020-06-22	80	13	47
131188	2020-06-23	80	13	47
131189	2020-06-24	63	14	47
131190	2020-06-25	80	13	47
131191	2020-06-26	80	13	47
131192	2020-06-27	80	13	47
131193	2020-06-28	64	14	47
131194	2020-06-29	63	14	47
131195	2020-06-30	80	13	47
131196	2020-06-01	64	14	69
131197	2020-06-02	63	14	69
131198	2020-06-03	80	13	69
131199	2020-06-04	80	13	69
131200	2020-06-05	80	13	69
131201	2020-06-06	80	13	69
131202	2020-06-07	80	13	69
131203	2020-06-08	64	14	69
131204	2020-06-09	80	13	69
131205	2020-06-10	80	13	69
131206	2020-06-11	63	14	69
131207	2020-06-12	80	13	69
131208	2020-06-13	80	13	69
131209	2020-06-14	80	13	69
131210	2020-06-15	80	13	69
131211	2020-06-16	80	13	69
131212	2020-06-17	80	13	69
131213	2020-06-18	64	14	69
131214	2020-06-19	63	14	69
131215	2020-06-20	80	13	69
131216	2020-06-21	80	13	69
131217	2020-06-22	80	13	69
131218	2020-06-23	80	13	69
131219	2020-06-24	80	13	69
131220	2020-06-25	64	14	69
131221	2020-06-26	80	13	69
131222	2020-06-27	80	13	69
131223	2020-06-28	80	13	69
131224	2020-06-29	80	13	69
131225	2020-06-30	63	14	69
131226	2020-06-01	80	13	46
131227	2020-06-02	80	13	46
131228	2020-06-03	80	13	46
131229	2020-06-04	64	14	46
131230	2020-06-05	63	14	46
131231	2020-06-06	80	13	46
131232	2020-06-07	80	13	46
131233	2020-06-08	80	13	46
131234	2020-06-09	63	14	46
131235	2020-06-10	80	13	46
131236	2020-06-11	80	13	46
131237	2020-06-12	64	14	46
131238	2020-06-13	63	14	46
131239	2020-06-14	80	13	46
131240	2020-06-15	80	13	46
131241	2020-06-16	63	14	46
131242	2020-06-17	80	13	46
131243	2020-06-18	80	13	46
131244	2020-06-19	80	13	46
131245	2020-06-20	80	13	46
131246	2020-06-21	80	13	46
131247	2020-06-22	80	13	46
131248	2020-06-23	64	14	46
131249	2020-06-24	80	13	46
131250	2020-06-25	80	13	46
131251	2020-06-26	80	13	46
131252	2020-06-27	80	13	46
131253	2020-06-28	80	13	46
131254	2020-06-29	64	14	46
131255	2020-06-30	80	13	46
131256	2020-06-01	80	13	60
131257	2020-06-02	80	13	60
131258	2020-06-03	80	13	60
131259	2020-06-04	80	13	60
131260	2020-06-05	80	13	60
131261	2020-06-06	80	13	60
131262	2020-06-07	64	14	60
131263	2020-06-08	63	14	60
131264	2020-06-09	80	13	60
131265	2020-06-10	80	13	60
131266	2020-06-11	80	13	60
131267	2020-06-12	80	13	60
131268	2020-06-13	80	13	60
131269	2020-06-14	64	14	60
131270	2020-06-15	80	13	60
131271	2020-06-16	80	13	60
131272	2020-06-17	63	14	60
131273	2020-06-18	80	13	60
131274	2020-06-19	80	13	60
131275	2020-06-20	80	13	60
131276	2020-06-21	64	14	60
131277	2020-06-22	63	14	60
131278	2020-06-23	80	13	60
131279	2020-06-24	80	13	60
131280	2020-06-25	80	13	60
131281	2020-06-26	63	14	60
131282	2020-06-27	64	14	60
131283	2020-06-28	80	13	60
131284	2020-06-29	80	13	60
131285	2020-06-30	80	13	60
131286	2020-06-01	64	14	64
131287	2020-06-02	63	14	64
131288	2020-06-03	80	13	64
131289	2020-06-04	80	13	64
131290	2020-06-05	80	13	64
131291	2020-06-06	80	13	64
131292	2020-06-07	80	13	64
131293	2020-06-08	80	13	64
131294	2020-06-09	64	14	64
131295	2020-06-10	80	13	64
131296	2020-06-11	80	13	64
131297	2020-06-12	63	14	64
131298	2020-06-13	80	13	64
131299	2020-06-14	80	13	64
131300	2020-06-15	64	14	64
131301	2020-06-16	80	13	64
131302	2020-06-17	80	13	64
131303	2020-06-18	80	13	64
131304	2020-06-19	63	14	64
131305	2020-06-20	80	13	64
131306	2020-06-21	80	13	64
131307	2020-06-22	64	14	64
131308	2020-06-23	80	13	64
131309	2020-06-24	80	13	64
131310	2020-06-25	80	13	64
131311	2020-06-26	80	13	64
131312	2020-06-27	80	13	64
131313	2020-06-28	63	14	64
131314	2020-06-29	80	13	64
131315	2020-06-30	80	13	64
131316	2020-06-01	80	13	65
131317	2020-06-02	80	13	65
131318	2020-06-03	80	13	65
131319	2020-06-04	64	14	65
131320	2020-06-05	80	13	65
131321	2020-06-06	80	13	65
131322	2020-06-07	63	14	65
131323	2020-06-08	80	13	65
131324	2020-06-09	80	13	65
131325	2020-06-10	64	14	65
131326	2020-06-11	80	13	65
131327	2020-06-12	80	13	65
131328	2020-06-13	80	13	65
131329	2020-06-14	80	13	65
131330	2020-06-15	80	13	65
131331	2020-06-16	80	13	65
131332	2020-06-17	64	14	65
131333	2020-06-18	63	14	65
131334	2020-06-19	80	13	65
131335	2020-06-20	80	13	65
131336	2020-06-21	63	14	65
131337	2020-06-22	80	13	65
131338	2020-06-23	80	13	65
131339	2020-06-24	80	13	65
131340	2020-06-25	80	13	65
131341	2020-06-26	64	14	65
131342	2020-06-27	80	13	65
131343	2020-06-28	80	13	65
131344	2020-06-29	80	13	65
131345	2020-06-30	63	14	65
131346	2020-06-01	80	13	51
131347	2020-06-02	80	13	51
131348	2020-06-03	64	14	51
131349	2020-06-04	80	13	51
131350	2020-06-05	80	13	51
131351	2020-06-06	80	13	51
131352	2020-06-07	80	13	51
131353	2020-06-08	63	14	51
131354	2020-06-09	80	13	51
131355	2020-06-10	80	13	51
131356	2020-06-11	64	14	51
131357	2020-06-12	63	14	51
131358	2020-06-13	80	13	51
131359	2020-06-14	80	13	51
131360	2020-06-15	63	14	51
131361	2020-06-16	63	14	51
131362	2020-06-17	80	13	51
131363	2020-06-18	80	13	51
131364	2020-06-19	80	13	51
131365	2020-06-20	80	13	51
131366	2020-06-21	80	13	51
131367	2020-06-22	80	13	51
131368	2020-06-23	64	14	51
131369	2020-06-24	80	13	51
131370	2020-06-25	80	13	51
131371	2020-06-26	80	13	51
131372	2020-06-27	64	14	51
131373	2020-06-28	80	13	51
131374	2020-06-29	80	13	51
131375	2020-06-30	80	13	51
131376	2020-06-01	80	13	57
131377	2020-06-02	80	13	57
131378	2020-06-03	80	13	57
131379	2020-06-04	64	14	57
131380	2020-06-05	63	14	57
131381	2020-06-06	80	13	57
131382	2020-06-07	80	13	57
131383	2020-06-08	80	13	57
131384	2020-06-09	80	13	57
131385	2020-06-10	64	14	57
131386	2020-06-11	80	13	57
131387	2020-06-12	80	13	57
131388	2020-06-13	63	14	57
131389	2020-06-14	80	13	57
131390	2020-06-15	80	13	57
131391	2020-06-16	80	13	57
131392	2020-06-17	64	14	57
131393	2020-06-18	80	13	57
131394	2020-06-19	80	13	57
131395	2020-06-20	80	13	57
131396	2020-06-21	80	13	57
131397	2020-06-22	80	13	57
131398	2020-06-23	64	14	57
131399	2020-06-24	63	14	57
131400	2020-06-25	80	13	57
131401	2020-06-26	80	13	57
131402	2020-06-27	80	13	57
131403	2020-06-28	80	13	57
131404	2020-06-29	80	13	57
131405	2020-06-30	63	14	57
131406	2020-06-01	80	13	71
131407	2020-06-02	80	13	71
131408	2020-06-03	64	14	71
131409	2020-06-04	80	13	71
131410	2020-06-05	80	13	71
131411	2020-06-06	63	14	71
131412	2020-06-07	63	14	71
131413	2020-06-08	80	13	71
131414	2020-06-09	80	13	71
131415	2020-06-10	80	13	71
131416	2020-06-11	80	13	71
131417	2020-06-12	80	13	71
131418	2020-06-13	80	13	71
131419	2020-06-14	64	14	71
131420	2020-06-15	80	13	71
131421	2020-06-16	80	13	71
131422	2020-06-17	80	13	71
131423	2020-06-18	63	14	71
131424	2020-06-19	63	14	71
131425	2020-06-20	80	13	71
131426	2020-06-21	80	13	71
131427	2020-06-22	80	13	71
131428	2020-06-23	80	13	71
131429	2020-06-24	64	14	71
131430	2020-06-25	64	14	71
131431	2020-06-26	80	13	71
131432	2020-06-27	80	13	71
131433	2020-06-28	80	13	71
131434	2020-06-29	80	13	71
131435	2020-06-30	80	13	71
131436	2020-06-01	64	14	78
131437	2020-06-02	63	14	78
131438	2020-06-03	80	13	78
131439	2020-06-04	80	13	78
131440	2020-06-05	80	13	78
131441	2020-06-06	80	13	78
131442	2020-06-07	80	13	78
131443	2020-06-08	80	13	78
131444	2020-06-09	64	14	78
131445	2020-06-10	80	13	78
131446	2020-06-11	80	13	78
131447	2020-06-12	80	13	78
131448	2020-06-13	80	13	78
131449	2020-06-14	80	13	78
131450	2020-06-15	80	13	78
131451	2020-06-16	64	14	78
131452	2020-06-17	80	13	78
131453	2020-06-18	80	13	78
131454	2020-06-19	80	13	78
131455	2020-06-20	80	13	78
131456	2020-06-21	80	13	78
131457	2020-06-22	64	14	78
131458	2020-06-23	80	13	78
131459	2020-06-24	80	13	78
131460	2020-06-25	63	14	78
131461	2020-06-26	63	14	78
131462	2020-06-27	80	13	78
131463	2020-06-28	80	13	78
131464	2020-06-29	63	14	78
131465	2020-06-30	80	13	78
131466	2020-06-01	80	13	79
131467	2020-06-02	80	13	79
131468	2020-06-03	80	13	79
131469	2020-06-04	80	13	79
131470	2020-06-05	64	14	79
131471	2020-06-06	80	13	79
131472	2020-06-07	80	13	79
131473	2020-06-08	63	14	79
131474	2020-06-09	80	13	79
131475	2020-06-10	80	13	79
131476	2020-06-11	64	14	79
131477	2020-06-12	80	13	79
131478	2020-06-13	80	13	79
131479	2020-06-14	63	14	79
131480	2020-06-15	80	13	79
131481	2020-06-16	80	13	79
131482	2020-06-17	64	14	79
131483	2020-06-18	80	13	79
131484	2020-06-19	80	13	79
131485	2020-06-20	63	14	79
131486	2020-06-21	80	13	79
131487	2020-06-22	80	13	79
131488	2020-06-23	80	13	79
131489	2020-06-24	80	13	79
131490	2020-06-25	64	14	79
131491	2020-06-26	80	13	79
131492	2020-06-27	80	13	79
131493	2020-06-28	80	13	79
131494	2020-06-29	63	14	79
131495	2020-06-30	80	13	79
131496	2020-06-01	64	14	56
131497	2020-06-02	63	14	56
131498	2020-06-03	63	14	56
131499	2020-06-04	81	13	56
131500	2020-06-05	81	13	56
131501	2020-06-06	81	13	56
131502	2020-06-07	81	13	56
131503	2020-06-08	64	14	56
131504	2020-06-09	81	13	56
131505	2020-06-10	81	13	56
131506	2020-06-11	81	13	56
131507	2020-06-12	81	13	56
131508	2020-06-13	63	14	56
131509	2020-06-14	81	13	56
131510	2020-06-15	81	13	56
131511	2020-06-16	64	14	56
131512	2020-06-17	81	13	56
131513	2020-06-18	81	13	56
131514	2020-06-19	81	13	56
131515	2020-06-20	81	13	56
131516	2020-06-21	81	13	56
131517	2020-06-22	81	13	56
131518	2020-06-23	64	14	56
131519	2020-06-24	81	13	56
131520	2020-06-25	81	13	56
131521	2020-06-26	81	13	56
131522	2020-06-27	81	13	56
131523	2020-06-28	81	13	56
131524	2020-06-29	81	13	56
131525	2020-06-30	63	14	56
131526	2020-06-01	81	13	62
131527	2020-06-02	81	13	62
131528	2020-06-03	81	13	62
131529	2020-06-04	81	13	62
131530	2020-06-05	81	13	62
131531	2020-06-06	64	14	62
131532	2020-06-07	81	13	62
131533	2020-06-08	81	13	62
131534	2020-06-09	81	13	62
131535	2020-06-10	63	14	62
131536	2020-06-11	81	13	62
131537	2020-06-12	81	13	62
131538	2020-06-13	81	13	62
131539	2020-06-14	64	14	62
131540	2020-06-15	63	14	62
131541	2020-06-16	81	13	62
131542	2020-06-17	81	13	62
131543	2020-06-18	63	14	62
131544	2020-06-19	81	13	62
131545	2020-06-20	81	13	62
131546	2020-06-21	64	14	62
131547	2020-06-22	63	14	62
131548	2020-06-23	81	13	62
131549	2020-06-24	81	13	62
131550	2020-06-25	81	13	62
131551	2020-06-26	64	14	62
131552	2020-06-27	81	13	62
131553	2020-06-28	81	13	62
131554	2020-06-29	81	13	62
131555	2020-06-30	81	13	62
131556	2020-06-01	81	13	63
131557	2020-06-02	81	13	63
131558	2020-06-03	81	13	63
131559	2020-06-04	81	13	63
131560	2020-06-05	64	14	63
131561	2020-06-06	81	13	63
131562	2020-06-07	81	13	63
131563	2020-06-08	63	14	63
131564	2020-06-09	63	14	63
131565	2020-06-10	81	13	63
131566	2020-06-11	81	13	63
131567	2020-06-12	81	13	63
131568	2020-06-13	81	13	63
131569	2020-06-14	81	13	63
131570	2020-06-15	81	13	63
131571	2020-06-16	64	14	63
131572	2020-06-17	81	13	63
131573	2020-06-18	81	13	63
131574	2020-06-19	81	13	63
131575	2020-06-20	63	14	63
131576	2020-06-21	81	13	63
131577	2020-06-22	81	13	63
131578	2020-06-23	64	14	63
131579	2020-06-24	81	13	63
131580	2020-06-25	81	13	63
131581	2020-06-26	63	14	63
131582	2020-06-27	81	13	63
131583	2020-06-28	81	13	63
131584	2020-06-29	64	14	63
131585	2020-06-30	81	13	63
131586	2020-06-01	64	14	67
131587	2020-06-02	63	14	67
131588	2020-06-03	81	13	67
131589	2020-06-04	81	13	67
131590	2020-06-05	81	13	67
131591	2020-06-06	81	13	67
131592	2020-06-07	81	13	67
131593	2020-06-08	81	13	67
131594	2020-06-09	64	14	67
131595	2020-06-10	81	13	67
131596	2020-06-11	81	13	67
131597	2020-06-12	63	14	67
131598	2020-06-13	81	13	67
131599	2020-06-14	81	13	67
131600	2020-06-15	81	13	67
131601	2020-06-16	81	13	67
131602	2020-06-17	64	14	67
131603	2020-06-18	63	14	67
131604	2020-06-19	81	13	67
131605	2020-06-20	81	13	67
131606	2020-06-21	81	13	67
131607	2020-06-22	81	13	67
131608	2020-06-23	81	13	67
131609	2020-06-24	64	14	67
131610	2020-06-25	81	13	67
131611	2020-06-26	81	13	67
131612	2020-06-27	81	13	67
131613	2020-06-28	81	13	67
131614	2020-06-29	81	13	67
131615	2020-06-30	63	14	67
131616	2020-06-01	81	13	73
131617	2020-06-02	81	13	73
131618	2020-06-03	64	14	73
131619	2020-06-04	63	14	73
131620	2020-06-05	63	14	73
131621	2020-06-06	81	13	73
131622	2020-06-07	81	13	73
131623	2020-06-08	81	13	73
131624	2020-06-09	81	13	73
131625	2020-06-10	81	13	73
131626	2020-06-11	81	13	73
131627	2020-06-12	64	14	73
131628	2020-06-13	81	13	73
131629	2020-06-14	81	13	73
131630	2020-06-15	81	13	73
131631	2020-06-16	81	13	73
131632	2020-06-17	63	14	73
131633	2020-06-18	81	13	73
131634	2020-06-19	81	13	73
131635	2020-06-20	81	13	73
131636	2020-06-21	81	13	73
131637	2020-06-22	64	14	73
131638	2020-06-23	81	13	73
131639	2020-06-24	81	13	73
131640	2020-06-25	63	14	73
131641	2020-06-26	81	13	73
131642	2020-06-27	81	13	73
131643	2020-06-28	81	13	73
131644	2020-06-29	64	14	73
131645	2020-06-30	81	13	73
131646	2020-06-01	64	14	66
131647	2020-06-02	81	13	66
131648	2020-06-03	81	13	66
131649	2020-06-04	63	14	66
131650	2020-06-05	81	13	66
131651	2020-06-06	81	13	66
131652	2020-06-07	81	13	66
131653	2020-06-08	81	13	66
131654	2020-06-09	81	13	66
131655	2020-06-10	64	14	66
131656	2020-06-11	63	14	66
131657	2020-06-12	81	13	66
131658	2020-06-13	81	13	66
131659	2020-06-14	81	13	66
131660	2020-06-15	81	13	66
131661	2020-06-16	64	14	66
131662	2020-06-17	81	13	66
131663	2020-06-18	81	13	66
131664	2020-06-19	63	14	66
131665	2020-06-20	81	13	66
131666	2020-06-21	81	13	66
131667	2020-06-22	81	13	66
131668	2020-06-23	81	13	66
131669	2020-06-24	64	14	66
131670	2020-06-25	81	13	66
131671	2020-06-26	81	13	66
131672	2020-06-27	63	14	66
131673	2020-06-28	81	13	66
131674	2020-06-29	81	13	66
131675	2020-06-30	81	13	66
131676	2020-06-01	81	13	55
131677	2020-06-02	81	13	55
131678	2020-06-03	64	14	55
131679	2020-06-04	81	13	55
131680	2020-06-05	81	13	55
131681	2020-06-06	81	13	55
131682	2020-06-07	63	14	55
131683	2020-06-08	81	13	55
131684	2020-06-09	81	13	55
131685	2020-06-10	64	14	55
131686	2020-06-11	63	14	55
131687	2020-06-12	81	13	55
131688	2020-06-13	81	13	55
131689	2020-06-14	81	13	55
131690	2020-06-15	63	14	55
131691	2020-06-16	81	13	55
131692	2020-06-17	81	13	55
131693	2020-06-18	81	13	55
131694	2020-06-19	64	14	55
131695	2020-06-20	81	13	55
131696	2020-06-21	81	13	55
131697	2020-06-22	81	13	55
131698	2020-06-23	81	13	55
131699	2020-06-24	81	13	55
131700	2020-06-25	64	14	55
131701	2020-06-26	81	13	55
131702	2020-06-27	81	13	55
131703	2020-06-28	63	14	55
131704	2020-06-29	81	13	55
131705	2020-06-30	81	13	55
131706	2020-06-01	83	13	45
131707	2020-06-02	83	13	45
131708	2020-06-03	64	14	45
131709	2020-06-04	83	13	45
131710	2020-06-05	83	13	45
131711	2020-06-06	63	14	45
131712	2020-06-07	83	13	45
131713	2020-06-08	83	13	45
131714	2020-06-09	83	13	45
131715	2020-06-10	64	14	45
131716	2020-06-11	83	13	45
131717	2020-06-12	83	13	45
131718	2020-06-13	83	13	45
131719	2020-06-14	63	14	45
131720	2020-06-15	63	14	45
131721	2020-06-16	83	13	45
131722	2020-06-17	83	13	45
131723	2020-06-18	83	13	45
131724	2020-06-19	83	13	45
131725	2020-06-20	64	14	45
131726	2020-06-21	83	13	45
131727	2020-06-22	83	13	45
131728	2020-06-23	83	13	45
131729	2020-06-24	63	14	45
131730	2020-06-25	83	13	45
131731	2020-06-26	83	13	45
131732	2020-06-27	64	14	45
131733	2020-06-28	83	13	45
131734	2020-06-29	83	13	45
131735	2020-06-30	83	13	45
131736	2020-06-01	83	13	68
131737	2020-06-02	83	13	68
131738	2020-06-03	83	13	68
131739	2020-06-04	83	13	68
131740	2020-06-05	83	13	68
131741	2020-06-06	83	13	68
131742	2020-06-07	64	14	68
131743	2020-06-08	63	14	68
131744	2020-06-09	83	13	68
131745	2020-06-10	83	13	68
131746	2020-06-11	83	13	68
131747	2020-06-12	83	13	68
131748	2020-06-13	64	14	68
131749	2020-06-14	83	13	68
131750	2020-06-15	83	13	68
131751	2020-06-16	83	13	68
131752	2020-06-17	83	13	68
131753	2020-06-18	63	14	68
131754	2020-06-19	83	13	68
131755	2020-06-20	83	13	68
131756	2020-06-21	83	13	68
131757	2020-06-22	64	14	68
131758	2020-06-23	83	13	68
131759	2020-06-24	83	13	68
131760	2020-06-25	63	14	68
131761	2020-06-26	83	13	68
131762	2020-06-27	83	13	68
131763	2020-06-28	64	14	68
131764	2020-06-29	63	14	68
131765	2020-06-30	83	13	68
131766	2020-06-01	64	14	53
131767	2020-06-02	63	14	53
131768	2020-06-03	83	13	53
131769	2020-06-04	83	13	53
131770	2020-06-05	83	13	53
131771	2020-06-06	83	13	53
131772	2020-06-07	83	13	53
131773	2020-06-08	64	14	53
131774	2020-06-09	83	13	53
131775	2020-06-10	83	13	53
131776	2020-06-11	63	14	53
131777	2020-06-12	83	13	53
131778	2020-06-13	83	13	53
131779	2020-06-14	83	13	53
131780	2020-06-15	83	13	53
131781	2020-06-16	83	13	53
131782	2020-06-17	83	13	53
131783	2020-06-18	64	14	53
131784	2020-06-19	83	13	53
131785	2020-06-20	83	13	53
131786	2020-06-21	63	14	53
131787	2020-06-22	83	13	53
131788	2020-06-23	83	13	53
131789	2020-06-24	83	13	53
131790	2020-06-25	83	13	53
131791	2020-06-26	64	14	53
131792	2020-06-27	83	13	53
131793	2020-06-28	83	13	53
131794	2020-06-29	83	13	53
131795	2020-06-30	63	14	53
131796	2020-06-01	64	14	54
131797	2020-06-02	63	14	54
131798	2020-06-03	83	13	54
131799	2020-06-04	83	13	54
131800	2020-06-05	63	14	54
131801	2020-06-06	83	13	54
131802	2020-06-07	83	13	54
131803	2020-06-08	83	13	54
131804	2020-06-09	83	13	54
131805	2020-06-10	64	14	54
131806	2020-06-11	83	13	54
131807	2020-06-12	83	13	54
131808	2020-06-13	83	13	54
131809	2020-06-14	83	13	54
131810	2020-06-15	83	13	54
131811	2020-06-16	83	13	54
131812	2020-06-17	64	14	54
131813	2020-06-18	83	13	54
131814	2020-06-19	83	13	54
131815	2020-06-20	83	13	54
131816	2020-06-21	83	13	54
131817	2020-06-22	83	13	54
131818	2020-06-23	64	14	54
131819	2020-06-24	83	13	54
131820	2020-06-25	83	13	54
131821	2020-06-26	63	14	54
131822	2020-06-27	83	13	54
131823	2020-06-28	83	13	54
131824	2020-06-29	83	13	54
131825	2020-06-30	63	14	54
131826	2020-06-01	83	13	49
131827	2020-06-02	83	13	49
131828	2020-06-03	83	13	49
131829	2020-06-04	64	14	49
131830	2020-06-05	63	14	49
131831	2020-06-06	83	13	49
131832	2020-06-07	83	13	49
131833	2020-06-08	83	13	49
131834	2020-06-09	83	13	49
131835	2020-06-10	83	13	49
131836	2020-06-11	83	13	49
131837	2020-06-12	64	14	49
131838	2020-06-13	83	13	49
131839	2020-06-14	83	13	49
131840	2020-06-15	83	13	49
131841	2020-06-16	63	14	49
131842	2020-06-17	83	13	49
131843	2020-06-18	83	13	49
131844	2020-06-19	64	14	49
131845	2020-06-20	83	13	49
131846	2020-06-21	83	13	49
131847	2020-06-22	63	14	49
131848	2020-06-23	83	13	49
131849	2020-06-24	83	13	49
131850	2020-06-25	64	14	49
131851	2020-06-26	83	13	49
131852	2020-06-27	83	13	49
131853	2020-06-28	83	13	49
131854	2020-06-29	63	14	49
131855	2020-06-30	83	13	49
131856	2020-06-01	83	13	50
131857	2020-06-02	83	13	50
131858	2020-06-03	64	14	50
131859	2020-06-04	63	14	50
131860	2020-06-05	83	13	50
131861	2020-06-06	83	13	50
131862	2020-06-07	83	13	50
131863	2020-06-08	83	13	50
131864	2020-06-09	64	14	50
131865	2020-06-10	83	13	50
131866	2020-06-11	83	13	50
131867	2020-06-12	83	13	50
131868	2020-06-13	83	13	50
131869	2020-06-14	83	13	50
131870	2020-06-15	64	14	50
131871	2020-06-16	63	14	50
131872	2020-06-17	83	13	50
131873	2020-06-18	83	13	50
131874	2020-06-19	63	14	50
131875	2020-06-20	83	13	50
131876	2020-06-21	83	13	50
131877	2020-06-22	83	13	50
131878	2020-06-23	64	14	50
131879	2020-06-24	63	14	50
131880	2020-06-25	83	13	50
131881	2020-06-26	83	13	50
131882	2020-06-27	83	13	50
131883	2020-06-28	83	13	50
131884	2020-06-29	83	13	50
131885	2020-06-30	83	13	50
131886	2020-06-01	82	16	43
131887	2020-06-02	82	16	43
131888	2020-06-03	82	16	43
131889	2020-06-04	82	16	43
131890	2020-06-05	82	16	43
131891	2020-06-06	63	14	43
131892	2020-06-07	64	14	43
131893	2020-06-08	82	16	43
131894	2020-06-09	82	16	43
131895	2020-06-10	82	16	43
131896	2020-06-11	82	16	43
131897	2020-06-12	82	16	43
131898	2020-06-13	63	14	43
131899	2020-06-14	64	14	43
131900	2020-06-15	82	16	43
131901	2020-06-16	82	16	43
131902	2020-06-17	82	16	43
131903	2020-06-18	82	16	43
131904	2020-06-19	82	16	43
131905	2020-06-20	63	14	43
131906	2020-06-21	64	14	43
131907	2020-06-22	82	16	43
131908	2020-06-23	82	16	43
131909	2020-06-24	82	16	43
131910	2020-06-25	82	16	43
131911	2020-06-26	82	16	43
131912	2020-06-27	63	14	43
131913	2020-06-28	64	14	43
131914	2020-06-29	82	16	43
131915	2020-06-30	82	16	43
131916	2020-06-01	82	16	44
131917	2020-06-02	82	16	44
131918	2020-06-03	82	16	44
131919	2020-06-04	82	16	44
131920	2020-06-05	82	16	44
131921	2020-06-06	63	14	44
131922	2020-06-07	64	14	44
131923	2020-06-08	82	16	44
131924	2020-06-09	82	16	44
131925	2020-06-10	82	16	44
131926	2020-06-11	82	16	44
131927	2020-06-12	82	16	44
131928	2020-06-13	63	14	44
131929	2020-06-14	64	14	44
131930	2020-06-15	82	16	44
131931	2020-06-16	82	16	44
131932	2020-06-17	82	16	44
131933	2020-06-18	82	16	44
131934	2020-06-19	82	16	44
131935	2020-06-20	63	14	44
131936	2020-06-21	64	14	44
131937	2020-06-22	82	16	44
131938	2020-06-23	82	16	44
131939	2020-06-24	82	16	44
131940	2020-06-25	82	16	44
131941	2020-06-26	82	16	44
131942	2020-06-27	63	14	44
131943	2020-06-28	64	14	44
131944	2020-06-29	82	16	44
131945	2020-06-30	82	16	44
134286	2020-09-01	64	14	47
134287	2020-09-02	63	14	47
134288	2020-09-03	80	13	47
134289	2020-09-04	80	13	47
134290	2020-09-05	80	13	47
134291	2020-09-06	80	13	47
134292	2020-09-07	80	13	47
134293	2020-09-08	80	13	47
134294	2020-09-09	64	14	47
134295	2020-09-10	80	13	47
134296	2020-09-11	80	13	47
134297	2020-09-12	80	13	47
134298	2020-09-13	80	13	47
134299	2020-09-14	80	13	47
134300	2020-09-15	64	14	47
134301	2020-09-16	63	14	47
134302	2020-09-17	80	13	47
134303	2020-09-18	80	13	47
134304	2020-09-19	80	13	47
134305	2020-09-20	63	14	47
134306	2020-09-21	80	13	47
134307	2020-09-22	80	13	47
134308	2020-09-23	80	13	47
134309	2020-09-24	80	13	47
134310	2020-09-25	80	13	47
134311	2020-09-26	80	13	47
134312	2020-09-27	64	14	47
134313	2020-09-28	84	14	47
134314	2020-09-29	63	14	47
134315	2020-09-30	80	13	47
134316	2020-09-01	80	13	69
134317	2020-09-02	80	13	69
134318	2020-09-03	80	13	69
134319	2020-09-04	64	14	69
134320	2020-09-05	84	14	69
134321	2020-09-06	63	14	69
134322	2020-09-07	63	14	69
134323	2020-09-08	63	14	69
134324	2020-09-09	80	13	69
134325	2020-09-10	80	13	69
134326	2020-09-11	80	13	69
134327	2020-09-12	80	13	69
134328	2020-09-13	80	13	69
134329	2020-09-14	64	14	69
134330	2020-09-15	80	13	69
134331	2020-09-16	80	13	69
134332	2020-09-17	80	13	69
134333	2020-09-18	80	13	69
134334	2020-09-19	80	13	69
134335	2020-09-20	80	13	69
134336	2020-09-21	64	14	69
134337	2020-09-22	80	13	69
134338	2020-09-23	80	13	69
134339	2020-09-24	63	14	69
134340	2020-09-25	80	13	69
134341	2020-09-26	80	13	69
134342	2020-09-27	80	13	69
134343	2020-09-28	80	13	69
134344	2020-09-29	64	14	69
134345	2020-09-30	80	13	69
134346	2020-09-01	80	13	46
134347	2020-09-02	80	13	46
134348	2020-09-03	64	14	46
134349	2020-09-04	80	13	46
134350	2020-09-05	80	13	46
134351	2020-09-06	63	14	46
134352	2020-09-07	80	13	46
134353	2020-09-08	80	13	46
134354	2020-09-09	80	13	46
134355	2020-09-10	64	14	46
134356	2020-09-11	63	14	46
134357	2020-09-12	63	14	46
134358	2020-09-13	63	14	46
134359	2020-09-14	80	13	46
134360	2020-09-15	80	13	46
134361	2020-09-16	80	13	46
134362	2020-09-17	80	13	46
134363	2020-09-18	80	13	46
134364	2020-09-19	64	14	46
134365	2020-09-20	84	14	46
134366	2020-09-21	80	13	46
134367	2020-09-22	80	13	46
134368	2020-09-23	65	15	46
134369	2020-09-24	80	13	46
134370	2020-09-25	80	13	46
134371	2020-09-26	80	13	46
134372	2020-09-27	64	14	46
134373	2020-09-28	80	13	46
134374	2020-09-29	80	13	46
134375	2020-09-30	80	13	46
134376	2020-09-01	80	13	60
134377	2020-09-02	64	14	60
134378	2020-09-03	80	13	60
134379	2020-09-04	80	13	60
134380	2020-09-05	80	13	60
134381	2020-09-06	80	13	60
134382	2020-09-07	80	13	60
134383	2020-09-08	80	13	60
134384	2020-09-09	64	14	60
134385	2020-09-10	80	13	60
134386	2020-09-11	80	13	60
134387	2020-09-12	63	14	60
134388	2020-09-13	80	13	60
134389	2020-09-14	80	13	60
134390	2020-09-15	80	13	60
134391	2020-09-16	80	13	60
134392	2020-09-17	64	14	60
134393	2020-09-18	84	14	60
134394	2020-09-19	80	13	60
134395	2020-09-20	80	13	60
134396	2020-09-21	80	13	60
134397	2020-09-22	63	14	60
134398	2020-09-23	80	13	60
134399	2020-09-24	80	13	60
134400	2020-09-25	64	14	60
134401	2020-09-26	63	14	60
134402	2020-09-27	80	13	60
134403	2020-09-28	80	13	60
134404	2020-09-29	80	13	60
134405	2020-09-30	63	14	60
134406	2020-09-01	64	14	64
134407	2020-09-02	63	14	64
134408	2020-09-03	80	13	64
134409	2020-09-04	80	13	64
134410	2020-09-05	84	14	64
134411	2020-09-06	63	14	64
134412	2020-09-07	80	13	64
134413	2020-09-08	80	13	64
134414	2020-09-09	80	13	64
134415	2020-09-10	80	13	64
134416	2020-09-11	80	13	64
134417	2020-09-12	80	13	64
134418	2020-09-13	64	14	64
134419	2020-09-14	80	13	64
134420	2020-09-15	80	13	64
134421	2020-09-16	80	13	64
134422	2020-09-17	80	13	64
134423	2020-09-18	80	13	64
134424	2020-09-19	80	13	64
134425	2020-09-20	64	14	64
134426	2020-09-21	63	14	64
134427	2020-09-22	63	14	64
134428	2020-09-23	80	13	64
134429	2020-09-24	80	13	64
134430	2020-09-25	80	13	64
134431	2020-09-26	64	14	64
134432	2020-09-27	80	13	64
134433	2020-09-28	80	13	64
134434	2020-09-29	80	13	64
134435	2020-09-30	80	13	64
134436	2020-09-01	80	13	65
134437	2020-09-02	80	13	65
134438	2020-09-03	80	13	65
134439	2020-09-04	80	13	65
134440	2020-09-05	80	13	65
134441	2020-09-06	64	14	65
134442	2020-09-07	63	14	65
134443	2020-09-08	63	14	65
134444	2020-09-09	80	13	65
134445	2020-09-10	80	13	65
134446	2020-09-11	63	14	65
134447	2020-09-12	64	14	65
134448	2020-09-13	80	13	65
134449	2020-09-14	80	13	65
134450	2020-09-15	80	13	65
134451	2020-09-16	80	13	65
134452	2020-09-17	63	14	65
134453	2020-09-18	80	13	65
134454	2020-09-19	80	13	65
134455	2020-09-20	80	13	65
134456	2020-09-21	80	13	65
134457	2020-09-22	80	13	65
134458	2020-09-23	80	13	65
134459	2020-09-24	64	14	65
134460	2020-09-25	80	13	65
134461	2020-09-26	80	13	65
134462	2020-09-27	84	14	65
134463	2020-09-28	64	14	65
134464	2020-09-29	80	13	65
134465	2020-09-30	80	13	65
134466	2020-09-01	80	13	51
134467	2020-09-02	80	13	51
134468	2020-09-03	80	13	51
134469	2020-09-04	64	14	51
134470	2020-09-05	80	13	51
134471	2020-09-06	63	14	51
134472	2020-09-07	80	13	51
134473	2020-09-08	80	13	51
134474	2020-09-09	63	14	51
134475	2020-09-10	64	14	51
134476	2020-09-11	63	14	51
134477	2020-09-12	80	13	51
134478	2020-09-13	80	13	51
134479	2020-09-14	80	13	51
134480	2020-09-15	80	13	51
134481	2020-09-16	64	14	51
134482	2020-09-17	63	14	51
134483	2020-09-18	80	13	51
134484	2020-09-19	80	13	51
134485	2020-09-20	80	13	51
134486	2020-09-21	80	13	51
134487	2020-09-22	80	13	51
134488	2020-09-23	80	13	51
134489	2020-09-24	64	14	51
134490	2020-09-25	80	13	51
134491	2020-09-26	80	13	51
134492	2020-09-27	80	13	51
134493	2020-09-28	80	13	51
134494	2020-09-29	84	14	51
134495	2020-09-30	80	13	51
134496	2020-09-01	80	13	57
134497	2020-09-02	80	13	57
134498	2020-09-03	64	14	57
134499	2020-09-04	80	13	57
134500	2020-09-05	80	13	57
134501	2020-09-06	63	14	57
134502	2020-09-07	80	13	57
134503	2020-09-08	80	13	57
134504	2020-09-09	64	14	57
134505	2020-09-10	80	13	57
134506	2020-09-11	80	13	57
134507	2020-09-12	63	14	57
134508	2020-09-13	80	13	57
134509	2020-09-14	80	13	57
134510	2020-09-15	64	14	57
134511	2020-09-16	80	13	57
134512	2020-09-17	80	13	57
134513	2020-09-18	63	14	57
134514	2020-09-19	80	13	57
134515	2020-09-20	80	13	57
134516	2020-09-21	80	13	57
134517	2020-09-22	80	13	57
134518	2020-09-23	80	13	57
134519	2020-09-24	80	13	57
134520	2020-09-25	64	14	57
134521	2020-09-26	80	13	57
134522	2020-09-27	80	13	57
134523	2020-09-28	80	13	57
134524	2020-09-29	84	14	57
134525	2020-09-30	63	14	57
134526	2020-09-01	80	13	71
134527	2020-09-02	80	13	71
134528	2020-09-03	64	14	71
134529	2020-09-04	80	13	71
134530	2020-09-05	80	13	71
134531	2020-09-06	63	14	71
134532	2020-09-07	80	13	71
134533	2020-09-08	80	13	71
134534	2020-09-09	80	13	71
134535	2020-09-10	64	14	71
134536	2020-09-11	84	14	71
134537	2020-09-12	80	13	71
134538	2020-09-13	80	13	71
134539	2020-09-14	63	14	71
134540	2020-09-15	80	13	71
134541	2020-09-16	80	13	71
134542	2020-09-17	80	13	71
134543	2020-09-18	64	14	71
134544	2020-09-19	80	13	71
134545	2020-09-20	80	13	71
134546	2020-09-21	80	13	71
134547	2020-09-22	80	13	71
134548	2020-09-23	63	14	71
134549	2020-09-24	80	13	71
134550	2020-09-25	80	13	71
134551	2020-09-26	80	13	71
134552	2020-09-27	64	14	71
134553	2020-09-28	63	14	71
134554	2020-09-29	80	13	71
134555	2020-09-30	80	13	71
134556	2020-09-01	80	13	78
134557	2020-09-02	80	13	78
134558	2020-09-03	64	14	78
134559	2020-09-04	63	14	78
134560	2020-09-05	63	14	78
134561	2020-09-06	63	14	78
134562	2020-09-07	80	13	78
134563	2020-09-08	80	13	78
134564	2020-09-09	80	13	78
134565	2020-09-10	80	13	78
134566	2020-09-11	80	13	78
134567	2020-09-12	64	14	78
134568	2020-09-13	84	14	78
134569	2020-09-14	80	13	78
134570	2020-09-15	80	13	78
134571	2020-09-16	80	13	78
134572	2020-09-17	80	13	78
134573	2020-09-18	80	13	78
134574	2020-09-19	64	14	78
134575	2020-09-20	80	13	78
134576	2020-09-21	80	13	78
134577	2020-09-22	63	14	78
134578	2020-09-23	80	13	78
134579	2020-09-24	80	13	78
134580	2020-09-25	64	14	78
134581	2020-09-26	80	13	78
134582	2020-09-27	80	13	78
134583	2020-09-28	80	13	78
134584	2020-09-29	80	13	78
134585	2020-09-30	80	13	78
134586	2020-09-01	64	14	79
134587	2020-09-02	63	14	79
134588	2020-09-03	80	13	79
134589	2020-09-04	80	13	79
134590	2020-09-05	84	14	79
134591	2020-09-06	63	14	79
134592	2020-09-07	64	14	79
134593	2020-09-08	63	14	79
134594	2020-09-09	80	13	79
134595	2020-09-10	80	13	79
134596	2020-09-11	80	13	79
134597	2020-09-12	80	13	79
134598	2020-09-13	80	13	79
134599	2020-09-14	80	13	79
134600	2020-09-15	64	14	79
134601	2020-09-16	80	13	79
134602	2020-09-17	80	13	79
134603	2020-09-18	80	13	79
134604	2020-09-19	63	14	79
134605	2020-09-20	80	13	79
134606	2020-09-21	80	13	79
134607	2020-09-22	80	13	79
134608	2020-09-23	80	13	79
134609	2020-09-24	80	13	79
134610	2020-09-25	80	13	79
134611	2020-09-26	64	14	79
134612	2020-09-27	80	13	79
134613	2020-09-28	80	13	79
134614	2020-09-29	80	13	79
134615	2020-09-30	80	13	79
134616	2020-09-01	64	14	56
134617	2020-09-02	81	13	56
134618	2020-09-03	81	13	56
134619	2020-09-04	63	14	56
134620	2020-09-05	81	13	56
134621	2020-09-06	63	14	56
134622	2020-09-07	81	13	56
134623	2020-09-08	81	13	56
134624	2020-09-09	81	13	56
134625	2020-09-10	64	14	56
134626	2020-09-11	81	13	56
134627	2020-09-12	81	13	56
134628	2020-09-13	63	14	56
134629	2020-09-14	81	13	56
134630	2020-09-15	81	13	56
134631	2020-09-16	81	13	56
134632	2020-09-17	64	14	56
134633	2020-09-18	84	14	56
134634	2020-09-19	81	13	56
134635	2020-09-20	81	13	56
134636	2020-09-21	81	13	56
134637	2020-09-22	81	13	56
134638	2020-09-23	81	13	56
134639	2020-09-24	81	13	56
134640	2020-09-25	64	14	56
134641	2020-09-26	81	13	56
134642	2020-09-27	81	13	56
134643	2020-09-28	81	13	56
134644	2020-09-29	81	13	56
134645	2020-09-30	63	14	56
134646	2020-09-01	81	13	62
134647	2020-09-02	81	13	62
134648	2020-09-03	64	14	62
134649	2020-09-04	81	13	62
134650	2020-09-05	81	13	62
134651	2020-09-06	63	14	62
134652	2020-09-07	81	13	62
134653	2020-09-08	63	14	62
134654	2020-09-09	81	13	62
134655	2020-09-10	81	13	62
134656	2020-09-11	81	13	62
134657	2020-09-12	81	13	62
134658	2020-09-13	81	13	62
134659	2020-09-14	81	13	62
134660	2020-09-15	64	14	62
134661	2020-09-16	63	14	62
134662	2020-09-17	81	13	62
134663	2020-09-18	81	13	62
134664	2020-09-19	63	14	62
134665	2020-09-20	84	14	62
134666	2020-09-21	81	13	62
134667	2020-09-22	81	13	62
134668	2020-09-23	81	13	62
134669	2020-09-24	64	14	62
134670	2020-09-25	81	13	62
134671	2020-09-26	81	13	62
134672	2020-09-27	81	13	62
134673	2020-09-28	81	13	62
134674	2020-09-29	64	14	62
134675	2020-09-30	81	13	62
134676	2020-09-01	81	13	63
134677	2020-09-02	81	13	63
134678	2020-09-03	64	14	63
134679	2020-09-04	81	13	63
134680	2020-09-05	81	13	63
134681	2020-09-06	84	14	63
134682	2020-09-07	81	13	63
134683	2020-09-08	81	13	63
134684	2020-09-09	81	13	63
134685	2020-09-10	81	13	63
134686	2020-09-11	64	14	63
134687	2020-09-12	63	14	63
134688	2020-09-13	63	14	63
134689	2020-09-14	81	13	63
134690	2020-09-15	81	13	63
134691	2020-09-16	81	13	63
134692	2020-09-17	81	13	63
134693	2020-09-18	64	14	63
134694	2020-09-19	81	13	63
134695	2020-09-20	81	13	63
134696	2020-09-21	81	13	63
134697	2020-09-22	81	13	63
134698	2020-09-23	63	14	63
134699	2020-09-24	81	13	63
134700	2020-09-25	81	13	63
134701	2020-09-26	81	13	63
134702	2020-09-27	81	13	63
134703	2020-09-28	81	13	63
134704	2020-09-29	64	14	63
134705	2020-09-30	63	14	63
134706	2020-09-01	81	13	67
134707	2020-09-02	81	13	67
134708	2020-09-03	64	14	67
134709	2020-09-04	63	14	67
134710	2020-09-05	81	13	67
134711	2020-09-06	84	14	67
134712	2020-09-07	63	14	67
134713	2020-09-08	63	14	67
134714	2020-09-09	64	14	67
134715	2020-09-10	81	13	67
134716	2020-09-11	81	13	67
134717	2020-09-12	81	13	67
134718	2020-09-13	81	13	67
134719	2020-09-14	63	14	67
134720	2020-09-15	81	13	67
134721	2020-09-16	81	13	67
134722	2020-09-17	81	13	67
134723	2020-09-18	81	13	67
134724	2020-09-19	81	13	67
134725	2020-09-20	81	13	67
134726	2020-09-21	64	14	67
134727	2020-09-22	81	13	67
134728	2020-09-23	81	13	67
134729	2020-09-24	81	13	67
134730	2020-09-25	81	13	67
134731	2020-09-26	81	13	67
134732	2020-09-27	64	14	67
134733	2020-09-28	81	13	67
134734	2020-09-29	81	13	67
134735	2020-09-30	81	13	67
134736	2020-09-01	64	14	73
134737	2020-09-02	63	14	73
134738	2020-09-03	81	13	73
134739	2020-09-04	81	13	73
134740	2020-09-05	81	13	73
134741	2020-09-06	84	14	73
134742	2020-09-07	64	14	73
134743	2020-09-08	63	14	73
134744	2020-09-09	63	14	73
134745	2020-09-10	63	14	73
134746	2020-09-11	81	13	73
134747	2020-09-12	81	13	73
134748	2020-09-13	81	13	73
134749	2020-09-14	81	13	73
134750	2020-09-15	81	13	73
134751	2020-09-16	81	13	73
134752	2020-09-17	64	14	73
134753	2020-09-18	81	13	73
134754	2020-09-19	81	13	73
134755	2020-09-20	81	13	73
134756	2020-09-21	81	13	73
134757	2020-09-22	81	13	73
134758	2020-09-23	81	13	73
134759	2020-09-24	64	14	73
134760	2020-09-25	81	13	73
134761	2020-09-26	81	13	73
134762	2020-09-27	81	13	73
134763	2020-09-28	81	13	73
134764	2020-09-29	81	13	73
134765	2020-09-30	81	13	73
134766	2020-09-01	81	13	66
134767	2020-09-02	81	13	66
134768	2020-09-03	81	13	66
134769	2020-09-04	64	14	66
134770	2020-09-05	63	14	66
134771	2020-09-06	63	14	66
134772	2020-09-07	81	13	66
134773	2020-09-08	81	13	66
134774	2020-09-09	81	13	66
134775	2020-09-10	64	14	66
134776	2020-09-11	63	14	66
134777	2020-09-12	63	14	66
134778	2020-09-13	81	13	66
134779	2020-09-14	81	13	66
134780	2020-09-15	84	14	66
134781	2020-09-16	81	13	66
134782	2020-09-17	81	13	66
134783	2020-09-18	81	13	66
134784	2020-09-19	81	13	66
134785	2020-09-20	81	13	66
134786	2020-09-21	81	13	66
134787	2020-09-22	64	14	66
134788	2020-09-23	81	13	66
134789	2020-09-24	81	13	66
134790	2020-09-25	64	14	66
134791	2020-09-26	81	13	66
134792	2020-09-27	81	13	66
134793	2020-09-28	81	13	66
134794	2020-09-29	81	13	66
134795	2020-09-30	81	13	66
134796	2020-09-01	64	14	55
134797	2020-09-02	63	14	55
134798	2020-09-03	81	13	55
134799	2020-09-04	81	13	55
134800	2020-09-05	63	14	55
134801	2020-09-06	63	14	55
134802	2020-09-07	81	13	55
134803	2020-09-08	81	13	55
134804	2020-09-09	81	13	55
134805	2020-09-10	81	13	55
134806	2020-09-11	81	13	55
134807	2020-09-12	81	13	55
134808	2020-09-13	64	14	55
134809	2020-09-14	81	13	55
134810	2020-09-15	81	13	55
134811	2020-09-16	81	13	55
134812	2020-09-17	81	13	55
134813	2020-09-18	81	13	55
134814	2020-09-19	64	14	55
134815	2020-09-20	84	14	55
134816	2020-09-21	81	13	55
134817	2020-09-22	81	13	55
134818	2020-09-23	81	13	55
134819	2020-09-24	81	13	55
134820	2020-09-25	81	13	55
134821	2020-09-26	64	14	55
134822	2020-09-27	81	13	55
134823	2020-09-28	63	14	55
134824	2020-09-29	81	13	55
134825	2020-09-30	81	13	55
134826	2020-09-01	83	13	45
134827	2020-09-02	83	13	45
134828	2020-09-03	64	14	45
134829	2020-09-04	63	14	45
134830	2020-09-05	83	13	45
134831	2020-09-06	63	14	45
134832	2020-09-07	83	13	45
134833	2020-09-08	83	13	45
134834	2020-09-09	83	13	45
134835	2020-09-10	83	13	45
134836	2020-09-11	64	14	45
134837	2020-09-12	83	13	45
134838	2020-09-13	83	13	45
134839	2020-09-14	83	13	45
134840	2020-09-15	63	14	45
134841	2020-09-16	84	14	45
134842	2020-09-17	83	13	45
134843	2020-09-18	83	13	45
134844	2020-09-19	83	13	45
134845	2020-09-20	64	14	45
134846	2020-09-21	63	14	45
134847	2020-09-22	65	15	45
134848	2020-09-23	83	13	45
134849	2020-09-24	83	13	45
134850	2020-09-25	83	13	45
134851	2020-09-26	64	14	45
134852	2020-09-27	83	13	45
134853	2020-09-28	83	13	45
134854	2020-09-29	67	14	45
134855	2020-09-30	72	14	45
134856	2020-09-01	64	14	68
134857	2020-09-02	83	13	68
134858	2020-09-03	83	13	68
134859	2020-09-04	83	13	68
134860	2020-09-05	83	13	68
134861	2020-09-06	63	14	68
134862	2020-09-07	83	13	68
134863	2020-09-08	64	14	68
134864	2020-09-09	83	13	68
134865	2020-09-10	83	13	68
134866	2020-09-11	83	13	68
134867	2020-09-12	63	14	68
134868	2020-09-13	83	13	68
134869	2020-09-14	83	13	68
134870	2020-09-15	83	13	68
134871	2020-09-16	83	13	68
134872	2020-09-17	64	14	68
134873	2020-09-18	84	14	68
134874	2020-09-19	83	13	68
134875	2020-09-20	83	13	68
134876	2020-09-21	83	13	68
134877	2020-09-22	83	13	68
134878	2020-09-23	64	14	68
134879	2020-09-24	83	13	68
134880	2020-09-25	83	13	68
134881	2020-09-26	83	13	68
134882	2020-09-27	63	14	68
134883	2020-09-28	63	14	68
134884	2020-09-29	83	13	68
134885	2020-09-30	83	13	68
134886	2020-09-01	64	14	53
134887	2020-09-02	63	14	53
134888	2020-09-03	83	13	53
134889	2020-09-04	83	13	53
134890	2020-09-05	83	13	53
134891	2020-09-06	84	14	53
134892	2020-09-07	83	13	53
134893	2020-09-08	83	13	53
134894	2020-09-09	83	13	53
134895	2020-09-10	64	14	53
134896	2020-09-11	63	14	53
134897	2020-09-12	83	13	53
134898	2020-09-13	83	13	53
134899	2020-09-14	83	13	53
134900	2020-09-15	83	13	53
134901	2020-09-16	83	13	53
134902	2020-09-17	83	13	53
134903	2020-09-18	64	14	53
134904	2020-09-19	83	13	53
134905	2020-09-20	63	14	53
134906	2020-09-21	83	13	53
134907	2020-09-22	83	13	53
134908	2020-09-23	63	14	53
134909	2020-09-24	83	13	53
134910	2020-09-25	83	13	53
134911	2020-09-26	64	14	53
134912	2020-09-27	83	13	53
134913	2020-09-28	83	13	53
134914	2020-09-29	83	13	53
134915	2020-09-30	83	13	53
134916	2020-09-01	64	14	54
134917	2020-09-02	63	14	54
134918	2020-09-03	83	13	54
134919	2020-09-04	83	13	54
134920	2020-09-05	84	14	54
134921	2020-09-06	63	14	54
134922	2020-09-07	83	13	54
134923	2020-09-08	83	13	54
134924	2020-09-09	64	14	54
134925	2020-09-10	83	13	54
134926	2020-09-11	83	13	54
134927	2020-09-12	63	14	54
134928	2020-09-13	63	14	54
134929	2020-09-14	83	13	54
134930	2020-09-15	83	13	54
134931	2020-09-16	83	13	54
134932	2020-09-17	83	13	54
134933	2020-09-18	83	13	54
134934	2020-09-19	64	14	54
134935	2020-09-20	83	13	54
134936	2020-09-21	83	13	54
134937	2020-09-22	83	13	54
134938	2020-09-23	83	13	54
134939	2020-09-24	83	13	54
134940	2020-09-25	64	14	54
134941	2020-09-26	83	13	54
134942	2020-09-27	83	13	54
134943	2020-09-28	83	13	54
134944	2020-09-29	83	13	54
134945	2020-09-30	83	13	54
134946	2020-09-01	83	13	49
134947	2020-09-02	83	13	49
134948	2020-09-03	64	14	49
134949	2020-09-04	84	14	49
134950	2020-09-05	83	13	49
134951	2020-09-06	63	14	49
134952	2020-09-07	63	14	49
134953	2020-09-08	63	14	49
134954	2020-09-09	83	13	49
134955	2020-09-10	64	14	49
134956	2020-09-11	83	13	49
134957	2020-09-12	83	13	49
134958	2020-09-13	83	13	49
134959	2020-09-14	83	13	49
134960	2020-09-15	83	13	49
134961	2020-09-16	83	13	49
134962	2020-09-17	64	14	49
134963	2020-09-18	83	13	49
134964	2020-09-19	83	13	49
134965	2020-09-20	83	13	49
134966	2020-09-21	83	13	49
134967	2020-09-22	83	13	49
134968	2020-09-23	83	13	49
134969	2020-09-24	64	14	49
134970	2020-09-25	83	13	49
134971	2020-09-26	83	13	49
134972	2020-09-27	83	13	49
134973	2020-09-28	83	13	49
134974	2020-09-29	83	13	49
134975	2020-09-30	63	14	49
134976	2020-09-01	83	13	50
134977	2020-09-02	83	13	50
134978	2020-09-03	83	13	50
134979	2020-09-04	83	13	50
134980	2020-09-05	64	14	50
134981	2020-09-06	63	14	50
134982	2020-09-07	83	13	50
134983	2020-09-08	84	14	50
134984	2020-09-09	83	13	50
134985	2020-09-10	83	13	50
134986	2020-09-11	64	14	50
134987	2020-09-12	83	13	50
134988	2020-09-13	63	14	50
134989	2020-09-14	63	14	50
134990	2020-09-15	63	14	50
134991	2020-09-16	83	13	50
134992	2020-09-17	83	13	50
134993	2020-09-18	83	13	50
134994	2020-09-19	83	13	50
134995	2020-09-20	83	13	50
134996	2020-09-21	83	13	50
134997	2020-09-22	64	14	50
134998	2020-09-23	83	13	50
134999	2020-09-24	83	13	50
135000	2020-09-25	83	13	50
135001	2020-09-26	83	13	50
135002	2020-09-27	83	13	50
135003	2020-09-28	83	13	50
135004	2020-09-29	64	14	50
135005	2020-09-30	83	13	50
135006	2020-09-01	84	14	43
135007	2020-09-02	82	16	43
135008	2020-09-03	82	16	43
135009	2020-09-04	82	16	43
135010	2020-09-05	63	14	43
135011	2020-09-06	64	14	43
135012	2020-09-07	82	16	43
135013	2020-09-08	82	16	43
135014	2020-09-09	82	16	43
135015	2020-09-10	82	16	43
135016	2020-09-11	82	16	43
135017	2020-09-12	63	14	43
135018	2020-09-13	64	14	43
135019	2020-09-14	82	16	43
135020	2020-09-15	82	16	43
135021	2020-09-16	82	16	43
135022	2020-09-17	82	16	43
135023	2020-09-18	82	16	43
135024	2020-09-19	63	14	43
135025	2020-09-20	64	14	43
135026	2020-09-21	82	16	43
135027	2020-09-22	82	16	43
135028	2020-09-23	82	16	43
135029	2020-09-24	82	16	43
135030	2020-09-25	82	16	43
135031	2020-09-26	63	14	43
135032	2020-09-27	64	14	43
135033	2020-09-28	82	16	43
135034	2020-09-29	82	16	43
135035	2020-09-30	82	16	43
135036	2020-09-01	84	14	44
135037	2020-09-02	82	16	44
135038	2020-09-03	82	16	44
135039	2020-09-04	82	16	44
135040	2020-09-05	63	14	44
135041	2020-09-06	64	14	44
135042	2020-09-07	82	16	44
135043	2020-09-08	82	16	44
135044	2020-09-09	82	16	44
135045	2020-09-10	82	16	44
135046	2020-09-11	82	16	44
135047	2020-09-12	63	14	44
135048	2020-09-13	64	14	44
135049	2020-09-14	82	16	44
135050	2020-09-15	82	16	44
135051	2020-09-16	82	16	44
135052	2020-09-17	82	16	44
135053	2020-09-18	82	16	44
135054	2020-09-19	63	14	44
135055	2020-09-20	64	14	44
135056	2020-09-21	82	16	44
135057	2020-09-22	82	16	44
135058	2020-09-23	82	16	44
135059	2020-09-24	82	16	44
135060	2020-09-25	82	16	44
135061	2020-09-26	63	14	44
135062	2020-09-27	64	14	44
135063	2020-09-28	82	16	44
135064	2020-09-29	82	16	44
135065	2020-09-30	82	16	44
135071	2020-11-01	80	13	47
135072	2020-11-02	80	13	47
135073	2020-11-03	64	14	47
135074	2020-11-04	80	13	47
135075	2020-11-05	80	13	47
135076	2020-11-06	80	13	47
135077	2020-11-07	80	13	47
135078	2020-11-08	80	13	47
135079	2020-11-09	64	14	47
135080	2020-11-10	63	14	47
135081	2020-11-11	80	13	47
135082	2020-11-12	80	13	47
135083	2020-11-13	80	13	47
135084	2020-11-14	80	13	47
135085	2020-11-15	64	14	47
135086	2020-11-16	63	14	47
135087	2020-11-17	63	14	47
135088	2020-11-18	63	14	47
135089	2020-11-19	80	13	47
135090	2020-11-20	80	13	47
135091	2020-11-21	80	13	47
135092	2020-11-22	80	13	47
135093	2020-11-23	64	14	47
135094	2020-11-24	80	13	47
135095	2020-11-25	80	13	47
135096	2020-11-26	80	13	47
135097	2020-11-27	80	13	47
135098	2020-11-28	64	14	47
135099	2020-11-29	80	13	47
135100	2020-11-30	80	13	47
135101	2020-11-01	80	13	69
135102	2020-11-02	80	13	69
135103	2020-11-03	80	13	69
135104	2020-11-04	64	14	69
135105	2020-11-05	80	13	69
135106	2020-11-06	63	14	69
135107	2020-11-07	63	14	69
135108	2020-11-08	63	14	69
135109	2020-11-09	80	13	69
135110	2020-11-10	80	13	69
135111	2020-11-11	80	13	69
135112	2020-11-12	80	13	69
135113	2020-11-13	80	13	69
135114	2020-11-14	64	14	69
135115	2020-11-15	80	13	69
135116	2020-11-16	80	13	69
135117	2020-11-17	80	13	69
135118	2020-11-18	80	13	69
135119	2020-11-19	80	13	69
135120	2020-11-20	80	13	69
135121	2020-11-21	64	14	69
135122	2020-11-22	80	13	69
135123	2020-11-23	80	13	69
135124	2020-11-24	80	13	69
135125	2020-11-25	80	13	69
135126	2020-11-26	63	14	69
135127	2020-11-27	64	14	69
135128	2020-11-28	80	13	69
135129	2020-11-29	80	13	69
135130	2020-11-30	64	14	69
135131	2020-11-01	67	14	46
135132	2020-11-02	64	14	46
135133	2020-11-03	80	13	46
135134	2020-11-04	80	13	46
135135	2020-11-05	63	14	46
135136	2020-11-06	63	14	46
135137	2020-11-07	80	13	46
135138	2020-11-08	80	13	46
135139	2020-11-09	80	13	46
135140	2020-11-10	80	13	46
135141	2020-11-11	80	13	46
135142	2020-11-12	64	14	46
135143	2020-11-13	63	14	46
135144	2020-11-14	63	14	46
135145	2020-11-15	80	13	46
135146	2020-11-16	80	13	46
135147	2020-11-17	80	13	46
135148	2020-11-18	80	13	46
135149	2020-11-19	64	14	46
135150	2020-11-20	64	14	46
135151	2020-11-21	80	13	46
135152	2020-11-22	80	13	46
135153	2020-11-23	80	13	46
135154	2020-11-24	64	14	46
135155	2020-11-25	80	13	46
135156	2020-11-26	80	13	46
135157	2020-11-27	80	13	46
135158	2020-11-28	80	13	46
135159	2020-11-29	80	13	46
135160	2020-11-30	80	13	46
135161	2020-11-01	80	13	64
135162	2020-11-02	80	13	64
135163	2020-11-03	80	13	64
135164	2020-11-04	80	13	64
135165	2020-11-05	64	14	64
135166	2020-11-06	80	13	64
135167	2020-11-07	80	13	64
135168	2020-11-08	63	14	64
135169	2020-11-09	80	13	64
135170	2020-11-10	80	13	64
135171	2020-11-11	80	13	64
135172	2020-11-12	64	14	64
135173	2020-11-13	63	14	64
135174	2020-11-14	80	13	64
135175	2020-11-15	80	13	64
135176	2020-11-16	63	14	64
135177	2020-11-17	63	14	64
135178	2020-11-18	80	13	64
135179	2020-11-19	80	13	64
135180	2020-11-20	80	13	64
135181	2020-11-21	64	14	64
135182	2020-11-22	64	14	64
135183	2020-11-23	80	13	64
135184	2020-11-24	80	13	64
135185	2020-11-25	80	13	64
135186	2020-11-26	80	13	64
135187	2020-11-27	80	13	64
135188	2020-11-28	80	13	64
135189	2020-11-29	64	14	64
135190	2020-11-30	80	13	64
135191	2020-11-01	64	14	65
135192	2020-11-02	63	14	65
135193	2020-11-03	80	13	65
135194	2020-11-04	80	13	65
135195	2020-11-05	80	13	65
135196	2020-11-06	80	13	65
135197	2020-11-07	80	13	65
135198	2020-11-08	64	14	65
135199	2020-11-09	80	13	65
135200	2020-11-10	63	14	65
135201	2020-11-11	63	14	65
135202	2020-11-12	80	13	65
135203	2020-11-13	80	13	65
135204	2020-11-14	80	13	65
135205	2020-11-15	80	13	65
135206	2020-11-16	64	14	65
135207	2020-11-17	80	13	65
135208	2020-11-18	80	13	65
135209	2020-11-19	80	13	65
135210	2020-11-20	80	13	65
135211	2020-11-21	63	14	65
135212	2020-11-22	80	13	65
135213	2020-11-23	80	13	65
135214	2020-11-24	64	14	65
135215	2020-11-25	80	13	65
135216	2020-11-26	80	13	65
135217	2020-11-27	64	14	65
135218	2020-11-28	80	13	65
135219	2020-11-29	80	13	65
135220	2020-11-30	80	13	65
135221	2020-11-01	64	14	51
135222	2020-11-02	63	14	51
135223	2020-11-03	80	13	51
135224	2020-11-04	80	13	51
135225	2020-11-05	80	13	51
135226	2020-11-06	63	14	51
135227	2020-11-07	80	13	51
135228	2020-11-08	80	13	51
135229	2020-11-09	80	13	51
135230	2020-11-10	64	14	51
135231	2020-11-11	63	14	51
135232	2020-11-12	80	13	51
135233	2020-11-13	80	13	51
135234	2020-11-14	80	13	51
135235	2020-11-15	80	13	51
135236	2020-11-16	80	13	51
135237	2020-11-17	80	13	51
135238	2020-11-18	64	14	51
135239	2020-11-19	80	13	51
135240	2020-11-20	80	13	51
135241	2020-11-21	80	13	51
135242	2020-11-22	80	13	51
135243	2020-11-23	80	13	51
135244	2020-11-24	80	13	51
135245	2020-11-25	64	14	51
135246	2020-11-26	63	14	51
135247	2020-11-27	64	14	51
135248	2020-11-28	80	13	51
135249	2020-11-29	80	13	51
135250	2020-11-30	80	13	51
135251	2020-11-01	80	13	57
135252	2020-11-02	80	13	57
135253	2020-11-03	64	14	57
135254	2020-11-04	80	13	57
135255	2020-11-05	80	13	57
135256	2020-11-06	63	14	57
135257	2020-11-07	63	14	57
135258	2020-11-08	80	13	57
135259	2020-11-09	80	13	57
135260	2020-11-10	80	13	57
135261	2020-11-11	80	13	57
135262	2020-11-12	80	13	57
135263	2020-11-13	80	13	57
135264	2020-11-14	64	14	57
135265	2020-11-15	63	14	57
135266	2020-11-16	80	13	57
135267	2020-11-17	80	13	57
135268	2020-11-18	80	13	57
135269	2020-11-19	80	13	57
135270	2020-11-20	64	14	57
135271	2020-11-21	80	13	57
135272	2020-11-22	80	13	57
135273	2020-11-23	80	13	57
135274	2020-11-24	63	14	57
135275	2020-11-25	80	13	57
135276	2020-11-26	80	13	57
135277	2020-11-27	80	13	57
135278	2020-11-28	80	13	57
135279	2020-11-29	64	14	57
135280	2020-11-30	64	14	57
135281	2020-11-01	64	14	71
135282	2020-11-02	63	14	71
135283	2020-11-03	80	13	71
135284	2020-11-04	80	13	71
135285	2020-11-05	80	13	71
135286	2020-11-06	80	13	71
135287	2020-11-07	80	13	71
135288	2020-11-08	80	13	71
135289	2020-11-09	64	14	71
135290	2020-11-10	63	14	71
135291	2020-11-11	63	14	71
135292	2020-11-12	80	13	71
135293	2020-11-13	80	13	71
135294	2020-11-14	80	13	71
135295	2020-11-15	80	13	71
135296	2020-11-16	80	13	71
135297	2020-11-17	64	14	71
135298	2020-11-18	80	13	71
135299	2020-11-19	80	13	71
135300	2020-11-20	80	13	71
135301	2020-11-21	80	13	71
135302	2020-11-22	80	13	71
135303	2020-11-23	64	14	71
135304	2020-11-24	80	13	71
135305	2020-11-25	80	13	71
135306	2020-11-26	63	14	71
135307	2020-11-27	80	13	71
135308	2020-11-28	80	13	71
135309	2020-11-29	64	14	71
135310	2020-11-30	80	13	71
135311	2020-11-01	80	13	78
135312	2020-11-02	80	13	78
135313	2020-11-03	64	14	78
135314	2020-11-04	63	14	78
135315	2020-11-05	63	14	78
135316	2020-11-06	80	13	78
135317	2020-11-07	80	13	78
135318	2020-11-08	80	13	78
135319	2020-11-09	64	14	78
135320	2020-11-10	80	13	78
135321	2020-11-11	80	13	78
135322	2020-11-12	63	14	78
135323	2020-11-13	63	14	78
135324	2020-11-14	80	13	78
135325	2020-11-15	80	13	78
135326	2020-11-16	80	13	78
135327	2020-11-17	80	13	78
135328	2020-11-18	80	13	78
135329	2020-11-19	64	14	78
135330	2020-11-20	80	13	78
135331	2020-11-21	80	13	78
135332	2020-11-22	64	14	78
135333	2020-11-23	80	13	78
135334	2020-11-24	80	13	78
135335	2020-11-25	80	13	78
135336	2020-11-26	80	13	78
135337	2020-11-27	80	13	78
135338	2020-11-28	64	14	78
135339	2020-11-29	80	13	78
135340	2020-11-30	80	13	78
135341	2020-11-01	80	13	79
135342	2020-11-02	80	13	79
135343	2020-11-03	64	14	79
135344	2020-11-04	63	14	79
135345	2020-11-05	63	14	79
135346	2020-11-06	63	14	79
135347	2020-11-07	63	14	79
135348	2020-11-08	64	14	79
135349	2020-11-09	80	13	79
135350	2020-11-10	80	13	79
135351	2020-11-11	80	13	79
135352	2020-11-12	80	13	79
135353	2020-11-13	80	13	79
135354	2020-11-14	80	13	79
135355	2020-11-15	64	14	79
135356	2020-11-16	80	13	79
135357	2020-11-17	80	13	79
135358	2020-11-18	80	13	79
135359	2020-11-19	80	13	79
135360	2020-11-20	80	13	79
135361	2020-11-21	80	13	79
135362	2020-11-22	64	14	79
135363	2020-11-23	80	13	79
135364	2020-11-24	80	13	79
135365	2020-11-25	64	14	79
135366	2020-11-26	80	13	79
135367	2020-11-27	80	13	79
135368	2020-11-28	80	13	79
135369	2020-11-29	80	13	79
135370	2020-11-30	80	13	79
135371	2020-11-01	81	13	56
135372	2020-11-02	81	13	56
135373	2020-11-03	81	13	56
135374	2020-11-04	81	13	56
135375	2020-11-05	64	14	56
135376	2020-11-06	63	14	56
135377	2020-11-07	81	13	56
135378	2020-11-08	63	14	56
135379	2020-11-09	63	14	56
135380	2020-11-10	81	13	56
135381	2020-11-11	81	13	56
135382	2020-11-12	81	13	56
135383	2020-11-13	64	14	56
135384	2020-11-14	81	13	56
135385	2020-11-15	81	13	56
135386	2020-11-16	81	13	56
135387	2020-11-17	81	13	56
135388	2020-11-18	81	13	56
135389	2020-11-19	64	14	56
135390	2020-11-20	63	14	56
135391	2020-11-21	81	13	56
135392	2020-11-22	81	13	56
135393	2020-11-23	81	13	56
135394	2020-11-24	64	14	56
135395	2020-11-25	81	13	56
135396	2020-11-26	81	13	56
135397	2020-11-27	64	14	56
135398	2020-11-28	81	13	56
135399	2020-11-29	81	13	56
135400	2020-11-30	81	13	56
135401	2020-11-01	81	13	62
135402	2020-11-02	81	13	62
135403	2020-11-03	64	14	62
135404	2020-11-04	81	13	62
135405	2020-11-05	81	13	62
135406	2020-11-06	81	13	62
135407	2020-11-07	63	14	62
135408	2020-11-08	63	14	62
135409	2020-11-09	64	14	62
135410	2020-11-10	81	13	62
135411	2020-11-11	81	13	62
135412	2020-11-12	81	13	62
135413	2020-11-13	81	13	62
135414	2020-11-14	63	14	62
135415	2020-11-15	64	14	62
135416	2020-11-16	81	13	62
135417	2020-11-17	81	13	62
135418	2020-11-18	81	13	62
135419	2020-11-19	81	13	62
135420	2020-11-20	81	13	62
135421	2020-11-21	81	13	62
135422	2020-11-22	64	14	62
135423	2020-11-23	81	13	62
135424	2020-11-24	81	13	62
135425	2020-11-25	81	13	62
135426	2020-11-26	63	14	62
135427	2020-11-27	81	13	62
135428	2020-11-28	81	13	62
135429	2020-11-29	81	13	62
135430	2020-11-30	64	14	62
135431	2020-11-01	81	13	63
135432	2020-11-02	81	13	63
135433	2020-11-03	64	14	63
135434	2020-11-04	81	13	63
135435	2020-11-05	81	13	63
135436	2020-11-06	63	14	63
135437	2020-11-07	63	14	63
135438	2020-11-08	81	13	63
135439	2020-11-09	81	13	63
135440	2020-11-10	81	13	63
135441	2020-11-11	64	14	63
135442	2020-11-12	81	13	63
135443	2020-11-13	81	13	63
135444	2020-11-14	81	13	63
135445	2020-11-15	81	13	63
135446	2020-11-16	81	13	63
135447	2020-11-17	81	13	63
135448	2020-11-18	64	14	63
135449	2020-11-19	81	13	63
135450	2020-11-20	81	13	63
135451	2020-11-21	81	13	63
135452	2020-11-22	81	13	63
135453	2020-11-23	63	14	63
135454	2020-11-24	81	13	63
135455	2020-11-25	81	13	63
135456	2020-11-26	81	13	63
135457	2020-11-27	81	13	63
135458	2020-11-28	64	14	63
135459	2020-11-29	63	14	63
135460	2020-11-30	64	14	63
135461	2020-11-01	64	14	67
135462	2020-11-02	63	14	67
135463	2020-11-03	81	13	67
135464	2020-11-04	81	13	67
135465	2020-11-05	81	13	67
135466	2020-11-06	63	14	67
135467	2020-11-07	81	13	67
135468	2020-11-08	81	13	67
135469	2020-11-09	64	14	67
135470	2020-11-10	81	13	67
135471	2020-11-11	81	13	67
135472	2020-11-12	63	14	67
135473	2020-11-13	63	14	67
135474	2020-11-14	64	14	67
135475	2020-11-15	81	13	67
135476	2020-11-16	81	13	67
135477	2020-11-17	81	13	67
135478	2020-11-18	81	13	67
135479	2020-11-19	81	13	67
135480	2020-11-20	81	13	67
135481	2020-11-21	64	14	67
135482	2020-11-22	81	13	67
135483	2020-11-23	81	13	67
135484	2020-11-24	81	13	67
135485	2020-11-25	64	14	67
135486	2020-11-26	81	13	67
135487	2020-11-27	81	13	67
135488	2020-11-28	81	13	67
135489	2020-11-29	81	13	67
135490	2020-11-30	81	13	67
135491	2020-11-01	81	13	73
135492	2020-11-02	81	13	73
135493	2020-11-03	64	14	73
135494	2020-11-04	63	14	73
135495	2020-11-05	81	13	73
135496	2020-11-06	81	13	73
135497	2020-11-07	63	14	73
135498	2020-11-08	63	14	73
135499	2020-11-09	81	13	73
135500	2020-11-10	64	14	73
135501	2020-11-11	81	13	73
135502	2020-11-12	81	13	73
135503	2020-11-13	63	14	73
135504	2020-11-14	81	13	73
135505	2020-11-15	81	13	73
135506	2020-11-16	81	13	73
135507	2020-11-17	64	14	73
135508	2020-11-18	81	13	73
135509	2020-11-19	81	13	73
135510	2020-11-20	81	13	73
135511	2020-11-21	81	13	73
135512	2020-11-22	81	13	73
135513	2020-11-23	81	13	73
135514	2020-11-24	64	14	73
135515	2020-11-25	81	13	73
135516	2020-11-26	81	13	73
135517	2020-11-27	81	13	73
135518	2020-11-28	64	14	73
135519	2020-11-29	81	13	73
135520	2020-11-30	81	13	73
135521	2020-11-01	81	13	66
135522	2020-11-02	81	13	66
135523	2020-11-03	81	13	66
135524	2020-11-04	64	14	66
135525	2020-11-05	63	14	66
135526	2020-11-06	81	13	66
135527	2020-11-07	81	13	66
135528	2020-11-08	63	14	66
135529	2020-11-09	63	14	66
135530	2020-11-10	64	14	66
135531	2020-11-11	63	14	66
135532	2020-11-12	81	13	66
135533	2020-11-13	81	13	66
135534	2020-11-14	81	13	66
135535	2020-11-15	64	14	66
135536	2020-11-16	81	13	66
135537	2020-11-17	81	13	66
135538	2020-11-18	81	13	66
135539	2020-11-19	81	13	66
135540	2020-11-20	81	13	66
135541	2020-11-21	81	13	66
135542	2020-11-22	64	14	66
135543	2020-11-23	81	13	66
135544	2020-11-24	81	13	66
135545	2020-11-25	81	13	66
135546	2020-11-26	81	13	66
135547	2020-11-27	81	13	66
135548	2020-11-28	81	13	66
135549	2020-11-29	64	14	66
135550	2020-11-30	81	13	66
135551	2020-11-01	64	14	55
135552	2020-11-02	63	14	55
135553	2020-11-03	81	13	55
135554	2020-11-04	81	13	55
135555	2020-11-05	63	14	55
135556	2020-11-06	81	13	55
135557	2020-11-07	81	13	55
135558	2020-11-08	81	13	55
135559	2020-11-09	81	13	55
135560	2020-11-10	81	13	55
135561	2020-11-11	64	14	55
135562	2020-11-12	63	14	55
135563	2020-11-13	81	13	55
135564	2020-11-14	81	13	55
135565	2020-11-15	81	13	55
135566	2020-11-16	63	14	55
135567	2020-11-17	81	13	55
135568	2020-11-18	81	13	55
135569	2020-11-19	64	14	55
135570	2020-11-20	64	14	55
135571	2020-11-21	81	13	55
135572	2020-11-22	81	13	55
135573	2020-11-23	81	13	55
135574	2020-11-24	81	13	55
135575	2020-11-25	81	13	55
135576	2020-11-26	81	13	55
135577	2020-11-27	64	14	55
135578	2020-11-28	81	13	55
135579	2020-11-29	81	13	55
135580	2020-11-30	81	13	55
135581	2020-11-01	83	13	68
135582	2020-11-02	83	13	68
135583	2020-11-03	83	13	68
135584	2020-11-04	64	14	68
135585	2020-11-05	63	14	68
135586	2020-11-06	63	14	68
135587	2020-11-07	83	13	68
135588	2020-11-08	83	13	68
135589	2020-11-09	63	14	68
135590	2020-11-10	83	13	68
135591	2020-11-11	83	13	68
135592	2020-11-12	83	13	68
135593	2020-11-13	83	13	68
135594	2020-11-14	64	14	68
135595	2020-11-15	83	13	68
135596	2020-11-16	83	13	68
135597	2020-11-17	83	13	68
135598	2020-11-18	83	13	68
135599	2020-11-19	83	13	68
135600	2020-11-20	64	14	68
135601	2020-11-21	83	13	68
135602	2020-11-22	83	13	68
135603	2020-11-23	83	13	68
135604	2020-11-24	83	13	68
135605	2020-11-25	63	14	68
135606	2020-11-26	64	14	68
135607	2020-11-27	83	13	68
135608	2020-11-28	83	13	68
135609	2020-11-29	83	13	68
135610	2020-11-30	64	14	68
135611	2020-11-01	64	14	80
135612	2020-11-02	63	14	80
135613	2020-11-03	83	13	80
135614	2020-11-04	83	13	80
135615	2020-11-05	83	13	80
135616	2020-11-06	83	13	80
135617	2020-11-07	83	13	80
135618	2020-11-08	64	14	80
135619	2020-11-09	83	13	80
135620	2020-11-10	83	13	80
135621	2020-11-11	63	14	80
135622	2020-11-12	63	14	80
135623	2020-11-13	83	13	80
135624	2020-11-14	83	13	80
135625	2020-11-15	64	14	80
135626	2020-11-16	83	13	80
135627	2020-11-17	83	13	80
135628	2020-11-18	83	13	80
135629	2020-11-19	63	14	80
135630	2020-11-20	83	13	80
135631	2020-11-21	83	13	80
135632	2020-11-22	64	14	80
135633	2020-11-23	83	13	80
135634	2020-11-24	83	13	80
135635	2020-11-25	83	13	80
135636	2020-11-26	83	13	80
135637	2020-11-27	83	13	80
135638	2020-11-28	64	14	80
135639	2020-11-29	83	13	80
135640	2020-11-30	83	13	80
135641	2020-11-01	83	13	60
135642	2020-11-02	83	13	60
135643	2020-11-03	64	14	60
135644	2020-11-04	83	13	60
135645	2020-11-05	83	13	60
135646	2020-11-06	83	13	60
135647	2020-11-07	63	14	60
135648	2020-11-08	83	13	60
135649	2020-11-09	83	13	60
135650	2020-11-10	64	14	60
135651	2020-11-11	83	13	60
135652	2020-11-12	83	13	60
135653	2020-11-13	63	14	60
135654	2020-11-14	83	13	60
135655	2020-11-15	83	13	60
135656	2020-11-16	64	14	60
135657	2020-11-17	63	14	60
135658	2020-11-18	63	14	60
135659	2020-11-19	83	13	60
135660	2020-11-20	83	13	60
135661	2020-11-21	64	14	60
135662	2020-11-22	83	13	60
135663	2020-11-23	83	13	60
135664	2020-11-24	83	13	60
135665	2020-11-25	83	13	60
135666	2020-11-26	83	13	60
135667	2020-11-27	64	14	60
135668	2020-11-28	83	13	60
135669	2020-11-29	83	13	60
135670	2020-11-30	83	13	60
135671	2020-11-01	83	13	53
135672	2020-11-02	83	13	53
135673	2020-11-03	64	14	53
135674	2020-11-04	63	14	53
135675	2020-11-05	83	13	53
135676	2020-11-06	83	13	53
135677	2020-11-07	63	14	53
135678	2020-11-08	63	14	53
135679	2020-11-09	83	13	53
135680	2020-11-10	83	13	53
135681	2020-11-11	64	14	53
135682	2020-11-12	83	13	53
135683	2020-11-13	83	13	53
135684	2020-11-14	83	13	53
135685	2020-11-15	83	13	53
135686	2020-11-16	83	13	53
135687	2020-11-17	83	13	53
135688	2020-11-18	64	14	53
135689	2020-11-19	83	13	53
135690	2020-11-20	63	14	53
135691	2020-11-21	64	14	53
135692	2020-11-22	83	13	53
135693	2020-11-23	83	13	53
135694	2020-11-24	83	13	53
135695	2020-11-25	83	13	53
135696	2020-11-26	64	14	53
135697	2020-11-27	83	13	53
135698	2020-11-28	83	13	53
135699	2020-11-29	83	13	53
135700	2020-11-30	83	13	53
135701	2020-11-01	64	14	54
135702	2020-11-02	63	14	54
135703	2020-11-03	83	13	54
135704	2020-11-04	83	13	54
135705	2020-11-05	83	13	54
135706	2020-11-06	63	14	54
135707	2020-11-07	83	13	54
135708	2020-11-08	83	13	54
135709	2020-11-09	64	14	54
135710	2020-11-10	83	13	54
135711	2020-11-11	83	13	54
135712	2020-11-12	63	14	54
135713	2020-11-13	63	14	54
135714	2020-11-14	83	13	54
135715	2020-11-15	83	13	54
135716	2020-11-16	83	13	54
135717	2020-11-17	83	13	54
135718	2020-11-18	83	13	54
135719	2020-11-19	64	14	54
135720	2020-11-20	83	13	54
135721	2020-11-21	83	13	54
135722	2020-11-22	83	13	54
135723	2020-11-23	83	13	54
135724	2020-11-24	64	14	54
135725	2020-11-25	64	14	54
135726	2020-11-26	83	13	54
135727	2020-11-27	83	13	54
135728	2020-11-28	83	13	54
135729	2020-11-29	83	13	54
135730	2020-11-30	63	14	54
135731	2020-11-01	64	14	49
135732	2020-11-02	63	14	49
135733	2020-11-03	83	13	49
135734	2020-11-04	83	13	49
135735	2020-11-05	83	13	49
135736	2020-11-06	83	13	49
135737	2020-11-07	83	13	49
135738	2020-11-08	64	14	49
135739	2020-11-09	83	13	49
135740	2020-11-10	63	14	49
135741	2020-11-11	63	14	49
135742	2020-11-12	83	13	49
135743	2020-11-13	83	13	49
135744	2020-11-14	83	13	49
135745	2020-11-15	83	13	49
135746	2020-11-16	64	14	49
135747	2020-11-17	63	14	49
135748	2020-11-18	83	13	49
135749	2020-11-19	83	13	49
135750	2020-11-20	83	13	49
135751	2020-11-21	83	13	49
135752	2020-11-22	83	13	49
135753	2020-11-23	64	14	49
135754	2020-11-24	83	13	49
135755	2020-11-25	83	13	49
135756	2020-11-26	83	13	49
135757	2020-11-27	64	14	49
135758	2020-11-28	63	14	49
135759	2020-11-29	83	13	49
135760	2020-11-30	83	13	49
135761	2020-11-01	83	13	50
135762	2020-11-02	83	13	50
135763	2020-11-03	64	14	50
135764	2020-11-04	63	14	50
135765	2020-11-05	63	14	50
135766	2020-11-06	63	14	50
135767	2020-11-07	83	13	50
135768	2020-11-08	83	13	50
135769	2020-11-09	83	13	50
135770	2020-11-10	83	13	50
135771	2020-11-11	83	13	50
135772	2020-11-12	83	13	50
135773	2020-11-13	64	14	50
135774	2020-11-14	63	14	50
135775	2020-11-15	64	14	50
135776	2020-11-16	83	13	50
135777	2020-11-17	83	13	50
135778	2020-11-18	83	13	50
135779	2020-11-19	83	13	50
135780	2020-11-20	83	13	50
135781	2020-11-21	83	13	50
135782	2020-11-22	64	14	50
135783	2020-11-23	83	13	50
135784	2020-11-24	83	13	50
135785	2020-11-25	83	13	50
135786	2020-11-26	83	13	50
135787	2020-11-27	83	13	50
135788	2020-11-28	83	13	50
135789	2020-11-29	64	14	50
135790	2020-11-30	83	13	50
135791	2020-11-01	64	14	43
135792	2020-11-02	82	16	43
135793	2020-11-03	82	16	43
135794	2020-11-04	82	16	43
135795	2020-11-05	82	16	43
135796	2020-11-06	82	16	43
135797	2020-11-07	63	14	43
135798	2020-11-08	64	14	43
135799	2020-11-09	82	16	43
135800	2020-11-10	82	16	43
135801	2020-11-11	82	16	43
135802	2020-11-12	82	16	43
135803	2020-11-13	82	16	43
135804	2020-11-14	63	14	43
135805	2020-11-15	64	14	43
135806	2020-11-16	82	16	43
135807	2020-11-17	82	16	43
135808	2020-11-18	82	16	43
135809	2020-11-19	82	16	43
135810	2020-11-20	82	16	43
135811	2020-11-21	63	14	43
135812	2020-11-22	64	14	43
135813	2020-11-23	82	16	43
135814	2020-11-24	82	16	43
135815	2020-11-25	82	16	43
135816	2020-11-26	82	16	43
135817	2020-11-27	82	16	43
135818	2020-11-28	63	14	43
135819	2020-11-29	64	14	43
135820	2020-11-30	82	16	43
135821	2020-11-01	64	14	44
135822	2020-11-02	82	16	44
135823	2020-11-03	82	16	44
135824	2020-11-04	82	16	44
135825	2020-11-05	82	16	44
135826	2020-11-06	82	16	44
135827	2020-11-07	63	14	44
135828	2020-11-08	64	14	44
135829	2020-11-09	82	16	44
135830	2020-11-10	82	16	44
135831	2020-11-11	82	16	44
135832	2020-11-12	82	16	44
135833	2020-11-13	82	16	44
135834	2020-11-14	63	14	44
135835	2020-11-15	64	14	44
135836	2020-11-16	82	16	44
135837	2020-11-17	82	16	44
135838	2020-11-18	82	16	44
135839	2020-11-19	82	16	44
135840	2020-11-20	82	16	44
135841	2020-11-21	63	14	44
135842	2020-11-22	64	14	44
135843	2020-11-23	82	16	44
135844	2020-11-24	82	16	44
135845	2020-11-25	82	16	44
135846	2020-11-26	82	16	44
135847	2020-11-27	82	16	44
135848	2020-11-28	63	14	44
135849	2020-11-29	64	14	44
135850	2020-11-30	82	16	44
135851	2020-10-01	80	13	47
135852	2020-10-02	80	13	47
135853	2020-10-03	80	13	47
135854	2020-10-04	80	13	47
135855	2020-10-05	64	14	47
135856	2020-10-06	63	14	47
135857	2020-10-07	63	14	47
135858	2020-10-08	80	13	47
135859	2020-10-09	80	13	47
135860	2020-10-10	80	13	47
135861	2020-10-11	80	13	47
135862	2020-10-12	80	13	47
135863	2020-10-13	80	13	47
135864	2020-10-14	64	14	47
135865	2020-10-15	63	14	47
135866	2020-10-16	63	14	47
135867	2020-10-17	80	13	47
135868	2020-10-18	80	13	47
135869	2020-10-19	80	13	47
135870	2020-10-20	80	13	47
135871	2020-10-21	64	14	47
135872	2020-10-22	80	13	47
135873	2020-10-23	80	13	47
135874	2020-10-24	80	13	47
135875	2020-10-25	63	14	47
135876	2020-10-26	80	13	47
135877	2020-10-27	80	13	47
135878	2020-10-28	80	13	47
135879	2020-10-29	64	14	47
135880	2020-10-30	80	13	47
135881	2020-10-31	80	13	47
135882	2020-10-01	80	13	69
135883	2020-10-02	63	14	69
135884	2020-10-03	63	14	69
135885	2020-10-04	80	13	69
135886	2020-10-05	80	13	69
135887	2020-10-06	80	13	69
135888	2020-10-07	80	13	69
135889	2020-10-08	80	13	69
135890	2020-10-09	64	14	69
135891	2020-10-10	63	14	69
135892	2020-10-11	80	13	69
135893	2020-10-12	80	13	69
135894	2020-10-13	63	14	69
135895	2020-10-14	80	13	69
135896	2020-10-15	80	13	69
135897	2020-10-16	80	13	69
135898	2020-10-17	64	14	69
135899	2020-10-18	80	13	69
135900	2020-10-19	80	13	69
135901	2020-10-20	80	13	69
135902	2020-10-21	80	13	69
135903	2020-10-22	63	14	69
135904	2020-10-23	80	13	69
135905	2020-10-24	80	13	69
135906	2020-10-25	80	13	69
135907	2020-10-26	80	13	69
135908	2020-10-27	64	14	69
135909	2020-10-28	64	14	69
135910	2020-10-29	80	13	69
135911	2020-10-30	80	13	69
135912	2020-10-31	80	13	69
135913	2020-10-01	63	14	46
135914	2020-10-02	80	13	46
135915	2020-10-03	80	13	46
135916	2020-10-04	64	14	46
135917	2020-10-05	80	13	46
135918	2020-10-06	80	13	46
135919	2020-10-07	80	13	46
135920	2020-10-08	63	14	46
135921	2020-10-09	80	13	46
135922	2020-10-10	80	13	46
135923	2020-10-11	80	13	46
135924	2020-10-12	64	14	46
135925	2020-10-13	80	13	46
135926	2020-10-14	80	13	46
135927	2020-10-15	80	13	46
135928	2020-10-16	80	13	46
135929	2020-10-17	80	13	46
135930	2020-10-18	64	14	46
135931	2020-10-19	63	14	46
135932	2020-10-20	80	13	46
135933	2020-10-21	80	13	46
135934	2020-10-22	80	13	46
135935	2020-10-23	80	13	46
135936	2020-10-24	80	13	46
135937	2020-10-25	80	13	46
135938	2020-10-26	64	14	46
135939	2020-10-27	80	13	46
135940	2020-10-28	80	13	46
135941	2020-10-29	80	13	46
135942	2020-10-30	63	14	46
135943	2020-10-31	63	14	46
135944	2020-10-01	63	14	64
135945	2020-10-02	80	13	64
135946	2020-10-03	80	13	64
135947	2020-10-04	80	13	64
135948	2020-10-05	80	13	64
135949	2020-10-06	64	14	64
135950	2020-10-07	80	13	64
135951	2020-10-08	80	13	64
135952	2020-10-09	80	13	64
135953	2020-10-10	63	14	64
135954	2020-10-11	80	13	64
135955	2020-10-12	80	13	64
135956	2020-10-13	64	14	64
135957	2020-10-14	80	13	64
135958	2020-10-15	80	13	64
135959	2020-10-16	63	14	64
135960	2020-10-17	80	13	64
135961	2020-10-18	80	13	64
135962	2020-10-19	64	14	64
135963	2020-10-20	80	13	64
135964	2020-10-21	80	13	64
135965	2020-10-22	80	13	64
135966	2020-10-23	80	13	64
135967	2020-10-24	63	14	64
135968	2020-10-25	80	13	64
135969	2020-10-26	80	13	64
135970	2020-10-27	64	14	64
135971	2020-10-28	80	13	64
135972	2020-10-29	80	13	64
135973	2020-10-30	63	14	64
135974	2020-10-31	80	13	64
135975	2020-10-01	80	13	65
135976	2020-10-02	80	13	65
135977	2020-10-03	80	13	65
135978	2020-10-04	80	13	65
135979	2020-10-05	64	14	65
135980	2020-10-06	80	13	65
135981	2020-10-07	80	13	65
135982	2020-10-08	63	14	65
135983	2020-10-09	63	14	65
135984	2020-10-10	80	13	65
135985	2020-10-11	80	13	65
135986	2020-10-12	80	13	65
135987	2020-10-13	80	13	65
135988	2020-10-14	64	14	65
135989	2020-10-15	63	14	65
135990	2020-10-16	80	13	65
135991	2020-10-17	80	13	65
135992	2020-10-18	80	13	65
135993	2020-10-19	80	13	65
135994	2020-10-20	64	14	65
135995	2020-10-21	80	13	65
135996	2020-10-22	80	13	65
135997	2020-10-23	80	13	65
135998	2020-10-24	63	14	65
135999	2020-10-25	80	13	65
136000	2020-10-26	80	13	65
136001	2020-10-27	64	14	65
136002	2020-10-28	63	14	65
136003	2020-10-29	80	13	65
136004	2020-10-30	80	13	65
136005	2020-10-31	80	13	65
136006	2020-10-01	80	13	51
136007	2020-10-02	80	13	51
136008	2020-10-03	80	13	51
136009	2020-10-04	64	14	51
136010	2020-10-05	63	14	51
136011	2020-10-06	80	13	51
136012	2020-10-07	80	13	51
136013	2020-10-08	80	13	51
136014	2020-10-09	63	14	51
136015	2020-10-10	80	13	51
136016	2020-10-11	80	13	51
136017	2020-10-12	80	13	51
136018	2020-10-13	80	13	51
136019	2020-10-14	80	13	51
136020	2020-10-15	80	13	51
136021	2020-10-16	64	14	51
136022	2020-10-17	63	14	51
136023	2020-10-18	80	13	51
136024	2020-10-19	80	13	51
136025	2020-10-20	63	14	51
136026	2020-10-21	80	13	51
136027	2020-10-22	80	13	51
136028	2020-10-23	80	13	51
136029	2020-10-24	80	13	51
136030	2020-10-25	64	14	51
136031	2020-10-26	80	13	51
136032	2020-10-27	80	13	51
136033	2020-10-28	80	13	51
136034	2020-10-29	63	14	51
136035	2020-10-30	64	14	51
136036	2020-10-31	80	13	51
136037	2020-10-01	64	14	57
136038	2020-10-02	63	14	57
136039	2020-10-03	80	13	57
136040	2020-10-04	80	13	57
136041	2020-10-05	63	14	57
136042	2020-10-06	80	13	57
136043	2020-10-07	80	13	57
136044	2020-10-08	80	13	57
136045	2020-10-09	80	13	57
136046	2020-10-10	80	13	57
136047	2020-10-11	80	13	57
136048	2020-10-12	64	14	57
136049	2020-10-13	80	13	57
136050	2020-10-14	80	13	57
136051	2020-10-15	80	13	57
136052	2020-10-16	80	13	57
136053	2020-10-17	80	13	57
136054	2020-10-18	64	14	57
136055	2020-10-19	80	13	57
136056	2020-10-20	80	13	57
136057	2020-10-21	63	14	57
136058	2020-10-22	63	14	57
136059	2020-10-23	80	13	57
136060	2020-10-24	80	13	57
136061	2020-10-25	80	13	57
136062	2020-10-26	64	14	57
136063	2020-10-27	80	13	57
136064	2020-10-28	80	13	57
136065	2020-10-29	63	14	57
136066	2020-10-30	80	13	57
136067	2020-10-31	80	13	57
136068	2020-10-01	80	13	71
136069	2020-10-02	80	13	71
136070	2020-10-03	64	14	71
136071	2020-10-04	80	13	71
136072	2020-10-05	80	13	71
136073	2020-10-06	80	13	71
136074	2020-10-07	63	14	71
136075	2020-10-08	80	13	71
136076	2020-10-09	80	13	71
136077	2020-10-10	80	13	71
136078	2020-10-11	64	14	71
136079	2020-10-12	80	13	71
136080	2020-10-13	80	13	71
136081	2020-10-14	80	13	71
136082	2020-10-15	80	13	71
136083	2020-10-16	80	13	71
136084	2020-10-17	80	13	71
136085	2020-10-18	64	14	71
136086	2020-10-19	80	13	71
136087	2020-10-20	80	13	71
136088	2020-10-21	63	14	71
136089	2020-10-22	63	14	71
136090	2020-10-23	63	14	71
136091	2020-10-24	80	13	71
136092	2020-10-25	80	13	71
136093	2020-10-26	80	13	71
136094	2020-10-27	64	14	71
136095	2020-10-28	63	14	71
136096	2020-10-29	80	13	71
136097	2020-10-30	80	13	71
136098	2020-10-31	80	13	71
136099	2020-10-01	80	13	78
136100	2020-10-02	64	14	78
136101	2020-10-03	80	13	78
136102	2020-10-04	80	13	78
136103	2020-10-05	80	13	78
136104	2020-10-06	80	13	78
136105	2020-10-07	80	13	78
136106	2020-10-08	64	14	78
136107	2020-10-09	80	13	78
136108	2020-10-10	80	13	78
136109	2020-10-11	80	13	78
136110	2020-10-12	63	14	78
136111	2020-10-13	63	14	78
136112	2020-10-14	64	14	78
136113	2020-10-15	80	13	78
136114	2020-10-16	80	13	78
136115	2020-10-17	80	13	78
136116	2020-10-18	80	13	78
136117	2020-10-19	63	14	78
136118	2020-10-20	80	13	78
136119	2020-10-21	80	13	78
136120	2020-10-22	80	13	78
136121	2020-10-23	64	14	78
136122	2020-10-24	80	13	78
136123	2020-10-25	80	13	78
136124	2020-10-26	80	13	78
136125	2020-10-27	80	13	78
136126	2020-10-28	63	14	78
136127	2020-10-29	63	14	78
136128	2020-10-30	80	13	78
136129	2020-10-31	80	13	78
136130	2020-10-01	80	13	79
136131	2020-10-02	80	13	79
136132	2020-10-03	64	14	79
136133	2020-10-04	80	13	79
136134	2020-10-05	80	13	79
136135	2020-10-06	63	14	79
136136	2020-10-07	63	14	79
136137	2020-10-08	80	13	79
136138	2020-10-09	80	13	79
136139	2020-10-10	80	13	79
136140	2020-10-11	64	14	79
136141	2020-10-12	80	13	79
136142	2020-10-13	80	13	79
136143	2020-10-14	80	13	79
136144	2020-10-15	63	14	79
136145	2020-10-16	80	13	79
136146	2020-10-17	80	13	79
136147	2020-10-18	80	13	79
136148	2020-10-19	80	13	79
136149	2020-10-20	64	14	79
136150	2020-10-21	80	13	79
136151	2020-10-22	80	13	79
136152	2020-10-23	63	14	79
136153	2020-10-24	80	13	79
136154	2020-10-25	80	13	79
136155	2020-10-26	64	14	79
136156	2020-10-27	80	13	79
136157	2020-10-28	80	13	79
136158	2020-10-29	80	13	79
136159	2020-10-30	80	13	79
136160	2020-10-31	63	14	79
136161	2020-10-01	64	14	56
136162	2020-10-02	81	13	56
136163	2020-10-03	81	13	56
136164	2020-10-04	81	13	56
136165	2020-10-05	63	14	56
136166	2020-10-06	81	13	56
136167	2020-10-07	81	13	56
136168	2020-10-08	81	13	56
136169	2020-10-09	81	13	56
136170	2020-10-10	64	14	56
136171	2020-10-11	63	14	56
136172	2020-10-12	81	13	56
136173	2020-10-13	81	13	56
136174	2020-10-14	81	13	56
136175	2020-10-15	81	13	56
136176	2020-10-16	81	13	56
136177	2020-10-17	81	13	56
136178	2020-10-18	64	14	56
136179	2020-10-19	63	14	56
136180	2020-10-20	81	13	56
136181	2020-10-21	81	13	56
136182	2020-10-22	81	13	56
136183	2020-10-23	81	13	56
136184	2020-10-24	81	13	56
136185	2020-10-25	81	13	56
136186	2020-10-26	64	14	56
136187	2020-10-27	63	14	56
136188	2020-10-28	81	13	56
136189	2020-10-29	81	13	56
136190	2020-10-30	81	13	56
136191	2020-10-31	63	14	56
136192	2020-10-01	81	13	62
136193	2020-10-02	81	13	62
136194	2020-10-03	63	14	62
136195	2020-10-04	81	13	62
136196	2020-10-05	81	13	62
136197	2020-10-06	81	13	62
136198	2020-10-07	81	13	62
136199	2020-10-08	81	13	62
136200	2020-10-09	64	14	62
136201	2020-10-10	81	13	62
136202	2020-10-11	81	13	62
136203	2020-10-12	81	13	62
136204	2020-10-13	81	13	62
136205	2020-10-14	63	14	62
136206	2020-10-15	81	13	62
136207	2020-10-16	81	13	62
136208	2020-10-17	64	14	62
136209	2020-10-18	81	13	62
136210	2020-10-19	81	13	62
136211	2020-10-20	81	13	62
136212	2020-10-21	63	14	62
136213	2020-10-22	63	14	62
136214	2020-10-23	81	13	62
136215	2020-10-24	81	13	62
136216	2020-10-25	64	14	62
136217	2020-10-26	81	13	62
136218	2020-10-27	81	13	62
136219	2020-10-28	63	14	62
136220	2020-10-29	64	14	62
136221	2020-10-30	81	13	62
136222	2020-10-31	81	13	62
136223	2020-10-01	63	14	63
136224	2020-10-02	81	13	63
136225	2020-10-03	81	13	63
136226	2020-10-04	81	13	63
136227	2020-10-05	64	14	63
136228	2020-10-06	63	14	63
136229	2020-10-07	81	13	63
136230	2020-10-08	81	13	63
136231	2020-10-09	81	13	63
136232	2020-10-10	81	13	63
136233	2020-10-11	81	13	63
136234	2020-10-12	81	13	63
136235	2020-10-13	64	14	63
136236	2020-10-14	63	14	63
136237	2020-10-15	81	13	63
136238	2020-10-16	81	13	63
136239	2020-10-17	81	13	63
136240	2020-10-18	81	13	63
136241	2020-10-19	64	14	63
136242	2020-10-20	63	14	63
136243	2020-10-21	81	13	63
136244	2020-10-22	81	13	63
136245	2020-10-23	81	13	63
136246	2020-10-24	81	13	63
136247	2020-10-25	64	14	63
136248	2020-10-26	81	13	63
136249	2020-10-27	81	13	63
136250	2020-10-28	81	13	63
136251	2020-10-29	63	14	63
136252	2020-10-30	81	13	63
136253	2020-10-31	81	13	63
136254	2020-10-01	81	13	67
136255	2020-10-02	63	14	67
136256	2020-10-03	81	13	67
136257	2020-10-04	81	13	67
136258	2020-10-05	81	13	67
136259	2020-10-06	81	13	67
136260	2020-10-07	81	13	67
136261	2020-10-08	64	14	67
136262	2020-10-09	63	14	67
136263	2020-10-10	81	13	67
136264	2020-10-11	81	13	67
136265	2020-10-12	63	14	67
136266	2020-10-13	81	13	67
136267	2020-10-14	81	13	67
136268	2020-10-15	64	14	67
136269	2020-10-16	63	14	67
136270	2020-10-17	81	13	67
136271	2020-10-18	81	13	67
136272	2020-10-19	81	13	67
136273	2020-10-20	63	14	67
136274	2020-10-21	81	13	67
136275	2020-10-22	81	13	67
136276	2020-10-23	64	14	67
136277	2020-10-24	81	13	67
136278	2020-10-25	81	13	67
136279	2020-10-26	64	14	67
136280	2020-10-27	81	13	67
136281	2020-10-28	81	13	67
136282	2020-10-29	81	13	67
136283	2020-10-30	81	13	67
136284	2020-10-31	81	13	67
136285	2020-10-01	64	14	73
136286	2020-10-02	81	13	73
136287	2020-10-03	81	13	73
136288	2020-10-04	81	13	73
136289	2020-10-05	81	13	73
136290	2020-10-06	63	14	73
136291	2020-10-07	81	13	73
136292	2020-10-08	81	13	73
136293	2020-10-09	81	13	73
136294	2020-10-10	64	14	73
136295	2020-10-11	81	13	73
136296	2020-10-12	81	13	73
136297	2020-10-13	81	13	73
136298	2020-10-14	81	13	73
136299	2020-10-15	63	14	73
136300	2020-10-16	81	13	73
136301	2020-10-17	81	13	73
136302	2020-10-18	64	14	73
136303	2020-10-19	81	13	73
136304	2020-10-20	81	13	73
136305	2020-10-21	81	13	73
136306	2020-10-22	63	14	73
136307	2020-10-23	81	13	73
136308	2020-10-24	81	13	73
136309	2020-10-25	81	13	73
136310	2020-10-26	81	13	73
136311	2020-10-27	64	14	73
136312	2020-10-28	63	14	73
136313	2020-10-29	63	14	73
136314	2020-10-30	81	13	73
136315	2020-10-31	81	13	73
136316	2020-10-01	81	13	66
136317	2020-10-02	64	14	66
136318	2020-10-03	81	13	66
136319	2020-10-04	81	13	66
136320	2020-10-05	81	13	66
136321	2020-10-06	81	13	66
136322	2020-10-07	63	14	66
136323	2020-10-08	64	14	66
136324	2020-10-09	81	13	66
136325	2020-10-10	81	13	66
136326	2020-10-11	81	13	66
136327	2020-10-12	81	13	66
136328	2020-10-13	63	14	66
136329	2020-10-14	64	14	66
136330	2020-10-15	81	13	66
136331	2020-10-16	81	13	66
136332	2020-10-17	81	13	66
136333	2020-10-18	81	13	66
136334	2020-10-19	81	13	66
136335	2020-10-20	81	13	66
136336	2020-10-21	64	14	66
136337	2020-10-22	81	13	66
136338	2020-10-23	81	13	66
136339	2020-10-24	81	13	66
136340	2020-10-25	81	13	66
136341	2020-10-26	81	13	66
136342	2020-10-27	81	13	66
136343	2020-10-28	63	14	66
136344	2020-10-29	81	13	66
136345	2020-10-30	63	14	66
136346	2020-10-31	63	14	66
136347	2020-10-01	81	13	55
136348	2020-10-02	81	13	55
136349	2020-10-03	64	14	55
136350	2020-10-04	63	14	55
136351	2020-10-05	81	13	55
136352	2020-10-06	81	13	55
136353	2020-10-07	63	14	55
136354	2020-10-08	81	13	55
136355	2020-10-09	81	13	55
136356	2020-10-10	81	13	55
136357	2020-10-11	64	14	55
136358	2020-10-12	63	14	55
136359	2020-10-13	81	13	55
136360	2020-10-14	81	13	55
136361	2020-10-15	81	13	55
136362	2020-10-16	63	14	55
136363	2020-10-17	81	13	55
136364	2020-10-18	81	13	55
136365	2020-10-19	81	13	55
136366	2020-10-20	81	13	55
136367	2020-10-21	81	13	55
136368	2020-10-22	81	13	55
136369	2020-10-23	64	14	55
136370	2020-10-24	63	14	55
136371	2020-10-25	81	13	55
136372	2020-10-26	81	13	55
136373	2020-10-27	81	13	55
136374	2020-10-28	81	13	55
136375	2020-10-29	81	13	55
136376	2020-10-30	64	14	55
136377	2020-10-31	81	13	55
136378	2020-10-01	64	14	68
136379	2020-10-02	63	14	68
136380	2020-10-03	83	13	68
136381	2020-10-04	83	13	68
136382	2020-10-05	83	13	68
136383	2020-10-06	83	13	68
136384	2020-10-07	64	14	68
136385	2020-10-08	63	14	68
136386	2020-10-09	83	13	68
136387	2020-10-10	83	13	68
136388	2020-10-11	63	14	68
136389	2020-10-12	83	13	68
136390	2020-10-13	83	13	68
136391	2020-10-14	64	14	68
136392	2020-10-15	83	13	68
136393	2020-10-16	83	13	68
136394	2020-10-17	83	13	68
136395	2020-10-18	63	14	68
136396	2020-10-19	83	13	68
136397	2020-10-20	83	13	68
136398	2020-10-21	83	13	68
136399	2020-10-22	64	14	68
136400	2020-10-23	83	13	68
136401	2020-10-24	83	13	68
136402	2020-10-25	83	13	68
136403	2020-10-26	83	13	68
136404	2020-10-27	83	13	68
136405	2020-10-28	83	13	68
136406	2020-10-29	63	14	68
136407	2020-10-30	83	13	68
136408	2020-10-31	83	13	68
136409	2020-10-01	83	13	80
136410	2020-10-02	83	13	80
136411	2020-10-03	83	13	80
136412	2020-10-04	83	13	80
136413	2020-10-05	64	14	80
136414	2020-10-06	63	14	80
136415	2020-10-07	83	13	80
136416	2020-10-08	83	13	80
136417	2020-10-09	83	13	80
136418	2020-10-10	83	13	80
136419	2020-10-11	83	13	80
136420	2020-10-12	83	13	80
136421	2020-10-13	64	14	80
136422	2020-10-14	83	13	80
136423	2020-10-15	83	13	80
136424	2020-10-16	63	14	80
136425	2020-10-17	63	14	80
136426	2020-10-18	83	13	80
136427	2020-10-19	83	13	80
136428	2020-10-20	83	13	80
136429	2020-10-21	83	13	80
136430	2020-10-22	83	13	80
136431	2020-10-23	64	14	80
136432	2020-10-24	63	14	80
136433	2020-10-25	63	14	80
136434	2020-10-26	83	13	80
136435	2020-10-27	83	13	80
136436	2020-10-28	83	13	80
136437	2020-10-29	83	13	80
136438	2020-10-30	64	14	80
136439	2020-10-31	83	13	80
136440	2020-10-01	83	13	60
136441	2020-10-02	83	13	60
136442	2020-10-03	64	14	60
136443	2020-10-04	83	13	60
136444	2020-10-05	83	13	60
136445	2020-10-06	83	13	60
136446	2020-10-07	83	13	60
136447	2020-10-08	83	13	60
136448	2020-10-09	64	14	60
136449	2020-10-10	83	13	60
136450	2020-10-11	83	13	60
136451	2020-10-12	63	14	60
136452	2020-10-13	83	13	60
136453	2020-10-14	83	13	60
136454	2020-10-15	64	14	60
136455	2020-10-16	83	13	60
136456	2020-10-17	83	13	60
136457	2020-10-18	83	13	60
136458	2020-10-19	63	14	60
136459	2020-10-20	83	13	60
136460	2020-10-21	83	13	60
136461	2020-10-22	83	13	60
136462	2020-10-23	83	13	60
136463	2020-10-24	83	13	60
136464	2020-10-25	83	13	60
136465	2020-10-26	64	14	60
136466	2020-10-27	63	14	60
136467	2020-10-28	63	14	60
136468	2020-10-29	83	13	60
136469	2020-10-30	83	13	60
136470	2020-10-31	63	14	60
136471	2020-10-01	63	14	53
136472	2020-10-02	83	13	53
136473	2020-10-03	83	13	53
136474	2020-10-04	83	13	53
136475	2020-10-05	64	14	53
136476	2020-10-06	83	13	53
136477	2020-10-07	83	13	53
136478	2020-10-08	83	13	53
136479	2020-10-09	83	13	53
136480	2020-10-10	83	13	53
136481	2020-10-11	83	13	53
136482	2020-10-12	64	14	53
136483	2020-10-13	83	13	53
136484	2020-10-14	83	13	53
136485	2020-10-15	83	13	53
136486	2020-10-16	63	14	53
136487	2020-10-17	83	13	53
136488	2020-10-18	83	13	53
136489	2020-10-19	64	14	53
136490	2020-10-20	83	13	53
136491	2020-10-21	83	13	53
136492	2020-10-22	63	14	53
136493	2020-10-23	63	14	53
136494	2020-10-24	83	13	53
136495	2020-10-25	83	13	53
136496	2020-10-26	83	13	53
136497	2020-10-27	83	13	53
136498	2020-10-28	64	14	53
136499	2020-10-29	83	13	53
136500	2020-10-30	83	13	53
136501	2020-10-31	63	14	53
136502	2020-10-01	83	13	54
136503	2020-10-02	64	14	54
136504	2020-10-03	83	13	54
136505	2020-10-04	83	13	54
136506	2020-10-05	63	14	54
136507	2020-10-06	83	13	54
136508	2020-10-07	83	13	54
136509	2020-10-08	64	14	54
136510	2020-10-09	63	14	54
136511	2020-10-10	83	13	54
136512	2020-10-11	83	13	54
136513	2020-10-12	83	13	54
136514	2020-10-13	83	13	54
136515	2020-10-14	64	14	54
136516	2020-10-15	63	14	54
136517	2020-10-16	83	13	54
136518	2020-10-17	83	13	54
136519	2020-10-18	83	13	54
136520	2020-10-19	83	13	54
136521	2020-10-20	83	13	54
136522	2020-10-21	64	14	54
136523	2020-10-22	63	14	54
136524	2020-10-23	83	13	54
136525	2020-10-24	83	13	54
136526	2020-10-25	83	13	54
136527	2020-10-26	83	13	54
136528	2020-10-27	83	13	54
136529	2020-10-28	83	13	54
136530	2020-10-29	63	14	54
136531	2020-10-30	83	13	54
136532	2020-10-31	83	13	54
136533	2020-10-01	83	13	49
136534	2020-10-02	83	13	49
136535	2020-10-03	64	14	49
136536	2020-10-04	63	14	49
136537	2020-10-05	83	13	49
136538	2020-10-06	83	13	49
136539	2020-10-07	63	14	49
136540	2020-10-08	83	13	49
136541	2020-10-09	83	13	49
136542	2020-10-10	64	14	49
136543	2020-10-11	83	13	49
136544	2020-10-12	83	13	49
136545	2020-10-13	83	13	49
136546	2020-10-14	83	13	49
136547	2020-10-15	63	14	49
136548	2020-10-16	83	13	49
136549	2020-10-17	83	13	49
136550	2020-10-18	83	13	49
136551	2020-10-19	83	13	49
136552	2020-10-20	64	14	49
136553	2020-10-21	83	13	49
136554	2020-10-22	83	13	49
136555	2020-10-23	83	13	49
136556	2020-10-24	83	13	49
136557	2020-10-25	83	13	49
136558	2020-10-26	64	14	49
136559	2020-10-27	63	14	49
136560	2020-10-28	83	13	49
136561	2020-10-29	83	13	49
136562	2020-10-30	63	14	49
136563	2020-10-31	83	13	49
136564	2020-10-01	83	13	50
136565	2020-10-02	63	14	50
136566	2020-10-03	83	13	50
136567	2020-10-04	83	13	50
136568	2020-10-05	83	13	50
136569	2020-10-06	64	14	50
136570	2020-10-07	83	13	50
136571	2020-10-08	83	13	50
136572	2020-10-09	63	14	50
136573	2020-10-10	83	13	50
136574	2020-10-11	83	13	50
136575	2020-10-12	64	14	50
136576	2020-10-13	63	14	50
136577	2020-10-14	83	13	50
136578	2020-10-15	83	13	50
136579	2020-10-16	83	13	50
136580	2020-10-17	83	13	50
136581	2020-10-18	83	13	50
136582	2020-10-19	83	13	50
136583	2020-10-20	64	14	50
136584	2020-10-21	63	14	50
136585	2020-10-22	83	13	50
136586	2020-10-23	83	13	50
136587	2020-10-24	83	13	50
136588	2020-10-25	83	13	50
136589	2020-10-26	64	14	50
136590	2020-10-27	83	13	50
136591	2020-10-28	83	13	50
136592	2020-10-29	83	13	50
136593	2020-10-30	63	14	50
136594	2020-10-31	83	13	50
136595	2020-10-01	82	16	43
136596	2020-10-02	82	16	43
136597	2020-10-03	63	14	43
136598	2020-10-04	64	14	43
136599	2020-10-05	82	16	43
136600	2020-10-06	82	16	43
136601	2020-10-07	82	16	43
136602	2020-10-08	82	16	43
136603	2020-10-09	82	16	43
136604	2020-10-10	63	14	43
136605	2020-10-11	64	14	43
136606	2020-10-12	82	16	43
136607	2020-10-13	82	16	43
136608	2020-10-14	82	16	43
136609	2020-10-15	82	16	43
136610	2020-10-16	82	16	43
136611	2020-10-17	63	14	43
136612	2020-10-18	64	14	43
136613	2020-10-19	82	16	43
136614	2020-10-20	82	16	43
136615	2020-10-21	82	16	43
136616	2020-10-22	82	16	43
136617	2020-10-23	82	16	43
136618	2020-10-24	63	14	43
136619	2020-10-25	64	14	43
136620	2020-10-26	82	16	43
136621	2020-10-27	82	16	43
136622	2020-10-28	82	16	43
136623	2020-10-29	82	16	43
136624	2020-10-30	82	16	43
136625	2020-10-31	63	14	43
136626	2020-10-01	82	16	44
136627	2020-10-02	82	16	44
136628	2020-10-03	63	14	44
136629	2020-10-04	64	14	44
136630	2020-10-05	82	16	44
136631	2020-10-06	82	16	44
136632	2020-10-07	82	16	44
136633	2020-10-08	82	16	44
136634	2020-10-09	82	16	44
136635	2020-10-10	63	14	44
136636	2020-10-11	64	14	44
136637	2020-10-12	82	16	44
136638	2020-10-13	82	16	44
136639	2020-10-14	82	16	44
136640	2020-10-15	82	16	44
136641	2020-10-16	82	16	44
136642	2020-10-17	63	14	44
136643	2020-10-18	64	14	44
136644	2020-10-19	82	16	44
136645	2020-10-20	82	16	44
136646	2020-10-21	82	16	44
136647	2020-10-22	82	16	44
136648	2020-10-23	82	16	44
136649	2020-10-24	63	14	44
136650	2020-10-25	64	14	44
136651	2020-10-26	82	16	44
136652	2020-10-27	82	16	44
136653	2020-10-28	82	16	44
136654	2020-10-29	82	16	44
136655	2020-10-30	82	16	44
136656	2020-10-31	63	14	44
\.


--
-- Data for Name: result_result; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.result_result (id, date, shift_id, station_id, user_id) FROM stdin;
7924	2020-09-01	64	14	47
7925	2020-09-02	63	14	47
7926	2020-09-03	80	13	47
7927	2020-09-04	80	13	47
7928	2020-09-05	80	13	47
7929	2020-09-06	80	13	47
7930	2020-09-07	80	13	47
7931	2020-09-08	80	13	47
7932	2020-09-09	64	14	47
7933	2020-09-10	80	13	47
7934	2020-09-11	80	13	47
7935	2020-09-12	80	13	47
7936	2020-09-13	80	13	47
7937	2020-09-14	80	13	47
7938	2020-09-15	64	14	47
7939	2020-09-16	63	14	47
7940	2020-09-17	80	13	47
7941	2020-09-18	80	13	47
7942	2020-09-19	80	13	47
7943	2020-09-20	63	14	47
7944	2020-09-21	80	13	47
7945	2020-09-22	80	13	47
7946	2020-09-23	80	13	47
7947	2020-09-24	80	13	47
7948	2020-09-25	80	13	47
7949	2020-09-26	80	13	47
7950	2020-09-27	64	14	47
7951	2020-09-28	84	14	47
7952	2020-09-29	63	14	47
7953	2020-09-30	80	13	47
7954	2020-09-01	80	13	69
7955	2020-09-02	80	13	69
7956	2020-09-03	80	13	69
7957	2020-09-04	64	14	69
7958	2020-09-05	84	14	69
7959	2020-09-06	63	14	69
7960	2020-09-07	63	14	69
7961	2020-09-08	63	14	69
7962	2020-09-09	80	13	69
7963	2020-09-10	80	13	69
7964	2020-09-11	80	13	69
7965	2020-09-12	80	13	69
7966	2020-09-13	80	13	69
7967	2020-09-14	64	14	69
7968	2020-09-15	80	13	69
7969	2020-09-16	80	13	69
7970	2020-09-17	80	13	69
7971	2020-09-18	80	13	69
7972	2020-09-19	80	13	69
7973	2020-09-20	80	13	69
7974	2020-09-21	64	14	69
7975	2020-09-22	80	13	69
7976	2020-09-23	80	13	69
7977	2020-09-24	63	14	69
7978	2020-09-25	80	13	69
7979	2020-09-26	80	13	69
7980	2020-09-27	80	13	69
7981	2020-09-28	80	13	69
7982	2020-09-29	64	14	69
7983	2020-09-30	80	13	69
7984	2020-09-01	80	13	46
7985	2020-09-02	80	13	46
7986	2020-09-03	64	14	46
7987	2020-09-04	80	13	46
7988	2020-09-05	80	13	46
7989	2020-09-06	63	14	46
7990	2020-09-07	80	13	46
7991	2020-09-08	80	13	46
7992	2020-09-09	80	13	46
7993	2020-09-10	64	14	46
7994	2020-09-11	63	14	46
7995	2020-09-12	63	14	46
7996	2020-09-13	63	14	46
7997	2020-09-14	80	13	46
7998	2020-09-15	80	13	46
7999	2020-09-16	80	13	46
8000	2020-09-17	80	13	46
8001	2020-09-18	80	13	46
8002	2020-09-19	64	14	46
8003	2020-09-20	84	14	46
8004	2020-09-21	80	13	46
8005	2020-09-22	80	13	46
8006	2020-09-23	65	15	46
8007	2020-09-24	80	13	46
8008	2020-09-25	80	13	46
8009	2020-09-26	80	13	46
8010	2020-09-27	64	14	46
8011	2020-09-28	80	13	46
8012	2020-09-29	80	13	46
8013	2020-09-30	80	13	46
8014	2020-09-01	80	13	60
8015	2020-09-02	64	14	60
8016	2020-09-03	80	13	60
8017	2020-09-04	80	13	60
8018	2020-09-05	80	13	60
8019	2020-09-06	80	13	60
8020	2020-09-07	80	13	60
8021	2020-09-08	80	13	60
8022	2020-09-09	64	14	60
8023	2020-09-10	80	13	60
8024	2020-09-11	80	13	60
8025	2020-09-12	63	14	60
8026	2020-09-13	80	13	60
8027	2020-09-14	80	13	60
8028	2020-09-15	80	13	60
8029	2020-09-16	80	13	60
8030	2020-09-17	64	14	60
8031	2020-09-18	84	14	60
8032	2020-09-19	80	13	60
8033	2020-09-20	80	13	60
8034	2020-09-21	80	13	60
8035	2020-09-22	63	14	60
8036	2020-09-23	80	13	60
8037	2020-09-24	80	13	60
8038	2020-09-25	64	14	60
8039	2020-09-26	63	14	60
8040	2020-09-27	80	13	60
8041	2020-09-28	80	13	60
8042	2020-09-29	80	13	60
8043	2020-09-30	63	14	60
8044	2020-09-01	64	14	64
8045	2020-09-02	63	14	64
8046	2020-09-03	80	13	64
8047	2020-09-04	80	13	64
8048	2020-09-05	84	14	64
8049	2020-09-06	63	14	64
8050	2020-09-07	80	13	64
8051	2020-09-08	80	13	64
8052	2020-09-09	80	13	64
8053	2020-09-10	80	13	64
8054	2020-09-11	80	13	64
8055	2020-09-12	80	13	64
8056	2020-09-13	64	14	64
8057	2020-09-14	80	13	64
8058	2020-09-15	80	13	64
8059	2020-09-16	80	13	64
8060	2020-09-17	80	13	64
8061	2020-09-18	80	13	64
8062	2020-09-19	80	13	64
8063	2020-09-20	64	14	64
8064	2020-09-21	63	14	64
8065	2020-09-22	63	14	64
8066	2020-09-23	80	13	64
8067	2020-09-24	80	13	64
8068	2020-09-25	80	13	64
8069	2020-09-26	64	14	64
8070	2020-09-27	80	13	64
8071	2020-09-28	80	13	64
8072	2020-09-29	80	13	64
8073	2020-09-30	80	13	64
8074	2020-09-01	80	13	65
8075	2020-09-02	80	13	65
8076	2020-09-03	80	13	65
8077	2020-09-04	80	13	65
8078	2020-09-05	80	13	65
8079	2020-09-06	64	14	65
8080	2020-09-07	63	14	65
8081	2020-09-08	63	14	65
8082	2020-09-09	80	13	65
8083	2020-09-10	80	13	65
8084	2020-09-11	63	14	65
8085	2020-09-12	64	14	65
8086	2020-09-13	80	13	65
8087	2020-09-14	80	13	65
8088	2020-09-15	80	13	65
8089	2020-09-16	80	13	65
8090	2020-09-17	63	14	65
8091	2020-09-18	80	13	65
8092	2020-09-19	80	13	65
8093	2020-09-20	80	13	65
8094	2020-09-21	80	13	65
8095	2020-09-22	80	13	65
8096	2020-09-23	80	13	65
8097	2020-09-24	64	14	65
8098	2020-09-25	80	13	65
8099	2020-09-26	80	13	65
8100	2020-09-27	84	14	65
8101	2020-09-28	64	14	65
8102	2020-09-29	80	13	65
8103	2020-09-30	80	13	65
8104	2020-09-01	80	13	51
8105	2020-09-02	80	13	51
8106	2020-09-03	80	13	51
8107	2020-09-04	64	14	51
8108	2020-09-05	80	13	51
8109	2020-09-06	63	14	51
8110	2020-09-07	80	13	51
8111	2020-09-08	80	13	51
8112	2020-09-09	63	14	51
8113	2020-09-10	64	14	51
8114	2020-09-11	63	14	51
8115	2020-09-12	80	13	51
8116	2020-09-13	80	13	51
8117	2020-09-14	80	13	51
8118	2020-09-15	80	13	51
8119	2020-09-16	64	14	51
8120	2020-09-17	63	14	51
8121	2020-09-18	80	13	51
8122	2020-09-19	80	13	51
8123	2020-09-20	80	13	51
8124	2020-09-21	80	13	51
8125	2020-09-22	80	13	51
8126	2020-09-23	80	13	51
8127	2020-09-24	64	14	51
8128	2020-09-25	80	13	51
8129	2020-09-26	80	13	51
8130	2020-09-27	80	13	51
8131	2020-09-28	80	13	51
8132	2020-09-29	84	14	51
8133	2020-09-30	80	13	51
8134	2020-09-01	80	13	57
8135	2020-09-02	80	13	57
8136	2020-09-03	64	14	57
8137	2020-09-04	80	13	57
8138	2020-09-05	80	13	57
8139	2020-09-06	63	14	57
8140	2020-09-07	80	13	57
8141	2020-09-08	80	13	57
8142	2020-09-09	64	14	57
8143	2020-09-10	80	13	57
8144	2020-09-11	80	13	57
8145	2020-09-12	63	14	57
8146	2020-09-13	80	13	57
8147	2020-09-14	80	13	57
8148	2020-09-15	64	14	57
8149	2020-09-16	80	13	57
8150	2020-09-17	80	13	57
8151	2020-09-18	63	14	57
8152	2020-09-19	80	13	57
8153	2020-09-20	80	13	57
8154	2020-09-21	80	13	57
8155	2020-09-22	80	13	57
8156	2020-09-23	80	13	57
8157	2020-09-24	80	13	57
8158	2020-09-25	64	14	57
8159	2020-09-26	80	13	57
8160	2020-09-27	80	13	57
8161	2020-09-28	80	13	57
8162	2020-09-29	84	14	57
8163	2020-09-30	63	14	57
8164	2020-09-01	80	13	71
8165	2020-09-02	80	13	71
8166	2020-09-03	64	14	71
8167	2020-09-04	80	13	71
8168	2020-09-05	80	13	71
8169	2020-09-06	63	14	71
8170	2020-09-07	80	13	71
8171	2020-09-08	80	13	71
8172	2020-09-09	80	13	71
8173	2020-09-10	64	14	71
8174	2020-09-11	84	14	71
8175	2020-09-12	80	13	71
8176	2020-09-13	80	13	71
8177	2020-09-14	63	14	71
8178	2020-09-15	80	13	71
8179	2020-09-16	80	13	71
8180	2020-09-17	80	13	71
8181	2020-09-18	64	14	71
8182	2020-09-19	80	13	71
8183	2020-09-20	80	13	71
8184	2020-09-21	80	13	71
8185	2020-09-22	80	13	71
8186	2020-09-23	63	14	71
8187	2020-09-24	80	13	71
8188	2020-09-25	80	13	71
8189	2020-09-26	80	13	71
8190	2020-09-27	64	14	71
8191	2020-09-28	63	14	71
8192	2020-09-29	80	13	71
8193	2020-09-30	80	13	71
8194	2020-09-01	80	13	78
8195	2020-09-02	80	13	78
8196	2020-09-03	64	14	78
8197	2020-09-04	63	14	78
8198	2020-09-05	63	14	78
8199	2020-09-06	63	14	78
8200	2020-09-07	80	13	78
8201	2020-09-08	80	13	78
8202	2020-09-09	80	13	78
8203	2020-09-10	80	13	78
8204	2020-09-11	80	13	78
8205	2020-09-12	64	14	78
8206	2020-09-13	84	14	78
8207	2020-09-14	80	13	78
8208	2020-09-15	80	13	78
8209	2020-09-16	80	13	78
8210	2020-09-17	80	13	78
8211	2020-09-18	80	13	78
8212	2020-09-19	64	14	78
8213	2020-09-20	80	13	78
8214	2020-09-21	80	13	78
8215	2020-09-22	63	14	78
8216	2020-09-23	80	13	78
8217	2020-09-24	80	13	78
8218	2020-09-25	64	14	78
8219	2020-09-26	80	13	78
8220	2020-09-27	80	13	78
8221	2020-09-28	80	13	78
8222	2020-09-29	80	13	78
8223	2020-09-30	80	13	78
8224	2020-09-01	64	14	79
8225	2020-09-02	63	14	79
8226	2020-09-03	80	13	79
8227	2020-09-04	80	13	79
8228	2020-09-05	84	14	79
8229	2020-09-06	63	14	79
8230	2020-09-07	64	14	79
8231	2020-09-08	63	14	79
8232	2020-09-09	80	13	79
8233	2020-09-10	80	13	79
8234	2020-09-11	80	13	79
8235	2020-09-12	80	13	79
8236	2020-09-13	80	13	79
8237	2020-09-14	80	13	79
8238	2020-09-15	64	14	79
8239	2020-09-16	80	13	79
8240	2020-09-17	80	13	79
8241	2020-09-18	80	13	79
8242	2020-09-19	63	14	79
8243	2020-09-20	80	13	79
8244	2020-09-21	80	13	79
8245	2020-09-22	80	13	79
8246	2020-09-23	80	13	79
8247	2020-09-24	80	13	79
8248	2020-09-25	80	13	79
8249	2020-09-26	64	14	79
8250	2020-09-27	80	13	79
8251	2020-09-28	80	13	79
8252	2020-09-29	80	13	79
8253	2020-09-30	80	13	79
8254	2020-09-01	64	14	56
8255	2020-09-02	81	13	56
8256	2020-09-03	81	13	56
8257	2020-09-04	63	14	56
8258	2020-09-05	81	13	56
8259	2020-09-06	63	14	56
8260	2020-09-07	81	13	56
8261	2020-09-08	81	13	56
8262	2020-09-09	81	13	56
8263	2020-09-10	64	14	56
8264	2020-09-11	81	13	56
8265	2020-09-12	81	13	56
8266	2020-09-13	63	14	56
8267	2020-09-14	81	13	56
8268	2020-09-15	81	13	56
8269	2020-09-16	81	13	56
8270	2020-09-17	64	14	56
8271	2020-09-18	84	14	56
8272	2020-09-19	81	13	56
8273	2020-09-20	81	13	56
8274	2020-09-21	81	13	56
8275	2020-09-22	81	13	56
8276	2020-09-23	81	13	56
8277	2020-09-24	81	13	56
8278	2020-09-25	64	14	56
8279	2020-09-26	81	13	56
8280	2020-09-27	81	13	56
8281	2020-09-28	81	13	56
8282	2020-09-29	81	13	56
8283	2020-09-30	63	14	56
8284	2020-09-01	81	13	62
8285	2020-09-02	81	13	62
8286	2020-09-03	64	14	62
8287	2020-09-04	81	13	62
8288	2020-09-05	81	13	62
8289	2020-09-06	63	14	62
8290	2020-09-07	81	13	62
8291	2020-09-08	63	14	62
8292	2020-09-09	81	13	62
8293	2020-09-10	81	13	62
8294	2020-09-11	81	13	62
8295	2020-09-12	81	13	62
8296	2020-09-13	81	13	62
8297	2020-09-14	81	13	62
8298	2020-09-15	64	14	62
8299	2020-09-16	63	14	62
8300	2020-09-17	81	13	62
8301	2020-09-18	81	13	62
8302	2020-09-19	63	14	62
8303	2020-09-20	84	14	62
8304	2020-09-21	81	13	62
8305	2020-09-22	81	13	62
8306	2020-09-23	81	13	62
8307	2020-09-24	64	14	62
8308	2020-09-25	81	13	62
8309	2020-09-26	81	13	62
8310	2020-09-27	81	13	62
8311	2020-09-28	81	13	62
8312	2020-09-29	64	14	62
8313	2020-09-30	81	13	62
8314	2020-09-01	81	13	63
8315	2020-09-02	81	13	63
8316	2020-09-03	64	14	63
8317	2020-09-04	81	13	63
8318	2020-09-05	81	13	63
8319	2020-09-06	84	14	63
8320	2020-09-07	81	13	63
8321	2020-09-08	81	13	63
8322	2020-09-09	81	13	63
8323	2020-09-10	81	13	63
8324	2020-09-11	64	14	63
8325	2020-09-12	63	14	63
8326	2020-09-13	63	14	63
8327	2020-09-14	81	13	63
8328	2020-09-15	81	13	63
8329	2020-09-16	81	13	63
8330	2020-09-17	81	13	63
8331	2020-09-18	64	14	63
8332	2020-09-19	81	13	63
8333	2020-09-20	81	13	63
8334	2020-09-21	81	13	63
8335	2020-09-22	81	13	63
8336	2020-09-23	63	14	63
8337	2020-09-24	81	13	63
8338	2020-09-25	81	13	63
8339	2020-09-26	81	13	63
8340	2020-09-27	81	13	63
8341	2020-09-28	81	13	63
8342	2020-09-29	64	14	63
8343	2020-09-30	63	14	63
8344	2020-09-01	81	13	67
8345	2020-09-02	81	13	67
8346	2020-09-03	64	14	67
8347	2020-09-04	63	14	67
8348	2020-09-05	81	13	67
8349	2020-09-06	84	14	67
8350	2020-09-07	63	14	67
8351	2020-09-08	63	14	67
8352	2020-09-09	64	14	67
8353	2020-09-10	81	13	67
8354	2020-09-11	81	13	67
8355	2020-09-12	81	13	67
8356	2020-09-13	81	13	67
8357	2020-09-14	63	14	67
8358	2020-09-15	81	13	67
8359	2020-09-16	81	13	67
8360	2020-09-17	81	13	67
8361	2020-09-18	81	13	67
8362	2020-09-19	81	13	67
8363	2020-09-20	81	13	67
8364	2020-09-21	64	14	67
8365	2020-09-22	81	13	67
8366	2020-09-23	81	13	67
8367	2020-09-24	81	13	67
8368	2020-09-25	81	13	67
8369	2020-09-26	81	13	67
8370	2020-09-27	64	14	67
8371	2020-09-28	81	13	67
8372	2020-09-29	81	13	67
8373	2020-09-30	81	13	67
8374	2020-09-01	64	14	73
8375	2020-09-02	63	14	73
8376	2020-09-03	81	13	73
8377	2020-09-04	81	13	73
8378	2020-09-05	81	13	73
8379	2020-09-06	84	14	73
8380	2020-09-07	64	14	73
8381	2020-09-08	63	14	73
8382	2020-09-09	63	14	73
8383	2020-09-10	63	14	73
8384	2020-09-11	81	13	73
8385	2020-09-12	81	13	73
8386	2020-09-13	81	13	73
8387	2020-09-14	81	13	73
8388	2020-09-15	81	13	73
8389	2020-09-16	81	13	73
8390	2020-09-17	64	14	73
8391	2020-09-18	81	13	73
8392	2020-09-19	81	13	73
8393	2020-09-20	81	13	73
8394	2020-09-21	81	13	73
8395	2020-09-22	81	13	73
8396	2020-09-23	81	13	73
8397	2020-09-24	64	14	73
8398	2020-09-25	81	13	73
8399	2020-09-26	81	13	73
8400	2020-09-27	81	13	73
8401	2020-09-28	81	13	73
8402	2020-09-29	81	13	73
8403	2020-09-30	81	13	73
8404	2020-09-01	81	13	66
8405	2020-09-02	81	13	66
8406	2020-09-03	81	13	66
8407	2020-09-04	64	14	66
8408	2020-09-05	63	14	66
8409	2020-09-06	63	14	66
8410	2020-09-07	81	13	66
8411	2020-09-08	81	13	66
8412	2020-09-09	81	13	66
8413	2020-09-10	64	14	66
8414	2020-09-11	63	14	66
8415	2020-09-12	63	14	66
8416	2020-09-13	81	13	66
8417	2020-09-14	81	13	66
8418	2020-09-15	84	14	66
8419	2020-09-16	81	13	66
8420	2020-09-17	81	13	66
8421	2020-09-18	81	13	66
8422	2020-09-19	81	13	66
8423	2020-09-20	81	13	66
8424	2020-09-21	81	13	66
8425	2020-09-22	64	14	66
8426	2020-09-23	81	13	66
8427	2020-09-24	81	13	66
8428	2020-09-25	64	14	66
8429	2020-09-26	81	13	66
8430	2020-09-27	81	13	66
8431	2020-09-28	81	13	66
8432	2020-09-29	81	13	66
8433	2020-09-30	81	13	66
8434	2020-09-01	64	14	55
8435	2020-09-02	63	14	55
8436	2020-09-03	81	13	55
8437	2020-09-04	81	13	55
8438	2020-09-05	63	14	55
8439	2020-09-06	63	14	55
8440	2020-09-07	81	13	55
8441	2020-09-08	81	13	55
8442	2020-09-09	81	13	55
8443	2020-09-10	81	13	55
8444	2020-09-11	81	13	55
8445	2020-09-12	81	13	55
8446	2020-09-13	64	14	55
8447	2020-09-14	81	13	55
8448	2020-09-15	81	13	55
8449	2020-09-16	81	13	55
8450	2020-09-17	81	13	55
8451	2020-09-18	81	13	55
8452	2020-09-19	64	14	55
8453	2020-09-20	84	14	55
8454	2020-09-21	81	13	55
8455	2020-09-22	81	13	55
8456	2020-09-23	81	13	55
8457	2020-09-24	81	13	55
8458	2020-09-25	81	13	55
8459	2020-09-26	64	14	55
8460	2020-09-27	81	13	55
8461	2020-09-28	63	14	55
8462	2020-09-29	81	13	55
8463	2020-09-30	81	13	55
8464	2020-09-01	83	13	45
8465	2020-09-02	83	13	45
8466	2020-09-03	64	14	45
8467	2020-09-04	63	14	45
8468	2020-09-05	83	13	45
8469	2020-09-06	63	14	45
8470	2020-09-07	83	13	45
8471	2020-09-08	83	13	45
8472	2020-09-09	83	13	45
8473	2020-09-10	83	13	45
8474	2020-09-11	64	14	45
8475	2020-09-12	83	13	45
8476	2020-09-13	83	13	45
8477	2020-09-14	83	13	45
8478	2020-09-15	63	14	45
8479	2020-09-16	84	14	45
8480	2020-09-17	83	13	45
8481	2020-09-18	83	13	45
8482	2020-09-19	83	13	45
8483	2020-09-20	64	14	45
8484	2020-09-21	63	14	45
8485	2020-09-22	65	15	45
8486	2020-09-23	83	13	45
8487	2020-09-24	83	13	45
8488	2020-09-25	83	13	45
8489	2020-09-26	64	14	45
8490	2020-09-27	83	13	45
8491	2020-09-28	83	13	45
8492	2020-09-29	67	14	45
8493	2020-09-30	72	14	45
8494	2020-09-01	64	14	68
8495	2020-09-02	83	13	68
8496	2020-09-03	83	13	68
8497	2020-09-04	83	13	68
8498	2020-09-05	83	13	68
8499	2020-09-06	63	14	68
8500	2020-09-07	83	13	68
8501	2020-09-08	64	14	68
8502	2020-09-09	83	13	68
8503	2020-09-10	83	13	68
8504	2020-09-11	83	13	68
8505	2020-09-12	63	14	68
8506	2020-09-13	83	13	68
8507	2020-09-14	83	13	68
8508	2020-09-15	83	13	68
8509	2020-09-16	83	13	68
8510	2020-09-17	64	14	68
8511	2020-09-18	84	14	68
8512	2020-09-19	83	13	68
8513	2020-09-20	83	13	68
8514	2020-09-21	83	13	68
8515	2020-09-22	83	13	68
8516	2020-09-23	64	14	68
8517	2020-09-24	83	13	68
8518	2020-09-25	83	13	68
8519	2020-09-26	83	13	68
8520	2020-09-27	63	14	68
8521	2020-09-28	63	14	68
8522	2020-09-29	83	13	68
8523	2020-09-30	83	13	68
8524	2020-09-01	64	14	53
8525	2020-09-02	63	14	53
8526	2020-09-03	83	13	53
8527	2020-09-04	83	13	53
8528	2020-09-05	83	13	53
8529	2020-09-06	84	14	53
8530	2020-09-07	83	13	53
8531	2020-09-08	83	13	53
8532	2020-09-09	83	13	53
8533	2020-09-10	64	14	53
8534	2020-09-11	63	14	53
8535	2020-09-12	83	13	53
8536	2020-09-13	83	13	53
8537	2020-09-14	83	13	53
8538	2020-09-15	83	13	53
8539	2020-09-16	83	13	53
8540	2020-09-17	83	13	53
8541	2020-09-18	64	14	53
8542	2020-09-19	83	13	53
8543	2020-09-20	63	14	53
8544	2020-09-21	83	13	53
8545	2020-09-22	83	13	53
8546	2020-09-23	63	14	53
8547	2020-09-24	83	13	53
8548	2020-09-25	83	13	53
8549	2020-09-26	64	14	53
8550	2020-09-27	83	13	53
8551	2020-09-28	83	13	53
8552	2020-09-29	83	13	53
8553	2020-09-30	83	13	53
8554	2020-09-01	64	14	54
8555	2020-09-02	63	14	54
8556	2020-09-03	83	13	54
8557	2020-09-04	83	13	54
8558	2020-09-05	84	14	54
8559	2020-09-06	63	14	54
8560	2020-09-07	83	13	54
8561	2020-09-08	83	13	54
8562	2020-09-09	64	14	54
8563	2020-09-10	83	13	54
8564	2020-09-11	83	13	54
8565	2020-09-12	63	14	54
8566	2020-09-13	63	14	54
8567	2020-09-14	83	13	54
8568	2020-09-15	83	13	54
8569	2020-09-16	83	13	54
8570	2020-09-17	83	13	54
8571	2020-09-18	83	13	54
8572	2020-09-19	64	14	54
8573	2020-09-20	83	13	54
8574	2020-09-21	83	13	54
8575	2020-09-22	83	13	54
8576	2020-09-23	83	13	54
8577	2020-09-24	83	13	54
8578	2020-09-25	64	14	54
8579	2020-09-26	83	13	54
8580	2020-09-27	83	13	54
8581	2020-09-28	83	13	54
8582	2020-09-29	83	13	54
8583	2020-09-30	83	13	54
8584	2020-09-01	83	13	49
8585	2020-09-02	83	13	49
8586	2020-09-03	64	14	49
8587	2020-09-04	84	14	49
8588	2020-09-05	83	13	49
8589	2020-09-06	63	14	49
8590	2020-09-07	63	14	49
8591	2020-09-08	63	14	49
8592	2020-09-09	83	13	49
8593	2020-09-10	64	14	49
8594	2020-09-11	83	13	49
8595	2020-09-12	83	13	49
8596	2020-09-13	83	13	49
8597	2020-09-14	83	13	49
8598	2020-09-15	83	13	49
8599	2020-09-16	83	13	49
8600	2020-09-17	64	14	49
8601	2020-09-18	83	13	49
8602	2020-09-19	83	13	49
8603	2020-09-20	83	13	49
8604	2020-09-21	83	13	49
8605	2020-09-22	83	13	49
8606	2020-09-23	83	13	49
8607	2020-09-24	64	14	49
8608	2020-09-25	83	13	49
8609	2020-09-26	83	13	49
8610	2020-09-27	83	13	49
8611	2020-09-28	83	13	49
8612	2020-09-29	83	13	49
8613	2020-09-30	63	14	49
8614	2020-09-01	83	13	50
8615	2020-09-02	83	13	50
8616	2020-09-03	83	13	50
8617	2020-09-04	83	13	50
8618	2020-09-05	64	14	50
8619	2020-09-06	63	14	50
8620	2020-09-07	83	13	50
8621	2020-09-08	84	14	50
8622	2020-09-09	83	13	50
8623	2020-09-10	83	13	50
8624	2020-09-11	64	14	50
8625	2020-09-12	83	13	50
8626	2020-09-13	63	14	50
8627	2020-09-14	63	14	50
8628	2020-09-15	63	14	50
8629	2020-09-16	83	13	50
8630	2020-09-17	83	13	50
8631	2020-09-18	83	13	50
8632	2020-09-19	83	13	50
8633	2020-09-20	83	13	50
8634	2020-09-21	83	13	50
8635	2020-09-22	64	14	50
8636	2020-09-23	83	13	50
8637	2020-09-24	83	13	50
8638	2020-09-25	83	13	50
8639	2020-09-26	83	13	50
8640	2020-09-27	83	13	50
8641	2020-09-28	83	13	50
8642	2020-09-29	64	14	50
8643	2020-09-30	83	13	50
8644	2020-09-01	84	14	43
8645	2020-09-02	82	16	43
8646	2020-09-03	82	16	43
8647	2020-09-04	82	16	43
8648	2020-09-05	63	14	43
8649	2020-09-06	64	14	43
8650	2020-09-07	82	16	43
8651	2020-09-08	82	16	43
8652	2020-09-09	82	16	43
8653	2020-09-10	82	16	43
8654	2020-09-11	82	16	43
8655	2020-09-12	63	14	43
8656	2020-09-13	64	14	43
8657	2020-09-14	82	16	43
8658	2020-09-15	82	16	43
8659	2020-09-16	82	16	43
8660	2020-09-17	82	16	43
8661	2020-09-18	82	16	43
8662	2020-09-19	63	14	43
8663	2020-09-20	64	14	43
8664	2020-09-21	82	16	43
8665	2020-09-22	82	16	43
8666	2020-09-23	82	16	43
8667	2020-09-24	82	16	43
8668	2020-09-25	82	16	43
8669	2020-09-26	63	14	43
8670	2020-09-27	64	14	43
8671	2020-09-28	82	16	43
8672	2020-09-29	82	16	43
8673	2020-09-30	82	16	43
8674	2020-09-01	84	14	44
8675	2020-09-02	82	16	44
8676	2020-09-03	82	16	44
8677	2020-09-04	82	16	44
8678	2020-09-05	63	14	44
8679	2020-09-06	64	14	44
8680	2020-09-07	82	16	44
8681	2020-09-08	82	16	44
8682	2020-09-09	82	16	44
8683	2020-09-10	82	16	44
8684	2020-09-11	82	16	44
8685	2020-09-12	63	14	44
8686	2020-09-13	64	14	44
8687	2020-09-14	82	16	44
8688	2020-09-15	82	16	44
8689	2020-09-16	82	16	44
8690	2020-09-17	82	16	44
8691	2020-09-18	82	16	44
8692	2020-09-19	63	14	44
8693	2020-09-20	64	14	44
8694	2020-09-21	82	16	44
8695	2020-09-22	82	16	44
8696	2020-09-23	82	16	44
8697	2020-09-24	82	16	44
8698	2020-09-25	82	16	44
8699	2020-09-26	63	14	44
8700	2020-09-27	64	14	44
8701	2020-09-28	82	16	44
8702	2020-09-29	82	16	44
8703	2020-09-30	82	16	44
8704	2020-11-01	80	13	47
8705	2020-11-02	80	13	47
8706	2020-11-03	64	14	47
8707	2020-11-04	80	13	47
8708	2020-11-05	80	13	47
8709	2020-11-06	80	13	47
8710	2020-11-07	80	13	47
8711	2020-11-08	80	13	47
8712	2020-11-09	64	14	47
8713	2020-11-10	63	14	47
8714	2020-11-11	80	13	47
8715	2020-11-12	80	13	47
8716	2020-11-13	80	13	47
8717	2020-11-14	80	13	47
8718	2020-11-15	64	14	47
8719	2020-11-16	63	14	47
8720	2020-11-17	63	14	47
8721	2020-11-18	63	14	47
8722	2020-11-19	80	13	47
8723	2020-11-20	80	13	47
8724	2020-11-21	80	13	47
8725	2020-11-22	80	13	47
8726	2020-11-23	64	14	47
8727	2020-11-24	80	13	47
8728	2020-11-25	80	13	47
8729	2020-11-26	80	13	47
8730	2020-11-27	80	13	47
8731	2020-11-28	64	14	47
8732	2020-11-29	80	13	47
8733	2020-11-30	80	13	47
8734	2020-11-01	80	13	69
8735	2020-11-02	80	13	69
8736	2020-11-03	80	13	69
8737	2020-11-04	64	14	69
8738	2020-11-05	80	13	69
8739	2020-11-06	63	14	69
8740	2020-11-07	63	14	69
8741	2020-11-08	63	14	69
8742	2020-11-09	80	13	69
8743	2020-11-10	80	13	69
8744	2020-11-11	80	13	69
8745	2020-11-12	80	13	69
8746	2020-11-13	80	13	69
8747	2020-11-14	64	14	69
8748	2020-11-15	80	13	69
8749	2020-11-16	80	13	69
8750	2020-11-17	80	13	69
8751	2020-11-18	80	13	69
8752	2020-11-19	80	13	69
8753	2020-11-20	80	13	69
8754	2020-11-21	64	14	69
8755	2020-11-22	80	13	69
8756	2020-11-23	80	13	69
8757	2020-11-24	80	13	69
8758	2020-11-25	80	13	69
8759	2020-11-26	63	14	69
8760	2020-11-27	64	14	69
8761	2020-11-28	80	13	69
8762	2020-11-29	80	13	69
8763	2020-11-30	64	14	69
8764	2020-11-01	67	14	46
8765	2020-11-02	64	14	46
8766	2020-11-03	80	13	46
8767	2020-11-04	80	13	46
8768	2020-11-05	63	14	46
8769	2020-11-06	63	14	46
8770	2020-11-07	80	13	46
8771	2020-11-08	80	13	46
8772	2020-11-09	80	13	46
8773	2020-11-10	80	13	46
8774	2020-11-11	80	13	46
8775	2020-11-12	64	14	46
8776	2020-11-13	63	14	46
8777	2020-11-14	63	14	46
8778	2020-11-15	80	13	46
8779	2020-11-16	80	13	46
8780	2020-11-17	80	13	46
8781	2020-11-18	80	13	46
8782	2020-11-19	64	14	46
8783	2020-11-20	64	14	46
8784	2020-11-21	80	13	46
8785	2020-11-22	80	13	46
8786	2020-11-23	80	13	46
8787	2020-11-24	64	14	46
8788	2020-11-25	80	13	46
8789	2020-11-26	80	13	46
8790	2020-11-27	80	13	46
8791	2020-11-28	80	13	46
8792	2020-11-29	80	13	46
8793	2020-11-30	80	13	46
8794	2020-11-01	80	13	64
8795	2020-11-02	80	13	64
8796	2020-11-03	80	13	64
8797	2020-11-04	80	13	64
8798	2020-11-05	64	14	64
8799	2020-11-06	80	13	64
8800	2020-11-07	80	13	64
8801	2020-11-08	63	14	64
8802	2020-11-09	80	13	64
8803	2020-11-10	80	13	64
8804	2020-11-11	80	13	64
8805	2020-11-12	64	14	64
8806	2020-11-13	63	14	64
8807	2020-11-14	80	13	64
8808	2020-11-15	80	13	64
8809	2020-11-16	63	14	64
8810	2020-11-17	63	14	64
8811	2020-11-18	80	13	64
8812	2020-11-19	80	13	64
8813	2020-11-20	80	13	64
8814	2020-11-21	64	14	64
8815	2020-11-22	64	14	64
8816	2020-11-23	80	13	64
8817	2020-11-24	80	13	64
8818	2020-11-25	80	13	64
8819	2020-11-26	80	13	64
8820	2020-11-27	80	13	64
8821	2020-11-28	80	13	64
8822	2020-11-29	64	14	64
8823	2020-11-30	80	13	64
8824	2020-11-01	64	14	65
8825	2020-11-02	63	14	65
8826	2020-11-03	80	13	65
8827	2020-11-04	80	13	65
8828	2020-11-05	80	13	65
8829	2020-11-06	80	13	65
8830	2020-11-07	80	13	65
8831	2020-11-08	64	14	65
8832	2020-11-09	80	13	65
8833	2020-11-10	63	14	65
8834	2020-11-11	63	14	65
8835	2020-11-12	80	13	65
8836	2020-11-13	80	13	65
8837	2020-11-14	80	13	65
8838	2020-11-15	80	13	65
8839	2020-11-16	64	14	65
8840	2020-11-17	80	13	65
8841	2020-11-18	80	13	65
8842	2020-11-19	80	13	65
8843	2020-11-20	80	13	65
8844	2020-11-21	63	14	65
8845	2020-11-22	80	13	65
8846	2020-11-23	80	13	65
8847	2020-11-24	64	14	65
8848	2020-11-25	80	13	65
8849	2020-11-26	80	13	65
8850	2020-11-27	64	14	65
8851	2020-11-28	80	13	65
8852	2020-11-29	80	13	65
8853	2020-11-30	80	13	65
8854	2020-11-01	64	14	51
8855	2020-11-02	63	14	51
8856	2020-11-03	80	13	51
8857	2020-11-04	80	13	51
8858	2020-11-05	80	13	51
8859	2020-11-06	63	14	51
8860	2020-11-07	80	13	51
8861	2020-11-08	80	13	51
8862	2020-11-09	80	13	51
8863	2020-11-10	64	14	51
8864	2020-11-11	63	14	51
8865	2020-11-12	80	13	51
8866	2020-11-13	80	13	51
8867	2020-11-14	80	13	51
8868	2020-11-15	80	13	51
8869	2020-11-16	80	13	51
8870	2020-11-17	80	13	51
8871	2020-11-18	64	14	51
8872	2020-11-19	80	13	51
8873	2020-11-20	80	13	51
8874	2020-11-21	80	13	51
8875	2020-11-22	80	13	51
8876	2020-11-23	80	13	51
8877	2020-11-24	80	13	51
8878	2020-11-25	64	14	51
8879	2020-11-26	63	14	51
8880	2020-11-27	64	14	51
8881	2020-11-28	80	13	51
8882	2020-11-29	80	13	51
8883	2020-11-30	80	13	51
8884	2020-11-01	80	13	57
8885	2020-11-02	80	13	57
8886	2020-11-03	64	14	57
8887	2020-11-04	80	13	57
8888	2020-11-05	80	13	57
8889	2020-11-06	63	14	57
8890	2020-11-07	63	14	57
8891	2020-11-08	80	13	57
8892	2020-11-09	80	13	57
8893	2020-11-10	80	13	57
8894	2020-11-11	80	13	57
8895	2020-11-12	80	13	57
8896	2020-11-13	80	13	57
8897	2020-11-14	64	14	57
8898	2020-11-15	63	14	57
8899	2020-11-16	80	13	57
8900	2020-11-17	80	13	57
8901	2020-11-18	80	13	57
8902	2020-11-19	80	13	57
8903	2020-11-20	64	14	57
8904	2020-11-21	80	13	57
8905	2020-11-22	80	13	57
8906	2020-11-23	80	13	57
8907	2020-11-24	63	14	57
8908	2020-11-25	80	13	57
8909	2020-11-26	80	13	57
8910	2020-11-27	80	13	57
8911	2020-11-28	80	13	57
8912	2020-11-29	64	14	57
8913	2020-11-30	64	14	57
8914	2020-11-01	64	14	71
8915	2020-11-02	63	14	71
8916	2020-11-03	80	13	71
8917	2020-11-04	80	13	71
8918	2020-11-05	80	13	71
8919	2020-11-06	80	13	71
8920	2020-11-07	80	13	71
8921	2020-11-08	80	13	71
8922	2020-11-09	64	14	71
8923	2020-11-10	63	14	71
8924	2020-11-11	63	14	71
8925	2020-11-12	80	13	71
8926	2020-11-13	80	13	71
8927	2020-11-14	80	13	71
8928	2020-11-15	80	13	71
8929	2020-11-16	80	13	71
8930	2020-11-17	64	14	71
8931	2020-11-18	80	13	71
8932	2020-11-19	80	13	71
8933	2020-11-20	80	13	71
8934	2020-11-21	80	13	71
8935	2020-11-22	80	13	71
8936	2020-11-23	64	14	71
8937	2020-11-24	80	13	71
8938	2020-11-25	80	13	71
8939	2020-11-26	63	14	71
8940	2020-11-27	80	13	71
8941	2020-11-28	80	13	71
8942	2020-11-29	64	14	71
8943	2020-11-30	80	13	71
8944	2020-11-01	80	13	78
8945	2020-11-02	80	13	78
8946	2020-11-03	64	14	78
8947	2020-11-04	63	14	78
8948	2020-11-05	63	14	78
8949	2020-11-06	80	13	78
8950	2020-11-07	80	13	78
8951	2020-11-08	80	13	78
8952	2020-11-09	64	14	78
8953	2020-11-10	80	13	78
8954	2020-11-11	80	13	78
8955	2020-11-12	63	14	78
8956	2020-11-13	63	14	78
8957	2020-11-14	80	13	78
8958	2020-11-15	80	13	78
8959	2020-11-16	80	13	78
8960	2020-11-17	80	13	78
8961	2020-11-18	80	13	78
8962	2020-11-19	64	14	78
8963	2020-11-20	80	13	78
8964	2020-11-21	80	13	78
8965	2020-11-22	64	14	78
8966	2020-11-23	80	13	78
8967	2020-11-24	80	13	78
8968	2020-11-25	80	13	78
8969	2020-11-26	80	13	78
8970	2020-11-27	80	13	78
8971	2020-11-28	64	14	78
8972	2020-11-29	80	13	78
8973	2020-11-30	80	13	78
8974	2020-11-01	80	13	79
8975	2020-11-02	80	13	79
8976	2020-11-03	64	14	79
8977	2020-11-04	63	14	79
8978	2020-11-05	63	14	79
8979	2020-11-06	63	14	79
8980	2020-11-07	63	14	79
8981	2020-11-08	64	14	79
8982	2020-11-09	80	13	79
8983	2020-11-10	80	13	79
8984	2020-11-11	80	13	79
8985	2020-11-12	80	13	79
8986	2020-11-13	80	13	79
8987	2020-11-14	80	13	79
8988	2020-11-15	64	14	79
8989	2020-11-16	80	13	79
8990	2020-11-17	80	13	79
8991	2020-11-18	80	13	79
8992	2020-11-19	80	13	79
8993	2020-11-20	80	13	79
8994	2020-11-21	80	13	79
8995	2020-11-22	64	14	79
8996	2020-11-23	80	13	79
8997	2020-11-24	80	13	79
8998	2020-11-25	64	14	79
8999	2020-11-26	80	13	79
9000	2020-11-27	80	13	79
9001	2020-11-28	80	13	79
9002	2020-11-29	80	13	79
9003	2020-11-30	80	13	79
9004	2020-11-01	81	13	56
9005	2020-11-02	81	13	56
9006	2020-11-03	81	13	56
9007	2020-11-04	81	13	56
9008	2020-11-05	64	14	56
9009	2020-11-06	63	14	56
9010	2020-11-07	81	13	56
9011	2020-11-08	63	14	56
9012	2020-11-09	63	14	56
9013	2020-11-10	81	13	56
9014	2020-11-11	81	13	56
9015	2020-11-12	81	13	56
9016	2020-11-13	64	14	56
9017	2020-11-14	81	13	56
9018	2020-11-15	81	13	56
9019	2020-11-16	81	13	56
9020	2020-11-17	81	13	56
9021	2020-11-18	81	13	56
9022	2020-11-19	64	14	56
9023	2020-11-20	63	14	56
9024	2020-11-21	81	13	56
9025	2020-11-22	81	13	56
9026	2020-11-23	81	13	56
9027	2020-11-24	64	14	56
9028	2020-11-25	81	13	56
9029	2020-11-26	81	13	56
9030	2020-11-27	64	14	56
9031	2020-11-28	81	13	56
9032	2020-11-29	81	13	56
9033	2020-11-30	81	13	56
9034	2020-11-01	81	13	62
9035	2020-11-02	81	13	62
9036	2020-11-03	64	14	62
9037	2020-11-04	81	13	62
9038	2020-11-05	81	13	62
9039	2020-11-06	81	13	62
9040	2020-11-07	63	14	62
9041	2020-11-08	63	14	62
9042	2020-11-09	64	14	62
9043	2020-11-10	81	13	62
9044	2020-11-11	81	13	62
9045	2020-11-12	81	13	62
9046	2020-11-13	81	13	62
9047	2020-11-14	63	14	62
9048	2020-11-15	64	14	62
9049	2020-11-16	81	13	62
9050	2020-11-17	81	13	62
9051	2020-11-18	81	13	62
9052	2020-11-19	81	13	62
9053	2020-11-20	81	13	62
9054	2020-11-21	81	13	62
9055	2020-11-22	64	14	62
9056	2020-11-23	81	13	62
9057	2020-11-24	81	13	62
9058	2020-11-25	81	13	62
9059	2020-11-26	63	14	62
9060	2020-11-27	81	13	62
9061	2020-11-28	81	13	62
9062	2020-11-29	81	13	62
9063	2020-11-30	64	14	62
9064	2020-11-01	81	13	63
9065	2020-11-02	81	13	63
9066	2020-11-03	64	14	63
9067	2020-11-04	81	13	63
9068	2020-11-05	81	13	63
9069	2020-11-06	63	14	63
9070	2020-11-07	63	14	63
9071	2020-11-08	81	13	63
9072	2020-11-09	81	13	63
9073	2020-11-10	81	13	63
9074	2020-11-11	64	14	63
9075	2020-11-12	81	13	63
9076	2020-11-13	81	13	63
9077	2020-11-14	81	13	63
9078	2020-11-15	81	13	63
9079	2020-11-16	81	13	63
9080	2020-11-17	81	13	63
9081	2020-11-18	64	14	63
9082	2020-11-19	81	13	63
9083	2020-11-20	81	13	63
9084	2020-11-21	81	13	63
9085	2020-11-22	81	13	63
9086	2020-11-23	63	14	63
9087	2020-11-24	81	13	63
9088	2020-11-25	81	13	63
9089	2020-11-26	81	13	63
9090	2020-11-27	81	13	63
9091	2020-11-28	64	14	63
9092	2020-11-29	63	14	63
9093	2020-11-30	64	14	63
9094	2020-11-01	64	14	67
9095	2020-11-02	63	14	67
9096	2020-11-03	81	13	67
9097	2020-11-04	81	13	67
9098	2020-11-05	81	13	67
9099	2020-11-06	63	14	67
9100	2020-11-07	81	13	67
9101	2020-11-08	81	13	67
9102	2020-11-09	64	14	67
9103	2020-11-10	81	13	67
9104	2020-11-11	81	13	67
9105	2020-11-12	63	14	67
9106	2020-11-13	63	14	67
9107	2020-11-14	64	14	67
9108	2020-11-15	81	13	67
9109	2020-11-16	81	13	67
9110	2020-11-17	81	13	67
9111	2020-11-18	81	13	67
9112	2020-11-19	81	13	67
9113	2020-11-20	81	13	67
9114	2020-11-21	64	14	67
9115	2020-11-22	81	13	67
9116	2020-11-23	81	13	67
9117	2020-11-24	81	13	67
9118	2020-11-25	64	14	67
9119	2020-11-26	81	13	67
9120	2020-11-27	81	13	67
9121	2020-11-28	81	13	67
9122	2020-11-29	81	13	67
9123	2020-11-30	81	13	67
9124	2020-11-01	81	13	73
9125	2020-11-02	81	13	73
9126	2020-11-03	64	14	73
9127	2020-11-04	63	14	73
9128	2020-11-05	81	13	73
9129	2020-11-06	81	13	73
9130	2020-11-07	63	14	73
9131	2020-11-08	63	14	73
9132	2020-11-09	81	13	73
9133	2020-11-10	64	14	73
9134	2020-11-11	81	13	73
9135	2020-11-12	81	13	73
9136	2020-11-13	63	14	73
9137	2020-11-14	81	13	73
9138	2020-11-15	81	13	73
9139	2020-11-16	81	13	73
9140	2020-11-17	64	14	73
9141	2020-11-18	81	13	73
9142	2020-11-19	81	13	73
9143	2020-11-20	81	13	73
9144	2020-11-21	81	13	73
9145	2020-11-22	81	13	73
9146	2020-11-23	81	13	73
9147	2020-11-24	64	14	73
9148	2020-11-25	81	13	73
9149	2020-11-26	81	13	73
9150	2020-11-27	81	13	73
9151	2020-11-28	64	14	73
9152	2020-11-29	81	13	73
9153	2020-11-30	81	13	73
9154	2020-11-01	81	13	66
9155	2020-11-02	81	13	66
9156	2020-11-03	81	13	66
9157	2020-11-04	64	14	66
9158	2020-11-05	63	14	66
9159	2020-11-06	81	13	66
9160	2020-11-07	81	13	66
9161	2020-11-08	63	14	66
9162	2020-11-09	63	14	66
9163	2020-11-10	64	14	66
9164	2020-11-11	63	14	66
9165	2020-11-12	81	13	66
9166	2020-11-13	81	13	66
9167	2020-11-14	81	13	66
9168	2020-11-15	64	14	66
9169	2020-11-16	81	13	66
9170	2020-11-17	81	13	66
9171	2020-11-18	81	13	66
9172	2020-11-19	81	13	66
9173	2020-11-20	81	13	66
9174	2020-11-21	81	13	66
9175	2020-11-22	64	14	66
9176	2020-11-23	81	13	66
9177	2020-11-24	81	13	66
9178	2020-11-25	81	13	66
9179	2020-11-26	81	13	66
9180	2020-11-27	81	13	66
9181	2020-11-28	81	13	66
9182	2020-11-29	64	14	66
9183	2020-11-30	81	13	66
9184	2020-11-01	64	14	55
9185	2020-11-02	63	14	55
9186	2020-11-03	81	13	55
9187	2020-11-04	81	13	55
9188	2020-11-05	63	14	55
9189	2020-11-06	81	13	55
9190	2020-11-07	81	13	55
9191	2020-11-08	81	13	55
9192	2020-11-09	81	13	55
9193	2020-11-10	81	13	55
9194	2020-11-11	64	14	55
9195	2020-11-12	63	14	55
9196	2020-11-13	81	13	55
9197	2020-11-14	81	13	55
9198	2020-11-15	81	13	55
9199	2020-11-16	63	14	55
9200	2020-11-17	81	13	55
9201	2020-11-18	81	13	55
9202	2020-11-19	64	14	55
9203	2020-11-20	64	14	55
9204	2020-11-21	81	13	55
9205	2020-11-22	81	13	55
9206	2020-11-23	81	13	55
9207	2020-11-24	81	13	55
9208	2020-11-25	81	13	55
9209	2020-11-26	81	13	55
9210	2020-11-27	64	14	55
9211	2020-11-28	81	13	55
9212	2020-11-29	81	13	55
9213	2020-11-30	81	13	55
9214	2020-11-01	83	13	68
9215	2020-11-02	83	13	68
9216	2020-11-03	83	13	68
9217	2020-11-04	64	14	68
9218	2020-11-05	63	14	68
9219	2020-11-06	63	14	68
9220	2020-11-07	83	13	68
9221	2020-11-08	83	13	68
9222	2020-11-09	63	14	68
9223	2020-11-10	83	13	68
9224	2020-11-11	83	13	68
9225	2020-11-12	83	13	68
9226	2020-11-13	83	13	68
9227	2020-11-14	64	14	68
9228	2020-11-15	83	13	68
9229	2020-11-16	83	13	68
9230	2020-11-17	83	13	68
9231	2020-11-18	83	13	68
9232	2020-11-19	83	13	68
9233	2020-11-20	64	14	68
9234	2020-11-21	83	13	68
9235	2020-11-22	83	13	68
9236	2020-11-23	83	13	68
9237	2020-11-24	83	13	68
9238	2020-11-25	63	14	68
9239	2020-11-26	64	14	68
9240	2020-11-27	83	13	68
9241	2020-11-28	83	13	68
9242	2020-11-29	83	13	68
9243	2020-11-30	64	14	68
9244	2020-11-01	64	14	80
9245	2020-11-02	63	14	80
9246	2020-11-03	83	13	80
9247	2020-11-04	83	13	80
9248	2020-11-05	83	13	80
9249	2020-11-06	83	13	80
9250	2020-11-07	83	13	80
9251	2020-11-08	64	14	80
9252	2020-11-09	83	13	80
9253	2020-11-10	83	13	80
9254	2020-11-11	63	14	80
9255	2020-11-12	63	14	80
9256	2020-11-13	83	13	80
9257	2020-11-14	83	13	80
9258	2020-11-15	64	14	80
9259	2020-11-16	83	13	80
9260	2020-11-17	83	13	80
9261	2020-11-18	83	13	80
9262	2020-11-19	63	14	80
9263	2020-11-20	83	13	80
9264	2020-11-21	83	13	80
9265	2020-11-22	64	14	80
9266	2020-11-23	83	13	80
9267	2020-11-24	83	13	80
9268	2020-11-25	83	13	80
9269	2020-11-26	83	13	80
9270	2020-11-27	83	13	80
9271	2020-11-28	64	14	80
9272	2020-11-29	83	13	80
9273	2020-11-30	83	13	80
9274	2020-11-01	83	13	60
9275	2020-11-02	83	13	60
9276	2020-11-03	64	14	60
9277	2020-11-04	83	13	60
9278	2020-11-05	83	13	60
9279	2020-11-06	83	13	60
9280	2020-11-07	63	14	60
9281	2020-11-08	83	13	60
9282	2020-11-09	83	13	60
9283	2020-11-10	64	14	60
9284	2020-11-11	83	13	60
9285	2020-11-12	83	13	60
9286	2020-11-13	63	14	60
9287	2020-11-14	83	13	60
9288	2020-11-15	83	13	60
9289	2020-11-16	64	14	60
9290	2020-11-17	63	14	60
9291	2020-11-18	63	14	60
9292	2020-11-19	83	13	60
9293	2020-11-20	83	13	60
9294	2020-11-21	64	14	60
9295	2020-11-22	83	13	60
9296	2020-11-23	83	13	60
9297	2020-11-24	83	13	60
9298	2020-11-25	83	13	60
9299	2020-11-26	83	13	60
9300	2020-11-27	64	14	60
9301	2020-11-28	83	13	60
9302	2020-11-29	83	13	60
9303	2020-11-30	83	13	60
9304	2020-11-01	83	13	53
9305	2020-11-02	83	13	53
9306	2020-11-03	64	14	53
9307	2020-11-04	63	14	53
9308	2020-11-05	83	13	53
9309	2020-11-06	83	13	53
9310	2020-11-07	63	14	53
9311	2020-11-08	63	14	53
9312	2020-11-09	83	13	53
9313	2020-11-10	83	13	53
9314	2020-11-11	64	14	53
9315	2020-11-12	83	13	53
9316	2020-11-13	83	13	53
9317	2020-11-14	83	13	53
9318	2020-11-15	83	13	53
9319	2020-11-16	83	13	53
9320	2020-11-17	83	13	53
9321	2020-11-18	64	14	53
9322	2020-11-19	83	13	53
9323	2020-11-20	63	14	53
9324	2020-11-21	64	14	53
9325	2020-11-22	83	13	53
9326	2020-11-23	83	13	53
9327	2020-11-24	83	13	53
9328	2020-11-25	83	13	53
9329	2020-11-26	64	14	53
9330	2020-11-27	83	13	53
9331	2020-11-28	83	13	53
9332	2020-11-29	83	13	53
9333	2020-11-30	83	13	53
9334	2020-11-01	64	14	54
9335	2020-11-02	63	14	54
9336	2020-11-03	83	13	54
9337	2020-11-04	83	13	54
9338	2020-11-05	83	13	54
9339	2020-11-06	63	14	54
9340	2020-11-07	83	13	54
9341	2020-11-08	83	13	54
9342	2020-11-09	64	14	54
9343	2020-11-10	83	13	54
9344	2020-11-11	83	13	54
9345	2020-11-12	63	14	54
9346	2020-11-13	63	14	54
9347	2020-11-14	83	13	54
9348	2020-11-15	83	13	54
9349	2020-11-16	83	13	54
9350	2020-11-17	83	13	54
9351	2020-11-18	83	13	54
9352	2020-11-19	64	14	54
9353	2020-11-20	83	13	54
9354	2020-11-21	83	13	54
9355	2020-11-22	83	13	54
9356	2020-11-23	83	13	54
9357	2020-11-24	64	14	54
9358	2020-11-25	64	14	54
9359	2020-11-26	83	13	54
9360	2020-11-27	83	13	54
9361	2020-11-28	83	13	54
9362	2020-11-29	83	13	54
9363	2020-11-30	63	14	54
9364	2020-11-01	64	14	49
9365	2020-11-02	63	14	49
9366	2020-11-03	83	13	49
9367	2020-11-04	83	13	49
9368	2020-11-05	83	13	49
9369	2020-11-06	83	13	49
9370	2020-11-07	83	13	49
9371	2020-11-08	64	14	49
9372	2020-11-09	83	13	49
9373	2020-11-10	63	14	49
9374	2020-11-11	63	14	49
9375	2020-11-12	83	13	49
9376	2020-11-13	83	13	49
9377	2020-11-14	83	13	49
9378	2020-11-15	83	13	49
9379	2020-11-16	64	14	49
9380	2020-11-17	63	14	49
9381	2020-11-18	83	13	49
9382	2020-11-19	83	13	49
9383	2020-11-20	83	13	49
9384	2020-11-21	83	13	49
9385	2020-11-22	83	13	49
9386	2020-11-23	64	14	49
9387	2020-11-24	83	13	49
9388	2020-11-25	83	13	49
9389	2020-11-26	83	13	49
9390	2020-11-27	64	14	49
9391	2020-11-28	63	14	49
9392	2020-11-29	83	13	49
9393	2020-11-30	83	13	49
9394	2020-11-01	83	13	50
9395	2020-11-02	83	13	50
9396	2020-11-03	64	14	50
9397	2020-11-04	63	14	50
9398	2020-11-05	63	14	50
9399	2020-11-06	63	14	50
9400	2020-11-07	83	13	50
9401	2020-11-08	83	13	50
9402	2020-11-09	83	13	50
9403	2020-11-10	83	13	50
9404	2020-11-11	83	13	50
9405	2020-11-12	83	13	50
9406	2020-11-13	64	14	50
9407	2020-11-14	63	14	50
9408	2020-11-15	64	14	50
9409	2020-11-16	83	13	50
9410	2020-11-17	83	13	50
9411	2020-11-18	83	13	50
9412	2020-11-19	83	13	50
9413	2020-11-20	83	13	50
9414	2020-11-21	83	13	50
9415	2020-11-22	64	14	50
9416	2020-11-23	83	13	50
9417	2020-11-24	83	13	50
9418	2020-11-25	83	13	50
9419	2020-11-26	83	13	50
9420	2020-11-27	83	13	50
9421	2020-11-28	83	13	50
9422	2020-11-29	64	14	50
9423	2020-11-30	83	13	50
9424	2020-11-01	64	14	43
9425	2020-11-02	82	16	43
9426	2020-11-03	82	16	43
9427	2020-11-04	82	16	43
9428	2020-11-05	82	16	43
9429	2020-11-06	82	16	43
9430	2020-11-07	63	14	43
9431	2020-11-08	64	14	43
9432	2020-11-09	82	16	43
9433	2020-11-10	82	16	43
9434	2020-11-11	82	16	43
9435	2020-11-12	82	16	43
9436	2020-11-13	82	16	43
9437	2020-11-14	63	14	43
9438	2020-11-15	64	14	43
9439	2020-11-16	82	16	43
9440	2020-11-17	82	16	43
9441	2020-11-18	82	16	43
9442	2020-11-19	82	16	43
9443	2020-11-20	82	16	43
9444	2020-11-21	63	14	43
9445	2020-11-22	64	14	43
9446	2020-11-23	82	16	43
9447	2020-11-24	82	16	43
9448	2020-11-25	82	16	43
9449	2020-11-26	82	16	43
9450	2020-11-27	82	16	43
9451	2020-11-28	63	14	43
9452	2020-11-29	64	14	43
9453	2020-11-30	82	16	43
9454	2020-11-01	64	14	44
9455	2020-11-02	82	16	44
9456	2020-11-03	82	16	44
9457	2020-11-04	82	16	44
9458	2020-11-05	82	16	44
9459	2020-11-06	82	16	44
9460	2020-11-07	63	14	44
9461	2020-11-08	64	14	44
9462	2020-11-09	82	16	44
9463	2020-11-10	82	16	44
9464	2020-11-11	82	16	44
9465	2020-11-12	82	16	44
9466	2020-11-13	82	16	44
9467	2020-11-14	63	14	44
9468	2020-11-15	64	14	44
9469	2020-11-16	82	16	44
9470	2020-11-17	82	16	44
9471	2020-11-18	82	16	44
9472	2020-11-19	82	16	44
9473	2020-11-20	82	16	44
9474	2020-11-21	63	14	44
9475	2020-11-22	64	14	44
9476	2020-11-23	82	16	44
9477	2020-11-24	82	16	44
9478	2020-11-25	82	16	44
9479	2020-11-26	82	16	44
9480	2020-11-27	82	16	44
9481	2020-11-28	63	14	44
9482	2020-11-29	64	14	44
9483	2020-11-30	82	16	44
\.


--
-- Data for Name: result_timeadjustment; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.result_timeadjustment (id, date, hours, adjustment_type, adjustment_item, remark, user_id) FROM stdin;
16	2020-11-06	8	0	1	白班	47
26	2020-11-20	8	0	1	白班	46
28	2020-11-21	8	0	1	白班	51
29	2020-11-19	8	0	1	小夜	54
30	2020-09-14	8	0	1	白班	64
31	2020-09-16	8	0	1	白班	65
33	2020-11-06	8	0	1	白班	69
34	2020-11-19	8	0	1	白班	78
35	2020-11-18	8	0	1	白班	79
37	2020-11-21	8	0	1	白班	64
38	2020-11-22	8	0	1	白班	65
41	2020-11-19	8	0	1	白班	71
44	2020-11-21	8	0	1	白班	62
45	2020-11-14	8	0	1	白班	57
48	2021-01-08	8	0	1	白班	45
49	2021-01-06	8	0	1	白班	46
50	2020-09-03	8	0	1	白班	47
51	2020-09-03	8	0	1	白班	53
52	2020-09-23	8	0	1	白班	45
53	2020-09-24	2	1	5	白班	47
58	2020-11-05	8	0	0	白班	46
59	2020-11-06	8	0	0	小夜	46
\.


--
-- Data for Name: shift_shift; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.shift_shift (id, name, shift_type, start_time, end_time, work_hours, department_id, code) FROM stdin;
63	休息	5	00:00:00	00:00:00	0	4	
64	例假	5	00:00:00	00:00:00	0	4	
65	公假	3	00:00:00	00:00:00	8	4	
67	事假	6	00:00:00	00:00:00	0	4	
68	家庭照顧假	6	00:00:00	00:00:00	0	4	
69	無薪病假	6	00:00:00	00:00:00	0	4	
70	產假	5	00:00:00	00:00:00	0	4	
71	生理假	5	00:00:00	00:00:00	0	4	
72	特休	5	00:00:00	00:00:00	0	4	
73	補休	5	00:00:00	00:00:00	0	4	
74	婚假	5	00:00:00	00:00:00	0	4	
75	計薪病假	5	00:00:00	00:00:00	0	4	
76	喪假	5	00:00:00	00:00:00	0	4	
77	安胎休養假	5	00:00:00	00:00:00	0	4	
78	產檢假	5	00:00:00	00:00:00	0	4	
79	陪產假	5	00:00:00	00:00:00	0	4	
80	白班	0	08:00:00	16:00:00	8	4	A
81	小夜	1	16:00:00	00:00:00	8	4	E
82	行政	7	08:00:00	17:00:00	8	4	B
83	大夜	2	23:59:00	08:00:00	8	4	N
84	國定假日	5	00:00:00	00:00:00	0	4	H
\.


--
-- Data for Name: station_station; Type: TABLE DATA; Schema: db; Owner: schedule_user
--

COPY db.station_station (id, name, department_id) FROM stdin;
13	護理站	4
14	休假	4
15	公假	4
16	行政	4
\.


--
-- Data for Name: account_customuser; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.account_customuser (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, full_name, job_title, level, role, gender, type_of_user, pregnant, can_be_scheduled, holiday_rest_num, holiday_rest_num_used, special_rest_num, special_rest_num_used, eid, hour_required, hour_realized, onboard_date, compensatory_rest, starting_month, department_id) FROM stdin;
43	pbkdf2_sha256$180000$8vLuu9SQNhDe$8OqJAvaB4BTnjP4f/tsR24pNd7+7O7OYJx0gpL9D/vA=	2020-10-06 10:32:08.596208+00	f	N55639			test@mail.com	t	t	2020-09-14 05:34:49.181485+00	江○華	7B護理長	5	user	female	2	f	t	10	0	10	0	N55639	0	0	2019-10-02	0	1	4
44	pbkdf2_sha256$180000$xwWMAtrUQG3i$aKYhLtyLdxj+FHN6LLbx1Qtfm0p91NRuDejjSANatmE=	2020-09-16 03:30:17.834397+00	f	N00000			test@mail.com	t	t	2020-09-14 05:34:49.331882+00	吳○榕	7A護理長	5	user	female	2	f	t	10	0	10	0	N00000	0	0	2019-10-02	0	1	4
45	pbkdf2_sha256$180000$zqdppHjDrbJl$W0hiJr4AKchaIMeHOTS2ZMVNz+bZEGUUopwdnyNQBUA=	2020-10-05 14:02:05.988319+00	f	N30185			test@mail.com	t	t	2020-09-14 05:34:49.481875+00	何○惠	護理師	1	manager	female	1	f	f	10	0	10	0	N30185	0	0	2018-12-10	0	1	4
46	pbkdf2_sha256$180000$ummUgtLeu9ho$APx9kRYCMjnw9Q8/Vkrgl2YPypwswxnmx4JiLWN00h8=	2020-10-05 14:02:31.202259+00	f	N31268			test@mail.com	f	t	2020-09-14 05:34:49.632836+00	蕭○庭	護理師	1	user	female	1	f	t	10	0	10	0	N31268	0	0	2017-05-22	0	1	4
47	pbkdf2_sha256$180000$nHADfuk9ZF60$2Qsyn0UwuAkPJJfHbWVXb/9SiztmZyr3vmHsxWGPWiQ=	2020-10-06 10:39:44.763808+00	f	N55072			test@mail.com	f	t	2020-09-14 05:34:49.781956+00	趙○萍	護理師	1	user	female	1	f	t	10	0	10	0	N55072	0	0	2018-08-13	0	1	4
48	pbkdf2_sha256$180000$L90SqboxziGO$q6MoGZXxxiZjePwK1M5hxr5sPn8OgvsEYkz5iNd0ABw=	2020-09-18 09:45:55.71421+00	f	N55185			test@mail.com	f	t	2020-09-14 05:34:49.933519+00	廖○欣	護理師	2	user	female	1	f	f	10	0	10	0	N55185	0	0	2018-12-10	0	1	4
49	pbkdf2_sha256$180000$2T6oeoVnNtYr$XN09Nven2pqgqm4zzMO/aUmfzgiwlZPC9xCWNl4JQNs=	2020-09-30 04:55:41.048044+00	f	N55480			test@mail.com	f	t	2020-09-14 05:34:50.08268+00	蘇○君	護理師	1	user	female	0	f	t	10	0	10	0	N55480	0	0	2019-07-10	0	1	4
50	pbkdf2_sha256$180000$PHAWlozXD1Qb$9Aid0Et4ZYnChZZr7JlMVRt8kFg1oPLuO1NeOfu+VqQ=	2020-09-30 06:33:32.470669+00	f	N55502			test@mail.com	f	t	2020-09-14 05:34:50.233449+00	竺○卉	護理師	1	user	female	0	f	t	10	0	10	0	N55502	0	0	2019-07-29	0	1	4
51	pbkdf2_sha256$180000$kxhd1mUMRVBW$yaYGF1LGZwoGJvRd1bjSfwnMTfJbtUnwjQKcArBuL44=	2020-09-30 06:34:22.984091+00	f	N55567			test@mail.com	f	t	2020-09-14 05:34:50.386172+00	徐○馨	護理師	1	user	female	0	f	t	10	0	10	0	N55567	0	0	2019-08-26	0	1	4
52	pbkdf2_sha256$180000$oOGUwFfpZ5Fb$RXLa3/AzOgF+Uowequv03jo29160GZDYOb9fbVJaiho=	\N	f	N55616			test@mail.com	f	t	2020-09-14 05:34:50.537485+00	范○涵	護理師	1	user	female	1	f	f	10	0	10	0	N55616	0	0	2019-09-09	0	1	4
53	pbkdf2_sha256$180000$fY7jrIrSzijE$NmJcfsaIh8I6LH2S6bvSjbqJFO9kP4usj6uhejJp5v4=	2020-09-14 08:26:08.947393+00	f	N55705			test@mail.com	f	t	2020-09-14 05:34:50.686875+00	吳○蕙	護理師	1	user	female	0	f	t	10	0	10	0	N55705	0	0	2019-12-16	0	1	4
54	pbkdf2_sha256$180000$Qc2aZ72B1558$66hmK84DdF2lC+fHkwOttzglxC2yvvKhvSCWJHtwGOg=	2020-09-14 08:20:38.611683+00	f	N55777			test@mail.com	f	t	2020-09-14 05:34:50.838076+00	謝○如	護理師	1	user	female	0	f	t	10	0	10	0	N55777	0	0	2020-05-11	0	1	4
55	pbkdf2_sha256$180000$k7YfKSC1ozgW$CZ+xTfa4VTW0FiXTnO7sGMFbV3SHfb71bshQy3/QXyE=	2020-09-14 08:27:01.74122+00	f	N55776			test@mail.com	f	t	2020-09-14 05:34:50.98675+00	姚○伶	護理師	1	user	female	0	f	t	10	0	10	0	N55776	0	0	2020-05-11	0	1	4
56	pbkdf2_sha256$180000$tycvNxZQIJ7H$ROD0pYtnLYn9ehyV0jd+z+/5W00lQXRCP1HERGVXuKw=	2020-09-14 08:27:12.502813+00	f	N55764			test@mail.com	f	t	2020-09-14 05:34:51.137723+00	李○鑫	護理師	1	user	female	1	f	t	10	0	10	0	N55764	0	0	2020-05-11	0	1	4
57	pbkdf2_sha256$180000$ZcWDCnMTjQpg$gtnqzlH5lOcPI5uQijT7jKoPYa+oJHhbs6kAC2NA0xE=	2020-09-14 08:28:48.809182+00	f	N55792			test@mail.com	f	t	2020-09-14 05:34:51.286644+00	陳○甄	新進護理師	1	user	female	0	f	t	10	0	10	0	N55792	0	0	2020-06-01	0	1	4
58	pbkdf2_sha256$180000$683R2SikBKpH$QRyuzcW1usgJm/qsxmw4//Zvstso00SAQlIV8pXmS6g=	2020-09-21 08:39:23.226125+00	f	N55798			test@mail.com	f	t	2020-09-14 05:34:51.452696+00	謝○蓉	新進護理師	1	user	female	3	f	f	10	0	10	0	N55798	0	0	2020-06-08	0	1	4
59	pbkdf2_sha256$180000$6fMIUoq06wXH$Uono5hMtZsXVg9vWVdA0bvdGN/i2Gid4vd7ibv5FsTk=	2020-10-06 10:32:28.818473+00	f	N55812			test@mail.com	f	t	2020-09-14 05:34:51.615354+00	蔡○亭	新進護理師	1	user	female	3	f	f	10	0	10	0	N55812	0	0	2020-06-28	0	1	4
60	pbkdf2_sha256$180000$asFNabhz6gR7$dW1MAoW2nGUSdh7xDA5hmPyCraDzynuJ91KjcuZ7CKk=	2020-09-14 08:26:51.785465+00	f	N55822			test@mail.com	f	t	2020-09-14 05:34:51.76657+00	陳○瑋	新進護理師	1	user	female	1	f	t	10	0	10	0	N55822	0	0	2020-07-06	0	1	4
61	pbkdf2_sha256$180000$3jjBYCwqxd1L$JmJ0+8lKgYR78GB9KTMEP3RBuJCo7h/rPNRMurMRxrE=	\N	f	N55823			test@mail.com	f	t	2020-09-14 05:34:51.915729+00	吳○盈	新進護理師	1	user	female	3	f	f	10	0	10	0	N55823	0	0	2020-07-06	0	1	4
62	pbkdf2_sha256$180000$gMyillnffrJN$KGZAEiSQM/d9qCZ4ImzDcPTGlPKu78ANcmowgQuSAi8=	2020-09-14 08:30:03.010935+00	f	N55098			test@mail.com	f	t	2020-09-14 05:34:52.066491+00	阮○婷	護理師	1	user	female	1	f	t	10	0	10	0	N55098	0	0	2018-10-08	0	1	4
63	pbkdf2_sha256$180000$YCFPmvMDNrZD$g+R61YFWFuSV4GORcoc7bRwWAoQDpwpmam7y6l/fylU=	2020-09-30 03:54:10.288209+00	f	N55336			test@mail.com	f	t	2020-09-14 05:34:52.215269+00	鄭○勻	護理師	1	user	female	0	f	t	10	0	10	0	N55336	0	0	2019-04-01	0	1	4
64	pbkdf2_sha256$180000$KOQsGt9TeATl$Bv1wQCrtNdO1q27P4k2T1rwApYsYEWgH4cTcgN7PN4w=	2020-09-14 08:29:17.83704+00	f	N55376			test@mail.com	f	t	2020-09-14 05:34:52.36687+00	陳○昕	護理師	1	user	female	0	f	t	10	0	10	0	N55376	0	0	2019-04-22	0	1	4
65	pbkdf2_sha256$180000$onHbztYprQG5$/tw1HDtytF7oOS9/xOhvfAWPyWdYnIw12mJA785nLgM=	2020-09-14 08:29:09.117182+00	f	N55539			test@mail.com	f	t	2020-09-14 05:34:52.515849+00	黃○芳	護理師	1	user	female	0	f	t	10	0	10	0	N55539	0	0	2019-08-19	0	1	4
66	pbkdf2_sha256$180000$T8n7Q7MWel5c$VtPRShzqIoLMClugnV5M2Tcvxatv0GStJi7SLLVDTNE=	2020-09-30 04:03:04.000303+00	f	N55562			test@mail.com	f	t	2020-09-14 05:34:52.666666+00	遲○婷	護理師	1	user	female	0	f	t	10	0	10	0	N55562	0	0	2019-08-26	0	1	4
67	pbkdf2_sha256$180000$axRxeN6SA676$FlJATruPD6/Nqkjw/TfIBP2SGpbm+DL94WpVgm2i+lw=	2020-09-14 08:27:22.533551+00	f	N55679			test@mail.com	f	t	2020-09-14 05:34:52.816068+00	魏○恬	護理師	1	user	female	0	f	t	10	0	10	0	N55679	0	0	2019-11-04	0	1	4
68	pbkdf2_sha256$180000$owQgmTwIk3qg$7JS9o3fkrf0TzOmLi6DGMR3o5D2HD6XEf+lvmhifs7w=	2020-09-14 08:25:57.891948+00	f	N55767			test@mail.com	f	t	2020-09-14 05:34:52.966717+00	黃○茹	護理師	1	user	female	1	f	t	10	0	10	0	N55767	0	0	2020-04-20	0	1	4
69	pbkdf2_sha256$180000$TylHET2HCCiM$pEXjhZW+dR7qDoha3q6d+9rpKw23Vnq0RO7boGYQDMA=	2020-09-14 08:30:13.998561+00	f	N55095			test@mail.com	f	t	2020-09-14 05:34:53.115919+00	曾○琳	護理師	1	user	female	1	f	t	10	0	10	0	N55095	0	0	2018-10-01	0	1	4
70	pbkdf2_sha256$180000$BP0RPhQQZ4l1$S/vr/dd1oN5Oa8ZFA6uOj6A58PAmGRq26daekubUL2A=	\N	f	N55121			test@mail.com	f	t	2020-09-14 05:34:53.266459+00	師○亭	護理師	1	user	female	0	f	f	10	0	10	0	N55121	0	0	2018-11-05	0	1	4
71	pbkdf2_sha256$180000$35FUePiziwMx$ylfW0Us6jkRjd1x4B2zg79YINnQEJHoajdMyhsr0g7I=	2020-09-14 08:29:27.68645+00	f	N55337			test@mail.com	f	t	2020-09-14 05:34:53.417031+00	陳○宇	護理師	1	user	male	0	f	t	10	0	10	0	N55337	0	0	2019-10-25	0	1	4
72	pbkdf2_sha256$180000$2sGBCY1vjnVA$BoaAtO0aAibBXxlfw+MqDtiCL+uurTPeIPjMCMjcfxs=	\N	f	N55429			test@mail.com	f	t	2020-09-14 05:34:53.567902+00	何○昤	護理師	1	user	female	0	f	f	10	0	10	0	N55429	0	0	2019-06-03	0	1	4
73	pbkdf2_sha256$180000$7bMpSYWRyWVr$wJ8FxKHqU7g3YHADeGxoc1PnXD3E38wSGGn5xxN8xE8=	2020-09-14 08:27:43.16223+00	f	N55503			test@mail.com	f	t	2020-09-14 05:34:53.716665+00	林○亭	護理師	1	user	female	0	f	t	10	0	10	0	N55503	0	0	2019-07-29	0	1	4
74	pbkdf2_sha256$180000$BrKxNBlIxyiL$UA2giLeLbczboI75voCI06Bv9r42oHQuwwYqfuvNmxU=	\N	f	New001			test@mail.com	f	t	2020-09-14 05:34:53.867574+00	沈○靜	新進護理師	1	user	female	3	f	t	10	0	10	0	New001	0	0	2020-09-01	0	1	4
75	pbkdf2_sha256$180000$44VBzL0onCML$D7bjxel7MPJiXeF6JM2ZK587H0moGeklYNPEXyV8q9g=	\N	f	New002			test@mail.com	f	t	2020-09-14 05:34:54.017386+00	古○儒	新進護理師	1	user	female	3	f	t	10	0	10	0	New002	0	0	2020-09-01	0	1	4
76	pbkdf2_sha256$180000$obaSC261Cdo5$M0Pesmv0f8ydP0ULbcPBzosrGATftuKQBOO6ek06fuw=	\N	f	New003			test@mail.com	f	t	2020-09-14 05:34:54.168222+00	黃○雅	新進護理師	1	user	female	3	f	t	10	0	10	0	New003	0	0	2020-09-01	0	1	4
77	pbkdf2_sha256$180000$1QhuW79Kmk0r$pn0Hyw9Gpz+gp2tXLN0+Gfz5eyPIa7cGEfs/DtR/TTg=	\N	f	New004			test@mail.com	f	t	2020-09-14 05:34:54.317642+00	陳○澐	新進護理師	1	user	female	3	f	t	10	0	10	0	New004	0	0	2020-09-01	0	1	4
78	pbkdf2_sha256$180000$0NSOiPl4hX8d$2rQjimwuWSFnhiNbINTkdcd3HGZ3co3nnv/vHZmjiy4=	2020-09-30 03:43:30.305282+00	f	N7287			test@mail.com	f	t	2020-09-14 05:34:54.497147+00	董○盈	護理師	1	user	female	0	f	t	10	0	10	0	N7287	0	0	2020-09-01	0	1	4
79	pbkdf2_sha256$180000$UrMNlylDUHto$effx3DQ8bOKB16zjexHiWr07aEpkaMQQE7A1VR5Ui44=	2020-09-14 08:28:26.309533+00	f	N25917			test@mail.com	f	t	2020-09-14 05:34:54.64609+00	陳○頻	護理師	1	user	female	0	f	t	10	0	10	0	N25917	0	0	2020-09-01	0	1	4
80	pbkdf2_sha256$180000$yF3tcKq0Hzxb$1k2UFh9i2XnrOIhqfC7kchKARrwzDXtpK0LPZZ+D/Ww=	2020-09-14 08:27:56.588769+00	f	N55476			test@mail.com	f	t	2020-09-14 05:34:54.797022+00	宋○綺	護理師	2	user	female	1	f	t	10	0	10	0	N55476	0	0	2019-07-01	0	1	4
42	pbkdf2_sha256$600000$EBIxc5fRg4Se1Lh9dJNU82$6g0J+NYrJsY3lPEMqLakPIRAX1zDgI+MjS98cl3f0aU=	2026-04-28 06:04:23.028816+00	t	circlepen			lyle.lai@redfalcon-hpc.com	t	t	2020-09-14 05:34:29.376024+00	YiJu Lai	職稱	3	admin	male	1	f	f	10	0	10	0	20190022	100	0	\N	0	1	4
\.


--
-- Data for Name: account_customuser_groups; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.account_customuser_groups (id, customuser_id, group_id) FROM stdin;
\.


--
-- Data for Name: account_customuser_user_permissions; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.account_customuser_user_permissions (id, customuser_id, permission_id) FROM stdin;
\.


--
-- Data for Name: account_department; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.account_department (id, name, detail, limit_pre_schedule, deadline_pre_schedule, reset, law_rule, schedule_rule, admin_in_schedule, same_day_notice, date_start, start_of_week, can_rest_redday, overtime_rule, month_cycle) FROM stdin;
4	7AB	7AB病房	6	19	0	2	1	f	5	2020-09-01	1	10	0	1
\.


--
-- Data for Name: account_departmentmanager; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.account_departmentmanager (id, department_id, manager_one_id, manager_two_id) FROM stdin;
3	4	42	45
\.


--
-- Data for Name: account_liscense; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.account_liscense (id, name, date, due, source, liscense_pic, liscense_pic_2, user_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_customuser
22	Can change user	6	change_customuser
23	Can delete user	6	delete_customuser
24	Can view user	6	view_customuser
25	Can add department	7	add_department
26	Can change department	7	change_department
27	Can delete department	7	delete_department
28	Can view department	7	view_department
29	Can add liscense	8	add_liscense
30	Can change liscense	8	change_liscense
31	Can delete liscense	8	delete_liscense
32	Can view liscense	8	view_liscense
33	Can add department manager	9	add_departmentmanager
34	Can change department manager	9	change_departmentmanager
35	Can delete department manager	9	delete_departmentmanager
36	Can view department manager	9	view_departmentmanager
37	Can add time adjustment	10	add_timeadjustment
38	Can change time adjustment	10	change_timeadjustment
39	Can delete time adjustment	10	delete_timeadjustment
40	Can view time adjustment	10	view_timeadjustment
41	Can add history result	11	add_historyresult
42	Can change history result	11	change_historyresult
43	Can delete history result	11	delete_historyresult
44	Can view history result	11	view_historyresult
45	Can add exchange application	12	add_exchangeapplication
46	Can change exchange application	12	change_exchangeapplication
47	Can delete exchange application	12	delete_exchangeapplication
48	Can view exchange application	12	view_exchangeapplication
49	Can add result	13	add_result
50	Can change result	13	change_result
51	Can delete result	13	delete_result
52	Can view result	13	view_result
53	Can add pre result	14	add_preresult
54	Can change pre result	14	change_preresult
55	Can delete pre result	14	delete_preresult
56	Can view pre result	14	view_preresult
57	Can add after result	15	add_afterresult
58	Can change after result	15	change_afterresult
59	Can delete after result	15	delete_afterresult
60	Can view after result	15	view_afterresult
61	Can add station	16	add_station
62	Can change station	16	change_station
63	Can delete station	16	delete_station
64	Can view station	16	view_station
65	Can add demand of station	17	add_demandofstation
66	Can change demand of station	17	change_demandofstation
67	Can delete demand of station	17	delete_demandofstation
68	Can view demand of station	17	view_demandofstation
69	Can add demand user table	18	add_demandusertable
70	Can change demand user table	18	change_demandusertable
71	Can delete demand user table	18	delete_demandusertable
72	Can view demand user table	18	view_demandusertable
73	Can add shift	19	add_shift
74	Can change shift	19	change_shift
75	Can delete shift	19	delete_shift
76	Can view shift	19	view_shift
77	Can add h_ calendar	20	add_h_calendar
78	Can change h_ calendar	20	change_h_calendar
79	Can delete h_ calendar	20	delete_h_calendar
80	Can view h_ calendar	20	view_h_calendar
81	Can add remark square	21	add_remarksquare
82	Can change remark square	21	change_remarksquare
83	Can delete remark square	21	delete_remarksquare
84	Can view remark square	21	view_remarksquare
85	Can add result remark	22	add_resultremark
86	Can change result remark	22	change_resultremark
87	Can delete result remark	22	delete_resultremark
88	Can view result remark	22	view_resultremark
89	Can add pre result remark	23	add_preresultremark
90	Can change pre result remark	23	change_preresultremark
91	Can delete pre result remark	23	delete_preresultremark
92	Can view pre result remark	23	view_preresultremark
93	Can add user remark	24	add_userremark
94	Can change user remark	24	change_userremark
95	Can delete user remark	24	delete_userremark
96	Can view user remark	24	view_userremark
97	Can add reservation	25	add_reservation
98	Can change reservation	25	change_reservation
99	Can delete reservation	25	delete_reservation
100	Can view reservation	25	view_reservation
101	Can add promise shift	26	add_promiseshift
102	Can change promise shift	26	change_promiseshift
103	Can delete promise shift	26	delete_promiseshift
104	Can view promise shift	26	view_promiseshift
105	Can add Notification	27	add_notification
106	Can change Notification	27	change_notification
107	Can delete Notification	27	delete_notification
108	Can view Notification	27	view_notification
109	Can add Token	28	add_token
110	Can change Token	28	change_token
111	Can delete Token	28	delete_token
112	Can view Token	28	view_token
113	Can add Token	29	add_tokenproxy
114	Can change Token	29	change_tokenproxy
115	Can delete Token	29	delete_tokenproxy
116	Can view Token	29	view_tokenproxy
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
bc9df77baac6bb9e703f3c6f7dffef84b3bee2f7	2026-04-27 03:10:35.932195+00	1
a61b400af63f2ee018e1a98e2ee55e2ddde87790	2026-04-27 05:37:06.766947+00	42
\.


--
-- Data for Name: date_h_calendar; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.date_h_calendar (id, date, attribute, locked, red_day) FROM stdin;
1561	2020-01-01	{"4": "1"}	f	f
1562	2020-01-02	{"4": "1"}	f	f
1563	2020-01-03	{"4": "1"}	f	f
1564	2020-01-04	{"4": "2"}	f	t
1565	2020-01-05	{"4": "2"}	f	t
1566	2020-01-06	{"4": "1"}	f	f
1567	2020-01-07	{"4": "1"}	f	f
1568	2020-01-08	{"4": "1"}	f	f
1569	2020-01-09	{"4": "1"}	f	f
1570	2020-01-10	{"4": "1"}	f	f
1571	2020-01-11	{"4": "2"}	f	t
1572	2020-01-12	{"4": "2"}	f	t
1573	2020-01-13	{"4": "1"}	f	f
1574	2020-01-14	{"4": "1"}	f	f
1575	2020-01-15	{"4": "1"}	f	f
1576	2020-01-16	{"4": "1"}	f	f
1577	2020-01-17	{"4": "1"}	f	f
1578	2020-01-18	{"4": "2"}	f	t
1579	2020-01-19	{"4": "2"}	f	t
1580	2020-01-20	{"4": "1"}	f	f
1581	2020-01-21	{"4": "1"}	f	f
1582	2020-01-22	{"4": "1"}	f	f
1583	2020-01-23	{"4": "1"}	f	f
1584	2020-01-24	{"4": "1"}	f	f
1585	2020-01-25	{"4": "2"}	f	t
1586	2020-01-26	{"4": "2"}	f	t
1587	2020-01-27	{"4": "1"}	f	f
1588	2020-01-28	{"4": "1"}	f	f
1589	2020-01-29	{"4": "1"}	f	f
1590	2020-01-30	{"4": "1"}	f	f
1591	2020-01-31	{"4": "1"}	f	f
1592	2020-02-01	{"4": "2"}	f	t
1593	2020-02-02	{"4": "2"}	f	t
1594	2020-02-03	{"4": "1"}	f	f
1595	2020-02-04	{"4": "1"}	f	f
1596	2020-02-05	{"4": "1"}	f	f
1597	2020-02-06	{"4": "1"}	f	f
1598	2020-02-07	{"4": "1"}	f	f
1599	2020-02-08	{"4": "2"}	f	t
1600	2020-02-09	{"4": "2"}	f	t
1601	2020-02-10	{"4": "1"}	f	f
1602	2020-02-11	{"4": "1"}	f	f
1603	2020-02-12	{"4": "1"}	f	f
1604	2020-02-13	{"4": "1"}	f	f
1605	2020-02-14	{"4": "1"}	f	f
1606	2020-02-15	{"4": "2"}	f	t
1607	2020-02-16	{"4": "2"}	f	t
1608	2020-02-17	{"4": "1"}	f	f
1609	2020-02-18	{"4": "1"}	f	f
1610	2020-02-19	{"4": "1"}	f	f
1611	2020-02-20	{"4": "1"}	f	f
1612	2020-02-21	{"4": "1"}	f	f
1613	2020-02-22	{"4": "2"}	f	t
1614	2020-02-23	{"4": "2"}	f	t
1615	2020-02-24	{"4": "1"}	f	f
1616	2020-02-25	{"4": "1"}	f	f
1617	2020-02-26	{"4": "1"}	f	f
1618	2020-02-27	{"4": "1"}	f	f
1619	2020-02-28	{"4": "1"}	f	f
1620	2020-02-29	{"4": "2"}	f	t
1621	2020-03-01	{"4": "2"}	f	t
1622	2020-03-02	{"4": "1"}	f	f
1623	2020-03-03	{"4": "1"}	f	f
1624	2020-03-04	{"4": "1"}	f	f
1625	2020-03-05	{"4": "1"}	f	f
1626	2020-03-06	{"4": "1"}	f	f
1627	2020-03-07	{"4": "2"}	f	t
1628	2020-03-08	{"4": "2"}	f	t
1629	2020-03-09	{"4": "1"}	f	f
1630	2020-03-10	{"4": "1"}	f	f
1631	2020-03-11	{"4": "1"}	f	f
1632	2020-03-12	{"4": "1"}	f	f
1633	2020-03-13	{"4": "1"}	f	f
1634	2020-03-14	{"4": "2"}	f	t
1635	2020-03-15	{"4": "2"}	f	t
1636	2020-03-16	{"4": "1"}	f	f
1637	2020-03-17	{"4": "1"}	f	f
1638	2020-03-18	{"4": "1"}	f	f
1639	2020-03-19	{"4": "1"}	f	f
1640	2020-03-20	{"4": "1"}	f	f
1641	2020-03-21	{"4": "2"}	f	t
1642	2020-03-22	{"4": "2"}	f	t
1643	2020-03-23	{"4": "1"}	f	f
1644	2020-03-24	{"4": "1"}	f	f
1645	2020-03-25	{"4": "1"}	f	f
1646	2020-03-26	{"4": "1"}	f	f
1647	2020-03-27	{"4": "1"}	f	f
1648	2020-03-28	{"4": "2"}	f	t
1649	2020-03-29	{"4": "2"}	f	t
1650	2020-03-30	{"4": "1"}	f	f
1651	2020-03-31	{"4": "1"}	f	f
1652	2020-04-01	{"4": "1"}	f	f
1653	2020-04-02	{"4": "1"}	f	f
1654	2020-04-03	{"4": "1"}	f	f
1655	2020-04-04	{"4": "2"}	f	t
1656	2020-04-05	{"4": "2"}	f	t
1657	2020-04-06	{"4": "1"}	f	f
1658	2020-04-07	{"4": "1"}	f	f
1659	2020-04-08	{"4": "1"}	f	f
1660	2020-04-09	{"4": "1"}	f	f
1661	2020-04-10	{"4": "1"}	f	f
1662	2020-04-11	{"4": "2"}	f	t
1663	2020-04-12	{"4": "2"}	f	t
1664	2020-04-13	{"4": "1"}	f	f
1665	2020-04-14	{"4": "1"}	f	f
1666	2020-04-15	{"4": "1"}	f	f
1667	2020-04-16	{"4": "1"}	f	f
1668	2020-04-17	{"4": "1"}	f	f
1669	2020-04-18	{"4": "2"}	f	t
1670	2020-04-19	{"4": "2"}	f	t
1671	2020-04-20	{"4": "1"}	f	f
1672	2020-04-21	{"4": "1"}	f	f
1673	2020-04-22	{"4": "1"}	f	f
1674	2020-04-23	{"4": "1"}	f	f
1675	2020-04-24	{"4": "1"}	f	f
1676	2020-04-25	{"4": "2"}	f	t
1677	2020-04-26	{"4": "2"}	f	t
1678	2020-04-27	{"4": "1"}	f	f
1679	2020-04-28	{"4": "1"}	f	f
1680	2020-04-29	{"4": "1"}	f	f
1681	2020-04-30	{"4": "1"}	f	f
1682	2020-05-01	{"4": "1"}	f	f
1683	2020-05-02	{"4": "2"}	f	t
1684	2020-05-03	{"4": "2"}	f	t
1685	2020-05-04	{"4": "1"}	f	f
1686	2020-05-05	{"4": "1"}	f	f
1687	2020-05-06	{"4": "1"}	f	f
1688	2020-05-07	{"4": "1"}	f	f
1689	2020-05-08	{"4": "1"}	f	f
1690	2020-05-09	{"4": "2"}	f	t
1691	2020-05-10	{"4": "2"}	f	t
1692	2020-05-11	{"4": "1"}	f	f
1693	2020-05-12	{"4": "1"}	f	f
1694	2020-05-13	{"4": "1"}	f	f
1695	2020-05-14	{"4": "1"}	f	f
1696	2020-05-15	{"4": "1"}	f	f
1697	2020-05-16	{"4": "2"}	f	t
1698	2020-05-17	{"4": "2"}	f	t
1699	2020-05-18	{"4": "1"}	f	f
1700	2020-05-19	{"4": "1"}	f	f
1701	2020-05-20	{"4": "1"}	f	f
1702	2020-05-21	{"4": "1"}	f	f
1703	2020-05-22	{"4": "1"}	f	f
1704	2020-05-23	{"4": "2"}	f	t
1705	2020-05-24	{"4": "2"}	f	t
1706	2020-05-25	{"4": "1"}	f	f
1707	2020-05-26	{"4": "1"}	f	f
1708	2020-05-27	{"4": "1"}	f	f
1709	2020-05-28	{"4": "1"}	f	f
1710	2020-05-29	{"4": "1"}	f	f
1711	2020-05-30	{"4": "2"}	f	t
1712	2020-05-31	{"4": "2"}	f	t
1713	2020-06-01	{"4": "1"}	f	f
1714	2020-06-02	{"4": "1"}	f	f
1715	2020-06-03	{"4": "1"}	f	f
1716	2020-06-04	{"4": "1"}	f	f
1717	2020-06-05	{"4": "1"}	f	f
1718	2020-06-06	{"4": "2"}	f	t
1719	2020-06-07	{"4": "2"}	f	t
1720	2020-06-08	{"4": "1"}	f	f
1721	2020-06-09	{"4": "1"}	f	f
1722	2020-06-10	{"4": "1"}	f	f
1723	2020-06-11	{"4": "1"}	f	f
1724	2020-06-12	{"4": "1"}	f	f
1725	2020-06-13	{"4": "2"}	f	t
1726	2020-06-14	{"4": "2"}	f	t
1727	2020-06-15	{"4": "1"}	f	f
1728	2020-06-16	{"4": "1"}	f	f
1729	2020-06-17	{"4": "1"}	f	f
1730	2020-06-18	{"4": "1"}	f	t
1731	2020-06-19	{"4": "1"}	f	f
1732	2020-06-20	{"4": "2"}	f	t
1733	2020-06-21	{"4": "2"}	f	t
1734	2020-06-22	{"4": "1"}	f	f
1735	2020-06-23	{"4": "1"}	f	f
1736	2020-06-24	{"4": "1"}	f	f
1737	2020-06-25	{"4": "1"}	f	f
1738	2020-06-26	{"4": "1"}	f	f
1739	2020-06-27	{"4": "2"}	f	t
1740	2020-06-28	{"4": "2"}	f	t
1741	2020-06-29	{"4": "1"}	f	f
1742	2020-06-30	{"4": "1"}	f	f
1743	2020-07-01	{"4": "1"}	f	f
1744	2020-07-02	{"4": "1"}	f	f
1745	2020-07-03	{"4": "1"}	f	f
1746	2020-07-04	{"4": "2"}	f	t
1747	2020-07-05	{"4": "2"}	f	t
1748	2020-07-06	{"4": "1"}	f	f
1749	2020-07-07	{"4": "1"}	f	f
1750	2020-07-08	{"4": "1"}	f	f
1751	2020-07-09	{"4": "1"}	f	f
1752	2020-07-10	{"4": "1"}	f	f
1753	2020-07-11	{"4": "2"}	f	t
1754	2020-07-12	{"4": "2"}	f	t
1755	2020-07-13	{"4": "1"}	f	f
1756	2020-07-14	{"4": "1"}	f	f
1757	2020-07-15	{"4": "1"}	f	f
1758	2020-07-16	{"4": "1"}	f	f
1759	2020-07-17	{"4": "1"}	f	f
1760	2020-07-18	{"4": "2"}	f	t
1761	2020-07-19	{"4": "2"}	f	t
1762	2020-07-20	{"4": "1"}	f	f
1763	2020-07-21	{"4": "1"}	f	f
1764	2020-07-22	{"4": "1"}	f	f
1765	2020-07-23	{"4": "1"}	f	f
1766	2020-07-24	{"4": "1"}	f	f
1767	2020-07-25	{"4": "2"}	f	t
1768	2020-07-26	{"4": "2"}	f	t
1769	2020-07-27	{"4": "1"}	f	f
1770	2020-07-28	{"4": "1"}	f	f
1771	2020-07-29	{"4": "1"}	f	f
1772	2020-07-30	{"4": "1"}	f	f
1773	2020-07-31	{"4": "1"}	f	f
1774	2020-08-01	{"4": "2"}	f	t
1775	2020-08-02	{"4": "2"}	f	t
1776	2020-08-03	{"4": "1"}	f	f
1777	2020-08-04	{"4": "1"}	f	f
1778	2020-08-05	{"4": "1"}	f	f
1779	2020-08-06	{"4": "1"}	f	f
1780	2020-08-07	{"4": "1"}	f	f
1781	2020-08-08	{"4": "2"}	f	t
1782	2020-08-09	{"4": "2"}	f	t
1783	2020-08-10	{"4": "1"}	f	f
1784	2020-08-11	{"4": "1"}	f	f
1785	2020-08-12	{"4": "1"}	f	f
1786	2020-08-13	{"4": "1"}	f	f
1787	2020-08-14	{"4": "1"}	f	f
1788	2020-08-15	{"4": "2"}	f	t
1789	2020-08-16	{"4": "2"}	f	t
1790	2020-08-17	{"4": "1"}	f	f
1791	2020-08-18	{"4": "1"}	f	f
1792	2020-08-19	{"4": "1"}	f	f
1793	2020-08-20	{"4": "1"}	f	f
1794	2020-08-21	{"4": "1"}	f	f
1795	2020-08-22	{"4": "2"}	f	t
1796	2020-08-23	{"4": "2"}	f	t
1797	2020-08-24	{"4": "1"}	f	f
1798	2020-08-25	{"4": "1"}	f	f
1799	2020-08-26	{"4": "1"}	f	f
1800	2020-08-27	{"4": "1"}	f	f
1801	2020-08-28	{"4": "1"}	f	f
1802	2020-08-29	{"4": "2"}	f	t
1803	2020-08-30	{"4": "2"}	f	t
1804	2020-08-31	{"4": "1"}	f	f
1805	2020-09-01	{"4": "1"}	f	t
1806	2020-09-02	{"4": "1"}	f	f
1807	2020-09-03	{"4": "1"}	f	f
1808	2020-09-04	{"4": "1"}	f	f
1809	2020-09-05	{"4": "1"}	f	t
1810	2020-09-06	{"4": "0"}	f	t
1811	2020-09-07	{"4": "1"}	f	f
1812	2020-09-08	{"4": "1"}	f	f
1813	2020-09-09	{"4": "1"}	f	f
1814	2020-09-10	{"4": "1"}	f	f
1815	2020-09-11	{"4": "1"}	f	f
1816	2020-09-12	{"4": "1"}	f	t
1817	2020-09-13	{"4": "1"}	f	t
1818	2020-09-14	{"4": "2"}	f	f
1819	2020-09-15	{"4": "2"}	f	f
1820	2020-09-16	{"4": "2"}	f	f
1821	2020-09-17	{"4": "2"}	f	f
1822	2020-09-18	{"4": "2"}	f	f
1823	2020-09-19	{"4": "2"}	f	t
1824	2020-09-20	{"4": "2"}	f	t
1825	2020-09-21	{"4": "2"}	f	f
1826	2020-09-22	{"4": "2"}	f	f
1827	2020-09-23	{"4": "2"}	f	f
1828	2020-09-24	{"4": "2"}	f	f
1829	2020-09-25	{"4": "2"}	f	f
1830	2020-09-26	{"4": "2"}	f	t
1831	2020-09-27	{"4": "2"}	f	t
1832	2020-09-28	{"4": "2"}	f	f
1833	2020-09-29	{"4": "2"}	f	f
1834	2020-09-30	{"4": "2"}	f	f
1835	2020-10-01	{"4": "1"}	f	f
1836	2020-10-02	{"4": "1"}	f	f
1837	2020-10-03	{"4": "2"}	f	t
1838	2020-10-04	{"4": "2"}	f	t
1839	2020-10-05	{"4": "1"}	f	f
1840	2020-10-06	{"4": "1"}	f	f
1841	2020-10-07	{"4": "1"}	f	f
1842	2020-10-08	{"4": "1"}	f	f
1843	2020-10-09	{"4": "1"}	f	f
1844	2020-10-10	{"4": "2"}	f	t
1845	2020-10-11	{"4": "2"}	f	t
1846	2020-10-12	{"4": "1"}	f	f
1847	2020-10-13	{"4": "1"}	f	f
1848	2020-10-14	{"4": "1"}	f	f
1849	2020-10-15	{"4": "1"}	f	f
1850	2020-10-16	{"4": "1"}	f	f
1851	2020-10-17	{"4": "2"}	f	t
1852	2020-10-18	{"4": "2"}	f	t
1853	2020-10-19	{"4": "1"}	f	f
1854	2020-10-20	{"4": "1"}	f	f
1855	2020-10-21	{"4": "1"}	f	f
1856	2020-10-22	{"4": "1"}	f	f
1857	2020-10-23	{"4": "1"}	f	f
1858	2020-10-24	{"4": "2"}	f	t
1859	2020-10-25	{"4": "2"}	f	t
1860	2020-10-26	{"4": "1"}	f	f
1861	2020-10-27	{"4": "1"}	f	f
1862	2020-10-28	{"4": "1"}	f	f
1863	2020-10-29	{"4": "1"}	f	f
1864	2020-10-30	{"4": "1"}	f	f
1865	2020-10-31	{"4": "2"}	f	t
1866	2020-11-01	{"4": "1"}	f	t
1867	2020-11-02	{"4": "1"}	f	f
1868	2020-11-03	{"4": "1"}	f	f
1869	2020-11-04	{"4": "1"}	f	f
1870	2020-11-05	{"4": "1"}	f	f
1871	2020-11-06	{"4": "1"}	f	f
1872	2020-11-07	{"4": "1"}	f	t
1873	2020-11-08	{"4": "1"}	f	t
1874	2020-11-09	{"4": "1"}	f	f
1875	2020-11-10	{"4": "1"}	f	f
1876	2020-11-11	{"4": "1"}	f	f
1877	2020-11-12	{"4": "1"}	f	f
1878	2020-11-13	{"4": "1"}	f	f
1879	2020-11-14	{"4": "2"}	f	t
1880	2020-11-15	{"4": "2"}	f	t
1881	2020-11-16	{"4": "2"}	f	f
1882	2020-11-17	{"4": "2"}	f	f
1883	2020-11-18	{"4": "2"}	f	f
1884	2020-11-19	{"4": "2"}	f	f
1885	2020-11-20	{"4": "2"}	f	f
1886	2020-11-21	{"4": "2"}	f	t
1887	2020-11-22	{"4": "2"}	f	t
1888	2020-11-23	{"4": "2"}	f	f
1889	2020-11-24	{"4": "2"}	f	f
1890	2020-11-25	{"4": "2"}	f	f
1891	2020-11-26	{"4": "2"}	f	f
1892	2020-11-27	{"4": "2"}	f	f
1893	2020-11-28	{"4": "2"}	f	t
1894	2020-11-29	{"4": "2"}	f	t
1895	2020-11-30	{"4": "2"}	f	f
1896	2020-12-01	{"4": "1"}	f	f
1897	2020-12-02	{"4": "1"}	f	f
1898	2020-12-03	{"4": "1"}	f	f
1899	2020-12-04	{"4": "1"}	f	f
1900	2020-12-05	{"4": "1"}	f	t
1901	2020-12-06	{"4": "1"}	f	t
1902	2020-12-07	{"4": "1"}	f	f
1903	2020-12-08	{"4": "1"}	f	f
1904	2020-12-09	{"4": "1"}	f	f
1905	2020-12-10	{"4": "1"}	f	f
1906	2020-12-11	{"4": "1"}	f	f
1907	2020-12-12	{"4": "1"}	f	t
1908	2020-12-13	{"4": "1"}	f	t
1909	2020-12-14	{"4": "1"}	f	f
1910	2020-12-15	{"4": "1"}	f	f
1911	2020-12-16	{"4": "2"}	f	f
1912	2020-12-17	{"4": "2"}	f	f
1913	2020-12-18	{"4": "2"}	f	f
1914	2020-12-19	{"4": "2"}	f	t
1915	2020-12-20	{"4": "2"}	f	t
1916	2020-12-21	{"4": "2"}	f	f
1917	2020-12-22	{"4": "2"}	f	f
1918	2020-12-23	{"4": "2"}	f	f
1919	2020-12-24	{"4": "2"}	f	f
1920	2020-12-25	{"4": "2"}	f	f
1921	2020-12-26	{"4": "2"}	f	t
1922	2020-12-27	{"4": "2"}	f	t
1923	2020-12-28	{"4": "2"}	f	f
1924	2020-12-29	{"4": "2"}	f	f
1925	2020-12-30	{"4": "2"}	f	f
1926	2020-12-31	{"4": "2"}	f	f
1927	2021-01-01	{"4": "0"}	f	t
1928	2021-01-02	{"4": "1"}	f	t
1929	2021-01-03	{"4": "1"}	f	t
1930	2021-01-04	{"4": "1"}	f	f
1931	2021-01-05	{"4": "1"}	f	f
1932	2021-01-06	{"4": "1"}	f	f
1933	2021-01-07	{"4": "1"}	f	f
1934	2021-01-08	{"4": "1"}	f	f
1935	2021-01-09	{"4": "1"}	f	t
1936	2021-01-10	{"4": "1"}	f	t
1937	2021-01-11	{"4": "1"}	f	f
1938	2021-01-12	{"4": "1"}	f	f
1939	2021-01-13	{"4": "1"}	f	f
1940	2021-01-14	{"4": "2"}	f	f
1941	2021-01-15	{"4": "2"}	f	f
1942	2021-01-16	{"4": "2"}	f	t
1943	2021-01-17	{"4": "2"}	f	t
1944	2021-01-18	{"4": "2"}	f	f
1945	2021-01-19	{"4": "2"}	f	f
1946	2021-01-20	{"4": "2"}	f	f
1947	2021-01-21	{"4": "2"}	f	f
1948	2021-01-22	{"4": "2"}	f	f
1949	2021-01-23	{"4": "2"}	f	t
1950	2021-01-24	{"4": "2"}	f	t
1951	2021-01-25	{"4": "2"}	f	f
1952	2021-01-26	{"4": "2"}	f	f
1953	2021-01-27	{"4": "2"}	f	f
1954	2021-01-28	{"4": "2"}	f	f
1955	2021-01-29	{"4": "2"}	f	f
1956	2021-01-30	{"4": "2"}	f	t
1957	2021-01-31	{"4": "2"}	f	t
1958	2021-02-01	{"4": "1"}	f	f
1959	2021-02-02	{"4": "1"}	f	f
1960	2021-02-03	{"4": "1"}	f	f
1961	2021-02-04	{"4": "1"}	f	f
1962	2021-02-05	{"4": "1"}	f	f
1963	2021-02-06	{"4": "1"}	f	t
1964	2021-02-07	{"4": "1"}	f	t
1965	2021-02-08	{"4": "1"}	f	f
1966	2021-02-09	{"4": "1"}	f	f
1967	2021-02-10	{"4": "1"}	f	f
1968	2021-02-11	{"4": "1"}	f	t
1969	2021-02-12	{"4": "0"}	f	t
1970	2021-02-13	{"4": "0"}	f	t
1971	2021-02-14	{"4": "0"}	f	t
1972	2021-02-15	{"4": "2"}	f	t
1973	2021-02-16	{"4": "2"}	f	t
1974	2021-02-17	{"4": "2"}	f	f
1975	2021-02-18	{"4": "2"}	f	f
1976	2021-02-19	{"4": "2"}	f	f
1977	2021-02-20	{"4": "2"}	f	t
1978	2021-02-21	{"4": "2"}	f	t
1979	2021-02-22	{"4": "2"}	f	f
1980	2021-02-23	{"4": "2"}	f	f
1981	2021-02-24	{"4": "2"}	f	f
1982	2021-02-25	{"4": "2"}	f	f
1983	2021-02-26	{"4": "2"}	f	f
1984	2021-02-27	{"4": "2"}	f	t
1985	2021-02-28	{"4": "2"}	f	t
1986	2021-03-01	{"4": "1"}	f	f
1987	2021-03-02	{"4": "1"}	f	f
1988	2021-03-03	{"4": "1"}	f	f
1989	2021-03-04	{"4": "1"}	f	f
1990	2021-03-05	{"4": "1"}	f	f
1991	2021-03-06	{"4": "2"}	f	t
1992	2021-03-07	{"4": "2"}	f	t
1993	2021-03-08	{"4": "1"}	f	f
1994	2021-03-09	{"4": "1"}	f	f
1995	2021-03-10	{"4": "1"}	f	f
1996	2021-03-11	{"4": "1"}	f	f
1997	2021-03-12	{"4": "1"}	f	f
1998	2021-03-13	{"4": "2"}	f	t
1999	2021-03-14	{"4": "2"}	f	t
2000	2021-03-15	{"4": "1"}	f	f
2001	2021-03-16	{"4": "1"}	f	f
2002	2021-03-17	{"4": "1"}	f	f
2003	2021-03-18	{"4": "1"}	f	f
2004	2021-03-19	{"4": "1"}	f	f
2005	2021-03-20	{"4": "2"}	f	t
2006	2021-03-21	{"4": "2"}	f	t
2007	2021-03-22	{"4": "1"}	f	f
2008	2021-03-23	{"4": "1"}	f	f
2009	2021-03-24	{"4": "1"}	f	f
2010	2021-03-25	{"4": "1"}	f	f
2011	2021-03-26	{"4": "1"}	f	f
2012	2021-03-27	{"4": "2"}	f	t
2013	2021-03-28	{"4": "2"}	f	t
2014	2021-03-29	{"4": "1"}	f	f
2015	2021-03-30	{"4": "1"}	f	f
2016	2021-03-31	{"4": "1"}	f	f
2017	2021-04-01	{"4": "1"}	f	f
2018	2021-04-02	{"4": "1"}	f	f
2019	2021-04-03	{"4": "1"}	f	t
2020	2021-04-04	{"4": "1"}	f	t
2021	2021-04-05	{"4": "1"}	f	f
2022	2021-04-06	{"4": "1"}	f	f
2023	2021-04-07	{"4": "1"}	f	f
2024	2021-04-08	{"4": "1"}	f	f
2025	2021-04-09	{"4": "1"}	f	f
2026	2021-04-10	{"4": "1"}	f	t
2027	2021-04-11	{"4": "1"}	f	t
2028	2021-04-12	{"4": "1"}	f	f
2029	2021-04-13	{"4": "1"}	f	f
2030	2021-04-14	{"4": "2"}	f	f
2031	2021-04-15	{"4": "2"}	f	f
2032	2021-04-16	{"4": "2"}	f	f
2033	2021-04-17	{"4": "2"}	f	t
2034	2021-04-18	{"4": "2"}	f	t
2035	2021-04-19	{"4": "2"}	f	f
2036	2021-04-20	{"4": "2"}	f	f
2037	2021-04-21	{"4": "2"}	f	f
2038	2021-04-22	{"4": "2"}	f	f
2039	2021-04-23	{"4": "2"}	f	f
2040	2021-04-24	{"4": "2"}	f	t
2041	2021-04-25	{"4": "2"}	f	t
2042	2021-04-26	{"4": "2"}	f	f
2043	2021-04-27	{"4": "2"}	f	f
2044	2021-04-28	{"4": "2"}	f	f
2045	2021-04-29	{"4": "2"}	f	f
2046	2021-04-30	{"4": "2"}	f	f
2047	2021-05-01	{"4": "2"}	f	t
2048	2021-05-02	{"4": "2"}	f	t
2049	2021-05-03	{"4": "1"}	f	f
2050	2021-05-04	{"4": "1"}	f	f
2051	2021-05-05	{"4": "1"}	f	f
2052	2021-05-06	{"4": "1"}	f	f
2053	2021-05-07	{"4": "1"}	f	f
2054	2021-05-08	{"4": "2"}	f	t
2055	2021-05-09	{"4": "2"}	f	t
2056	2021-05-10	{"4": "1"}	f	f
2057	2021-05-11	{"4": "1"}	f	f
2058	2021-05-12	{"4": "1"}	f	f
2059	2021-05-13	{"4": "1"}	f	f
2060	2021-05-14	{"4": "1"}	f	f
2061	2021-05-15	{"4": "2"}	f	t
2062	2021-05-16	{"4": "2"}	f	t
2063	2021-05-17	{"4": "1"}	f	f
2064	2021-05-18	{"4": "1"}	f	f
2065	2021-05-19	{"4": "1"}	f	f
2066	2021-05-20	{"4": "1"}	f	f
2067	2021-05-21	{"4": "1"}	f	f
2068	2021-05-22	{"4": "2"}	f	t
2069	2021-05-23	{"4": "2"}	f	t
2070	2021-05-24	{"4": "1"}	f	f
2071	2021-05-25	{"4": "1"}	f	f
2072	2021-05-26	{"4": "1"}	f	f
2073	2021-05-27	{"4": "1"}	f	f
2074	2021-05-28	{"4": "1"}	f	f
2075	2021-05-29	{"4": "2"}	f	t
2076	2021-05-30	{"4": "2"}	f	t
2077	2021-05-31	{"4": "1"}	f	f
2078	2021-06-01	{"4": "1"}	f	f
2079	2021-06-02	{"4": "1"}	f	f
2080	2021-06-03	{"4": "1"}	f	f
2081	2022-01-01	{"4": "2"}	f	f
2082	2022-01-02	{"4": "2"}	f	f
2083	2022-01-03	{"4": "1"}	f	f
2084	2022-01-04	{"4": "1"}	f	f
2085	2022-01-05	{"4": "1"}	f	f
2086	2022-01-06	{"4": "1"}	f	f
2087	2022-01-07	{"4": "1"}	f	f
2088	2022-01-08	{"4": "2"}	f	f
2089	2022-01-09	{"4": "2"}	f	f
2090	2022-01-10	{"4": "1"}	f	f
2091	2022-01-11	{"4": "1"}	f	f
2092	2022-01-12	{"4": "1"}	f	f
2093	2022-01-13	{"4": "1"}	f	f
2094	2022-01-14	{"4": "1"}	f	f
2095	2022-01-15	{"4": "2"}	f	f
2096	2022-01-16	{"4": "2"}	f	f
2097	2022-01-17	{"4": "1"}	f	f
2098	2022-01-18	{"4": "1"}	f	f
2099	2022-01-19	{"4": "1"}	f	f
2100	2022-01-20	{"4": "1"}	f	f
2101	2022-01-21	{"4": "1"}	f	f
2102	2022-01-22	{"4": "2"}	f	f
2103	2022-01-23	{"4": "2"}	f	f
2104	2022-01-24	{"4": "1"}	f	f
2105	2022-01-25	{"4": "1"}	f	f
2106	2022-01-26	{"4": "1"}	f	f
2107	2022-01-27	{"4": "1"}	f	f
2108	2022-01-28	{"4": "1"}	f	f
2109	2022-01-29	{"4": "2"}	f	f
2110	2022-01-30	{"4": "2"}	f	f
2111	2022-01-31	{"4": "1"}	f	f
2112	2022-02-01	{"4": "1"}	f	f
2113	2022-02-02	{"4": "1"}	f	f
2114	2022-02-03	{"4": "1"}	f	f
2115	2022-02-04	{"4": "1"}	f	f
2116	2022-02-05	{"4": "2"}	f	f
2117	2022-02-06	{"4": "2"}	f	f
2118	2022-02-07	{"4": "1"}	f	f
2119	2022-02-08	{"4": "1"}	f	f
2120	2022-02-09	{"4": "1"}	f	f
2121	2022-02-10	{"4": "1"}	f	f
2122	2022-02-11	{"4": "1"}	f	f
2123	2022-02-12	{"4": "2"}	f	f
2124	2022-02-13	{"4": "2"}	f	f
2125	2022-02-14	{"4": "1"}	f	f
2126	2022-02-15	{"4": "1"}	f	f
2127	2022-02-16	{"4": "1"}	f	f
2128	2022-02-17	{"4": "1"}	f	f
2129	2022-02-18	{"4": "1"}	f	f
2130	2022-02-19	{"4": "2"}	f	f
2131	2022-02-20	{"4": "2"}	f	f
2132	2022-02-21	{"4": "1"}	f	f
2133	2022-02-22	{"4": "1"}	f	f
2134	2022-02-23	{"4": "1"}	f	f
2135	2022-02-24	{"4": "1"}	f	f
2136	2022-02-25	{"4": "1"}	f	f
2137	2022-02-26	{"4": "2"}	f	f
2138	2022-02-27	{"4": "2"}	f	f
2139	2022-02-28	{"4": "1"}	f	f
2140	2022-03-01	{"4": "1"}	f	f
2141	2022-03-02	{"4": "1"}	f	f
2142	2022-03-03	{"4": "1"}	f	f
2143	2022-03-04	{"4": "1"}	f	f
2144	2022-03-05	{"4": "2"}	f	f
2145	2022-03-06	{"4": "2"}	f	f
2146	2022-03-07	{"4": "1"}	f	f
2147	2022-03-08	{"4": "1"}	f	f
2148	2022-03-09	{"4": "1"}	f	f
2149	2022-03-10	{"4": "1"}	f	f
2150	2022-03-11	{"4": "1"}	f	f
2151	2022-03-12	{"4": "2"}	f	f
2152	2022-03-13	{"4": "2"}	f	f
2153	2022-03-14	{"4": "1"}	f	f
2154	2022-03-15	{"4": "1"}	f	f
2155	2022-03-16	{"4": "1"}	f	f
2156	2022-03-17	{"4": "1"}	f	f
2157	2022-03-18	{"4": "1"}	f	f
2158	2022-03-19	{"4": "2"}	f	f
2159	2022-03-20	{"4": "2"}	f	f
2160	2022-03-21	{"4": "1"}	f	f
2161	2022-03-22	{"4": "1"}	f	f
2162	2022-03-23	{"4": "1"}	f	f
2163	2022-03-24	{"4": "1"}	f	f
2164	2022-03-25	{"4": "1"}	f	f
2165	2022-03-26	{"4": "2"}	f	f
2166	2022-03-27	{"4": "2"}	f	f
2167	2022-03-28	{"4": "1"}	f	f
2168	2022-03-29	{"4": "1"}	f	f
2169	2022-03-30	{"4": "1"}	f	f
2170	2022-03-31	{"4": "1"}	f	f
2171	2022-04-01	{"4": "1"}	f	f
2172	2022-04-02	{"4": "2"}	f	f
2173	2022-04-03	{"4": "2"}	f	f
2174	2022-04-04	{"4": "1"}	f	f
2175	2022-04-05	{"4": "1"}	f	f
2176	2022-04-06	{"4": "1"}	f	f
2177	2022-04-07	{"4": "1"}	f	f
2178	2022-04-08	{"4": "1"}	f	f
2179	2022-04-09	{"4": "2"}	f	f
2180	2022-04-10	{"4": "2"}	f	f
2181	2022-04-11	{"4": "1"}	f	f
2182	2022-04-12	{"4": "1"}	f	f
2183	2022-04-13	{"4": "1"}	f	f
2184	2022-04-14	{"4": "1"}	f	f
2185	2022-04-15	{"4": "1"}	f	f
2186	2022-04-16	{"4": "2"}	f	f
2187	2022-04-17	{"4": "2"}	f	f
2188	2022-04-18	{"4": "1"}	f	f
2189	2022-04-19	{"4": "1"}	f	f
2190	2022-04-20	{"4": "1"}	f	f
2191	2022-04-21	{"4": "1"}	f	f
2192	2022-04-22	{"4": "1"}	f	f
2193	2022-04-23	{"4": "2"}	f	f
2194	2022-04-24	{"4": "2"}	f	f
2195	2022-04-25	{"4": "1"}	f	f
2196	2022-04-26	{"4": "1"}	f	f
2197	2022-04-27	{"4": "1"}	f	f
2198	2022-04-28	{"4": "1"}	f	f
2199	2022-04-29	{"4": "1"}	f	f
2200	2022-04-30	{"4": "2"}	f	f
2201	2022-05-01	{"4": "2"}	f	f
2202	2022-05-02	{"4": "1"}	f	f
2203	2022-05-03	{"4": "1"}	f	f
2204	2022-05-04	{"4": "1"}	f	f
2205	2022-05-05	{"4": "1"}	f	f
2206	2022-05-06	{"4": "1"}	f	f
2207	2022-05-07	{"4": "2"}	f	f
2208	2022-05-08	{"4": "2"}	f	f
2209	2022-05-09	{"4": "1"}	f	f
2210	2022-05-10	{"4": "1"}	f	f
2211	2022-05-11	{"4": "1"}	f	f
2212	2022-05-12	{"4": "1"}	f	f
2213	2022-05-13	{"4": "1"}	f	f
2214	2022-05-14	{"4": "2"}	f	f
2215	2022-05-15	{"4": "2"}	f	f
2216	2022-05-16	{"4": "1"}	f	f
2217	2022-05-17	{"4": "1"}	f	f
2218	2022-05-18	{"4": "1"}	f	f
2219	2022-05-19	{"4": "1"}	f	f
2220	2022-05-20	{"4": "1"}	f	f
2221	2022-05-21	{"4": "2"}	f	f
2222	2022-05-22	{"4": "2"}	f	f
2223	2022-05-23	{"4": "1"}	f	f
2224	2022-05-24	{"4": "1"}	f	f
2225	2022-05-25	{"4": "1"}	f	f
2226	2022-05-26	{"4": "1"}	f	f
2227	2022-05-27	{"4": "1"}	f	f
2228	2022-05-28	{"4": "2"}	f	f
2229	2022-05-29	{"4": "2"}	f	f
2230	2022-05-30	{"4": "1"}	f	f
2231	2022-05-31	{"4": "1"}	f	f
2232	2022-06-01	{"4": "1"}	f	f
2233	2022-06-02	{"4": "1"}	f	f
2234	2022-06-03	{"4": "1"}	f	f
2235	2022-06-04	{"4": "2"}	f	f
2236	2022-06-05	{"4": "2"}	f	f
2237	2022-06-06	{"4": "1"}	f	f
2238	2022-06-07	{"4": "1"}	f	f
2239	2022-06-08	{"4": "1"}	f	f
2240	2022-06-09	{"4": "1"}	f	f
2241	2022-06-10	{"4": "1"}	f	f
2242	2022-06-11	{"4": "2"}	f	f
2243	2022-06-12	{"4": "2"}	f	f
2244	2022-06-13	{"4": "1"}	f	f
2245	2022-06-14	{"4": "1"}	f	f
2246	2022-06-15	{"4": "1"}	f	f
2247	2022-06-16	{"4": "1"}	f	f
2248	2022-06-17	{"4": "1"}	f	f
2249	2022-06-18	{"4": "2"}	f	f
2250	2022-06-19	{"4": "2"}	f	f
2251	2022-06-20	{"4": "1"}	f	f
2252	2022-06-21	{"4": "1"}	f	f
2253	2022-06-22	{"4": "1"}	f	f
2254	2022-06-23	{"4": "1"}	f	f
2255	2022-06-24	{"4": "1"}	f	f
2256	2022-06-25	{"4": "2"}	f	f
2257	2022-06-26	{"4": "2"}	f	f
2258	2022-06-27	{"4": "1"}	f	f
2259	2022-06-28	{"4": "1"}	f	f
2260	2022-06-29	{"4": "1"}	f	f
2261	2022-06-30	{"4": "1"}	f	f
2262	2022-07-01	{"4": "1"}	f	f
2263	2022-07-02	{"4": "2"}	f	f
2264	2022-07-03	{"4": "2"}	f	f
2265	2022-07-04	{"4": "1"}	f	f
2266	2022-07-05	{"4": "1"}	f	f
2267	2022-07-06	{"4": "1"}	f	f
2268	2022-07-07	{"4": "1"}	f	f
2269	2022-07-08	{"4": "1"}	f	f
2270	2022-07-09	{"4": "2"}	f	f
2271	2022-07-10	{"4": "2"}	f	f
2272	2022-07-11	{"4": "1"}	f	f
2273	2022-07-12	{"4": "1"}	f	f
2274	2022-07-13	{"4": "1"}	f	f
2275	2022-07-14	{"4": "1"}	f	f
2276	2022-07-15	{"4": "1"}	f	f
2277	2022-07-16	{"4": "2"}	f	f
2278	2022-07-17	{"4": "2"}	f	f
2279	2022-07-18	{"4": "1"}	f	f
2280	2022-07-19	{"4": "1"}	f	f
2281	2022-07-20	{"4": "1"}	f	f
2282	2022-07-21	{"4": "1"}	f	f
2283	2022-07-22	{"4": "1"}	f	f
2284	2022-07-23	{"4": "2"}	f	f
2285	2022-07-24	{"4": "2"}	f	f
2286	2022-07-25	{"4": "1"}	f	f
2287	2022-07-26	{"4": "1"}	f	f
2288	2022-07-27	{"4": "1"}	f	f
2289	2022-07-28	{"4": "1"}	f	f
2290	2022-07-29	{"4": "1"}	f	f
2291	2022-07-30	{"4": "2"}	f	f
2292	2022-07-31	{"4": "2"}	f	f
2293	2022-08-01	{"4": "1"}	f	f
2294	2022-08-02	{"4": "1"}	f	f
2295	2022-08-03	{"4": "1"}	f	f
2296	2022-08-04	{"4": "1"}	f	f
2297	2022-08-05	{"4": "1"}	f	f
2298	2022-08-06	{"4": "2"}	f	f
2299	2022-08-07	{"4": "2"}	f	f
2300	2022-08-08	{"4": "1"}	f	f
2301	2022-08-09	{"4": "1"}	f	f
2302	2022-08-10	{"4": "1"}	f	f
2303	2022-08-11	{"4": "1"}	f	f
2304	2022-08-12	{"4": "1"}	f	f
2305	2022-08-13	{"4": "2"}	f	f
2306	2022-08-14	{"4": "2"}	f	f
2307	2022-08-15	{"4": "1"}	f	f
2308	2022-08-16	{"4": "1"}	f	f
2309	2022-08-17	{"4": "1"}	f	f
2310	2022-08-18	{"4": "1"}	f	f
2311	2022-08-19	{"4": "1"}	f	f
2312	2022-08-20	{"4": "2"}	f	f
2313	2022-08-21	{"4": "2"}	f	f
2314	2022-08-22	{"4": "1"}	f	f
2315	2022-08-23	{"4": "1"}	f	f
2316	2022-08-24	{"4": "1"}	f	f
2317	2022-08-25	{"4": "1"}	f	f
2318	2022-08-26	{"4": "1"}	f	f
2319	2022-08-27	{"4": "2"}	f	f
2320	2022-08-28	{"4": "2"}	f	f
2321	2022-08-29	{"4": "1"}	f	f
2322	2022-08-30	{"4": "1"}	f	f
2323	2022-08-31	{"4": "1"}	f	f
2324	2022-09-01	{"4": "1"}	f	f
2325	2022-09-02	{"4": "1"}	f	f
2326	2022-09-03	{"4": "2"}	f	f
2327	2022-09-04	{"4": "2"}	f	f
2328	2022-09-05	{"4": "1"}	f	f
2329	2022-09-06	{"4": "1"}	f	f
2330	2022-09-07	{"4": "1"}	f	f
2331	2022-09-08	{"4": "1"}	f	f
2332	2022-09-09	{"4": "1"}	f	f
2333	2022-09-10	{"4": "2"}	f	f
2334	2022-09-11	{"4": "2"}	f	f
2335	2022-09-12	{"4": "1"}	f	f
2336	2022-09-13	{"4": "1"}	f	f
2337	2022-09-14	{"4": "1"}	f	f
2338	2022-09-15	{"4": "1"}	f	f
2339	2022-09-16	{"4": "1"}	f	f
2340	2022-09-17	{"4": "2"}	f	f
2341	2022-09-18	{"4": "2"}	f	f
2342	2022-09-19	{"4": "1"}	f	f
2343	2022-09-20	{"4": "1"}	f	f
2344	2022-09-21	{"4": "1"}	f	f
2345	2022-09-22	{"4": "1"}	f	f
2346	2022-09-23	{"4": "1"}	f	f
2347	2022-09-24	{"4": "2"}	f	f
2348	2022-09-25	{"4": "2"}	f	f
2349	2022-09-26	{"4": "1"}	f	f
2350	2022-09-27	{"4": "1"}	f	f
2351	2022-09-28	{"4": "1"}	f	f
2352	2022-09-29	{"4": "1"}	f	f
2353	2022-09-30	{"4": "1"}	f	f
2354	2022-10-01	{"4": "2"}	f	f
2355	2022-10-02	{"4": "2"}	f	f
2356	2022-10-03	{"4": "1"}	f	f
2357	2022-10-04	{"4": "1"}	f	f
2358	2022-10-05	{"4": "1"}	f	f
2359	2022-10-06	{"4": "1"}	f	f
2360	2022-10-07	{"4": "1"}	f	f
2361	2022-10-08	{"4": "2"}	f	f
2362	2022-10-09	{"4": "2"}	f	f
2363	2022-10-10	{"4": "1"}	f	f
2364	2022-10-11	{"4": "1"}	f	f
2365	2022-10-12	{"4": "1"}	f	f
2366	2022-10-13	{"4": "1"}	f	f
2367	2022-10-14	{"4": "1"}	f	f
2368	2022-10-15	{"4": "2"}	f	f
2369	2022-10-16	{"4": "2"}	f	f
2370	2022-10-17	{"4": "1"}	f	f
2371	2022-10-18	{"4": "1"}	f	f
2372	2022-10-19	{"4": "1"}	f	f
2373	2022-10-20	{"4": "1"}	f	f
2374	2022-10-21	{"4": "1"}	f	f
2375	2022-10-22	{"4": "2"}	f	f
2376	2022-10-23	{"4": "2"}	f	f
2377	2022-10-24	{"4": "1"}	f	f
2378	2022-10-25	{"4": "1"}	f	f
2379	2022-10-26	{"4": "1"}	f	f
2380	2022-10-27	{"4": "1"}	f	f
2381	2022-10-28	{"4": "1"}	f	f
2382	2022-10-29	{"4": "2"}	f	f
2383	2022-10-30	{"4": "2"}	f	f
2384	2022-10-31	{"4": "1"}	f	f
2385	2022-11-01	{"4": "1"}	f	f
2386	2022-11-02	{"4": "1"}	f	f
2387	2022-11-03	{"4": "1"}	f	f
2388	2022-11-04	{"4": "1"}	f	f
2389	2022-11-05	{"4": "2"}	f	f
2390	2022-11-06	{"4": "2"}	f	f
2391	2022-11-07	{"4": "1"}	f	f
2392	2022-11-08	{"4": "1"}	f	f
2393	2022-11-09	{"4": "1"}	f	f
2394	2022-11-10	{"4": "1"}	f	f
2395	2022-11-11	{"4": "1"}	f	f
2396	2022-11-12	{"4": "2"}	f	f
2397	2022-11-13	{"4": "2"}	f	f
2398	2022-11-14	{"4": "1"}	f	f
2399	2022-11-15	{"4": "1"}	f	f
2400	2022-11-16	{"4": "1"}	f	f
2401	2022-11-17	{"4": "1"}	f	f
2402	2022-11-18	{"4": "1"}	f	f
2403	2022-11-19	{"4": "2"}	f	f
2404	2022-11-20	{"4": "2"}	f	f
2405	2022-11-21	{"4": "1"}	f	f
2406	2022-11-22	{"4": "1"}	f	f
2407	2022-11-23	{"4": "1"}	f	f
2408	2022-11-24	{"4": "1"}	f	f
2409	2022-11-25	{"4": "1"}	f	f
2410	2022-11-26	{"4": "2"}	f	f
2411	2022-11-27	{"4": "2"}	f	f
2412	2022-11-28	{"4": "1"}	f	f
2413	2022-11-29	{"4": "1"}	f	f
2414	2022-11-30	{"4": "1"}	f	f
2415	2022-12-01	{"4": "1"}	f	f
2416	2022-12-02	{"4": "1"}	f	f
2417	2022-12-03	{"4": "2"}	f	f
2418	2022-12-04	{"4": "2"}	f	f
2419	2022-12-05	{"4": "1"}	f	f
2420	2022-12-06	{"4": "1"}	f	f
2421	2022-12-07	{"4": "1"}	f	f
2422	2022-12-08	{"4": "1"}	f	f
2423	2022-12-09	{"4": "1"}	f	f
2424	2022-12-10	{"4": "2"}	f	f
2425	2022-12-11	{"4": "2"}	f	f
2426	2022-12-12	{"4": "1"}	f	f
2427	2022-12-13	{"4": "1"}	f	f
2428	2022-12-14	{"4": "1"}	f	f
2429	2022-12-15	{"4": "1"}	f	f
2430	2022-12-16	{"4": "1"}	f	f
2431	2022-12-17	{"4": "2"}	f	f
2432	2022-12-18	{"4": "2"}	f	f
2433	2022-12-19	{"4": "1"}	f	f
2434	2022-12-20	{"4": "1"}	f	f
2435	2022-12-21	{"4": "1"}	f	f
2436	2022-12-22	{"4": "1"}	f	f
2437	2022-12-23	{"4": "1"}	f	f
2438	2022-12-24	{"4": "2"}	f	f
2439	2022-12-25	{"4": "2"}	f	f
2440	2022-12-26	{"4": "1"}	f	f
2441	2022-12-27	{"4": "1"}	f	f
2442	2022-12-28	{"4": "1"}	f	f
2443	2022-12-29	{"4": "1"}	f	f
2444	2022-12-30	{"4": "1"}	f	f
2445	2022-12-31	{"4": "2"}	f	f
2446	2023-01-01	{"4": "2"}	f	f
2447	2023-01-02	{"4": "1"}	f	f
2448	2023-01-03	{"4": "1"}	f	f
2449	2023-01-04	{"4": "1"}	f	f
2450	2023-01-05	{"4": "1"}	f	f
2451	2023-01-06	{"4": "1"}	f	f
2452	2023-01-07	{"4": "2"}	f	f
2453	2023-01-08	{"4": "2"}	f	f
2454	2023-01-09	{"4": "1"}	f	f
2455	2023-01-10	{"4": "1"}	f	f
2456	2023-01-11	{"4": "1"}	f	f
2457	2023-01-12	{"4": "1"}	f	f
2458	2023-01-13	{"4": "1"}	f	f
2459	2023-01-14	{"4": "2"}	f	f
2460	2023-01-15	{"4": "2"}	f	f
2461	2023-01-16	{"4": "1"}	f	f
2462	2023-01-17	{"4": "1"}	f	f
2463	2023-01-18	{"4": "1"}	f	f
2464	2023-01-19	{"4": "1"}	f	f
2465	2023-01-20	{"4": "1"}	f	f
2466	2023-01-21	{"4": "2"}	f	f
2467	2023-01-22	{"4": "2"}	f	f
2468	2023-01-23	{"4": "1"}	f	f
2469	2023-01-24	{"4": "1"}	f	f
2470	2023-01-25	{"4": "1"}	f	f
2471	2023-01-26	{"4": "1"}	f	f
2472	2023-01-27	{"4": "1"}	f	f
2473	2023-01-28	{"4": "2"}	f	f
2474	2023-01-29	{"4": "2"}	f	f
2475	2023-01-30	{"4": "1"}	f	f
2476	2023-01-31	{"4": "1"}	f	f
2477	2023-02-01	{"4": "1"}	f	f
2478	2023-02-02	{"4": "1"}	f	f
2479	2023-02-03	{"4": "1"}	f	f
2480	2023-02-04	{"4": "2"}	f	f
2481	2023-02-05	{"4": "2"}	f	f
2482	2023-02-06	{"4": "1"}	f	f
2483	2023-02-07	{"4": "1"}	f	f
2484	2023-02-08	{"4": "1"}	f	f
2485	2023-02-09	{"4": "1"}	f	f
2486	2023-02-10	{"4": "1"}	f	f
2487	2023-02-11	{"4": "2"}	f	f
2488	2023-02-12	{"4": "2"}	f	f
2489	2023-02-13	{"4": "1"}	f	f
2490	2023-02-14	{"4": "1"}	f	f
2491	2023-02-15	{"4": "1"}	f	f
2492	2023-02-16	{"4": "1"}	f	f
2493	2023-02-17	{"4": "1"}	f	f
2494	2023-02-18	{"4": "2"}	f	f
2495	2023-02-19	{"4": "2"}	f	f
2496	2023-02-20	{"4": "1"}	f	f
2497	2023-02-21	{"4": "1"}	f	f
2498	2023-02-22	{"4": "1"}	f	f
2499	2023-02-23	{"4": "1"}	f	f
2500	2023-02-24	{"4": "1"}	f	f
2501	2023-02-25	{"4": "2"}	f	f
2502	2023-02-26	{"4": "2"}	f	f
2503	2023-02-27	{"4": "1"}	f	f
2504	2023-02-28	{"4": "1"}	f	f
2505	2023-03-01	{"4": "1"}	f	f
2506	2023-03-02	{"4": "1"}	f	f
2507	2023-03-03	{"4": "1"}	f	f
2508	2023-03-04	{"4": "2"}	f	f
2509	2023-03-05	{"4": "2"}	f	f
2510	2023-03-06	{"4": "1"}	f	f
2511	2023-03-07	{"4": "1"}	f	f
2512	2023-03-08	{"4": "1"}	f	f
2513	2023-03-09	{"4": "1"}	f	f
2514	2023-03-10	{"4": "1"}	f	f
2515	2023-03-11	{"4": "2"}	f	f
2516	2023-03-12	{"4": "2"}	f	f
2517	2023-03-13	{"4": "1"}	f	f
2518	2023-03-14	{"4": "1"}	f	f
2519	2023-03-15	{"4": "1"}	f	f
2520	2023-03-16	{"4": "1"}	f	f
2521	2023-03-17	{"4": "1"}	f	f
2522	2023-03-18	{"4": "2"}	f	f
2523	2023-03-19	{"4": "2"}	f	f
2524	2023-03-20	{"4": "1"}	f	f
2525	2023-03-21	{"4": "1"}	f	f
2526	2023-03-22	{"4": "1"}	f	f
2527	2023-03-23	{"4": "1"}	f	f
2528	2023-03-24	{"4": "1"}	f	f
2529	2023-03-25	{"4": "2"}	f	f
2530	2023-03-26	{"4": "2"}	f	f
2531	2023-03-27	{"4": "1"}	f	f
2532	2023-03-28	{"4": "1"}	f	f
2533	2023-03-29	{"4": "1"}	f	f
2534	2023-03-30	{"4": "1"}	f	f
2535	2023-03-31	{"4": "1"}	f	f
2536	2023-04-01	{"4": "2"}	f	f
2537	2023-04-02	{"4": "2"}	f	f
2538	2023-04-03	{"4": "1"}	f	f
2539	2023-04-04	{"4": "1"}	f	f
2540	2023-04-05	{"4": "1"}	f	f
2541	2023-04-06	{"4": "1"}	f	f
2542	2023-04-07	{"4": "1"}	f	f
2543	2023-04-08	{"4": "2"}	f	f
2544	2023-04-09	{"4": "2"}	f	f
2545	2023-04-10	{"4": "1"}	f	f
2546	2023-04-11	{"4": "1"}	f	f
2547	2023-04-12	{"4": "1"}	f	f
2548	2023-04-13	{"4": "1"}	f	f
2549	2023-04-14	{"4": "1"}	f	f
2550	2023-04-15	{"4": "2"}	f	f
2551	2023-04-16	{"4": "2"}	f	f
2552	2023-04-17	{"4": "1"}	f	f
2553	2023-04-18	{"4": "1"}	f	f
2554	2023-04-19	{"4": "1"}	f	f
2555	2023-04-20	{"4": "1"}	f	f
2556	2023-04-21	{"4": "1"}	f	f
2557	2023-04-22	{"4": "2"}	f	f
2558	2023-04-23	{"4": "2"}	f	f
2559	2023-04-24	{"4": "1"}	f	f
2560	2023-04-25	{"4": "1"}	f	f
2561	2023-04-26	{"4": "1"}	f	f
2562	2023-04-27	{"4": "1"}	f	f
2563	2023-04-28	{"4": "1"}	f	f
2564	2023-04-29	{"4": "2"}	f	f
2565	2023-04-30	{"4": "2"}	f	f
2566	2023-05-01	{"4": "1"}	f	f
2567	2023-05-02	{"4": "1"}	f	f
2568	2023-05-03	{"4": "1"}	f	f
2569	2023-05-04	{"4": "1"}	f	f
2570	2023-05-05	{"4": "1"}	f	f
2571	2023-05-06	{"4": "2"}	f	f
2572	2023-05-07	{"4": "2"}	f	f
2573	2023-05-08	{"4": "1"}	f	f
2574	2023-05-09	{"4": "1"}	f	f
2575	2023-05-10	{"4": "1"}	f	f
2576	2023-05-11	{"4": "1"}	f	f
2577	2023-05-12	{"4": "1"}	f	f
2578	2023-05-13	{"4": "2"}	f	f
2579	2023-05-14	{"4": "2"}	f	f
2580	2023-05-15	{"4": "1"}	f	f
2581	2023-05-16	{"4": "1"}	f	f
2582	2023-05-17	{"4": "1"}	f	f
2583	2023-05-18	{"4": "1"}	f	f
2584	2023-05-19	{"4": "1"}	f	f
2585	2023-05-20	{"4": "2"}	f	f
2586	2023-05-21	{"4": "2"}	f	f
2587	2023-05-22	{"4": "1"}	f	f
2588	2023-05-23	{"4": "1"}	f	f
2589	2023-05-24	{"4": "1"}	f	f
2590	2023-05-25	{"4": "1"}	f	f
2591	2023-05-26	{"4": "1"}	f	f
2592	2023-05-27	{"4": "2"}	f	f
2593	2023-05-28	{"4": "2"}	f	f
2594	2023-05-29	{"4": "1"}	f	f
2595	2023-05-30	{"4": "1"}	f	f
2596	2023-05-31	{"4": "1"}	f	f
2597	2023-06-01	{"4": "1"}	f	f
2598	2023-06-02	{"4": "1"}	f	f
2599	2023-06-03	{"4": "2"}	f	f
2600	2023-06-04	{"4": "2"}	f	f
2601	2023-06-05	{"4": "1"}	f	f
2602	2023-06-06	{"4": "1"}	f	f
2603	2023-06-07	{"4": "1"}	f	f
2604	2023-06-08	{"4": "1"}	f	f
2605	2023-06-09	{"4": "1"}	f	f
2606	2023-06-10	{"4": "2"}	f	f
2607	2023-06-11	{"4": "2"}	f	f
2608	2023-06-12	{"4": "1"}	f	f
2609	2023-06-13	{"4": "1"}	f	f
2610	2023-06-14	{"4": "1"}	f	f
2611	2023-06-15	{"4": "1"}	f	f
2612	2023-06-16	{"4": "1"}	f	f
2613	2023-06-17	{"4": "2"}	f	f
2614	2023-06-18	{"4": "2"}	f	f
2615	2023-06-19	{"4": "1"}	f	f
2616	2023-06-20	{"4": "1"}	f	f
2617	2023-06-21	{"4": "1"}	f	f
2618	2023-06-22	{"4": "1"}	f	f
2619	2023-06-23	{"4": "1"}	f	f
2620	2023-06-24	{"4": "2"}	f	f
2621	2023-06-25	{"4": "2"}	f	f
2622	2023-06-26	{"4": "1"}	f	f
2623	2023-06-27	{"4": "1"}	f	f
2624	2023-06-28	{"4": "1"}	f	f
2625	2023-06-29	{"4": "1"}	f	f
2626	2023-06-30	{"4": "1"}	f	f
2627	2023-07-01	{"4": "2"}	f	f
2628	2023-07-02	{"4": "2"}	f	f
2629	2023-07-03	{"4": "1"}	f	f
2630	2023-07-04	{"4": "1"}	f	f
2631	2023-07-05	{"4": "1"}	f	f
2632	2023-07-06	{"4": "1"}	f	f
2633	2023-07-07	{"4": "1"}	f	f
2634	2023-07-08	{"4": "2"}	f	f
2635	2023-07-09	{"4": "2"}	f	f
2636	2023-07-10	{"4": "1"}	f	f
2637	2023-07-11	{"4": "1"}	f	f
2638	2023-07-12	{"4": "1"}	f	f
2639	2023-07-13	{"4": "1"}	f	f
2640	2023-07-14	{"4": "1"}	f	f
2641	2023-07-15	{"4": "2"}	f	f
2642	2023-07-16	{"4": "2"}	f	f
2643	2023-07-17	{"4": "1"}	f	f
2644	2023-07-18	{"4": "1"}	f	f
2645	2023-07-19	{"4": "1"}	f	f
2646	2023-07-20	{"4": "1"}	f	f
2647	2023-07-21	{"4": "1"}	f	f
2648	2023-07-22	{"4": "2"}	f	f
2649	2023-07-23	{"4": "2"}	f	f
2650	2023-07-24	{"4": "1"}	f	f
2651	2023-07-25	{"4": "1"}	f	f
2652	2023-07-26	{"4": "1"}	f	f
2653	2023-07-27	{"4": "1"}	f	f
2654	2023-07-28	{"4": "1"}	f	f
2655	2023-07-29	{"4": "2"}	f	f
2656	2023-07-30	{"4": "2"}	f	f
2657	2023-07-31	{"4": "1"}	f	f
2658	2023-08-01	{"4": "1"}	f	f
2659	2023-08-02	{"4": "1"}	f	f
2660	2023-08-03	{"4": "1"}	f	f
2661	2023-08-04	{"4": "1"}	f	f
2662	2023-08-05	{"4": "2"}	f	f
2663	2023-08-06	{"4": "2"}	f	f
2664	2023-08-07	{"4": "1"}	f	f
2665	2023-08-08	{"4": "1"}	f	f
2666	2023-08-09	{"4": "1"}	f	f
2667	2023-08-10	{"4": "1"}	f	f
2668	2023-08-11	{"4": "1"}	f	f
2669	2023-08-12	{"4": "2"}	f	f
2670	2023-08-13	{"4": "2"}	f	f
2671	2023-08-14	{"4": "1"}	f	f
2672	2023-08-15	{"4": "1"}	f	f
2673	2023-08-16	{"4": "1"}	f	f
2674	2023-08-17	{"4": "1"}	f	f
2675	2023-08-18	{"4": "1"}	f	f
2676	2023-08-19	{"4": "2"}	f	f
2677	2023-08-20	{"4": "2"}	f	f
2678	2023-08-21	{"4": "1"}	f	f
2679	2023-08-22	{"4": "1"}	f	f
2680	2023-08-23	{"4": "1"}	f	f
2681	2023-08-24	{"4": "1"}	f	f
2682	2023-08-25	{"4": "1"}	f	f
2683	2023-08-26	{"4": "2"}	f	f
2684	2023-08-27	{"4": "2"}	f	f
2685	2023-08-28	{"4": "1"}	f	f
2686	2023-08-29	{"4": "1"}	f	f
2687	2023-08-30	{"4": "1"}	f	f
2688	2023-08-31	{"4": "1"}	f	f
2689	2023-09-01	{"4": "1"}	f	f
2690	2023-09-02	{"4": "2"}	f	f
2691	2023-09-03	{"4": "2"}	f	f
2692	2023-09-04	{"4": "1"}	f	f
2693	2023-09-05	{"4": "1"}	f	f
2694	2023-09-06	{"4": "1"}	f	f
2695	2023-09-07	{"4": "1"}	f	f
2696	2023-09-08	{"4": "1"}	f	f
2697	2023-09-09	{"4": "2"}	f	f
2698	2023-09-10	{"4": "2"}	f	f
2699	2023-09-11	{"4": "1"}	f	f
2700	2023-09-12	{"4": "1"}	f	f
2701	2023-09-13	{"4": "1"}	f	f
2702	2023-09-14	{"4": "1"}	f	f
2703	2023-09-15	{"4": "1"}	f	f
2704	2023-09-16	{"4": "2"}	f	f
2705	2023-09-17	{"4": "2"}	f	f
2706	2023-09-18	{"4": "1"}	f	f
2707	2023-09-19	{"4": "1"}	f	f
2708	2023-09-20	{"4": "1"}	f	f
2709	2023-09-21	{"4": "1"}	f	f
2710	2023-09-22	{"4": "1"}	f	f
2711	2023-09-23	{"4": "2"}	f	f
2712	2023-09-24	{"4": "2"}	f	f
2713	2023-09-25	{"4": "1"}	f	f
2714	2023-09-26	{"4": "1"}	f	f
2715	2023-09-27	{"4": "1"}	f	f
2716	2023-09-28	{"4": "1"}	f	f
2717	2023-09-29	{"4": "1"}	f	f
2718	2023-09-30	{"4": "2"}	f	f
2719	2023-10-01	{"4": "2"}	f	f
2720	2023-10-02	{"4": "1"}	f	f
2721	2023-10-03	{"4": "1"}	f	f
2722	2023-10-04	{"4": "1"}	f	f
2723	2023-10-05	{"4": "1"}	f	f
2724	2023-10-06	{"4": "1"}	f	f
2725	2023-10-07	{"4": "2"}	f	f
2726	2023-10-08	{"4": "2"}	f	f
2727	2023-10-09	{"4": "1"}	f	f
2728	2023-10-10	{"4": "1"}	f	f
2729	2023-10-11	{"4": "1"}	f	f
2730	2023-10-12	{"4": "1"}	f	f
2731	2023-10-13	{"4": "1"}	f	f
2732	2023-10-14	{"4": "2"}	f	f
2733	2023-10-15	{"4": "2"}	f	f
2734	2023-10-16	{"4": "1"}	f	f
2735	2023-10-17	{"4": "1"}	f	f
2736	2023-10-18	{"4": "1"}	f	f
2737	2023-10-19	{"4": "1"}	f	f
2738	2023-10-20	{"4": "1"}	f	f
2739	2023-10-21	{"4": "2"}	f	f
2740	2023-10-22	{"4": "2"}	f	f
2741	2023-10-23	{"4": "1"}	f	f
2742	2023-10-24	{"4": "1"}	f	f
2743	2023-10-25	{"4": "1"}	f	f
2744	2023-10-26	{"4": "1"}	f	f
2745	2023-10-27	{"4": "1"}	f	f
2746	2023-10-28	{"4": "2"}	f	f
2747	2023-10-29	{"4": "2"}	f	f
2748	2023-10-30	{"4": "1"}	f	f
2749	2023-10-31	{"4": "1"}	f	f
2750	2023-11-01	{"4": "1"}	f	f
2751	2023-11-02	{"4": "1"}	f	f
2752	2023-11-03	{"4": "1"}	f	f
2753	2023-11-04	{"4": "2"}	f	f
2754	2023-11-05	{"4": "2"}	f	f
2755	2023-11-06	{"4": "1"}	f	f
2756	2023-11-07	{"4": "1"}	f	f
2757	2023-11-08	{"4": "1"}	f	f
2758	2023-11-09	{"4": "1"}	f	f
2759	2023-11-10	{"4": "1"}	f	f
2760	2023-11-11	{"4": "2"}	f	f
2761	2023-11-12	{"4": "2"}	f	f
2762	2023-11-13	{"4": "1"}	f	f
2763	2023-11-14	{"4": "1"}	f	f
2764	2023-11-15	{"4": "1"}	f	f
2765	2023-11-16	{"4": "1"}	f	f
2766	2023-11-17	{"4": "1"}	f	f
2767	2023-11-18	{"4": "2"}	f	f
2768	2023-11-19	{"4": "2"}	f	f
2769	2023-11-20	{"4": "1"}	f	f
2770	2023-11-21	{"4": "1"}	f	f
2771	2023-11-22	{"4": "1"}	f	f
2772	2023-11-23	{"4": "1"}	f	f
2773	2023-11-24	{"4": "1"}	f	f
2774	2023-11-25	{"4": "2"}	f	f
2775	2023-11-26	{"4": "2"}	f	f
2776	2023-11-27	{"4": "1"}	f	f
2777	2023-11-28	{"4": "1"}	f	f
2778	2023-11-29	{"4": "1"}	f	f
2779	2023-11-30	{"4": "1"}	f	f
2780	2023-12-01	{"4": "1"}	f	f
2781	2023-12-02	{"4": "2"}	f	f
2782	2023-12-03	{"4": "2"}	f	f
2783	2023-12-04	{"4": "1"}	f	f
2784	2023-12-05	{"4": "1"}	f	f
2785	2023-12-06	{"4": "1"}	f	f
2786	2023-12-07	{"4": "1"}	f	f
2787	2023-12-08	{"4": "1"}	f	f
2788	2023-12-09	{"4": "2"}	f	f
2789	2023-12-10	{"4": "2"}	f	f
2790	2023-12-11	{"4": "1"}	f	f
2791	2023-12-12	{"4": "1"}	f	f
2792	2023-12-13	{"4": "1"}	f	f
2793	2023-12-14	{"4": "1"}	f	f
2794	2023-12-15	{"4": "1"}	f	f
2795	2023-12-16	{"4": "2"}	f	f
2796	2023-12-17	{"4": "2"}	f	f
2797	2023-12-18	{"4": "1"}	f	f
2798	2023-12-19	{"4": "1"}	f	f
2799	2023-12-20	{"4": "1"}	f	f
2800	2023-12-21	{"4": "1"}	f	f
2801	2023-12-22	{"4": "1"}	f	f
2802	2023-12-23	{"4": "2"}	f	f
2803	2023-12-24	{"4": "2"}	f	f
2804	2023-12-25	{"4": "1"}	f	f
2805	2023-12-26	{"4": "1"}	f	f
2806	2023-12-27	{"4": "1"}	f	f
2807	2023-12-28	{"4": "1"}	f	f
2808	2023-12-29	{"4": "1"}	f	f
2809	2023-12-30	{"4": "2"}	f	f
2810	2023-12-31	{"4": "2"}	f	f
2811	2024-01-01	{"4": "1"}	f	f
2812	2024-01-02	{"4": "1"}	f	f
2813	2024-01-03	{"4": "1"}	f	f
2814	2024-01-04	{"4": "1"}	f	f
2815	2024-01-05	{"4": "1"}	f	f
2816	2024-01-06	{"4": "2"}	f	f
2817	2024-01-07	{"4": "2"}	f	f
2818	2024-01-08	{"4": "1"}	f	f
2819	2024-01-09	{"4": "1"}	f	f
2820	2024-01-10	{"4": "1"}	f	f
2821	2024-01-11	{"4": "1"}	f	f
2822	2024-01-12	{"4": "1"}	f	f
2823	2024-01-13	{"4": "2"}	f	f
2824	2024-01-14	{"4": "2"}	f	f
2825	2024-01-15	{"4": "1"}	f	f
2826	2024-01-16	{"4": "1"}	f	f
2827	2024-01-17	{"4": "1"}	f	f
2828	2024-01-18	{"4": "1"}	f	f
2829	2024-01-19	{"4": "1"}	f	f
2830	2024-01-20	{"4": "2"}	f	f
2831	2024-01-21	{"4": "2"}	f	f
2832	2024-01-22	{"4": "1"}	f	f
2833	2024-01-23	{"4": "1"}	f	f
2834	2024-01-24	{"4": "1"}	f	f
2835	2024-01-25	{"4": "1"}	f	f
2836	2024-01-26	{"4": "1"}	f	f
2837	2024-01-27	{"4": "2"}	f	f
2838	2024-01-28	{"4": "2"}	f	f
2839	2024-01-29	{"4": "1"}	f	f
2840	2024-01-30	{"4": "1"}	f	f
2841	2024-01-31	{"4": "1"}	f	f
2842	2024-02-01	{"4": "1"}	f	f
2843	2024-02-02	{"4": "1"}	f	f
2844	2024-02-03	{"4": "2"}	f	f
2845	2024-02-04	{"4": "2"}	f	f
2846	2024-02-05	{"4": "1"}	f	f
2847	2024-02-06	{"4": "1"}	f	f
2848	2024-02-07	{"4": "1"}	f	f
2849	2024-02-08	{"4": "1"}	f	f
2850	2024-02-09	{"4": "1"}	f	f
2851	2024-02-10	{"4": "2"}	f	f
2852	2024-02-11	{"4": "2"}	f	f
2853	2024-02-12	{"4": "1"}	f	f
2854	2024-02-13	{"4": "1"}	f	f
2855	2024-02-14	{"4": "1"}	f	f
2856	2024-02-15	{"4": "1"}	f	f
2857	2024-02-16	{"4": "1"}	f	f
2858	2024-02-17	{"4": "2"}	f	f
2859	2024-02-18	{"4": "2"}	f	f
2860	2024-02-19	{"4": "1"}	f	f
2861	2024-02-20	{"4": "1"}	f	f
2862	2024-02-21	{"4": "1"}	f	f
2863	2024-02-22	{"4": "1"}	f	f
2864	2024-02-23	{"4": "1"}	f	f
2865	2024-02-24	{"4": "2"}	f	f
2866	2024-02-25	{"4": "2"}	f	f
2867	2024-02-26	{"4": "1"}	f	f
2868	2024-02-27	{"4": "1"}	f	f
2869	2024-02-28	{"4": "1"}	f	f
2870	2024-02-29	{"4": "1"}	f	f
2871	2024-03-01	{"4": "1"}	f	f
2872	2024-03-02	{"4": "2"}	f	f
2873	2024-03-03	{"4": "2"}	f	f
2874	2024-03-04	{"4": "1"}	f	f
2875	2024-03-05	{"4": "1"}	f	f
2876	2024-03-06	{"4": "1"}	f	f
2877	2024-03-07	{"4": "1"}	f	f
2878	2024-03-08	{"4": "1"}	f	f
2879	2024-03-09	{"4": "2"}	f	f
2880	2024-03-10	{"4": "2"}	f	f
2881	2024-03-11	{"4": "1"}	f	f
2882	2024-03-12	{"4": "1"}	f	f
2883	2024-03-13	{"4": "1"}	f	f
2884	2024-03-14	{"4": "1"}	f	f
2885	2024-03-15	{"4": "1"}	f	f
2886	2024-03-16	{"4": "2"}	f	f
2887	2024-03-17	{"4": "2"}	f	f
2888	2024-03-18	{"4": "1"}	f	f
2889	2024-03-19	{"4": "1"}	f	f
2890	2024-03-20	{"4": "1"}	f	f
2891	2024-03-21	{"4": "1"}	f	f
2892	2024-03-22	{"4": "1"}	f	f
2893	2024-03-23	{"4": "2"}	f	f
2894	2024-03-24	{"4": "2"}	f	f
2895	2024-03-25	{"4": "1"}	f	f
2896	2024-03-26	{"4": "1"}	f	f
2897	2024-03-27	{"4": "1"}	f	f
2898	2024-03-28	{"4": "1"}	f	f
2899	2024-03-29	{"4": "1"}	f	f
2900	2024-03-30	{"4": "2"}	f	f
2901	2024-03-31	{"4": "2"}	f	f
2902	2024-04-01	{"4": "1"}	f	f
2903	2024-04-02	{"4": "1"}	f	f
2904	2024-04-03	{"4": "1"}	f	f
2905	2024-04-04	{"4": "1"}	f	f
2906	2024-04-05	{"4": "1"}	f	f
2907	2024-04-06	{"4": "2"}	f	f
2908	2024-04-07	{"4": "2"}	f	f
2909	2024-04-08	{"4": "1"}	f	f
2910	2024-04-09	{"4": "1"}	f	f
2911	2024-04-10	{"4": "1"}	f	f
2912	2024-04-11	{"4": "1"}	f	f
2913	2024-04-12	{"4": "1"}	f	f
2914	2024-04-13	{"4": "2"}	f	f
2915	2024-04-14	{"4": "2"}	f	f
2916	2024-04-15	{"4": "1"}	f	f
2917	2024-04-16	{"4": "1"}	f	f
2918	2024-04-17	{"4": "1"}	f	f
2919	2024-04-18	{"4": "1"}	f	f
2920	2024-04-19	{"4": "1"}	f	f
2921	2024-04-20	{"4": "2"}	f	f
2922	2024-04-21	{"4": "2"}	f	f
2923	2024-04-22	{"4": "1"}	f	f
2924	2024-04-23	{"4": "1"}	f	f
2925	2024-04-24	{"4": "1"}	f	f
2926	2024-04-25	{"4": "1"}	f	f
2927	2024-04-26	{"4": "1"}	f	f
2928	2024-04-27	{"4": "2"}	f	f
2929	2024-04-28	{"4": "2"}	f	f
2930	2024-04-29	{"4": "1"}	f	f
2931	2024-04-30	{"4": "1"}	f	f
2932	2024-05-01	{"4": "1"}	f	f
2933	2024-05-02	{"4": "1"}	f	f
2934	2024-05-03	{"4": "1"}	f	f
2935	2024-05-04	{"4": "2"}	f	f
2936	2024-05-05	{"4": "2"}	f	f
2937	2024-05-06	{"4": "1"}	f	f
2938	2024-05-07	{"4": "1"}	f	f
2939	2024-05-08	{"4": "1"}	f	f
2940	2024-05-09	{"4": "1"}	f	f
2941	2024-05-10	{"4": "1"}	f	f
2942	2024-05-11	{"4": "2"}	f	f
2943	2024-05-12	{"4": "2"}	f	f
2944	2024-05-13	{"4": "1"}	f	f
2945	2024-05-14	{"4": "1"}	f	f
2946	2024-05-15	{"4": "1"}	f	f
2947	2024-05-16	{"4": "1"}	f	f
2948	2024-05-17	{"4": "1"}	f	f
2949	2024-05-18	{"4": "2"}	f	f
2950	2024-05-19	{"4": "2"}	f	f
2951	2024-05-20	{"4": "1"}	f	f
2952	2024-05-21	{"4": "1"}	f	f
2953	2024-05-22	{"4": "1"}	f	f
2954	2024-05-23	{"4": "1"}	f	f
2955	2024-05-24	{"4": "1"}	f	f
2956	2024-05-25	{"4": "2"}	f	f
2957	2024-05-26	{"4": "2"}	f	f
2958	2024-05-27	{"4": "1"}	f	f
2959	2024-05-28	{"4": "1"}	f	f
2960	2024-05-29	{"4": "1"}	f	f
2961	2024-05-30	{"4": "1"}	f	f
2962	2024-05-31	{"4": "1"}	f	f
2963	2024-06-01	{"4": "2"}	f	f
2964	2024-06-02	{"4": "2"}	f	f
2965	2024-06-03	{"4": "1"}	f	f
2966	2024-06-04	{"4": "1"}	f	f
2967	2024-06-05	{"4": "1"}	f	f
2968	2024-06-06	{"4": "1"}	f	f
2969	2024-06-07	{"4": "1"}	f	f
2970	2024-06-08	{"4": "2"}	f	f
2971	2024-06-09	{"4": "2"}	f	f
2972	2024-06-10	{"4": "1"}	f	f
2973	2024-06-11	{"4": "1"}	f	f
2974	2024-06-12	{"4": "1"}	f	f
2975	2024-06-13	{"4": "1"}	f	f
2976	2024-06-14	{"4": "1"}	f	f
2977	2024-06-15	{"4": "2"}	f	f
2978	2024-06-16	{"4": "2"}	f	f
2979	2024-06-17	{"4": "1"}	f	f
2980	2024-06-18	{"4": "1"}	f	f
2981	2024-06-19	{"4": "1"}	f	f
2982	2024-06-20	{"4": "1"}	f	f
2983	2024-06-21	{"4": "1"}	f	f
2984	2024-06-22	{"4": "2"}	f	f
2985	2024-06-23	{"4": "2"}	f	f
2986	2024-06-24	{"4": "1"}	f	f
2987	2024-06-25	{"4": "1"}	f	f
2988	2024-06-26	{"4": "1"}	f	f
2989	2024-06-27	{"4": "1"}	f	f
2990	2024-06-28	{"4": "1"}	f	f
2991	2024-06-29	{"4": "2"}	f	f
2992	2024-06-30	{"4": "2"}	f	f
2993	2024-07-01	{"4": "1"}	f	f
2994	2024-07-02	{"4": "1"}	f	f
2995	2024-07-03	{"4": "1"}	f	f
2996	2024-07-04	{"4": "1"}	f	f
2997	2024-07-05	{"4": "1"}	f	f
2998	2024-07-06	{"4": "2"}	f	f
2999	2024-07-07	{"4": "2"}	f	f
3000	2024-07-08	{"4": "1"}	f	f
3001	2024-07-09	{"4": "1"}	f	f
3002	2024-07-10	{"4": "1"}	f	f
3003	2024-07-11	{"4": "1"}	f	f
3004	2024-07-12	{"4": "1"}	f	f
3005	2024-07-13	{"4": "2"}	f	f
3006	2024-07-14	{"4": "2"}	f	f
3007	2024-07-15	{"4": "1"}	f	f
3008	2024-07-16	{"4": "1"}	f	f
3009	2024-07-17	{"4": "1"}	f	f
3010	2024-07-18	{"4": "1"}	f	f
3011	2024-07-19	{"4": "1"}	f	f
3012	2024-07-20	{"4": "2"}	f	f
3013	2024-07-21	{"4": "2"}	f	f
3014	2024-07-22	{"4": "1"}	f	f
3015	2024-07-23	{"4": "1"}	f	f
3016	2024-07-24	{"4": "1"}	f	f
3017	2024-07-25	{"4": "1"}	f	f
3018	2024-07-26	{"4": "1"}	f	f
3019	2024-07-27	{"4": "2"}	f	f
3020	2024-07-28	{"4": "2"}	f	f
3021	2024-07-29	{"4": "1"}	f	f
3022	2024-07-30	{"4": "1"}	f	f
3023	2024-07-31	{"4": "1"}	f	f
3024	2024-08-01	{"4": "1"}	f	f
3025	2024-08-02	{"4": "1"}	f	f
3026	2024-08-03	{"4": "2"}	f	f
3027	2024-08-04	{"4": "2"}	f	f
3028	2024-08-05	{"4": "1"}	f	f
3029	2024-08-06	{"4": "1"}	f	f
3030	2024-08-07	{"4": "1"}	f	f
3031	2024-08-08	{"4": "1"}	f	f
3032	2024-08-09	{"4": "1"}	f	f
3033	2024-08-10	{"4": "2"}	f	f
3034	2024-08-11	{"4": "2"}	f	f
3035	2024-08-12	{"4": "1"}	f	f
3036	2024-08-13	{"4": "1"}	f	f
3037	2024-08-14	{"4": "1"}	f	f
3038	2024-08-15	{"4": "1"}	f	f
3039	2024-08-16	{"4": "1"}	f	f
3040	2024-08-17	{"4": "2"}	f	f
3041	2024-08-18	{"4": "2"}	f	f
3042	2024-08-19	{"4": "1"}	f	f
3043	2024-08-20	{"4": "1"}	f	f
3044	2024-08-21	{"4": "1"}	f	f
3045	2024-08-22	{"4": "1"}	f	f
3046	2024-08-23	{"4": "1"}	f	f
3047	2024-08-24	{"4": "2"}	f	f
3048	2024-08-25	{"4": "2"}	f	f
3049	2024-08-26	{"4": "1"}	f	f
3050	2024-08-27	{"4": "1"}	f	f
3051	2024-08-28	{"4": "1"}	f	f
3052	2024-08-29	{"4": "1"}	f	f
3053	2024-08-30	{"4": "1"}	f	f
3054	2024-08-31	{"4": "2"}	f	f
3055	2024-09-01	{"4": "2"}	f	f
3056	2024-09-02	{"4": "1"}	f	f
3057	2024-09-03	{"4": "1"}	f	f
3058	2024-09-04	{"4": "1"}	f	f
3059	2024-09-05	{"4": "1"}	f	f
3060	2024-09-06	{"4": "1"}	f	f
3061	2024-09-07	{"4": "2"}	f	f
3062	2024-09-08	{"4": "2"}	f	f
3063	2024-09-09	{"4": "1"}	f	f
3064	2024-09-10	{"4": "1"}	f	f
3065	2024-09-11	{"4": "1"}	f	f
3066	2024-09-12	{"4": "1"}	f	f
3067	2024-09-13	{"4": "1"}	f	f
3068	2024-09-14	{"4": "2"}	f	f
3069	2024-09-15	{"4": "2"}	f	f
3070	2024-09-16	{"4": "1"}	f	f
3071	2024-09-17	{"4": "1"}	f	f
3072	2024-09-18	{"4": "1"}	f	f
3073	2024-09-19	{"4": "1"}	f	f
3074	2024-09-20	{"4": "1"}	f	f
3075	2024-09-21	{"4": "2"}	f	f
3076	2024-09-22	{"4": "2"}	f	f
3077	2024-09-23	{"4": "1"}	f	f
3078	2024-09-24	{"4": "1"}	f	f
3079	2024-09-25	{"4": "1"}	f	f
3080	2024-09-26	{"4": "1"}	f	f
3081	2024-09-27	{"4": "1"}	f	f
3082	2024-09-28	{"4": "2"}	f	f
3083	2024-09-29	{"4": "2"}	f	f
3084	2024-09-30	{"4": "1"}	f	f
3085	2024-10-01	{"4": "1"}	f	f
3086	2024-10-02	{"4": "1"}	f	f
3087	2024-10-03	{"4": "1"}	f	f
3088	2024-10-04	{"4": "1"}	f	f
3089	2024-10-05	{"4": "2"}	f	f
3090	2024-10-06	{"4": "2"}	f	f
3091	2024-10-07	{"4": "1"}	f	f
3092	2024-10-08	{"4": "1"}	f	f
3093	2024-10-09	{"4": "1"}	f	f
3094	2024-10-10	{"4": "1"}	f	f
3095	2024-10-11	{"4": "1"}	f	f
3096	2024-10-12	{"4": "2"}	f	f
3097	2024-10-13	{"4": "2"}	f	f
3098	2024-10-14	{"4": "1"}	f	f
3099	2024-10-15	{"4": "1"}	f	f
3100	2024-10-16	{"4": "1"}	f	f
3101	2024-10-17	{"4": "1"}	f	f
3102	2024-10-18	{"4": "1"}	f	f
3103	2024-10-19	{"4": "2"}	f	f
3104	2024-10-20	{"4": "2"}	f	f
3105	2024-10-21	{"4": "1"}	f	f
3106	2024-10-22	{"4": "1"}	f	f
3107	2024-10-23	{"4": "1"}	f	f
3108	2024-10-24	{"4": "1"}	f	f
3109	2024-10-25	{"4": "1"}	f	f
3110	2024-10-26	{"4": "2"}	f	f
3111	2024-10-27	{"4": "2"}	f	f
3112	2024-10-28	{"4": "1"}	f	f
3113	2024-10-29	{"4": "1"}	f	f
3114	2024-10-30	{"4": "1"}	f	f
3115	2024-10-31	{"4": "1"}	f	f
3116	2024-11-01	{"4": "1"}	f	f
3117	2024-11-02	{"4": "2"}	f	f
3118	2024-11-03	{"4": "2"}	f	f
3119	2024-11-04	{"4": "1"}	f	f
3120	2024-11-05	{"4": "1"}	f	f
3121	2024-11-06	{"4": "1"}	f	f
3122	2024-11-07	{"4": "1"}	f	f
3123	2024-11-08	{"4": "1"}	f	f
3124	2024-11-09	{"4": "2"}	f	f
3125	2024-11-10	{"4": "2"}	f	f
3126	2024-11-11	{"4": "1"}	f	f
3127	2024-11-12	{"4": "1"}	f	f
3128	2024-11-13	{"4": "1"}	f	f
3129	2024-11-14	{"4": "1"}	f	f
3130	2024-11-15	{"4": "1"}	f	f
3131	2024-11-16	{"4": "2"}	f	f
3132	2024-11-17	{"4": "2"}	f	f
3133	2024-11-18	{"4": "1"}	f	f
3134	2024-11-19	{"4": "1"}	f	f
3135	2024-11-20	{"4": "1"}	f	f
3136	2024-11-21	{"4": "1"}	f	f
3137	2024-11-22	{"4": "1"}	f	f
3138	2024-11-23	{"4": "2"}	f	f
3139	2024-11-24	{"4": "2"}	f	f
3140	2024-11-25	{"4": "1"}	f	f
3141	2024-11-26	{"4": "1"}	f	f
3142	2024-11-27	{"4": "1"}	f	f
3143	2024-11-28	{"4": "1"}	f	f
3144	2024-11-29	{"4": "1"}	f	f
3145	2024-11-30	{"4": "2"}	f	f
3146	2024-12-01	{"4": "2"}	f	f
3147	2024-12-02	{"4": "1"}	f	f
3148	2024-12-03	{"4": "1"}	f	f
3149	2024-12-04	{"4": "1"}	f	f
3150	2024-12-05	{"4": "1"}	f	f
3151	2024-12-06	{"4": "1"}	f	f
3152	2024-12-07	{"4": "2"}	f	f
3153	2024-12-08	{"4": "2"}	f	f
3154	2024-12-09	{"4": "1"}	f	f
3155	2024-12-10	{"4": "1"}	f	f
3156	2024-12-11	{"4": "1"}	f	f
3157	2024-12-12	{"4": "1"}	f	f
3158	2024-12-13	{"4": "1"}	f	f
3159	2024-12-14	{"4": "2"}	f	f
3160	2024-12-15	{"4": "2"}	f	f
3161	2024-12-16	{"4": "1"}	f	f
3162	2024-12-17	{"4": "1"}	f	f
3163	2024-12-18	{"4": "1"}	f	f
3164	2024-12-19	{"4": "1"}	f	f
3165	2024-12-20	{"4": "1"}	f	f
3166	2024-12-21	{"4": "2"}	f	f
3167	2024-12-22	{"4": "2"}	f	f
3168	2024-12-23	{"4": "1"}	f	f
3169	2024-12-24	{"4": "1"}	f	f
3170	2024-12-25	{"4": "1"}	f	f
3171	2024-12-26	{"4": "1"}	f	f
3172	2024-12-27	{"4": "1"}	f	f
3173	2024-12-28	{"4": "2"}	f	f
3174	2024-12-29	{"4": "2"}	f	f
3175	2024-12-30	{"4": "1"}	f	f
3176	2024-12-31	{"4": "1"}	f	f
3177	2025-01-01	{"4": "1"}	f	f
3178	2025-01-02	{"4": "1"}	f	f
3179	2025-01-03	{"4": "1"}	f	f
3180	2025-01-04	{"4": "2"}	f	f
3181	2025-01-05	{"4": "2"}	f	f
3182	2025-01-06	{"4": "1"}	f	f
3183	2025-01-07	{"4": "1"}	f	f
3184	2025-01-08	{"4": "1"}	f	f
3185	2025-01-09	{"4": "1"}	f	f
3186	2025-01-10	{"4": "1"}	f	f
3187	2025-01-11	{"4": "2"}	f	f
3188	2025-01-12	{"4": "2"}	f	f
3189	2025-01-13	{"4": "1"}	f	f
3190	2025-01-14	{"4": "1"}	f	f
3191	2025-01-15	{"4": "1"}	f	f
3192	2025-01-16	{"4": "1"}	f	f
3193	2025-01-17	{"4": "1"}	f	f
3194	2025-01-18	{"4": "2"}	f	f
3195	2025-01-19	{"4": "2"}	f	f
3196	2025-01-20	{"4": "1"}	f	f
3197	2025-01-21	{"4": "1"}	f	f
3198	2025-01-22	{"4": "1"}	f	f
3199	2025-01-23	{"4": "1"}	f	f
3200	2025-01-24	{"4": "1"}	f	f
3201	2025-01-25	{"4": "2"}	f	f
3202	2025-01-26	{"4": "2"}	f	f
3203	2025-01-27	{"4": "1"}	f	f
3204	2025-01-28	{"4": "1"}	f	f
3205	2025-01-29	{"4": "1"}	f	f
3206	2025-01-30	{"4": "1"}	f	f
3207	2025-01-31	{"4": "1"}	f	f
3208	2025-02-01	{"4": "2"}	f	f
3209	2025-02-02	{"4": "2"}	f	f
3210	2025-02-03	{"4": "1"}	f	f
3211	2025-02-04	{"4": "1"}	f	f
3212	2025-02-05	{"4": "1"}	f	f
3213	2025-02-06	{"4": "1"}	f	f
3214	2025-02-07	{"4": "1"}	f	f
3215	2025-02-08	{"4": "2"}	f	f
3216	2025-02-09	{"4": "2"}	f	f
3217	2025-02-10	{"4": "1"}	f	f
3218	2025-02-11	{"4": "1"}	f	f
3219	2025-02-12	{"4": "1"}	f	f
3220	2025-02-13	{"4": "1"}	f	f
3221	2025-02-14	{"4": "1"}	f	f
3222	2025-02-15	{"4": "2"}	f	f
3223	2025-02-16	{"4": "2"}	f	f
3224	2025-02-17	{"4": "1"}	f	f
3225	2025-02-18	{"4": "1"}	f	f
3226	2025-02-19	{"4": "1"}	f	f
3227	2025-02-20	{"4": "1"}	f	f
3228	2025-02-21	{"4": "1"}	f	f
3229	2025-02-22	{"4": "2"}	f	f
3230	2025-02-23	{"4": "2"}	f	f
3231	2025-02-24	{"4": "1"}	f	f
3232	2025-02-25	{"4": "1"}	f	f
3233	2025-02-26	{"4": "1"}	f	f
3234	2025-02-27	{"4": "1"}	f	f
3235	2025-02-28	{"4": "1"}	f	f
3236	2025-03-01	{"4": "2"}	f	f
3237	2025-03-02	{"4": "2"}	f	f
3238	2025-03-03	{"4": "1"}	f	f
3239	2025-03-04	{"4": "1"}	f	f
3240	2025-03-05	{"4": "1"}	f	f
3241	2025-03-06	{"4": "1"}	f	f
3242	2025-03-07	{"4": "1"}	f	f
3243	2025-03-08	{"4": "2"}	f	f
3244	2025-03-09	{"4": "2"}	f	f
3245	2025-03-10	{"4": "1"}	f	f
3246	2025-03-11	{"4": "1"}	f	f
3247	2025-03-12	{"4": "1"}	f	f
3248	2025-03-13	{"4": "1"}	f	f
3249	2025-03-14	{"4": "1"}	f	f
3250	2025-03-15	{"4": "2"}	f	f
3251	2025-03-16	{"4": "2"}	f	f
3252	2025-03-17	{"4": "1"}	f	f
3253	2025-03-18	{"4": "1"}	f	f
3254	2025-03-19	{"4": "1"}	f	f
3255	2025-03-20	{"4": "1"}	f	f
3256	2025-03-21	{"4": "1"}	f	f
3257	2025-03-22	{"4": "2"}	f	f
3258	2025-03-23	{"4": "2"}	f	f
3259	2025-03-24	{"4": "1"}	f	f
3260	2025-03-25	{"4": "1"}	f	f
3261	2025-03-26	{"4": "1"}	f	f
3262	2025-03-27	{"4": "1"}	f	f
3263	2025-03-28	{"4": "1"}	f	f
3264	2025-03-29	{"4": "2"}	f	f
3265	2025-03-30	{"4": "2"}	f	f
3266	2025-03-31	{"4": "1"}	f	f
3267	2025-04-01	{"4": "1"}	f	f
3268	2025-04-02	{"4": "1"}	f	f
3269	2025-04-03	{"4": "1"}	f	f
3270	2025-04-04	{"4": "1"}	f	f
3271	2025-04-05	{"4": "2"}	f	f
3272	2025-04-06	{"4": "2"}	f	f
3273	2025-04-07	{"4": "1"}	f	f
3274	2025-04-08	{"4": "1"}	f	f
3275	2025-04-09	{"4": "1"}	f	f
3276	2025-04-10	{"4": "1"}	f	f
3277	2025-04-11	{"4": "1"}	f	f
3278	2025-04-12	{"4": "2"}	f	f
3279	2025-04-13	{"4": "2"}	f	f
3280	2025-04-14	{"4": "1"}	f	f
3281	2025-04-15	{"4": "1"}	f	f
3282	2025-04-16	{"4": "1"}	f	f
3283	2025-04-17	{"4": "1"}	f	f
3284	2025-04-18	{"4": "1"}	f	f
3285	2025-04-19	{"4": "2"}	f	f
3286	2025-04-20	{"4": "2"}	f	f
3287	2025-04-21	{"4": "1"}	f	f
3288	2025-04-22	{"4": "1"}	f	f
3289	2025-04-23	{"4": "1"}	f	f
3290	2025-04-24	{"4": "1"}	f	f
3291	2025-04-25	{"4": "1"}	f	f
3292	2025-04-26	{"4": "2"}	f	f
3293	2025-04-27	{"4": "2"}	f	f
3294	2025-04-28	{"4": "1"}	f	f
3295	2025-04-29	{"4": "1"}	f	f
3296	2025-04-30	{"4": "1"}	f	f
3297	2025-05-01	{"4": "1"}	f	f
3298	2025-05-02	{"4": "1"}	f	f
3299	2025-05-03	{"4": "2"}	f	f
3300	2025-05-04	{"4": "2"}	f	f
3301	2025-05-05	{"4": "1"}	f	f
3302	2025-05-06	{"4": "1"}	f	f
3303	2025-05-07	{"4": "1"}	f	f
3304	2025-05-08	{"4": "1"}	f	f
3305	2025-05-09	{"4": "1"}	f	f
3306	2025-05-10	{"4": "2"}	f	f
3307	2025-05-11	{"4": "2"}	f	f
3308	2025-05-12	{"4": "1"}	f	f
3309	2025-05-13	{"4": "1"}	f	f
3310	2025-05-14	{"4": "1"}	f	f
3311	2025-05-15	{"4": "1"}	f	f
3312	2025-05-16	{"4": "1"}	f	f
3313	2025-05-17	{"4": "2"}	f	f
3314	2025-05-18	{"4": "2"}	f	f
3315	2025-05-19	{"4": "1"}	f	f
3316	2025-05-20	{"4": "1"}	f	f
3317	2025-05-21	{"4": "1"}	f	f
3318	2025-05-22	{"4": "1"}	f	f
3319	2025-05-23	{"4": "1"}	f	f
3320	2025-05-24	{"4": "2"}	f	f
3321	2025-05-25	{"4": "2"}	f	f
3322	2025-05-26	{"4": "1"}	f	f
3323	2025-05-27	{"4": "1"}	f	f
3324	2025-05-28	{"4": "1"}	f	f
3325	2025-05-29	{"4": "1"}	f	f
3326	2025-05-30	{"4": "1"}	f	f
3327	2025-05-31	{"4": "2"}	f	f
3328	2025-06-01	{"4": "2"}	f	f
3329	2025-06-02	{"4": "1"}	f	f
3330	2025-06-03	{"4": "1"}	f	f
3331	2025-06-04	{"4": "1"}	f	f
3332	2025-06-05	{"4": "1"}	f	f
3333	2025-06-06	{"4": "1"}	f	f
3334	2025-06-07	{"4": "2"}	f	f
3335	2025-06-08	{"4": "2"}	f	f
3336	2025-06-09	{"4": "1"}	f	f
3337	2025-06-10	{"4": "1"}	f	f
3338	2025-06-11	{"4": "1"}	f	f
3339	2025-06-12	{"4": "1"}	f	f
3340	2025-06-13	{"4": "1"}	f	f
3341	2025-06-14	{"4": "2"}	f	f
3342	2025-06-15	{"4": "2"}	f	f
3343	2025-06-16	{"4": "1"}	f	f
3344	2025-06-17	{"4": "1"}	f	f
3345	2025-06-18	{"4": "1"}	f	f
3346	2025-06-19	{"4": "1"}	f	f
3347	2025-06-20	{"4": "1"}	f	f
3348	2025-06-21	{"4": "2"}	f	f
3349	2025-06-22	{"4": "2"}	f	f
3350	2025-06-23	{"4": "1"}	f	f
3351	2025-06-24	{"4": "1"}	f	f
3352	2025-06-25	{"4": "1"}	f	f
3353	2025-06-26	{"4": "1"}	f	f
3354	2025-06-27	{"4": "1"}	f	f
3355	2025-06-28	{"4": "2"}	f	f
3356	2025-06-29	{"4": "2"}	f	f
3357	2025-06-30	{"4": "1"}	f	f
3358	2025-07-01	{"4": "1"}	f	f
3359	2025-07-02	{"4": "1"}	f	f
3360	2025-07-03	{"4": "1"}	f	f
3361	2025-07-04	{"4": "1"}	f	f
3362	2025-07-05	{"4": "2"}	f	f
3363	2025-07-06	{"4": "2"}	f	f
3364	2025-07-07	{"4": "1"}	f	f
3365	2025-07-08	{"4": "1"}	f	f
3366	2025-07-09	{"4": "1"}	f	f
3367	2025-07-10	{"4": "1"}	f	f
3368	2025-07-11	{"4": "1"}	f	f
3369	2025-07-12	{"4": "2"}	f	f
3370	2025-07-13	{"4": "2"}	f	f
3371	2025-07-14	{"4": "1"}	f	f
3372	2025-07-15	{"4": "1"}	f	f
3373	2025-07-16	{"4": "1"}	f	f
3374	2025-07-17	{"4": "1"}	f	f
3375	2025-07-18	{"4": "1"}	f	f
3376	2025-07-19	{"4": "2"}	f	f
3377	2025-07-20	{"4": "2"}	f	f
3378	2025-07-21	{"4": "1"}	f	f
3379	2025-07-22	{"4": "1"}	f	f
3380	2025-07-23	{"4": "1"}	f	f
3381	2025-07-24	{"4": "1"}	f	f
3382	2025-07-25	{"4": "1"}	f	f
3383	2025-07-26	{"4": "2"}	f	f
3384	2025-07-27	{"4": "2"}	f	f
3385	2025-07-28	{"4": "1"}	f	f
3386	2025-07-29	{"4": "1"}	f	f
3387	2025-07-30	{"4": "1"}	f	f
3388	2025-07-31	{"4": "1"}	f	f
3389	2025-08-01	{"4": "1"}	f	f
3390	2025-08-02	{"4": "2"}	f	f
3391	2025-08-03	{"4": "2"}	f	f
3392	2025-08-04	{"4": "1"}	f	f
3393	2025-08-05	{"4": "1"}	f	f
3394	2025-08-06	{"4": "1"}	f	f
3395	2025-08-07	{"4": "1"}	f	f
3396	2025-08-08	{"4": "1"}	f	f
3397	2025-08-09	{"4": "2"}	f	f
3398	2025-08-10	{"4": "2"}	f	f
3399	2025-08-11	{"4": "1"}	f	f
3400	2025-08-12	{"4": "1"}	f	f
3401	2025-08-13	{"4": "1"}	f	f
3402	2025-08-14	{"4": "1"}	f	f
3403	2025-08-15	{"4": "1"}	f	f
3404	2025-08-16	{"4": "2"}	f	f
3405	2025-08-17	{"4": "2"}	f	f
3406	2025-08-18	{"4": "1"}	f	f
3407	2025-08-19	{"4": "1"}	f	f
3408	2025-08-20	{"4": "1"}	f	f
3409	2025-08-21	{"4": "1"}	f	f
3410	2025-08-22	{"4": "1"}	f	f
3411	2025-08-23	{"4": "2"}	f	f
3412	2025-08-24	{"4": "2"}	f	f
3413	2025-08-25	{"4": "1"}	f	f
3414	2025-08-26	{"4": "1"}	f	f
3415	2025-08-27	{"4": "1"}	f	f
3416	2025-08-28	{"4": "1"}	f	f
3417	2025-08-29	{"4": "1"}	f	f
3418	2025-08-30	{"4": "2"}	f	f
3419	2025-08-31	{"4": "2"}	f	f
3420	2025-09-01	{"4": "1"}	f	f
3421	2025-09-02	{"4": "1"}	f	f
3422	2025-09-03	{"4": "1"}	f	f
3423	2025-09-04	{"4": "1"}	f	f
3424	2025-09-05	{"4": "1"}	f	f
3425	2025-09-06	{"4": "2"}	f	f
3426	2025-09-07	{"4": "2"}	f	f
3427	2025-09-08	{"4": "1"}	f	f
3428	2025-09-09	{"4": "1"}	f	f
3429	2025-09-10	{"4": "1"}	f	f
3430	2025-09-11	{"4": "1"}	f	f
3431	2025-09-12	{"4": "1"}	f	f
3432	2025-09-13	{"4": "2"}	f	f
3433	2025-09-14	{"4": "2"}	f	f
3434	2025-09-15	{"4": "1"}	f	f
3435	2025-09-16	{"4": "1"}	f	f
3436	2025-09-17	{"4": "1"}	f	f
3437	2025-09-18	{"4": "1"}	f	f
3438	2025-09-19	{"4": "1"}	f	f
3439	2025-09-20	{"4": "2"}	f	f
3440	2025-09-21	{"4": "2"}	f	f
3441	2025-09-22	{"4": "1"}	f	f
3442	2025-09-23	{"4": "1"}	f	f
3443	2025-09-24	{"4": "1"}	f	f
3444	2025-09-25	{"4": "1"}	f	f
3445	2025-09-26	{"4": "1"}	f	f
3446	2025-09-27	{"4": "2"}	f	f
3447	2025-09-28	{"4": "2"}	f	f
3448	2025-09-29	{"4": "1"}	f	f
3449	2025-09-30	{"4": "1"}	f	f
3450	2025-10-01	{"4": "1"}	f	f
3451	2025-10-02	{"4": "1"}	f	f
3452	2025-10-03	{"4": "1"}	f	f
3453	2025-10-04	{"4": "2"}	f	f
3454	2025-10-05	{"4": "2"}	f	f
3455	2025-10-06	{"4": "1"}	f	f
3456	2025-10-07	{"4": "1"}	f	f
3457	2025-10-08	{"4": "1"}	f	f
3458	2025-10-09	{"4": "1"}	f	f
3459	2025-10-10	{"4": "1"}	f	f
3460	2025-10-11	{"4": "2"}	f	f
3461	2025-10-12	{"4": "2"}	f	f
3462	2025-10-13	{"4": "1"}	f	f
3463	2025-10-14	{"4": "1"}	f	f
3464	2025-10-15	{"4": "1"}	f	f
3465	2025-10-16	{"4": "1"}	f	f
3466	2025-10-17	{"4": "1"}	f	f
3467	2025-10-18	{"4": "2"}	f	f
3468	2025-10-19	{"4": "2"}	f	f
3469	2025-10-20	{"4": "1"}	f	f
3470	2025-10-21	{"4": "1"}	f	f
3471	2025-10-22	{"4": "1"}	f	f
3472	2025-10-23	{"4": "1"}	f	f
3473	2025-10-24	{"4": "1"}	f	f
3474	2025-10-25	{"4": "2"}	f	f
3475	2025-10-26	{"4": "2"}	f	f
3476	2025-10-27	{"4": "1"}	f	f
3477	2025-10-28	{"4": "1"}	f	f
3478	2025-10-29	{"4": "1"}	f	f
3479	2025-10-30	{"4": "1"}	f	f
3480	2025-10-31	{"4": "1"}	f	f
3481	2025-11-01	{"4": "2"}	f	f
3482	2025-11-02	{"4": "2"}	f	f
3483	2025-11-03	{"4": "1"}	f	f
3484	2025-11-04	{"4": "1"}	f	f
3485	2025-11-05	{"4": "1"}	f	f
3486	2025-11-06	{"4": "1"}	f	f
3487	2025-11-07	{"4": "1"}	f	f
3488	2025-11-08	{"4": "2"}	f	f
3489	2025-11-09	{"4": "2"}	f	f
3490	2025-11-10	{"4": "1"}	f	f
3491	2025-11-11	{"4": "1"}	f	f
3492	2025-11-12	{"4": "1"}	f	f
3493	2025-11-13	{"4": "1"}	f	f
3494	2025-11-14	{"4": "1"}	f	f
3495	2025-11-15	{"4": "2"}	f	f
3496	2025-11-16	{"4": "2"}	f	f
3497	2025-11-17	{"4": "1"}	f	f
3498	2025-11-18	{"4": "1"}	f	f
3499	2025-11-19	{"4": "1"}	f	f
3500	2025-11-20	{"4": "1"}	f	f
3501	2025-11-21	{"4": "1"}	f	f
3502	2025-11-22	{"4": "2"}	f	f
3503	2025-11-23	{"4": "2"}	f	f
3504	2025-11-24	{"4": "1"}	f	f
3505	2025-11-25	{"4": "1"}	f	f
3506	2025-11-26	{"4": "1"}	f	f
3507	2025-11-27	{"4": "1"}	f	f
3508	2025-11-28	{"4": "1"}	f	f
3509	2025-11-29	{"4": "2"}	f	f
3510	2025-11-30	{"4": "2"}	f	f
3511	2025-12-01	{"4": "1"}	f	f
3512	2025-12-02	{"4": "1"}	f	f
3513	2025-12-03	{"4": "1"}	f	f
3514	2025-12-04	{"4": "1"}	f	f
3515	2025-12-05	{"4": "1"}	f	f
3516	2025-12-06	{"4": "2"}	f	f
3517	2025-12-07	{"4": "2"}	f	f
3518	2025-12-08	{"4": "1"}	f	f
3519	2025-12-09	{"4": "1"}	f	f
3520	2025-12-10	{"4": "1"}	f	f
3521	2025-12-11	{"4": "1"}	f	f
3522	2025-12-12	{"4": "1"}	f	f
3523	2025-12-13	{"4": "2"}	f	f
3524	2025-12-14	{"4": "2"}	f	f
3525	2025-12-15	{"4": "1"}	f	f
3526	2025-12-16	{"4": "1"}	f	f
3527	2025-12-17	{"4": "1"}	f	f
3528	2025-12-18	{"4": "1"}	f	f
3529	2025-12-19	{"4": "1"}	f	f
3530	2025-12-20	{"4": "2"}	f	f
3531	2025-12-21	{"4": "2"}	f	f
3532	2025-12-22	{"4": "1"}	f	f
3533	2025-12-23	{"4": "1"}	f	f
3534	2025-12-24	{"4": "1"}	f	f
3535	2025-12-25	{"4": "1"}	f	f
3536	2025-12-26	{"4": "1"}	f	f
3537	2025-12-27	{"4": "2"}	f	f
3538	2025-12-28	{"4": "2"}	f	f
3539	2025-12-29	{"4": "1"}	f	f
3540	2025-12-30	{"4": "1"}	f	f
3541	2025-12-31	{"4": "1"}	f	f
3542	2026-01-01	{"4": "1"}	f	f
3543	2026-01-02	{"4": "1"}	f	f
3544	2026-01-03	{"4": "2"}	f	f
3545	2026-01-04	{"4": "2"}	f	f
3546	2026-01-05	{"4": "1"}	f	f
3547	2026-01-06	{"4": "1"}	f	f
3548	2026-01-07	{"4": "1"}	f	f
3549	2026-01-08	{"4": "1"}	f	f
3550	2026-01-09	{"4": "1"}	f	f
3551	2026-01-10	{"4": "2"}	f	f
3552	2026-01-11	{"4": "2"}	f	f
3553	2026-01-12	{"4": "1"}	f	f
3554	2026-01-13	{"4": "1"}	f	f
3555	2026-01-14	{"4": "1"}	f	f
3556	2026-01-15	{"4": "1"}	f	f
3557	2026-01-16	{"4": "1"}	f	f
3558	2026-01-17	{"4": "2"}	f	f
3559	2026-01-18	{"4": "2"}	f	f
3560	2026-01-19	{"4": "1"}	f	f
3561	2026-01-20	{"4": "1"}	f	f
3562	2026-01-21	{"4": "1"}	f	f
3563	2026-01-22	{"4": "1"}	f	f
3564	2026-01-23	{"4": "1"}	f	f
3565	2026-01-24	{"4": "2"}	f	f
3566	2026-01-25	{"4": "2"}	f	f
3567	2026-01-26	{"4": "1"}	f	f
3568	2026-01-27	{"4": "1"}	f	f
3569	2026-01-28	{"4": "1"}	f	f
3570	2026-01-29	{"4": "1"}	f	f
3571	2026-01-30	{"4": "1"}	f	f
3572	2026-01-31	{"4": "2"}	f	f
3573	2026-02-01	{"4": "2"}	f	f
3574	2026-02-02	{"4": "1"}	f	f
3575	2026-02-03	{"4": "1"}	f	f
3576	2026-02-04	{"4": "1"}	f	f
3577	2026-02-05	{"4": "1"}	f	f
3578	2026-02-06	{"4": "1"}	f	f
3579	2026-02-07	{"4": "2"}	f	f
3580	2026-02-08	{"4": "2"}	f	f
3581	2026-02-09	{"4": "1"}	f	f
3582	2026-02-10	{"4": "1"}	f	f
3583	2026-02-11	{"4": "1"}	f	f
3584	2026-02-12	{"4": "1"}	f	f
3585	2026-02-13	{"4": "1"}	f	f
3586	2026-02-14	{"4": "2"}	f	f
3587	2026-02-15	{"4": "2"}	f	f
3588	2026-02-16	{"4": "1"}	f	f
3589	2026-02-17	{"4": "1"}	f	f
3590	2026-02-18	{"4": "1"}	f	f
3591	2026-02-19	{"4": "1"}	f	f
3592	2026-02-20	{"4": "1"}	f	f
3593	2026-02-21	{"4": "2"}	f	f
3594	2026-02-22	{"4": "2"}	f	f
3595	2026-02-23	{"4": "1"}	f	f
3596	2026-02-24	{"4": "1"}	f	f
3597	2026-02-25	{"4": "1"}	f	f
3598	2026-02-26	{"4": "1"}	f	f
3599	2026-02-27	{"4": "1"}	f	f
3600	2026-02-28	{"4": "2"}	f	f
3601	2026-03-01	{"4": "2"}	f	f
3602	2026-03-02	{"4": "1"}	f	f
3603	2026-03-03	{"4": "1"}	f	f
3604	2026-03-04	{"4": "1"}	f	f
3605	2026-03-05	{"4": "1"}	f	f
3606	2026-03-06	{"4": "1"}	f	f
3607	2026-03-07	{"4": "2"}	f	f
3608	2026-03-08	{"4": "2"}	f	f
3609	2026-03-09	{"4": "1"}	f	f
3610	2026-03-10	{"4": "1"}	f	f
3611	2026-03-11	{"4": "1"}	f	f
3612	2026-03-12	{"4": "1"}	f	f
3613	2026-03-13	{"4": "1"}	f	f
3614	2026-03-14	{"4": "2"}	f	f
3615	2026-03-15	{"4": "2"}	f	f
3616	2026-03-16	{"4": "1"}	f	f
3617	2026-03-17	{"4": "1"}	f	f
3618	2026-03-18	{"4": "1"}	f	f
3619	2026-03-19	{"4": "1"}	f	f
3620	2026-03-20	{"4": "1"}	f	f
3621	2026-03-21	{"4": "2"}	f	f
3622	2026-03-22	{"4": "2"}	f	f
3623	2026-03-23	{"4": "1"}	f	f
3624	2026-03-24	{"4": "1"}	f	f
3625	2026-03-25	{"4": "1"}	f	f
3626	2026-03-26	{"4": "1"}	f	f
3627	2026-03-27	{"4": "1"}	f	f
3628	2026-03-28	{"4": "2"}	f	f
3629	2026-03-29	{"4": "2"}	f	f
3630	2026-03-30	{"4": "1"}	f	f
3631	2026-03-31	{"4": "1"}	f	f
3632	2026-04-01	{"4": "1"}	f	f
3633	2026-04-02	{"4": "1"}	f	f
3634	2026-04-03	{"4": "1"}	f	f
3635	2026-04-04	{"4": "2"}	f	f
3636	2026-04-05	{"4": "2"}	f	f
3637	2026-04-06	{"4": "1"}	f	f
3638	2026-04-07	{"4": "1"}	f	f
3639	2026-04-08	{"4": "1"}	f	f
3640	2026-04-09	{"4": "1"}	f	f
3641	2026-04-10	{"4": "1"}	f	f
3642	2026-04-11	{"4": "2"}	f	f
3643	2026-04-12	{"4": "2"}	f	f
3644	2026-04-13	{"4": "1"}	f	f
3645	2026-04-14	{"4": "1"}	f	f
3646	2026-04-15	{"4": "1"}	f	f
3647	2026-04-16	{"4": "1"}	f	f
3648	2026-04-17	{"4": "1"}	f	f
3649	2026-04-18	{"4": "2"}	f	f
3650	2026-04-19	{"4": "2"}	f	f
3651	2026-04-20	{"4": "1"}	f	f
3652	2026-04-21	{"4": "1"}	f	f
3653	2026-04-22	{"4": "1"}	f	f
3654	2026-04-23	{"4": "1"}	f	f
3655	2026-04-24	{"4": "1"}	f	f
3656	2026-04-25	{"4": "2"}	f	f
3657	2026-04-26	{"4": "2"}	f	f
3658	2026-04-27	{"4": "1"}	f	f
3659	2026-04-28	{"4": "1"}	f	f
3660	2026-04-29	{"4": "1"}	f	f
3661	2026-04-30	{"4": "1"}	f	f
3662	2026-05-01	{"4": "1"}	f	f
3663	2026-05-02	{"4": "2"}	f	f
3664	2026-05-03	{"4": "2"}	f	f
3665	2026-05-04	{"4": "1"}	f	f
3666	2026-05-05	{"4": "1"}	f	f
3667	2026-05-06	{"4": "1"}	f	f
3668	2026-05-07	{"4": "1"}	f	f
3669	2026-05-08	{"4": "1"}	f	f
3670	2026-05-09	{"4": "2"}	f	f
3671	2026-05-10	{"4": "2"}	f	f
3672	2026-05-11	{"4": "1"}	f	f
3673	2026-05-12	{"4": "1"}	f	f
3674	2026-05-13	{"4": "1"}	f	f
3675	2026-05-14	{"4": "1"}	f	f
3676	2026-05-15	{"4": "1"}	f	f
3677	2026-05-16	{"4": "2"}	f	f
3678	2026-05-17	{"4": "2"}	f	f
3679	2026-05-18	{"4": "1"}	f	f
3680	2026-05-19	{"4": "1"}	f	f
3681	2026-05-20	{"4": "1"}	f	f
3682	2026-05-21	{"4": "1"}	f	f
3683	2026-05-22	{"4": "1"}	f	f
3684	2026-05-23	{"4": "2"}	f	f
3685	2026-05-24	{"4": "2"}	f	f
3686	2026-05-25	{"4": "1"}	f	f
3687	2026-05-26	{"4": "1"}	f	f
3688	2026-05-27	{"4": "1"}	f	f
3689	2026-05-28	{"4": "1"}	f	f
3690	2026-05-29	{"4": "1"}	f	f
3691	2026-05-30	{"4": "2"}	f	f
3692	2026-05-31	{"4": "2"}	f	f
3693	2026-06-01	{"4": "1"}	f	f
3694	2026-06-02	{"4": "1"}	f	f
3695	2026-06-03	{"4": "1"}	f	f
3696	2026-06-04	{"4": "1"}	f	f
3697	2026-06-05	{"4": "1"}	f	f
3698	2026-06-06	{"4": "2"}	f	f
3699	2026-06-07	{"4": "2"}	f	f
3700	2026-06-08	{"4": "1"}	f	f
3701	2026-06-09	{"4": "1"}	f	f
3702	2026-06-10	{"4": "1"}	f	f
3703	2026-06-11	{"4": "1"}	f	f
3704	2026-06-12	{"4": "1"}	f	f
3705	2026-06-13	{"4": "2"}	f	f
3706	2026-06-14	{"4": "2"}	f	f
3707	2026-06-15	{"4": "1"}	f	f
3708	2026-06-16	{"4": "1"}	f	f
3709	2026-06-17	{"4": "1"}	f	f
3710	2026-06-18	{"4": "1"}	f	f
3711	2026-06-19	{"4": "1"}	f	f
3712	2026-06-20	{"4": "2"}	f	f
3713	2026-06-21	{"4": "2"}	f	f
3714	2026-06-22	{"4": "1"}	f	f
3715	2026-06-23	{"4": "1"}	f	f
3716	2026-06-24	{"4": "1"}	f	f
3717	2026-06-25	{"4": "1"}	f	f
3718	2026-06-26	{"4": "1"}	f	f
3719	2026-06-27	{"4": "2"}	f	f
3720	2026-06-28	{"4": "2"}	f	f
3721	2026-06-29	{"4": "1"}	f	f
3722	2026-06-30	{"4": "1"}	f	f
3723	2026-07-01	{"4": "1"}	f	f
3724	2026-07-02	{"4": "1"}	f	f
3725	2026-07-03	{"4": "1"}	f	f
3726	2026-07-04	{"4": "2"}	f	f
3727	2026-07-05	{"4": "2"}	f	f
3728	2026-07-06	{"4": "1"}	f	f
3729	2026-07-07	{"4": "1"}	f	f
3730	2026-07-08	{"4": "1"}	f	f
3731	2026-07-09	{"4": "1"}	f	f
3732	2026-07-10	{"4": "1"}	f	f
3733	2026-07-11	{"4": "2"}	f	f
3734	2026-07-12	{"4": "2"}	f	f
3735	2026-07-13	{"4": "1"}	f	f
3736	2026-07-14	{"4": "1"}	f	f
3737	2026-07-15	{"4": "1"}	f	f
3738	2026-07-16	{"4": "1"}	f	f
3739	2026-07-17	{"4": "1"}	f	f
3740	2026-07-18	{"4": "2"}	f	f
3741	2026-07-19	{"4": "2"}	f	f
3742	2026-07-20	{"4": "1"}	f	f
3743	2026-07-21	{"4": "1"}	f	f
3744	2026-07-22	{"4": "1"}	f	f
3745	2026-07-23	{"4": "1"}	f	f
3746	2026-07-24	{"4": "1"}	f	f
3747	2026-07-25	{"4": "2"}	f	f
3748	2026-07-26	{"4": "2"}	f	f
3749	2026-07-27	{"4": "1"}	f	f
3750	2026-07-28	{"4": "1"}	f	f
3751	2026-07-29	{"4": "1"}	f	f
3752	2026-07-30	{"4": "1"}	f	f
3753	2026-07-31	{"4": "1"}	f	f
3754	2026-08-01	{"4": "2"}	f	f
3755	2026-08-02	{"4": "2"}	f	f
3756	2026-08-03	{"4": "1"}	f	f
3757	2026-08-04	{"4": "1"}	f	f
3758	2026-08-05	{"4": "1"}	f	f
3759	2026-08-06	{"4": "1"}	f	f
3760	2026-08-07	{"4": "1"}	f	f
3761	2026-08-08	{"4": "2"}	f	f
3762	2026-08-09	{"4": "2"}	f	f
3763	2026-08-10	{"4": "1"}	f	f
3764	2026-08-11	{"4": "1"}	f	f
3765	2026-08-12	{"4": "1"}	f	f
3766	2026-08-13	{"4": "1"}	f	f
3767	2026-08-14	{"4": "1"}	f	f
3768	2026-08-15	{"4": "2"}	f	f
3769	2026-08-16	{"4": "2"}	f	f
3770	2026-08-17	{"4": "1"}	f	f
3771	2026-08-18	{"4": "1"}	f	f
3772	2026-08-19	{"4": "1"}	f	f
3773	2026-08-20	{"4": "1"}	f	f
3774	2026-08-21	{"4": "1"}	f	f
3775	2026-08-22	{"4": "2"}	f	f
3776	2026-08-23	{"4": "2"}	f	f
3777	2026-08-24	{"4": "1"}	f	f
3778	2026-08-25	{"4": "1"}	f	f
3779	2026-08-26	{"4": "1"}	f	f
3780	2026-08-27	{"4": "1"}	f	f
3781	2026-08-28	{"4": "1"}	f	f
3782	2026-08-29	{"4": "2"}	f	f
3783	2026-08-30	{"4": "2"}	f	f
3784	2026-08-31	{"4": "1"}	f	f
3785	2026-09-01	{"4": "1"}	f	f
3786	2026-09-02	{"4": "1"}	f	f
3787	2026-09-03	{"4": "1"}	f	f
3788	2026-09-04	{"4": "1"}	f	f
3789	2026-09-05	{"4": "2"}	f	f
3790	2026-09-06	{"4": "2"}	f	f
3791	2026-09-07	{"4": "1"}	f	f
3792	2026-09-08	{"4": "1"}	f	f
3793	2026-09-09	{"4": "1"}	f	f
3794	2026-09-10	{"4": "1"}	f	f
3795	2026-09-11	{"4": "1"}	f	f
3796	2026-09-12	{"4": "2"}	f	f
3797	2026-09-13	{"4": "2"}	f	f
3798	2026-09-14	{"4": "1"}	f	f
3799	2026-09-15	{"4": "1"}	f	f
3800	2026-09-16	{"4": "1"}	f	f
3801	2026-09-17	{"4": "1"}	f	f
3802	2026-09-18	{"4": "1"}	f	f
3803	2026-09-19	{"4": "2"}	f	f
3804	2026-09-20	{"4": "2"}	f	f
3805	2026-09-21	{"4": "1"}	f	f
3806	2026-09-22	{"4": "1"}	f	f
3807	2026-09-23	{"4": "1"}	f	f
3808	2026-09-24	{"4": "1"}	f	f
3809	2026-09-25	{"4": "1"}	f	f
3810	2026-09-26	{"4": "2"}	f	f
3811	2026-09-27	{"4": "2"}	f	f
3812	2026-09-28	{"4": "1"}	f	f
3813	2026-09-29	{"4": "1"}	f	f
3814	2026-09-30	{"4": "1"}	f	f
3815	2026-10-01	{"4": "1"}	f	f
3816	2026-10-02	{"4": "1"}	f	f
3817	2026-10-03	{"4": "2"}	f	f
3818	2026-10-04	{"4": "2"}	f	f
3819	2026-10-05	{"4": "1"}	f	f
3820	2026-10-06	{"4": "1"}	f	f
3821	2026-10-07	{"4": "1"}	f	f
3822	2026-10-08	{"4": "1"}	f	f
3823	2026-10-09	{"4": "1"}	f	f
3824	2026-10-10	{"4": "2"}	f	f
3825	2026-10-11	{"4": "2"}	f	f
3826	2026-10-12	{"4": "1"}	f	f
3827	2026-10-13	{"4": "1"}	f	f
3828	2026-10-14	{"4": "1"}	f	f
3829	2026-10-15	{"4": "1"}	f	f
3830	2026-10-16	{"4": "1"}	f	f
3831	2026-10-17	{"4": "2"}	f	f
3832	2026-10-18	{"4": "2"}	f	f
3833	2026-10-19	{"4": "1"}	f	f
3834	2026-10-20	{"4": "1"}	f	f
3835	2026-10-21	{"4": "1"}	f	f
3836	2026-10-22	{"4": "1"}	f	f
3837	2026-10-23	{"4": "1"}	f	f
3838	2026-10-24	{"4": "2"}	f	f
3839	2026-10-25	{"4": "2"}	f	f
3840	2026-10-26	{"4": "1"}	f	f
3841	2026-10-27	{"4": "1"}	f	f
3842	2026-10-28	{"4": "1"}	f	f
3843	2026-10-29	{"4": "1"}	f	f
3844	2026-10-30	{"4": "1"}	f	f
3845	2026-10-31	{"4": "2"}	f	f
3846	2026-11-01	{"4": "2"}	f	f
3847	2026-11-02	{"4": "1"}	f	f
3848	2026-11-03	{"4": "1"}	f	f
3849	2026-11-04	{"4": "1"}	f	f
3850	2026-11-05	{"4": "1"}	f	f
3851	2026-11-06	{"4": "1"}	f	f
3852	2026-11-07	{"4": "2"}	f	f
3853	2026-11-08	{"4": "2"}	f	f
3854	2026-11-09	{"4": "1"}	f	f
3855	2026-11-10	{"4": "1"}	f	f
3856	2026-11-11	{"4": "1"}	f	f
3857	2026-11-12	{"4": "1"}	f	f
3858	2026-11-13	{"4": "1"}	f	f
3859	2026-11-14	{"4": "2"}	f	f
3860	2026-11-15	{"4": "2"}	f	f
3861	2026-11-16	{"4": "1"}	f	f
3862	2026-11-17	{"4": "1"}	f	f
3863	2026-11-18	{"4": "1"}	f	f
3864	2026-11-19	{"4": "1"}	f	f
3865	2026-11-20	{"4": "1"}	f	f
3866	2026-11-21	{"4": "2"}	f	f
3867	2026-11-22	{"4": "2"}	f	f
3868	2026-11-23	{"4": "1"}	f	f
3869	2026-11-24	{"4": "1"}	f	f
3870	2026-11-25	{"4": "1"}	f	f
3871	2026-11-26	{"4": "1"}	f	f
3872	2026-11-27	{"4": "1"}	f	f
3873	2026-11-28	{"4": "2"}	f	f
3874	2026-11-29	{"4": "2"}	f	f
3875	2026-11-30	{"4": "1"}	f	f
3876	2026-12-01	{"4": "1"}	f	f
3877	2026-12-02	{"4": "1"}	f	f
3878	2026-12-03	{"4": "1"}	f	f
3879	2026-12-04	{"4": "1"}	f	f
3880	2026-12-05	{"4": "2"}	f	f
3881	2026-12-06	{"4": "2"}	f	f
3882	2026-12-07	{"4": "1"}	f	f
3883	2026-12-08	{"4": "1"}	f	f
3884	2026-12-09	{"4": "1"}	f	f
3885	2026-12-10	{"4": "1"}	f	f
3886	2026-12-11	{"4": "1"}	f	f
3887	2026-12-12	{"4": "2"}	f	f
3888	2026-12-13	{"4": "2"}	f	f
3889	2026-12-14	{"4": "1"}	f	f
3890	2026-12-15	{"4": "1"}	f	f
3891	2026-12-16	{"4": "1"}	f	f
3892	2026-12-17	{"4": "1"}	f	f
3893	2026-12-18	{"4": "1"}	f	f
3894	2026-12-19	{"4": "2"}	f	f
3895	2026-12-20	{"4": "2"}	f	f
3896	2026-12-21	{"4": "1"}	f	f
3897	2026-12-22	{"4": "1"}	f	f
3898	2026-12-23	{"4": "1"}	f	f
3899	2026-12-24	{"4": "1"}	f	f
3900	2026-12-25	{"4": "1"}	f	f
3901	2026-12-26	{"4": "2"}	f	f
3902	2026-12-27	{"4": "2"}	f	f
3903	2026-12-28	{"4": "1"}	f	f
3904	2026-12-29	{"4": "1"}	f	f
3905	2026-12-30	{"4": "1"}	f	f
3906	2026-12-31	{"4": "1"}	f	f
3907	2027-01-01	{"4": "1"}	f	f
3908	2027-01-02	{"4": "2"}	f	f
3909	2027-01-03	{"4": "2"}	f	f
3910	2027-01-04	{"4": "1"}	f	f
3911	2027-01-05	{"4": "1"}	f	f
3912	2027-01-06	{"4": "1"}	f	f
3913	2027-01-07	{"4": "1"}	f	f
3914	2027-01-08	{"4": "1"}	f	f
3915	2027-01-09	{"4": "2"}	f	f
3916	2027-01-10	{"4": "2"}	f	f
3917	2027-01-11	{"4": "1"}	f	f
3918	2027-01-12	{"4": "1"}	f	f
3919	2027-01-13	{"4": "1"}	f	f
3920	2027-01-14	{"4": "1"}	f	f
3921	2027-01-15	{"4": "1"}	f	f
3922	2027-01-16	{"4": "2"}	f	f
3923	2027-01-17	{"4": "2"}	f	f
3924	2027-01-18	{"4": "1"}	f	f
3925	2027-01-19	{"4": "1"}	f	f
3926	2027-01-20	{"4": "1"}	f	f
3927	2027-01-21	{"4": "1"}	f	f
3928	2027-01-22	{"4": "1"}	f	f
3929	2027-01-23	{"4": "2"}	f	f
3930	2027-01-24	{"4": "2"}	f	f
3931	2027-01-25	{"4": "1"}	f	f
3932	2027-01-26	{"4": "1"}	f	f
3933	2027-01-27	{"4": "1"}	f	f
3934	2027-01-28	{"4": "1"}	f	f
3935	2027-01-29	{"4": "1"}	f	f
3936	2027-01-30	{"4": "2"}	f	f
3937	2027-01-31	{"4": "2"}	f	f
3938	2027-02-01	{"4": "1"}	f	f
3939	2027-02-02	{"4": "1"}	f	f
3940	2027-02-03	{"4": "1"}	f	f
3941	2027-02-04	{"4": "1"}	f	f
3942	2027-02-05	{"4": "1"}	f	f
3943	2027-02-06	{"4": "2"}	f	f
3944	2027-02-07	{"4": "2"}	f	f
3945	2027-02-08	{"4": "1"}	f	f
3946	2027-02-09	{"4": "1"}	f	f
3947	2027-02-10	{"4": "1"}	f	f
3948	2027-02-11	{"4": "1"}	f	f
3949	2027-02-12	{"4": "1"}	f	f
3950	2027-02-13	{"4": "2"}	f	f
3951	2027-02-14	{"4": "2"}	f	f
3952	2027-02-15	{"4": "1"}	f	f
3953	2027-02-16	{"4": "1"}	f	f
3954	2027-02-17	{"4": "1"}	f	f
3955	2027-02-18	{"4": "1"}	f	f
3956	2027-02-19	{"4": "1"}	f	f
3957	2027-02-20	{"4": "2"}	f	f
3958	2027-02-21	{"4": "2"}	f	f
3959	2027-02-22	{"4": "1"}	f	f
3960	2027-02-23	{"4": "1"}	f	f
3961	2027-02-24	{"4": "1"}	f	f
3962	2027-02-25	{"4": "1"}	f	f
3963	2027-02-26	{"4": "1"}	f	f
3964	2027-02-27	{"4": "2"}	f	f
3965	2027-02-28	{"4": "2"}	f	f
3966	2027-03-01	{"4": "1"}	f	f
3967	2027-03-02	{"4": "1"}	f	f
3968	2027-03-03	{"4": "1"}	f	f
3969	2027-03-04	{"4": "1"}	f	f
3970	2027-03-05	{"4": "1"}	f	f
3971	2027-03-06	{"4": "2"}	f	f
3972	2027-03-07	{"4": "2"}	f	f
3973	2027-03-08	{"4": "1"}	f	f
3974	2027-03-09	{"4": "1"}	f	f
3975	2027-03-10	{"4": "1"}	f	f
3976	2027-03-11	{"4": "1"}	f	f
3977	2027-03-12	{"4": "1"}	f	f
3978	2027-03-13	{"4": "2"}	f	f
3979	2027-03-14	{"4": "2"}	f	f
3980	2027-03-15	{"4": "1"}	f	f
3981	2027-03-16	{"4": "1"}	f	f
3982	2027-03-17	{"4": "1"}	f	f
3983	2027-03-18	{"4": "1"}	f	f
3984	2027-03-19	{"4": "1"}	f	f
3985	2027-03-20	{"4": "2"}	f	f
3986	2027-03-21	{"4": "2"}	f	f
3987	2027-03-22	{"4": "1"}	f	f
3988	2027-03-23	{"4": "1"}	f	f
3989	2027-03-24	{"4": "1"}	f	f
3990	2027-03-25	{"4": "1"}	f	f
3991	2027-03-26	{"4": "1"}	f	f
3992	2027-03-27	{"4": "2"}	f	f
3993	2027-03-28	{"4": "2"}	f	f
3994	2027-03-29	{"4": "1"}	f	f
3995	2027-03-30	{"4": "1"}	f	f
3996	2027-03-31	{"4": "1"}	f	f
3997	2027-04-01	{"4": "1"}	f	f
3998	2027-04-02	{"4": "1"}	f	f
3999	2027-04-03	{"4": "2"}	f	f
4000	2027-04-04	{"4": "2"}	f	f
4001	2027-04-05	{"4": "1"}	f	f
4002	2027-04-06	{"4": "1"}	f	f
4003	2027-04-07	{"4": "1"}	f	f
4004	2027-04-08	{"4": "1"}	f	f
4005	2027-04-09	{"4": "1"}	f	f
4006	2027-04-10	{"4": "2"}	f	f
4007	2027-04-11	{"4": "2"}	f	f
4008	2027-04-12	{"4": "1"}	f	f
4009	2027-04-13	{"4": "1"}	f	f
4010	2027-04-14	{"4": "1"}	f	f
4011	2027-04-15	{"4": "1"}	f	f
4012	2027-04-16	{"4": "1"}	f	f
4013	2027-04-17	{"4": "2"}	f	f
4014	2027-04-18	{"4": "2"}	f	f
4015	2027-04-19	{"4": "1"}	f	f
4016	2027-04-20	{"4": "1"}	f	f
4017	2027-04-21	{"4": "1"}	f	f
4018	2027-04-22	{"4": "1"}	f	f
4019	2027-04-23	{"4": "1"}	f	f
4020	2027-04-24	{"4": "2"}	f	f
4021	2027-04-25	{"4": "2"}	f	f
4022	2027-04-26	{"4": "1"}	f	f
4023	2027-04-27	{"4": "1"}	f	f
4024	2027-04-28	{"4": "1"}	f	f
4025	2027-04-29	{"4": "1"}	f	f
4026	2027-04-30	{"4": "1"}	f	f
4027	2027-05-01	{"4": "2"}	f	f
4028	2027-05-02	{"4": "2"}	f	f
4029	2027-05-03	{"4": "1"}	f	f
4030	2027-05-04	{"4": "1"}	f	f
4031	2027-05-05	{"4": "1"}	f	f
4032	2027-05-06	{"4": "1"}	f	f
4033	2027-05-07	{"4": "1"}	f	f
4034	2027-05-08	{"4": "2"}	f	f
4035	2027-05-09	{"4": "2"}	f	f
4036	2027-05-10	{"4": "1"}	f	f
4037	2027-05-11	{"4": "1"}	f	f
4038	2027-05-12	{"4": "1"}	f	f
4039	2027-05-13	{"4": "1"}	f	f
4040	2027-05-14	{"4": "1"}	f	f
4041	2027-05-15	{"4": "2"}	f	f
4042	2027-05-16	{"4": "2"}	f	f
4043	2027-05-17	{"4": "1"}	f	f
4044	2027-05-18	{"4": "1"}	f	f
4045	2027-05-19	{"4": "1"}	f	f
4046	2027-05-20	{"4": "1"}	f	f
4047	2027-05-21	{"4": "1"}	f	f
4048	2027-05-22	{"4": "2"}	f	f
4049	2027-05-23	{"4": "2"}	f	f
4050	2027-05-24	{"4": "1"}	f	f
4051	2027-05-25	{"4": "1"}	f	f
4052	2027-05-26	{"4": "1"}	f	f
4053	2027-05-27	{"4": "1"}	f	f
4054	2027-05-28	{"4": "1"}	f	f
4055	2027-05-29	{"4": "2"}	f	f
4056	2027-05-30	{"4": "2"}	f	f
4057	2027-05-31	{"4": "1"}	f	f
4058	2027-06-01	{"4": "1"}	f	f
4059	2027-06-02	{"4": "1"}	f	f
4060	2027-06-03	{"4": "1"}	f	f
4061	2027-06-04	{"4": "1"}	f	f
4062	2027-06-05	{"4": "2"}	f	f
4063	2027-06-06	{"4": "2"}	f	f
4064	2027-06-07	{"4": "1"}	f	f
4065	2027-06-08	{"4": "1"}	f	f
4066	2027-06-09	{"4": "1"}	f	f
4067	2027-06-10	{"4": "1"}	f	f
4068	2027-06-11	{"4": "1"}	f	f
4069	2027-06-12	{"4": "2"}	f	f
4070	2027-06-13	{"4": "2"}	f	f
4071	2027-06-14	{"4": "1"}	f	f
4072	2027-06-15	{"4": "1"}	f	f
4073	2027-06-16	{"4": "1"}	f	f
4074	2027-06-17	{"4": "1"}	f	f
4075	2027-06-18	{"4": "1"}	f	f
4076	2027-06-19	{"4": "2"}	f	f
4077	2027-06-20	{"4": "2"}	f	f
4078	2027-06-21	{"4": "1"}	f	f
4079	2027-06-22	{"4": "1"}	f	f
4080	2027-06-23	{"4": "1"}	f	f
4081	2027-06-24	{"4": "1"}	f	f
4082	2027-06-25	{"4": "1"}	f	f
4083	2027-06-26	{"4": "2"}	f	f
4084	2027-06-27	{"4": "2"}	f	f
4085	2027-06-28	{"4": "1"}	f	f
4086	2027-06-29	{"4": "1"}	f	f
4087	2027-06-30	{"4": "1"}	f	f
4088	2027-07-01	{"4": "1"}	f	f
4089	2027-07-02	{"4": "1"}	f	f
4090	2027-07-03	{"4": "2"}	f	f
4091	2027-07-04	{"4": "2"}	f	f
4092	2027-07-05	{"4": "1"}	f	f
4093	2027-07-06	{"4": "1"}	f	f
4094	2027-07-07	{"4": "1"}	f	f
4095	2027-07-08	{"4": "1"}	f	f
4096	2027-07-09	{"4": "1"}	f	f
4097	2027-07-10	{"4": "2"}	f	f
4098	2027-07-11	{"4": "2"}	f	f
4099	2027-07-12	{"4": "1"}	f	f
4100	2027-07-13	{"4": "1"}	f	f
4101	2027-07-14	{"4": "1"}	f	f
4102	2027-07-15	{"4": "1"}	f	f
4103	2027-07-16	{"4": "1"}	f	f
4104	2027-07-17	{"4": "2"}	f	f
4105	2027-07-18	{"4": "2"}	f	f
4106	2027-07-19	{"4": "1"}	f	f
4107	2027-07-20	{"4": "1"}	f	f
4108	2027-07-21	{"4": "1"}	f	f
4109	2027-07-22	{"4": "1"}	f	f
4110	2027-07-23	{"4": "1"}	f	f
4111	2027-07-24	{"4": "2"}	f	f
4112	2027-07-25	{"4": "2"}	f	f
4113	2027-07-26	{"4": "1"}	f	f
4114	2027-07-27	{"4": "1"}	f	f
4115	2027-07-28	{"4": "1"}	f	f
4116	2027-07-29	{"4": "1"}	f	f
4117	2027-07-30	{"4": "1"}	f	f
4118	2027-07-31	{"4": "2"}	f	f
4119	2027-08-01	{"4": "2"}	f	f
4120	2027-08-02	{"4": "1"}	f	f
4121	2027-08-03	{"4": "1"}	f	f
4122	2027-08-04	{"4": "1"}	f	f
4123	2027-08-05	{"4": "1"}	f	f
4124	2027-08-06	{"4": "1"}	f	f
4125	2027-08-07	{"4": "2"}	f	f
4126	2027-08-08	{"4": "2"}	f	f
4127	2027-08-09	{"4": "1"}	f	f
4128	2027-08-10	{"4": "1"}	f	f
4129	2027-08-11	{"4": "1"}	f	f
4130	2027-08-12	{"4": "1"}	f	f
4131	2027-08-13	{"4": "1"}	f	f
4132	2027-08-14	{"4": "2"}	f	f
4133	2027-08-15	{"4": "2"}	f	f
4134	2027-08-16	{"4": "1"}	f	f
4135	2027-08-17	{"4": "1"}	f	f
4136	2027-08-18	{"4": "1"}	f	f
4137	2027-08-19	{"4": "1"}	f	f
4138	2027-08-20	{"4": "1"}	f	f
4139	2027-08-21	{"4": "2"}	f	f
4140	2027-08-22	{"4": "2"}	f	f
4141	2027-08-23	{"4": "1"}	f	f
4142	2027-08-24	{"4": "1"}	f	f
4143	2027-08-25	{"4": "1"}	f	f
4144	2027-08-26	{"4": "1"}	f	f
4145	2027-08-27	{"4": "1"}	f	f
4146	2027-08-28	{"4": "2"}	f	f
4147	2027-08-29	{"4": "2"}	f	f
4148	2027-08-30	{"4": "1"}	f	f
4149	2027-08-31	{"4": "1"}	f	f
4150	2027-09-01	{"4": "1"}	f	f
4151	2027-09-02	{"4": "1"}	f	f
4152	2027-09-03	{"4": "1"}	f	f
4153	2027-09-04	{"4": "2"}	f	f
4154	2027-09-05	{"4": "2"}	f	f
4155	2027-09-06	{"4": "1"}	f	f
4156	2027-09-07	{"4": "1"}	f	f
4157	2027-09-08	{"4": "1"}	f	f
4158	2027-09-09	{"4": "1"}	f	f
4159	2027-09-10	{"4": "1"}	f	f
4160	2027-09-11	{"4": "2"}	f	f
4161	2027-09-12	{"4": "2"}	f	f
4162	2027-09-13	{"4": "1"}	f	f
4163	2027-09-14	{"4": "1"}	f	f
4164	2027-09-15	{"4": "1"}	f	f
4165	2027-09-16	{"4": "1"}	f	f
4166	2027-09-17	{"4": "1"}	f	f
4167	2027-09-18	{"4": "2"}	f	f
4168	2027-09-19	{"4": "2"}	f	f
4169	2027-09-20	{"4": "1"}	f	f
4170	2027-09-21	{"4": "1"}	f	f
4171	2027-09-22	{"4": "1"}	f	f
4172	2027-09-23	{"4": "1"}	f	f
4173	2027-09-24	{"4": "1"}	f	f
4174	2027-09-25	{"4": "2"}	f	f
4175	2027-09-26	{"4": "2"}	f	f
4176	2027-09-27	{"4": "1"}	f	f
4177	2027-09-28	{"4": "1"}	f	f
4178	2027-09-29	{"4": "1"}	f	f
4179	2027-09-30	{"4": "1"}	f	f
4180	2027-10-01	{"4": "1"}	f	f
4181	2027-10-02	{"4": "2"}	f	f
4182	2027-10-03	{"4": "2"}	f	f
4183	2027-10-04	{"4": "1"}	f	f
4184	2027-10-05	{"4": "1"}	f	f
4185	2027-10-06	{"4": "1"}	f	f
4186	2027-10-07	{"4": "1"}	f	f
4187	2027-10-08	{"4": "1"}	f	f
4188	2027-10-09	{"4": "2"}	f	f
4189	2027-10-10	{"4": "2"}	f	f
4190	2027-10-11	{"4": "1"}	f	f
4191	2027-10-12	{"4": "1"}	f	f
4192	2027-10-13	{"4": "1"}	f	f
4193	2027-10-14	{"4": "1"}	f	f
4194	2027-10-15	{"4": "1"}	f	f
4195	2027-10-16	{"4": "2"}	f	f
4196	2027-10-17	{"4": "2"}	f	f
4197	2027-10-18	{"4": "1"}	f	f
4198	2027-10-19	{"4": "1"}	f	f
4199	2027-10-20	{"4": "1"}	f	f
4200	2027-10-21	{"4": "1"}	f	f
4201	2027-10-22	{"4": "1"}	f	f
4202	2027-10-23	{"4": "2"}	f	f
4203	2027-10-24	{"4": "2"}	f	f
4204	2027-10-25	{"4": "1"}	f	f
4205	2027-10-26	{"4": "1"}	f	f
4206	2027-10-27	{"4": "1"}	f	f
4207	2027-10-28	{"4": "1"}	f	f
4208	2027-10-29	{"4": "1"}	f	f
4209	2027-10-30	{"4": "2"}	f	f
4210	2027-10-31	{"4": "2"}	f	f
4211	2027-11-01	{"4": "1"}	f	f
4212	2027-11-02	{"4": "1"}	f	f
4213	2027-11-03	{"4": "1"}	f	f
4214	2027-11-04	{"4": "1"}	f	f
4215	2027-11-05	{"4": "1"}	f	f
4216	2027-11-06	{"4": "2"}	f	f
4217	2027-11-07	{"4": "2"}	f	f
4218	2027-11-08	{"4": "1"}	f	f
4219	2027-11-09	{"4": "1"}	f	f
4220	2027-11-10	{"4": "1"}	f	f
4221	2027-11-11	{"4": "1"}	f	f
4222	2027-11-12	{"4": "1"}	f	f
4223	2027-11-13	{"4": "2"}	f	f
4224	2027-11-14	{"4": "2"}	f	f
4225	2027-11-15	{"4": "1"}	f	f
4226	2027-11-16	{"4": "1"}	f	f
4227	2027-11-17	{"4": "1"}	f	f
4228	2027-11-18	{"4": "1"}	f	f
4229	2027-11-19	{"4": "1"}	f	f
4230	2027-11-20	{"4": "2"}	f	f
4231	2027-11-21	{"4": "2"}	f	f
4232	2027-11-22	{"4": "1"}	f	f
4233	2027-11-23	{"4": "1"}	f	f
4234	2027-11-24	{"4": "1"}	f	f
4235	2027-11-25	{"4": "1"}	f	f
4236	2027-11-26	{"4": "1"}	f	f
4237	2027-11-27	{"4": "2"}	f	f
4238	2027-11-28	{"4": "2"}	f	f
4239	2027-11-29	{"4": "1"}	f	f
4240	2027-11-30	{"4": "1"}	f	f
4241	2027-12-01	{"4": "1"}	f	f
4242	2027-12-02	{"4": "1"}	f	f
4243	2027-12-03	{"4": "1"}	f	f
4244	2027-12-04	{"4": "2"}	f	f
4245	2027-12-05	{"4": "2"}	f	f
4246	2027-12-06	{"4": "1"}	f	f
4247	2027-12-07	{"4": "1"}	f	f
4248	2027-12-08	{"4": "1"}	f	f
4249	2027-12-09	{"4": "1"}	f	f
4250	2027-12-10	{"4": "1"}	f	f
4251	2027-12-11	{"4": "2"}	f	f
4252	2027-12-12	{"4": "2"}	f	f
4253	2027-12-13	{"4": "1"}	f	f
4254	2027-12-14	{"4": "1"}	f	f
4255	2027-12-15	{"4": "1"}	f	f
4256	2027-12-16	{"4": "1"}	f	f
4257	2027-12-17	{"4": "1"}	f	f
4258	2027-12-18	{"4": "2"}	f	f
4259	2027-12-19	{"4": "2"}	f	f
4260	2027-12-20	{"4": "1"}	f	f
4261	2027-12-21	{"4": "1"}	f	f
4262	2027-12-22	{"4": "1"}	f	f
4263	2027-12-23	{"4": "1"}	f	f
4264	2027-12-24	{"4": "1"}	f	f
4265	2027-12-25	{"4": "2"}	f	f
4266	2027-12-26	{"4": "2"}	f	f
4267	2027-12-27	{"4": "1"}	f	f
4268	2027-12-28	{"4": "1"}	f	f
4269	2027-12-29	{"4": "1"}	f	f
4270	2027-12-30	{"4": "1"}	f	f
4271	2027-12-31	{"4": "1"}	f	f
\.


--
-- Data for Name: demand_demandofstation; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.demand_demandofstation (id, level, config1, config2, shift_id, station_id) FROM stdin;
17	1	8	9	80	13
18	2	0	0	80	13
19	1	5	6	81	13
20	2	0	0	81	13
21	1	4	5	83	13
22	2	0	0	83	13
\.


--
-- Data for Name: demand_demandusertable; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.demand_demandusertable (id, demand_id, user_id) FROM stdin;
32	17	64
33	17	65
34	17	51
35	17	57
36	17	71
37	17	78
38	17	79
40	18	47
41	18	69
42	18	46
43	19	63
44	19	67
45	19	73
47	19	66
48	19	55
49	20	56
54	21	53
55	21	54
56	22	68
59	21	49
60	21	50
62	20	62
65	22	80
66	22	60
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	account	customuser
7	account	department
8	account	liscense
9	account	departmentmanager
10	result	timeadjustment
11	result	historyresult
12	result	exchangeapplication
13	result	result
14	result	preresult
15	result	afterresult
16	station	station
17	demand	demandofstation
18	demand	demandusertable
19	shift	shift
20	date	h_calendar
21	remarks	remarksquare
22	remarks	resultremark
23	remarks	preresultremark
24	remarks	userremark
25	reservation	reservation
26	reservation	promiseshift
27	notifications	notification
28	authtoken	token
29	authtoken	tokenproxy
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-04-27 02:14:20.092722+00
2	contenttypes	0002_remove_content_type_name	2026-04-27 02:14:20.115456+00
3	auth	0001_initial	2026-04-27 02:14:20.270241+00
4	auth	0002_alter_permission_name_max_length	2026-04-27 02:14:20.280842+00
5	auth	0003_alter_user_email_max_length	2026-04-27 02:14:20.290939+00
6	auth	0004_alter_user_username_opts	2026-04-27 02:14:20.302252+00
7	auth	0005_alter_user_last_login_null	2026-04-27 02:14:20.313918+00
8	auth	0006_require_contenttypes_0002	2026-04-27 02:14:20.319472+00
9	auth	0007_alter_validators_add_error_messages	2026-04-27 02:14:20.328605+00
10	auth	0008_alter_user_username_max_length	2026-04-27 02:14:20.337146+00
11	auth	0009_alter_user_last_name_max_length	2026-04-27 02:14:20.345952+00
12	auth	0010_alter_group_name_max_length	2026-04-27 02:14:20.359229+00
13	auth	0011_update_proxy_permissions	2026-04-27 02:14:20.367869+00
14	account	0001_initial	2026-04-27 02:14:20.680606+00
15	account	0002_alter_customuser_first_name	2026-04-27 02:14:20.695709+00
16	admin	0001_initial	2026-04-27 02:14:20.77333+00
17	admin	0002_logentry_remove_auto_add	2026-04-27 02:14:20.787674+00
18	admin	0003_logentry_add_action_flag_choices	2026-04-27 02:14:20.802332+00
19	auth	0012_alter_user_first_name_max_length	2026-04-27 02:14:20.815069+00
20	date	0001_initial	2026-04-27 02:14:20.848233+00
21	station	0001_initial	2026-04-27 02:14:20.904476+00
22	shift	0001_initial	2026-04-27 02:14:20.959722+00
23	demand	0001_initial	2026-04-27 02:14:21.091504+00
24	notifications	0001_initial	2026-04-27 02:14:21.194921+00
25	notifications	0002_auto_20150224_1134	2026-04-27 02:14:21.267218+00
26	notifications	0003_notification_data	2026-04-27 02:14:21.28549+00
27	notifications	0004_auto_20150826_1508	2026-04-27 02:14:21.302107+00
28	notifications	0005_auto_20160504_1520	2026-04-27 02:14:21.31888+00
29	notifications	0006_indexes	2026-04-27 02:14:21.405606+00
30	notifications	0007_add_timestamp_index	2026-04-27 02:14:21.432539+00
31	notifications	0008_index_together_recipient_unread	2026-04-27 02:14:21.460499+00
32	notifications	0009_alter_notification_options_and_more	2026-04-27 02:14:21.633976+00
33	result	0001_initial	2026-04-27 02:14:22.123462+00
34	remarks	0001_initial	2026-04-27 02:14:22.415683+00
35	reservation	0001_initial	2026-04-27 02:14:22.538704+00
36	sessions	0001_initial	2026-04-27 02:14:22.589091+00
37	authtoken	0001_initial	2026-04-27 02:49:14.250931+00
38	authtoken	0002_auto_20160226_1747	2026-04-27 02:49:14.33756+00
39	authtoken	0003_tokenproxy	2026-04-27 02:49:14.346723+00
40	authtoken	0004_alter_tokenproxy_options	2026-04-27 02:49:14.357495+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
mah0a32yz5yadhgc1q2bupzjhmvnoof1	.eJxVjDsOwjAQRO_iGlnBv40p6TmDtbu2cQDZUpxUiLuTSClgynlv5i0CrksJa09zmKK4CKPE6bck5GeqO4kPrPcmudVlnkjuijxol7cW0-t6uH8HBXvZ1mcAVslZIqPA4gBIMIIft1BK3uEwONYRSNvsPHo2JmqXmTJHQ6jE5wv_ETh7:1wHbUu:H2RZmfjyS-Ci1TmonHOKH9xO1pxlQCEsq4-qT0D1znk	2026-05-12 06:00:40.133507+00
wdzm9wjzmh4jk3fspofohzikaxsqi3s4	.eJxVjDsOwjAQRO_iGlnBv40p6TmDtbu2cQDZUpxUiLuTSClgynlv5i0CrksJa09zmKK4CKPE6bck5GeqO4kPrPcmudVlnkjuijxol7cW0-t6uH8HBXvZ1mcAVslZIqPA4gBIMIIft1BK3uEwONYRSNvsPHo2JmqXmTJHQ6jE5wv_ETh7:1wHbYV:JDTKF6BqRa3hz35kOKmplCh5lSu0jnkRKCVo2KhC9dg	2026-05-12 06:04:23.033269+00
\.


--
-- Data for Name: notifications_notification; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.notifications_notification (id, level, unread, actor_object_id, verb, description, target_object_id, action_object_object_id, "timestamp", public, action_object_content_type_id, actor_content_type_id, recipient_id, target_content_type_id, deleted, emailed, data) FROM stdin;
\.


--
-- Data for Name: remarks_preresultremark; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.remarks_preresultremark (id, content_id, result_id) FROM stdin;
\.


--
-- Data for Name: remarks_remarksquare; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.remarks_remarksquare (id, content, department_id) FROM stdin;
4	上課	\N
8	aaa	4
9	bbbb2	4
10	cccc	4
\.


--
-- Data for Name: remarks_resultremark; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.remarks_resultremark (id, content_id, result_id) FROM stdin;
\.


--
-- Data for Name: remarks_userremark; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.remarks_userremark (id, month, content, user_id) FROM stdin;
\.


--
-- Data for Name: reservation_promiseshift; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.reservation_promiseshift (id, date, shift_type, hours, remark, user_id) FROM stdin;
8	2020-10-16	0	4		45
9	2020-09-22	3	4		45
10	2020-10-30	7	8		45
11	2020-09-29	0	4		45
12	2020-09-30	7	8		45
14	2020-09-23	3	3	白班	46
16	2020-11-01	0	4		46
17	2020-11-01	0	3		45
18	2020-11-01	1	4		47
\.


--
-- Data for Name: reservation_reservation; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.reservation_reservation (id, date, user_id) FROM stdin;
144	2020-09-17	47
145	2020-09-18	47
146	2020-09-06	69
147	2020-09-07	69
148	2020-09-08	69
149	2020-09-14	69
150	2020-09-08	62
151	2020-09-09	62
152	2020-09-14	62
153	2020-09-06	46
154	2020-09-13	46
155	2020-09-14	46
156	2020-09-19	46
157	2020-09-20	46
160	2020-09-21	64
161	2020-09-22	64
162	2020-09-10	65
163	2020-09-11	65
164	2020-09-10	51
165	2020-09-11	51
166	2020-09-29	57
167	2020-09-30	57
168	2020-09-13	78
169	2020-09-19	78
170	2020-09-22	78
172	2020-09-06	79
173	2020-09-07	79
174	2020-09-08	79
175	2020-09-29	63
176	2020-09-30	63
179	2020-09-11	80
180	2020-09-12	80
182	2020-09-10	73
183	2020-09-10	66
184	2020-09-15	66
185	2020-09-14	67
186	2020-09-08	56
187	2020-09-09	56
188	2020-09-19	55
189	2020-09-20	55
190	2020-09-17	60
191	2020-09-18	60
192	2020-09-25	45
193	2020-09-26	45
197	2020-09-10	49
198	2020-09-16	49
199	2020-09-17	49
200	2020-09-13	50
201	2020-09-14	50
203	2020-09-20	53
204	2020-09-21	53
205	2020-09-25	68
206	2020-09-26	68
208	2020-09-09	54
209	2020-09-13	54
210	2020-11-09	54
211	2020-11-13	54
212	2020-11-25	68
213	2020-11-26	68
214	2020-11-20	53
215	2020-11-21	53
216	2020-11-13	50
217	2020-11-14	50
218	2020-11-10	49
219	2020-11-16	49
220	2020-11-17	49
221	2020-11-25	45
222	2020-11-26	45
223	2020-11-17	60
224	2020-11-18	60
225	2020-11-19	55
226	2020-11-20	55
227	2020-11-08	56
228	2020-11-09	56
229	2020-11-14	67
230	2020-11-10	66
231	2020-11-15	66
232	2020-11-10	73
235	2020-11-11	80
236	2020-11-12	80
237	2020-11-29	63
238	2020-11-30	63
239	2020-11-06	79
240	2020-11-07	79
241	2020-11-08	79
242	2020-11-13	78
243	2020-11-19	78
244	2020-11-22	78
245	2020-11-29	57
246	2020-11-30	57
247	2020-11-10	51
248	2020-11-11	51
249	2020-11-10	65
250	2020-11-11	65
251	2020-11-21	64
252	2020-11-22	64
253	2020-11-10	71
254	2020-11-11	71
255	2020-09-10	71
256	2020-09-11	71
257	2020-11-06	46
258	2020-11-13	46
259	2020-11-14	46
260	2020-11-19	46
261	2020-11-20	46
262	2020-11-08	62
263	2020-11-09	62
264	2020-11-14	62
265	2020-11-06	69
266	2020-11-07	69
267	2020-11-08	69
268	2020-11-14	69
269	2020-11-17	47
270	2020-11-18	47
304	2020-10-05	47
305	2020-10-07	47
\.


--
-- Data for Name: result_afterresult; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.result_afterresult (id, date, shift_id, station_id, user_id) FROM stdin;
\.


--
-- Data for Name: result_exchangeapplication; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.result_exchangeapplication (id, date_start, date_end, application_status, remark, created_at, is_confirm, deleted, shift_apply_id, shift_receive_id, station_apply_id, station_receive_id, user_apply_id, user_receive_id) FROM stdin;
1	2020-10-03	2020-10-04	3	\N	2020-09-30 04:02:44.446135+00	t	f	\N	\N	\N	\N	50	63
2	2020-10-09	2020-10-10	2	鄭○勻: it's not mine	2020-09-30 04:02:38.004756+00	f	f	\N	\N	\N	\N	50	66
3	2020-10-03	2020-10-04	0	\N	2020-09-30 04:05:14.236864+00	f	f	\N	\N	\N	\N	66	50
\.


--
-- Data for Name: result_historyresult; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.result_historyresult (id, date, shift_id, station_id, user_id) FROM stdin;
\.


--
-- Data for Name: result_preresult; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.result_preresult (id, date, shift_id, station_id, user_id) FROM stdin;
102780	2021-04-01	80	13	62
102781	2021-04-02	80	13	62
102782	2021-04-03	63	13	62
102783	2021-04-04	64	14	62
102784	2021-04-05	80	13	62
102785	2021-04-06	80	13	62
102786	2021-04-07	80	13	62
102787	2021-04-08	63	14	62
102788	2021-04-09	63	13	62
102789	2021-04-10	80	13	62
102790	2021-04-11	80	13	62
102791	2021-04-12	80	13	62
102792	2021-04-13	80	13	62
102793	2021-04-14	80	13	62
102794	2021-04-15	80	13	62
102795	2021-04-16	64	14	62
102796	2021-04-17	80	13	62
102797	2021-04-18	80	13	62
102798	2021-04-19	80	13	62
102799	2021-04-20	64	13	62
102800	2021-04-21	80	13	62
102801	2021-04-22	80	13	62
102802	2021-04-23	80	13	62
102803	2021-04-24	80	13	62
102804	2021-04-25	63	14	62
102805	2021-04-26	80	13	62
102806	2021-04-27	80	13	62
102807	2021-04-28	80	13	62
102808	2021-04-29	80	13	62
102809	2021-04-30	80	13	62
102810	2021-04-01	80	13	47
102811	2021-04-02	80	13	47
102812	2021-04-03	80	13	47
102813	2021-04-04	80	13	47
102814	2021-04-05	64	14	47
102815	2021-04-06	63	14	47
102816	2021-04-07	80	13	47
102817	2021-04-08	80	13	47
102818	2021-04-09	80	13	47
102819	2021-04-10	63	14	47
102820	2021-04-11	64	14	47
102821	2021-04-12	63	14	47
102822	2021-04-13	80	13	47
102823	2021-04-14	80	13	47
102824	2021-04-15	80	13	47
102825	2021-04-16	80	13	47
102826	2021-04-17	80	13	47
102827	2021-04-18	80	13	47
102828	2021-04-19	64	14	47
102829	2021-04-20	80	13	47
102830	2021-04-21	80	13	47
102831	2021-04-22	80	13	47
102832	2021-04-23	80	13	47
102833	2021-04-24	80	13	47
102834	2021-04-25	64	13	47
102835	2021-04-26	80	13	47
102836	2021-04-27	80	13	47
102837	2021-04-28	80	13	47
102838	2021-04-29	80	13	47
102839	2021-04-30	63	14	47
102840	2021-04-01	64	14	69
102841	2021-04-02	63	14	69
102842	2021-04-03	63	14	69
102843	2021-04-04	80	13	69
102844	2021-04-05	80	13	69
102845	2021-04-06	80	13	69
102846	2021-04-07	64	14	69
102847	2021-04-08	63	14	69
102848	2021-04-09	80	13	69
102849	2021-04-10	80	13	69
102850	2021-04-11	80	13	69
102851	2021-04-12	80	13	69
102852	2021-04-13	80	13	69
102853	2021-04-14	80	13	69
102854	2021-04-15	64	14	69
102855	2021-04-16	80	13	69
102856	2021-04-17	80	13	69
102857	2021-04-18	80	13	69
102858	2021-04-19	80	13	69
102859	2021-04-20	63	14	69
102860	2021-04-21	80	13	69
102861	2021-04-22	80	13	69
102862	2021-04-23	80	13	69
102863	2021-04-24	80	13	69
102864	2021-04-25	80	13	69
102865	2021-04-26	80	13	69
102866	2021-04-27	64	14	69
102867	2021-04-28	80	13	69
102868	2021-04-29	80	13	69
102869	2021-04-30	80	13	69
102870	2021-04-01	64	14	46
102871	2021-04-02	63	14	46
102872	2021-04-03	80	13	46
102873	2021-04-04	80	13	46
102874	2021-04-05	80	13	46
102875	2021-04-06	80	13	46
102876	2021-04-07	80	13	46
102877	2021-04-08	80	13	46
102878	2021-04-09	64	14	46
102879	2021-04-10	80	13	46
102880	2021-04-11	80	13	46
102881	2021-04-12	80	13	46
102882	2021-04-13	63	14	46
102883	2021-04-14	80	13	46
102884	2021-04-15	80	13	46
102885	2021-04-16	80	13	46
102886	2021-04-17	64	14	46
102887	2021-04-18	80	13	46
102888	2021-04-19	80	13	46
102889	2021-04-20	80	13	46
102890	2021-04-21	80	13	46
102891	2021-04-22	80	13	46
102892	2021-04-23	80	13	46
102893	2021-04-24	64	14	46
102894	2021-04-25	80	13	46
102895	2021-04-26	80	13	46
102896	2021-04-27	80	13	46
102897	2021-04-28	80	13	46
102898	2021-04-29	63	14	46
102899	2021-04-30	80	13	46
102900	2021-04-01	64	13	64
102901	2021-04-02	80	13	64
102902	2021-04-03	80	13	64
102903	2021-04-04	64	13	64
102904	2021-04-05	80	13	64
102905	2021-04-06	64	14	64
102906	2021-04-07	63	14	64
102907	2021-04-08	80	13	64
102908	2021-04-09	80	13	64
102909	2021-04-10	80	13	64
102910	2021-04-11	63	14	64
102911	2021-04-12	80	13	64
102912	2021-04-13	80	13	64
102913	2021-04-14	80	13	64
102914	2021-04-15	80	13	64
102915	2021-04-16	80	13	64
102916	2021-04-17	80	13	64
102917	2021-04-18	63	14	64
102918	2021-04-19	80	13	64
102919	2021-04-20	80	13	64
102920	2021-04-21	80	13	64
102921	2021-04-22	80	13	64
102922	2021-04-23	80	13	64
102923	2021-04-24	64	14	64
102924	2021-04-25	80	13	64
102925	2021-04-26	80	13	64
102926	2021-04-27	80	13	64
102927	2021-04-28	80	13	64
102928	2021-04-29	63	13	64
102929	2021-04-30	80	13	64
102930	2021-04-01	80	13	65
102931	2021-04-02	80	13	65
102932	2021-04-03	80	13	65
102933	2021-04-04	64	14	65
102934	2021-04-05	63	14	65
102935	2021-04-06	80	13	65
102936	2021-04-07	80	13	65
102937	2021-04-08	80	13	65
102938	2021-04-09	80	13	65
102939	2021-04-10	80	13	65
102940	2021-04-11	64	14	65
102941	2021-04-12	63	14	65
102942	2021-04-13	63	14	65
102943	2021-04-14	80	13	65
102944	2021-04-15	80	13	65
102945	2021-04-16	80	13	65
102946	2021-04-17	80	13	65
102947	2021-04-18	80	13	65
102948	2021-04-19	64	13	65
102949	2021-04-20	80	13	65
102950	2021-04-21	80	13	65
102951	2021-04-22	80	13	65
102952	2021-04-23	80	13	65
102953	2021-04-24	80	13	65
102954	2021-04-25	80	13	65
102955	2021-04-26	64	14	65
102956	2021-04-27	80	13	65
102957	2021-04-28	80	13	65
102958	2021-04-29	80	13	65
102959	2021-04-30	80	13	65
102960	2021-04-01	64	14	51
102961	2021-04-02	63	14	51
102962	2021-04-03	80	13	51
102963	2021-04-04	80	13	51
102964	2021-04-05	80	13	51
102965	2021-04-06	80	13	51
102966	2021-04-07	80	13	51
102967	2021-04-08	80	13	51
102968	2021-04-09	64	14	51
102969	2021-04-10	63	13	51
102970	2021-04-11	80	13	51
102971	2021-04-12	80	13	51
102972	2021-04-13	80	13	51
102973	2021-04-14	80	13	51
102974	2021-04-15	80	13	51
102975	2021-04-16	64	14	51
102976	2021-04-17	80	13	51
102977	2021-04-18	80	13	51
102978	2021-04-19	80	13	51
102979	2021-04-20	80	13	51
102980	2021-04-21	80	13	51
102981	2021-04-22	64	14	51
102982	2021-04-23	63	14	51
102983	2021-04-24	80	13	51
102984	2021-04-25	80	13	51
102985	2021-04-26	80	13	51
102986	2021-04-27	80	13	51
102987	2021-04-28	63	14	51
102988	2021-04-29	80	13	51
102989	2021-04-30	80	13	51
102990	2021-04-01	80	13	57
102991	2021-04-02	63	13	57
102992	2021-04-03	64	14	57
102993	2021-04-04	80	13	57
102994	2021-04-05	80	13	57
102995	2021-04-06	63	14	57
102996	2021-04-07	80	13	57
102997	2021-04-08	80	13	57
102998	2021-04-09	80	13	57
102999	2021-04-10	80	13	57
103000	2021-04-11	80	13	57
103001	2021-04-12	80	13	57
103002	2021-04-13	64	14	57
103003	2021-04-14	63	14	57
103004	2021-04-15	80	13	57
103005	2021-04-16	80	13	57
103006	2021-04-17	80	13	57
103007	2021-04-18	80	13	57
103008	2021-04-19	80	13	57
103009	2021-04-20	80	13	57
103010	2021-04-21	63	14	57
103011	2021-04-22	80	13	57
103012	2021-04-23	80	13	57
103013	2021-04-24	80	13	57
103014	2021-04-25	80	13	57
103015	2021-04-26	80	13	57
103016	2021-04-27	80	13	57
103017	2021-04-28	64	14	57
103018	2021-04-29	80	13	57
103019	2021-04-30	80	13	57
103020	2021-04-01	80	13	71
103021	2021-04-02	80	13	71
103022	2021-04-03	64	14	71
103023	2021-04-04	80	13	71
103024	2021-04-05	80	13	71
103025	2021-04-06	80	13	71
103026	2021-04-07	80	13	71
103027	2021-04-08	80	13	71
103028	2021-04-09	80	13	71
103029	2021-04-10	63	14	71
103030	2021-04-11	80	13	71
103031	2021-04-12	80	13	71
103032	2021-04-13	80	13	71
103033	2021-04-14	80	13	71
103034	2021-04-15	64	14	71
103035	2021-04-16	80	13	71
103036	2021-04-17	80	13	71
103037	2021-04-18	80	13	71
103038	2021-04-19	80	13	71
103039	2021-04-20	80	13	71
103040	2021-04-21	80	13	71
103041	2021-04-22	64	14	71
103042	2021-04-23	80	13	71
103043	2021-04-24	80	13	71
103044	2021-04-25	80	13	71
103045	2021-04-26	80	13	71
103046	2021-04-27	80	13	71
103047	2021-04-28	64	13	71
103048	2021-04-29	63	14	71
103049	2021-04-30	63	13	71
103050	2021-04-01	80	13	78
103051	2021-04-02	80	13	78
103052	2021-04-03	80	13	78
103053	2021-04-04	64	14	78
103054	2021-04-05	63	14	78
103055	2021-04-06	80	13	78
103056	2021-04-07	80	13	78
103057	2021-04-08	63	14	78
103058	2021-04-09	80	13	78
103059	2021-04-10	80	13	78
103060	2021-04-11	80	13	78
103061	2021-04-12	64	14	78
103062	2021-04-13	80	13	78
103063	2021-04-14	80	13	78
103064	2021-04-15	80	13	78
103065	2021-04-16	80	13	78
103066	2021-04-17	63	13	78
103067	2021-04-18	80	13	78
103068	2021-04-19	80	13	78
103069	2021-04-20	80	13	78
103070	2021-04-21	80	13	78
103071	2021-04-22	80	13	78
103072	2021-04-23	63	14	78
103073	2021-04-24	80	13	78
103074	2021-04-25	80	13	78
103075	2021-04-26	64	14	78
103076	2021-04-27	80	13	78
103077	2021-04-28	80	13	78
103078	2021-04-29	80	13	78
103079	2021-04-30	80	13	78
103080	2021-04-01	64	14	79
103081	2021-04-02	63	14	79
103082	2021-04-03	80	13	79
103083	2021-04-04	80	13	79
103084	2021-04-05	80	13	79
103085	2021-04-06	80	13	79
103086	2021-04-07	64	14	79
103087	2021-04-08	80	13	79
103088	2021-04-09	80	13	79
103089	2021-04-10	80	13	79
103090	2021-04-11	80	13	79
103091	2021-04-12	80	13	79
103092	2021-04-13	80	13	79
103093	2021-04-14	64	14	79
103094	2021-04-15	80	13	79
103095	2021-04-16	80	13	79
103096	2021-04-17	80	13	79
103097	2021-04-18	63	14	79
103098	2021-04-19	80	13	79
103099	2021-04-20	80	13	79
103100	2021-04-21	64	14	79
103101	2021-04-22	80	13	79
103102	2021-04-23	80	13	79
103103	2021-04-24	80	13	79
103104	2021-04-25	80	13	79
103105	2021-04-26	80	13	79
103106	2021-04-27	63	13	79
103107	2021-04-28	80	13	79
103108	2021-04-29	80	13	79
103109	2021-04-30	63	14	79
103110	2021-04-01	81	13	80
103111	2021-04-02	81	13	80
103112	2021-04-03	81	13	80
103113	2021-04-04	64	14	80
103114	2021-04-05	81	13	80
103115	2021-04-06	81	13	80
103116	2021-04-07	81	13	80
103117	2021-04-08	81	13	80
103118	2021-04-09	81	13	80
103119	2021-04-10	63	13	80
103120	2021-04-11	64	14	80
103121	2021-04-12	81	13	80
103122	2021-04-13	81	13	80
103123	2021-04-14	63	14	80
103124	2021-04-15	63	14	80
103125	2021-04-16	81	13	80
103126	2021-04-17	81	13	80
103127	2021-04-18	81	13	80
103128	2021-04-19	64	13	80
103129	2021-04-20	83	13	80
103130	2021-04-21	83	13	80
103131	2021-04-22	83	13	80
103132	2021-04-23	83	13	80
103133	2021-04-24	83	13	80
103134	2021-04-25	83	13	80
103135	2021-04-26	63	13	80
103136	2021-04-27	64	14	80
103137	2021-04-28	83	13	80
103138	2021-04-29	83	13	80
103139	2021-04-30	83	13	80
103140	2021-04-01	81	13	56
103141	2021-04-02	81	13	56
103142	2021-04-03	81	13	56
103143	2021-04-04	81	13	56
103144	2021-04-05	63	13	56
103145	2021-04-06	64	14	56
103146	2021-04-07	81	13	56
103147	2021-04-08	81	13	56
103148	2021-04-09	63	13	56
103149	2021-04-10	81	13	56
103150	2021-04-11	81	13	56
103151	2021-04-12	64	14	56
103152	2021-04-13	81	13	56
103153	2021-04-14	81	13	56
103154	2021-04-15	81	13	56
103155	2021-04-16	63	14	56
103156	2021-04-17	81	13	56
103157	2021-04-18	81	13	56
103158	2021-04-19	81	13	56
103159	2021-04-20	81	13	56
103160	2021-04-21	81	13	56
103161	2021-04-22	63	14	56
103162	2021-04-23	81	13	56
103163	2021-04-24	81	13	56
103164	2021-04-25	81	13	56
103165	2021-04-26	81	13	56
103166	2021-04-27	81	13	56
103167	2021-04-28	64	13	56
103168	2021-04-29	81	13	56
103169	2021-04-30	81	13	56
103170	2021-04-01	81	13	60
103171	2021-04-02	63	13	60
103172	2021-04-03	81	13	60
103173	2021-04-04	81	13	60
103174	2021-04-05	81	13	60
103175	2021-04-06	81	13	60
103176	2021-04-07	64	14	60
103177	2021-04-08	63	13	60
103178	2021-04-09	81	13	60
103179	2021-04-10	81	13	60
103180	2021-04-11	81	13	60
103181	2021-04-12	81	13	60
103182	2021-04-13	64	14	60
103183	2021-04-14	81	13	60
103184	2021-04-15	81	13	60
103185	2021-04-16	81	13	60
103186	2021-04-17	63	14	60
103187	2021-04-18	63	14	60
103188	2021-04-19	81	13	60
103189	2021-04-20	81	13	60
103190	2021-04-21	81	13	60
103191	2021-04-22	81	13	60
103192	2021-04-23	81	13	60
103193	2021-04-24	81	13	60
103194	2021-04-25	63	14	60
103195	2021-04-26	81	13	60
103196	2021-04-27	81	13	60
103197	2021-04-28	81	13	60
103198	2021-04-29	81	13	60
103199	2021-04-30	81	13	60
103200	2021-04-01	64	14	63
103201	2021-04-02	81	13	63
103202	2021-04-03	81	13	63
103203	2021-04-04	81	13	63
103204	2021-04-05	81	13	63
103205	2021-04-06	81	13	63
103206	2021-04-07	81	13	63
103207	2021-04-08	64	14	63
103208	2021-04-09	63	14	63
103209	2021-04-10	63	14	63
103210	2021-04-11	63	14	63
103211	2021-04-12	81	13	63
103212	2021-04-13	81	13	63
103213	2021-04-14	81	13	63
103214	2021-04-15	64	14	63
103215	2021-04-16	81	13	63
103216	2021-04-17	81	13	63
103217	2021-04-18	81	13	63
103218	2021-04-19	81	13	63
103219	2021-04-20	63	14	63
103220	2021-04-21	81	13	63
103221	2021-04-22	81	13	63
103222	2021-04-23	81	13	63
103223	2021-04-24	81	13	63
103224	2021-04-25	81	13	63
103225	2021-04-26	81	13	63
103226	2021-04-27	64	14	63
103227	2021-04-28	80	13	63
103228	2021-04-29	80	13	63
103229	2021-04-30	80	13	63
103230	2021-04-01	80	13	67
103231	2021-04-02	80	13	67
103232	2021-04-03	80	13	67
103233	2021-04-04	80	13	67
103234	2021-04-05	63	14	67
103235	2021-04-06	63	14	67
103236	2021-04-07	63	14	67
103237	2021-04-08	81	13	67
103238	2021-04-09	81	13	67
103239	2021-04-10	81	13	67
103240	2021-04-11	81	13	67
103241	2021-04-12	64	14	67
103242	2021-04-13	63	14	67
103243	2021-04-14	81	13	67
103244	2021-04-15	81	13	67
103245	2021-04-16	81	13	67
103246	2021-04-17	81	13	67
103247	2021-04-18	81	13	67
103248	2021-04-19	64	14	67
103249	2021-04-20	81	13	67
103250	2021-04-21	81	13	67
103251	2021-04-22	81	13	67
103252	2021-04-23	81	13	67
103253	2021-04-24	64	14	67
103254	2021-04-25	81	13	67
103255	2021-04-26	81	13	67
103256	2021-04-27	81	13	67
103257	2021-04-28	81	13	67
103258	2021-04-29	81	13	67
103259	2021-04-30	81	13	67
103260	2021-04-01	80	13	73
103261	2021-04-02	80	13	73
103262	2021-04-03	63	14	73
103263	2021-04-04	63	14	73
103264	2021-04-05	81	13	73
103265	2021-04-06	81	13	73
103266	2021-04-07	81	13	73
103267	2021-04-08	64	14	73
103268	2021-04-09	81	13	73
103269	2021-04-10	81	13	73
103270	2021-04-11	81	13	73
103271	2021-04-12	63	14	73
103272	2021-04-13	81	13	73
103273	2021-04-14	81	13	73
103274	2021-04-15	81	13	73
103275	2021-04-16	64	14	73
103276	2021-04-17	81	13	73
103277	2021-04-18	81	13	73
103278	2021-04-19	81	13	73
103279	2021-04-20	81	13	73
103280	2021-04-21	81	13	73
103281	2021-04-22	81	13	73
103282	2021-04-23	64	14	73
103283	2021-04-24	81	13	73
103284	2021-04-25	81	13	73
103285	2021-04-26	81	13	73
103286	2021-04-27	81	13	73
103287	2021-04-28	81	13	73
103288	2021-04-29	81	13	73
103289	2021-04-30	63	14	73
103290	2021-04-01	81	13	66
103291	2021-04-02	81	13	66
103292	2021-04-03	81	13	66
103293	2021-04-04	81	13	66
103294	2021-04-05	64	14	66
103295	2021-04-06	63	14	66
103296	2021-04-07	81	13	66
103297	2021-04-08	81	13	66
103298	2021-04-09	63	14	66
103299	2021-04-10	81	13	66
103300	2021-04-11	81	13	66
103301	2021-04-12	81	13	66
103302	2021-04-13	64	14	66
103303	2021-04-14	63	13	66
103304	2021-04-15	81	13	66
103305	2021-04-16	81	13	66
103306	2021-04-17	63	14	66
103307	2021-04-18	81	13	66
103308	2021-04-19	81	13	66
103309	2021-04-20	81	13	66
103310	2021-04-21	64	14	66
103311	2021-04-22	81	13	66
103312	2021-04-23	81	13	66
103313	2021-04-24	81	13	66
103314	2021-04-25	81	13	66
103315	2021-04-26	64	14	66
103316	2021-04-27	81	13	66
103317	2021-04-28	81	13	66
103318	2021-04-29	81	13	66
103319	2021-04-30	81	13	66
103320	2021-04-01	81	13	55
103321	2021-04-02	81	13	55
103322	2021-04-03	63	14	55
103323	2021-04-04	81	13	55
103324	2021-04-05	81	13	55
103325	2021-04-06	81	13	55
103326	2021-04-07	64	14	55
103327	2021-04-08	81	13	55
103328	2021-04-09	81	13	55
103329	2021-04-10	63	14	55
103330	2021-04-11	63	14	55
103331	2021-04-12	81	13	55
103332	2021-04-13	81	13	55
103333	2021-04-14	81	13	55
103334	2021-04-15	81	13	55
103335	2021-04-16	81	13	55
103336	2021-04-17	81	13	55
103337	2021-04-18	64	14	55
103338	2021-04-19	81	13	55
103339	2021-04-20	81	13	55
103340	2021-04-21	81	13	55
103341	2021-04-22	81	13	55
103342	2021-04-23	81	13	55
103343	2021-04-24	64	13	55
103344	2021-04-25	81	13	55
103345	2021-04-26	81	13	55
103346	2021-04-27	81	13	55
103347	2021-04-28	81	13	55
103348	2021-04-29	63	13	55
103349	2021-04-30	81	13	55
103350	2021-04-01	83	13	45
103351	2021-04-02	83	13	45
103352	2021-04-03	83	13	45
103353	2021-04-04	83	13	45
103354	2021-04-05	64	14	45
103355	2021-04-06	63	13	45
103356	2021-04-07	83	13	45
103357	2021-04-08	83	13	45
103358	2021-04-09	64	13	45
103359	2021-04-10	63	14	45
103360	2021-04-11	83	13	45
103361	2021-04-12	83	13	45
103362	2021-04-13	83	13	45
103363	2021-04-14	64	14	45
103364	2021-04-15	83	13	45
103365	2021-04-16	83	13	45
103366	2021-04-17	83	13	45
103367	2021-04-18	83	13	45
103368	2021-04-19	63	13	45
103369	2021-04-20	83	13	45
103370	2021-04-21	83	13	45
103371	2021-04-22	83	13	45
103372	2021-04-23	63	14	45
103373	2021-04-24	83	13	45
103374	2021-04-25	83	13	45
103375	2021-04-26	83	13	45
103376	2021-04-27	64	14	45
103377	2021-04-28	81	13	45
103378	2021-04-29	81	13	45
103379	2021-04-30	81	13	45
103380	2021-04-01	64	14	68
103381	2021-04-02	63	13	68
103382	2021-04-03	83	13	68
103383	2021-04-04	83	13	68
103384	2021-04-05	83	13	68
103385	2021-04-06	63	14	68
103386	2021-04-07	83	13	68
103387	2021-04-08	83	13	68
103388	2021-04-09	83	13	68
103389	2021-04-10	83	13	68
103390	2021-04-11	64	13	68
103391	2021-04-12	83	13	68
103392	2021-04-13	83	13	68
103393	2021-04-14	83	13	68
103394	2021-04-15	83	13	68
103395	2021-04-16	83	13	68
103396	2021-04-17	83	13	68
103397	2021-04-18	63	14	68
103398	2021-04-19	83	13	68
103399	2021-04-20	83	13	68
103400	2021-04-21	64	14	68
103401	2021-04-22	83	13	68
103402	2021-04-23	83	13	68
103403	2021-04-24	63	13	68
103404	2021-04-25	83	13	68
103405	2021-04-26	83	13	68
103406	2021-04-27	83	13	68
103407	2021-04-28	64	14	68
103408	2021-04-29	83	13	68
103409	2021-04-30	83	13	68
103410	2021-04-01	83	13	53
103411	2021-04-02	83	13	53
103412	2021-04-03	64	14	53
103413	2021-04-04	83	13	53
103414	2021-04-05	83	13	53
103415	2021-04-06	83	13	53
103416	2021-04-07	63	14	53
103417	2021-04-08	83	13	53
103418	2021-04-09	83	13	53
103419	2021-04-10	83	13	53
103420	2021-04-11	64	13	53
103421	2021-04-12	83	13	53
103422	2021-04-13	83	13	53
103423	2021-04-14	83	13	53
103424	2021-04-15	63	14	53
103425	2021-04-16	64	14	53
103426	2021-04-17	83	13	53
103427	2021-04-18	83	13	53
103428	2021-04-19	83	13	53
103429	2021-04-20	83	13	53
103430	2021-04-21	83	13	53
103431	2021-04-22	64	13	53
103432	2021-04-23	64	14	53
103433	2021-04-24	81	13	53
103434	2021-04-25	83	13	53
103435	2021-04-26	83	13	53
103436	2021-04-27	83	13	53
103437	2021-04-28	83	13	53
103438	2021-04-29	83	13	53
103439	2021-04-30	63	14	53
103440	2021-04-01	83	13	54
103441	2021-04-02	83	13	54
103442	2021-04-03	64	14	54
103443	2021-04-04	63	14	54
103444	2021-04-05	83	13	54
103445	2021-04-06	83	13	54
103446	2021-04-07	64	13	54
103447	2021-04-08	83	13	54
103448	2021-04-09	83	13	54
103449	2021-04-10	63	14	54
103450	2021-04-11	83	13	54
103451	2021-04-12	83	13	54
103452	2021-04-13	83	13	54
103453	2021-04-14	83	13	54
103454	2021-04-15	83	13	54
103455	2021-04-16	83	13	54
103456	2021-04-17	64	14	54
103457	2021-04-18	83	13	54
103458	2021-04-19	83	13	54
103459	2021-04-20	83	13	54
103460	2021-04-21	83	13	54
103461	2021-04-22	64	14	54
103462	2021-04-23	83	13	54
103463	2021-04-24	83	13	54
103464	2021-04-25	63	13	54
103465	2021-04-26	83	13	54
103466	2021-04-27	83	13	54
103467	2021-04-28	83	13	54
103468	2021-04-29	63	14	54
103469	2021-04-30	83	13	54
103470	2021-04-01	64	14	49
103471	2021-04-02	63	14	49
103472	2021-04-03	83	13	49
103473	2021-04-04	83	13	49
103474	2021-04-05	63	14	49
103475	2021-04-06	83	13	49
103476	2021-04-07	83	13	49
103477	2021-04-08	64	14	49
103478	2021-04-09	83	13	49
103479	2021-04-10	83	13	49
103480	2021-04-11	83	13	49
103481	2021-04-12	63	14	49
103482	2021-04-13	63	14	49
103483	2021-04-14	83	13	49
103484	2021-04-15	83	13	49
103485	2021-04-16	83	13	49
103486	2021-04-17	83	13	49
103487	2021-04-18	83	13	49
103488	2021-04-19	83	13	49
103489	2021-04-20	64	14	49
103490	2021-04-21	83	13	49
103491	2021-04-22	83	13	49
103492	2021-04-23	83	13	49
103493	2021-04-24	83	13	49
103494	2021-04-25	64	14	49
103495	2021-04-26	83	13	49
103496	2021-04-27	83	13	49
103497	2021-04-28	83	13	49
103498	2021-04-29	83	13	49
103499	2021-04-30	83	13	49
103500	2021-04-01	83	13	50
103501	2021-04-02	83	13	50
103502	2021-04-03	83	13	50
103503	2021-04-04	64	14	50
103504	2021-04-05	83	13	50
103505	2021-04-06	83	13	50
103506	2021-04-07	83	13	50
103507	2021-04-08	63	14	50
103508	2021-04-09	63	14	50
103509	2021-04-10	83	13	50
103510	2021-04-11	83	13	50
103511	2021-04-12	64	14	50
103512	2021-04-13	63	14	50
103513	2021-04-14	83	13	50
103514	2021-04-15	83	13	50
103515	2021-04-16	83	13	50
103516	2021-04-17	83	13	50
103517	2021-04-18	83	13	50
103518	2021-04-19	83	13	50
103519	2021-04-20	64	14	50
103520	2021-04-21	63	13	50
103521	2021-04-22	83	13	50
103522	2021-04-23	83	13	50
103523	2021-04-24	83	13	50
103524	2021-04-25	83	13	50
103525	2021-04-26	63	13	50
103526	2021-04-27	83	13	50
103527	2021-04-28	83	13	50
103528	2021-04-29	83	13	50
103529	2021-04-30	83	13	50
103530	2021-04-01	82	16	43
103531	2021-04-02	82	16	43
103532	2021-04-03	63	14	43
103533	2021-04-04	64	14	43
103534	2021-04-05	82	16	43
103535	2021-04-06	82	16	43
103536	2021-04-07	82	16	43
103537	2021-04-08	82	16	43
103538	2021-04-09	82	16	43
103539	2021-04-10	63	14	43
103540	2021-04-11	64	14	43
103541	2021-04-12	82	16	43
103542	2021-04-13	82	16	43
103543	2021-04-14	82	16	43
103544	2021-04-15	82	16	43
103545	2021-04-16	82	16	43
103546	2021-04-17	63	14	43
103547	2021-04-18	64	14	43
103548	2021-04-19	82	16	43
103549	2021-04-20	82	16	43
103550	2021-04-21	82	16	43
103551	2021-04-22	82	16	43
103552	2021-04-23	82	16	43
103553	2021-04-24	63	14	43
103554	2021-04-25	64	14	43
103555	2021-04-26	82	16	43
103556	2021-04-27	82	16	43
103557	2021-04-28	82	16	43
103558	2021-04-29	82	16	43
103559	2021-04-30	82	16	43
103560	2021-04-01	82	16	44
103561	2021-04-02	82	16	44
103562	2021-04-03	63	14	44
103563	2021-04-04	64	14	44
103564	2021-04-05	82	16	44
103565	2021-04-06	82	16	44
103566	2021-04-07	82	16	44
103567	2021-04-08	82	16	44
103568	2021-04-09	82	16	44
103569	2021-04-10	63	14	44
103570	2021-04-11	64	14	44
103571	2021-04-12	82	16	44
103572	2021-04-13	82	16	44
103573	2021-04-14	82	16	44
103574	2021-04-15	82	16	44
103575	2021-04-16	82	16	44
103576	2021-04-17	63	14	44
103577	2021-04-18	64	14	44
103578	2021-04-19	82	16	44
103579	2021-04-20	82	16	44
103580	2021-04-21	82	16	44
103581	2021-04-22	82	16	44
103582	2021-04-23	82	16	44
103583	2021-04-24	63	14	44
103584	2021-04-25	64	14	44
103585	2021-04-26	82	16	44
103586	2021-04-27	82	16	44
103587	2021-04-28	82	16	44
103588	2021-04-29	82	16	44
103589	2021-04-30	82	16	44
112557	2020-12-01	80	13	47
112558	2020-12-02	80	13	47
112559	2020-12-03	80	13	47
112560	2020-12-04	63	13	47
112561	2020-12-05	64	14	47
112562	2020-12-06	63	14	47
112563	2020-12-07	80	13	47
112564	2020-12-08	80	13	47
112565	2020-12-09	80	13	47
112566	2020-12-10	80	13	47
112567	2020-12-11	64	14	47
112568	2020-12-12	80	13	47
112569	2020-12-13	80	13	47
112570	2020-12-14	80	13	47
112571	2020-12-15	63	14	47
112572	2020-12-16	80	13	47
112573	2020-12-17	80	13	47
112574	2020-12-18	64	14	47
112575	2020-12-19	80	13	47
112576	2020-12-20	80	13	47
112577	2020-12-21	80	13	47
112578	2020-12-22	80	13	47
112579	2020-12-23	63	14	47
112580	2020-12-24	80	13	47
112581	2020-12-25	80	13	47
112582	2020-12-26	64	13	47
112583	2020-12-27	80	13	47
112584	2020-12-28	80	13	47
112585	2020-12-29	80	13	47
112586	2020-12-30	80	13	47
112587	2020-12-31	80	13	47
112588	2020-12-01	80	13	69
112589	2020-12-02	80	13	69
112590	2020-12-03	64	14	69
112591	2020-12-04	80	13	69
112592	2020-12-05	80	13	69
112593	2020-12-06	80	13	69
112594	2020-12-07	63	14	69
112595	2020-12-08	80	13	69
112596	2020-12-09	80	13	69
112597	2020-12-10	80	13	69
112598	2020-12-11	80	13	69
112599	2020-12-12	64	14	69
112600	2020-12-13	63	14	69
112601	2020-12-14	63	13	69
112602	2020-12-15	80	13	69
112603	2020-12-16	80	13	69
112604	2020-12-17	80	13	69
112605	2020-12-18	80	13	69
112606	2020-12-19	80	13	69
112607	2020-12-20	64	14	69
112608	2020-12-21	80	13	69
112609	2020-12-22	80	13	69
112610	2020-12-23	80	13	69
112611	2020-12-24	80	13	69
112612	2020-12-25	80	13	69
112613	2020-12-26	80	13	69
112614	2020-12-27	64	14	69
112615	2020-12-28	80	13	69
112616	2020-12-29	80	13	69
112617	2020-12-30	63	14	69
112618	2020-12-31	80	13	69
112619	2020-12-01	64	14	46
112620	2020-12-02	63	14	46
112621	2020-12-03	80	13	46
112622	2020-12-04	80	13	46
112623	2020-12-05	80	13	46
112624	2020-12-06	80	13	46
112625	2020-12-07	64	13	46
112626	2020-12-08	64	14	46
112627	2020-12-09	80	13	46
112628	2020-12-10	80	13	46
112629	2020-12-11	80	13	46
112630	2020-12-12	80	13	46
112631	2020-12-13	80	13	46
112632	2020-12-14	64	14	46
112633	2020-12-15	80	13	46
112634	2020-12-16	80	13	46
112635	2020-12-17	80	13	46
112636	2020-12-18	80	13	46
112637	2020-12-19	63	14	46
112638	2020-12-20	80	13	46
112639	2020-12-21	80	13	46
112640	2020-12-22	80	13	46
112641	2020-12-23	80	13	46
112642	2020-12-24	80	13	46
112643	2020-12-25	64	14	46
112644	2020-12-26	80	13	46
112645	2020-12-27	80	13	46
112646	2020-12-28	80	13	46
112647	2020-12-29	63	14	46
112648	2020-12-30	80	13	46
112649	2020-12-31	80	13	46
112650	2020-12-01	64	14	60
112651	2020-12-02	80	13	60
112652	2020-12-03	80	13	60
112653	2020-12-04	63	14	60
112654	2020-12-05	80	13	60
112655	2020-12-06	80	13	60
112656	2020-12-07	80	13	60
112657	2020-12-08	80	13	60
112658	2020-12-09	64	14	60
112659	2020-12-10	63	14	60
112660	2020-12-11	80	13	60
112661	2020-12-12	80	13	60
112662	2020-12-13	80	13	60
112663	2020-12-14	80	13	60
112664	2020-12-15	80	13	60
112665	2020-12-16	64	14	60
112666	2020-12-17	63	14	60
112667	2020-12-18	80	13	60
112668	2020-12-19	80	13	60
112669	2020-12-20	80	13	60
112670	2020-12-21	80	13	60
112671	2020-12-22	80	13	60
112672	2020-12-23	80	13	60
112673	2020-12-24	64	14	60
112674	2020-12-25	80	13	60
112675	2020-12-26	80	13	60
112676	2020-12-27	80	13	60
112677	2020-12-28	80	13	60
112678	2020-12-29	80	13	60
112679	2020-12-30	80	13	60
112680	2020-12-31	63	14	60
112681	2020-12-01	80	13	64
112682	2020-12-02	80	13	64
112683	2020-12-03	80	13	64
112684	2020-12-04	80	13	64
112685	2020-12-05	64	14	64
112686	2020-12-06	63	14	64
112687	2020-12-07	80	13	64
112688	2020-12-08	80	13	64
112689	2020-12-09	63	14	64
112690	2020-12-10	80	13	64
112691	2020-12-11	80	13	64
112692	2020-12-12	80	13	64
112693	2020-12-13	64	14	64
112694	2020-12-14	63	14	64
112695	2020-12-15	80	13	64
112696	2020-12-16	80	13	64
112697	2020-12-17	63	14	64
112698	2020-12-18	80	13	64
112699	2020-12-19	80	13	64
112700	2020-12-20	80	13	64
112701	2020-12-21	80	13	64
112702	2020-12-22	80	13	64
112703	2020-12-23	80	13	64
112704	2020-12-24	64	14	64
112705	2020-12-25	80	13	64
112706	2020-12-26	80	13	64
112707	2020-12-27	80	13	64
112708	2020-12-28	80	13	64
112709	2020-12-29	80	13	64
112710	2020-12-30	64	14	64
112711	2020-12-31	80	13	64
112712	2020-12-01	80	13	65
112713	2020-12-02	80	13	65
112714	2020-12-03	64	14	65
112715	2020-12-04	80	13	65
112716	2020-12-05	80	13	65
112717	2020-12-06	63	14	65
112718	2020-12-07	63	14	65
112719	2020-12-08	80	13	65
112720	2020-12-09	80	13	65
112721	2020-12-10	80	13	65
112722	2020-12-11	80	13	65
112723	2020-12-12	64	14	65
112724	2020-12-13	80	13	65
112725	2020-12-14	80	13	65
112726	2020-12-15	63	14	65
112727	2020-12-16	80	13	65
112728	2020-12-17	80	13	65
112729	2020-12-18	64	14	65
112730	2020-12-19	80	13	65
112731	2020-12-20	80	13	65
112732	2020-12-21	80	13	65
112733	2020-12-22	80	13	65
112734	2020-12-23	63	14	65
112735	2020-12-24	80	13	65
112736	2020-12-25	80	13	65
112737	2020-12-26	80	13	65
112738	2020-12-27	80	13	65
112739	2020-12-28	64	14	65
112740	2020-12-29	80	13	65
112741	2020-12-30	80	13	65
112742	2020-12-31	80	13	65
112743	2020-12-01	64	14	51
112744	2020-12-02	63	14	51
112745	2020-12-03	80	13	51
112746	2020-12-04	80	13	51
112747	2020-12-05	80	13	51
112748	2020-12-06	63	14	51
112749	2020-12-07	80	13	51
112750	2020-12-08	80	13	51
112751	2020-12-09	80	13	51
112752	2020-12-10	64	14	51
112753	2020-12-11	80	13	51
112754	2020-12-12	80	13	51
112755	2020-12-13	80	13	51
112756	2020-12-14	63	14	51
112757	2020-12-15	80	13	51
112758	2020-12-16	80	13	51
112759	2020-12-17	80	13	51
112760	2020-12-18	80	13	51
112761	2020-12-19	80	13	51
112762	2020-12-20	80	13	51
112763	2020-12-21	64	13	51
112764	2020-12-22	63	14	51
112765	2020-12-23	80	13	51
112766	2020-12-24	80	13	51
112767	2020-12-25	80	13	51
112768	2020-12-26	80	13	51
112769	2020-12-27	80	13	51
112770	2020-12-28	80	13	51
112771	2020-12-29	64	14	51
112772	2020-12-30	80	13	51
112773	2020-12-31	80	13	51
112774	2020-12-01	64	14	57
112775	2020-12-02	63	14	57
112776	2020-12-03	80	13	57
112777	2020-12-04	80	13	57
112778	2020-12-05	80	13	57
112779	2020-12-06	80	13	57
112780	2020-12-07	80	13	57
112781	2020-12-08	80	13	57
112782	2020-12-09	64	14	57
112783	2020-12-10	63	14	57
112784	2020-12-11	80	13	57
112785	2020-12-12	80	13	57
112786	2020-12-13	80	13	57
112787	2020-12-14	80	13	57
112788	2020-12-15	64	14	57
112789	2020-12-16	63	14	57
112790	2020-12-17	80	13	57
112791	2020-12-18	80	13	57
112792	2020-12-19	80	13	57
112793	2020-12-20	80	13	57
112794	2020-12-21	64	14	57
112795	2020-12-22	80	13	57
112796	2020-12-23	80	13	57
112797	2020-12-24	80	13	57
112798	2020-12-25	80	13	57
112799	2020-12-26	80	13	57
112800	2020-12-27	80	13	57
112801	2020-12-28	63	14	57
112802	2020-12-29	80	13	57
112803	2020-12-30	80	13	57
112804	2020-12-31	80	13	57
112805	2020-12-01	80	13	71
112806	2020-12-02	80	13	71
112807	2020-12-03	80	13	71
112808	2020-12-04	64	14	71
112809	2020-12-05	63	14	71
112810	2020-12-06	80	13	71
112811	2020-12-07	80	13	71
112812	2020-12-08	63	14	71
112813	2020-12-09	63	14	71
112814	2020-12-10	80	13	71
112815	2020-12-11	80	13	71
112816	2020-12-12	64	14	71
112817	2020-12-13	63	14	71
112818	2020-12-14	80	13	71
112819	2020-12-15	80	13	71
112820	2020-12-16	80	13	71
112821	2020-12-17	80	13	71
112822	2020-12-18	80	13	71
112823	2020-12-19	80	13	71
112824	2020-12-20	64	14	71
112825	2020-12-21	80	13	71
112826	2020-12-22	80	13	71
112827	2020-12-23	80	13	71
112828	2020-12-24	80	13	71
112829	2020-12-25	80	13	71
112830	2020-12-26	80	13	71
112831	2020-12-27	64	14	71
112832	2020-12-28	80	13	71
112833	2020-12-29	80	13	71
112834	2020-12-30	80	13	71
112835	2020-12-31	80	13	71
112836	2020-12-01	80	13	78
112837	2020-12-02	80	13	78
112838	2020-12-03	64	14	78
112839	2020-12-04	63	14	78
112840	2020-12-05	80	13	78
112841	2020-12-06	80	13	78
112842	2020-12-07	80	13	78
112843	2020-12-08	63	14	78
112844	2020-12-09	80	13	78
112845	2020-12-10	80	13	78
112846	2020-12-11	64	14	78
112847	2020-12-12	63	14	78
112848	2020-12-13	80	13	78
112849	2020-12-14	80	13	78
112850	2020-12-15	80	13	78
112851	2020-12-16	80	13	78
112852	2020-12-17	80	13	78
112853	2020-12-18	80	13	78
112854	2020-12-19	64	14	78
112855	2020-12-20	80	13	78
112856	2020-12-21	80	13	78
112857	2020-12-22	80	13	78
112858	2020-12-23	80	13	78
112859	2020-12-24	80	13	78
112860	2020-12-25	80	13	78
112861	2020-12-26	64	14	78
112862	2020-12-27	80	13	78
112863	2020-12-28	80	13	78
112864	2020-12-29	80	13	78
112865	2020-12-30	80	13	78
112866	2020-12-31	63	14	78
112867	2020-12-01	80	13	79
112868	2020-12-02	63	13	79
112869	2020-12-03	64	14	79
112870	2020-12-04	80	13	79
112871	2020-12-05	80	13	79
112872	2020-12-06	80	13	79
112873	2020-12-07	63	14	79
112874	2020-12-08	63	14	79
112875	2020-12-09	80	13	79
112876	2020-12-10	80	13	79
112877	2020-12-11	64	14	79
112878	2020-12-12	80	13	79
112879	2020-12-13	80	13	79
112880	2020-12-14	80	13	79
112881	2020-12-15	63	14	79
112882	2020-12-16	80	13	79
112883	2020-12-17	80	13	79
112884	2020-12-18	80	13	79
112885	2020-12-19	80	13	79
112886	2020-12-20	80	13	79
112887	2020-12-21	80	13	79
112888	2020-12-22	63	14	79
112889	2020-12-23	80	13	79
112890	2020-12-24	80	13	79
112891	2020-12-25	64	14	79
112892	2020-12-26	80	13	79
112893	2020-12-27	80	13	79
112894	2020-12-28	80	13	79
112895	2020-12-29	80	13	79
112896	2020-12-30	80	13	79
112897	2020-12-31	80	13	79
112898	2020-12-01	64	14	56
112899	2020-12-02	81	13	56
112900	2020-12-03	81	13	56
112901	2020-12-04	63	14	56
112902	2020-12-05	81	13	56
112903	2020-12-06	81	13	56
112904	2020-12-07	64	14	56
112905	2020-12-08	63	14	56
112906	2020-12-09	81	13	56
112907	2020-12-10	81	13	56
112908	2020-12-11	81	13	56
112909	2020-12-12	81	13	56
112910	2020-12-13	81	13	56
112911	2020-12-14	81	13	56
112912	2020-12-15	64	14	56
112913	2020-12-16	81	13	56
112914	2020-12-17	81	13	56
112915	2020-12-18	81	13	56
112916	2020-12-19	81	13	56
112917	2020-12-20	81	13	56
112918	2020-12-21	64	14	56
112919	2020-12-22	81	13	56
112920	2020-12-23	81	13	56
112921	2020-12-24	81	13	56
112922	2020-12-25	81	13	56
112923	2020-12-26	81	13	56
112924	2020-12-27	63	14	56
112925	2020-12-28	81	13	56
112926	2020-12-29	81	13	56
112927	2020-12-30	81	13	56
112928	2020-12-31	64	13	56
112929	2020-12-01	81	13	62
112930	2020-12-02	81	13	62
112931	2020-12-03	64	14	62
112932	2020-12-04	81	13	62
112933	2020-12-05	81	13	62
112934	2020-12-06	63	14	62
112935	2020-12-07	81	13	62
112936	2020-12-08	81	13	62
112937	2020-12-09	81	13	62
112938	2020-12-10	81	13	62
112939	2020-12-11	64	14	62
112940	2020-12-12	63	14	62
112941	2020-12-13	81	13	62
112942	2020-12-14	81	13	62
112943	2020-12-15	81	13	62
112944	2020-12-16	81	13	62
112945	2020-12-17	64	14	62
112946	2020-12-18	63	14	62
112947	2020-12-19	81	13	62
112948	2020-12-20	81	13	62
112949	2020-12-21	81	13	62
112950	2020-12-22	81	13	62
112951	2020-12-23	64	14	62
112952	2020-12-24	81	13	62
112953	2020-12-25	81	13	62
112954	2020-12-26	63	14	62
112955	2020-12-27	81	13	62
112956	2020-12-28	81	13	62
112957	2020-12-29	81	13	62
112958	2020-12-30	81	13	62
112959	2020-12-31	81	13	62
112960	2020-12-01	81	13	63
112961	2020-12-02	63	14	63
112962	2020-12-03	81	13	63
112963	2020-12-04	81	13	63
112964	2020-12-05	81	13	63
112965	2020-12-06	81	13	63
112966	2020-12-07	81	13	63
112967	2020-12-08	81	13	63
112968	2020-12-09	64	14	63
112969	2020-12-10	81	13	63
112970	2020-12-11	81	13	63
112971	2020-12-12	81	13	63
112972	2020-12-13	63	14	63
112973	2020-12-14	63	14	63
112974	2020-12-15	81	13	63
112975	2020-12-16	81	13	63
112976	2020-12-17	81	13	63
112977	2020-12-18	64	14	63
112978	2020-12-19	64	13	63
112979	2020-12-20	81	13	63
112980	2020-12-21	81	13	63
112981	2020-12-22	81	13	63
112982	2020-12-23	81	13	63
112983	2020-12-24	81	13	63
112984	2020-12-25	64	14	63
112985	2020-12-26	81	13	63
112986	2020-12-27	81	13	63
112987	2020-12-28	81	13	63
112988	2020-12-29	63	14	63
112989	2020-12-30	81	13	63
112990	2020-12-31	81	13	63
112991	2020-12-01	81	13	67
112992	2020-12-02	81	13	67
112993	2020-12-03	81	13	67
112994	2020-12-04	81	13	67
112995	2020-12-05	81	13	67
112996	2020-12-06	81	13	67
112997	2020-12-07	64	14	67
112998	2020-12-08	63	14	67
112999	2020-12-09	81	13	67
113000	2020-12-10	81	13	67
113001	2020-12-11	63	14	67
113002	2020-12-12	63	14	67
113003	2020-12-13	81	13	67
113004	2020-12-14	81	13	67
113005	2020-12-15	64	14	67
113006	2020-12-16	81	13	67
113007	2020-12-17	81	13	67
113008	2020-12-18	81	13	67
113009	2020-12-19	63	14	67
113010	2020-12-20	81	13	67
113011	2020-12-21	81	13	67
113012	2020-12-22	64	14	67
113013	2020-12-23	81	13	67
113014	2020-12-24	81	13	67
113015	2020-12-25	81	13	67
113016	2020-12-26	81	13	67
113017	2020-12-27	81	13	67
113018	2020-12-28	64	14	67
113019	2020-12-29	81	13	67
113020	2020-12-30	81	13	67
113021	2020-12-31	81	13	67
113022	2020-12-01	81	13	73
113023	2020-12-02	81	13	73
113024	2020-12-03	81	13	73
113025	2020-12-04	81	13	73
113026	2020-12-05	64	14	73
113027	2020-12-06	63	14	73
113028	2020-12-07	81	13	73
113029	2020-12-08	81	13	73
113030	2020-12-09	63	14	73
113031	2020-12-10	81	13	73
113032	2020-12-11	81	13	73
113033	2020-12-12	81	13	73
113034	2020-12-13	63	14	73
113035	2020-12-14	81	13	73
113036	2020-12-15	81	13	73
113037	2020-12-16	63	14	73
113038	2020-12-17	81	13	73
113039	2020-12-18	81	13	73
113040	2020-12-19	81	13	73
113041	2020-12-20	81	13	73
113042	2020-12-21	81	13	73
113043	2020-12-22	63	13	73
113044	2020-12-23	64	14	73
113045	2020-12-24	81	13	73
113046	2020-12-25	81	13	73
113047	2020-12-26	81	13	73
113048	2020-12-27	81	13	73
113049	2020-12-28	81	13	73
113050	2020-12-29	81	13	73
113051	2020-12-30	64	14	73
113052	2020-12-31	81	13	73
113053	2020-12-01	81	13	66
113054	2020-12-02	81	13	66
113055	2020-12-03	64	14	66
113056	2020-12-04	63	14	66
113057	2020-12-05	81	13	66
113058	2020-12-06	81	13	66
113059	2020-12-07	81	13	66
113060	2020-12-08	81	13	66
113061	2020-12-09	81	13	66
113062	2020-12-10	64	14	66
113063	2020-12-11	81	13	66
113064	2020-12-12	81	13	66
113065	2020-12-13	81	13	66
113066	2020-12-14	63	14	66
113067	2020-12-15	81	13	66
113068	2020-12-16	81	13	66
113069	2020-12-17	81	13	66
113070	2020-12-18	81	13	66
113071	2020-12-19	81	13	66
113072	2020-12-20	64	14	66
113073	2020-12-21	81	13	66
113074	2020-12-22	81	13	66
113075	2020-12-23	81	13	66
113076	2020-12-24	63	14	66
113077	2020-12-25	81	13	66
113078	2020-12-26	81	13	66
113079	2020-12-27	64	14	66
113080	2020-12-28	64	13	66
113081	2020-12-29	81	13	66
113082	2020-12-30	81	13	66
113083	2020-12-31	81	13	66
113084	2020-12-01	64	14	55
113085	2020-12-02	63	14	55
113086	2020-12-03	81	13	55
113087	2020-12-04	81	13	55
113088	2020-12-05	63	14	55
113089	2020-12-06	81	13	55
113090	2020-12-07	81	13	55
113091	2020-12-08	81	13	55
113092	2020-12-09	81	13	55
113093	2020-12-10	64	14	55
113094	2020-12-11	81	13	55
113095	2020-12-12	81	13	55
113096	2020-12-13	81	13	55
113097	2020-12-14	81	13	55
113098	2020-12-15	81	13	55
113099	2020-12-16	81	13	55
113100	2020-12-17	64	14	55
113101	2020-12-18	81	13	55
113102	2020-12-19	81	13	55
113103	2020-12-20	81	13	55
113104	2020-12-21	63	14	55
113105	2020-12-22	81	13	55
113106	2020-12-23	81	13	55
113107	2020-12-24	81	13	55
113108	2020-12-25	81	13	55
113109	2020-12-26	64	14	55
113110	2020-12-27	81	13	55
113111	2020-12-28	81	13	55
113112	2020-12-29	81	13	55
113113	2020-12-30	81	13	55
113114	2020-12-31	63	14	55
113115	2020-12-01	83	13	45
113116	2020-12-02	83	13	45
113117	2020-12-03	83	13	45
113118	2020-12-04	83	13	45
113119	2020-12-05	83	13	45
113120	2020-12-06	83	13	45
113121	2020-12-07	64	14	45
113122	2020-12-08	63	14	45
113123	2020-12-09	63	13	45
113124	2020-12-10	83	13	45
113125	2020-12-11	83	13	45
113126	2020-12-12	83	13	45
113127	2020-12-13	83	13	45
113128	2020-12-14	63	13	45
113129	2020-12-15	64	13	45
113130	2020-12-16	83	13	45
113131	2020-12-17	83	13	45
113132	2020-12-18	63	13	45
113133	2020-12-19	83	13	45
113134	2020-12-20	83	13	45
113135	2020-12-21	83	13	45
113136	2020-12-22	83	13	45
113137	2020-12-23	83	13	45
113138	2020-12-24	63	14	45
113139	2020-12-25	83	13	45
113140	2020-12-26	83	13	45
113141	2020-12-27	83	13	45
113142	2020-12-28	83	13	45
113143	2020-12-29	83	13	45
113144	2020-12-30	63	14	45
113145	2020-12-31	83	13	45
113146	2020-12-01	83	13	68
113147	2020-12-02	83	13	68
113148	2020-12-03	83	13	68
113149	2020-12-04	83	13	68
113150	2020-12-05	83	13	68
113151	2020-12-06	64	14	68
113152	2020-12-07	63	13	68
113153	2020-12-08	83	13	68
113154	2020-12-09	83	13	68
113155	2020-12-10	63	13	68
113156	2020-12-11	63	14	68
113157	2020-12-12	83	13	68
113158	2020-12-13	83	13	68
113159	2020-12-14	83	13	68
113160	2020-12-15	83	13	68
113161	2020-12-16	83	13	68
113162	2020-12-17	64	14	68
113163	2020-12-18	83	13	68
113164	2020-12-19	83	13	68
113165	2020-12-20	83	13	68
113166	2020-12-21	63	14	68
113167	2020-12-22	83	13	68
113168	2020-12-23	83	13	68
113169	2020-12-24	83	13	68
113170	2020-12-25	83	13	68
113171	2020-12-26	83	13	68
113172	2020-12-27	83	13	68
113173	2020-12-28	64	14	68
113174	2020-12-29	83	13	68
113175	2020-12-30	83	13	68
113176	2020-12-31	83	13	68
113177	2020-12-01	83	13	53
113178	2020-12-02	83	13	53
113179	2020-12-03	64	14	53
113180	2020-12-04	63	14	53
113181	2020-12-05	63	14	53
113182	2020-12-06	83	13	53
113183	2020-12-07	83	13	53
113184	2020-12-08	83	13	53
113185	2020-12-09	83	13	53
113186	2020-12-10	83	13	53
113187	2020-12-11	64	14	53
113188	2020-12-12	83	13	53
113189	2020-12-13	83	13	53
113190	2020-12-14	63	14	53
113191	2020-12-15	83	13	53
113192	2020-12-16	83	13	53
113193	2020-12-17	83	13	53
113194	2020-12-18	83	13	53
113195	2020-12-19	64	14	53
113196	2020-12-20	83	13	53
113197	2020-12-21	83	13	53
113198	2020-12-22	83	13	53
113199	2020-12-23	83	13	53
113200	2020-12-24	83	13	53
113201	2020-12-25	64	13	53
113202	2020-12-26	83	13	53
113203	2020-12-27	83	13	53
113204	2020-12-28	83	13	53
113205	2020-12-29	83	13	53
113206	2020-12-30	83	13	53
113207	2020-12-31	63	14	53
113208	2020-12-01	64	14	54
113209	2020-12-02	63	14	54
113210	2020-12-03	83	13	54
113211	2020-12-04	83	13	54
113212	2020-12-05	83	13	54
113213	2020-12-06	63	14	54
113214	2020-12-07	83	13	54
113215	2020-12-08	83	13	54
113216	2020-12-09	83	13	54
113217	2020-12-10	83	13	54
113218	2020-12-11	83	13	54
113219	2020-12-12	63	14	54
113220	2020-12-13	83	13	54
113221	2020-12-14	83	13	54
113222	2020-12-15	64	14	54
113223	2020-12-16	83	13	54
113224	2020-12-17	83	13	54
113225	2020-12-18	83	13	54
113226	2020-12-19	83	13	54
113227	2020-12-20	83	13	54
113228	2020-12-21	83	13	54
113229	2020-12-22	64	14	54
113230	2020-12-23	83	13	54
113231	2020-12-24	83	13	54
113232	2020-12-25	83	13	54
113233	2020-12-26	83	13	54
113234	2020-12-27	83	13	54
113235	2020-12-28	83	13	54
113236	2020-12-29	63	13	54
113237	2020-12-30	83	13	54
113238	2020-12-31	83	13	54
113239	2020-12-01	64	14	49
113240	2020-12-02	63	14	49
113241	2020-12-03	83	13	49
113242	2020-12-04	83	13	49
113243	2020-12-05	83	13	49
113244	2020-12-06	83	13	49
113245	2020-12-07	83	13	49
113246	2020-12-08	63	14	49
113247	2020-12-09	83	13	49
113248	2020-12-10	83	13	49
113249	2020-12-11	83	13	49
113250	2020-12-12	63	14	49
113251	2020-12-13	64	14	49
113252	2020-12-14	83	13	49
113253	2020-12-15	83	13	49
113254	2020-12-16	64	13	49
113255	2020-12-17	83	13	49
113256	2020-12-18	83	13	49
113257	2020-12-19	83	13	49
113258	2020-12-20	83	13	49
113259	2020-12-21	83	13	49
113260	2020-12-22	83	13	49
113261	2020-12-23	64	13	49
113262	2020-12-24	83	13	49
113263	2020-12-25	83	13	49
113264	2020-12-26	63	14	49
113265	2020-12-27	83	13	49
113266	2020-12-28	83	13	49
113267	2020-12-29	83	13	49
113268	2020-12-30	83	13	49
113269	2020-12-31	83	13	49
113270	2020-12-01	83	13	50
113271	2020-12-02	83	13	50
113272	2020-12-03	64	14	50
113273	2020-12-04	63	14	50
113274	2020-12-05	63	14	50
113275	2020-12-06	83	13	50
113276	2020-12-07	83	13	50
113277	2020-12-08	83	13	50
113278	2020-12-09	64	14	50
113279	2020-12-10	63	14	50
113280	2020-12-11	83	13	50
113281	2020-12-12	83	13	50
113282	2020-12-13	64	14	50
113283	2020-12-14	83	13	50
113284	2020-12-15	83	13	50
113285	2020-12-16	83	13	50
113286	2020-12-17	83	13	50
113287	2020-12-18	83	13	50
113288	2020-12-19	83	13	50
113289	2020-12-20	64	14	50
113290	2020-12-21	83	13	50
113291	2020-12-22	83	13	50
113292	2020-12-23	83	13	50
113293	2020-12-24	83	13	50
113294	2020-12-25	83	13	50
113295	2020-12-26	83	13	50
113296	2020-12-27	63	14	50
113297	2020-12-28	83	13	50
113298	2020-12-29	83	13	50
113299	2020-12-30	83	13	50
113300	2020-12-31	83	13	50
113301	2020-12-01	82	16	43
113302	2020-12-02	82	16	43
113303	2020-12-03	82	16	43
113304	2020-12-04	82	16	43
113305	2020-12-05	63	14	43
113306	2020-12-06	64	14	43
113307	2020-12-07	82	16	43
113308	2020-12-08	82	16	43
113309	2020-12-09	82	16	43
113310	2020-12-10	82	16	43
113311	2020-12-11	82	16	43
113312	2020-12-12	63	14	43
113313	2020-12-13	64	14	43
113314	2020-12-14	82	16	43
113315	2020-12-15	82	16	43
113316	2020-12-16	82	16	43
113317	2020-12-17	82	16	43
113318	2020-12-18	82	16	43
113319	2020-12-19	63	14	43
113320	2020-12-20	64	14	43
113321	2020-12-21	82	16	43
113322	2020-12-22	82	16	43
113323	2020-12-23	82	16	43
113324	2020-12-24	82	16	43
113325	2020-12-25	82	16	43
113326	2020-12-26	63	14	43
113327	2020-12-27	64	14	43
113328	2020-12-28	82	16	43
113329	2020-12-29	82	16	43
113330	2020-12-30	82	16	43
113331	2020-12-31	82	16	43
113332	2020-12-01	82	16	44
113333	2020-12-02	82	16	44
113334	2020-12-03	82	16	44
113335	2020-12-04	82	16	44
113336	2020-12-05	63	14	44
113337	2020-12-06	64	14	44
113338	2020-12-07	82	16	44
113339	2020-12-08	82	16	44
113340	2020-12-09	82	16	44
113341	2020-12-10	82	16	44
113342	2020-12-11	82	16	44
113343	2020-12-12	63	14	44
113344	2020-12-13	64	14	44
113345	2020-12-14	82	16	44
113346	2020-12-15	82	16	44
113347	2020-12-16	82	16	44
113348	2020-12-17	82	16	44
113349	2020-12-18	82	16	44
113350	2020-12-19	63	14	44
113351	2020-12-20	64	14	44
113352	2020-12-21	82	16	44
113353	2020-12-22	82	16	44
113354	2020-12-23	82	16	44
113355	2020-12-24	82	16	44
113356	2020-12-25	82	16	44
113357	2020-12-26	63	14	44
113358	2020-12-27	64	14	44
113359	2020-12-28	82	16	44
113360	2020-12-29	82	16	44
113361	2020-12-30	82	16	44
113362	2020-12-31	82	16	44
114976	2020-12-01	80	13	80
114977	2020-12-03	80	13	80
114978	2020-12-06	80	13	80
114979	2020-12-12	80	13	80
114980	2020-12-08	80	13	80
114981	2020-12-09	80	13	80
114982	2020-12-15	80	13	80
114983	2020-12-17	81	13	80
114984	2020-12-21	81	13	80
114985	2020-12-23	81	13	80
114986	2020-12-27	81	13	80
114987	2020-12-18	81	13	80
114988	2020-12-22	81	13	80
114989	2020-12-28	81	13	80
114990	2020-12-19	81	13	80
114991	2020-12-02	80	13	80
114992	2020-12-04	80	13	80
114993	2020-12-26	81	13	80
114994	2020-12-31	81	13	80
114995	2020-12-14	80	13	80
114996	2020-12-16	64	13	80
114997	2020-12-20	63	13	80
114998	2020-12-24	63	13	80
114999	2020-12-05	64	13	80
115000	2020-12-07	80	13	80
115001	2020-12-10	63	13	80
115002	2020-12-11	64	13	80
115003	2020-12-13	80	13	80
115004	2020-12-25	64	13	80
115005	2020-12-29	63	13	80
115006	2020-12-30	81	13	80
129632	2021-01-01	64	14	47
129633	2021-01-02	80	13	47
129634	2021-01-03	80	13	47
129635	2021-01-04	63	14	47
129636	2021-01-05	80	13	47
129637	2021-01-06	80	13	47
129638	2021-01-07	80	13	47
129639	2021-01-08	80	13	47
129640	2021-01-09	80	13	47
129641	2021-01-10	64	14	47
129642	2021-01-11	80	13	47
129643	2021-01-12	80	13	47
129644	2021-01-13	63	14	47
129645	2021-01-14	63	14	47
129646	2021-01-15	80	13	47
129647	2021-01-16	80	13	47
129648	2021-01-17	80	13	47
129649	2021-01-18	64	14	47
129650	2021-01-19	63	14	47
129651	2021-01-20	84	14	47
129652	2021-01-21	80	13	47
129653	2021-01-22	80	13	47
129654	2021-01-23	80	13	47
129655	2021-01-24	80	13	47
129656	2021-01-25	80	13	47
129657	2021-01-26	64	14	47
129658	2021-01-27	80	13	47
129659	2021-01-28	80	13	47
129660	2021-01-29	80	13	47
129661	2021-01-30	63	14	47
129662	2021-01-31	64	14	47
129663	2021-01-01	64	14	69
129664	2021-01-02	80	13	69
129665	2021-01-03	80	13	69
129666	2021-01-04	80	13	69
129667	2021-01-05	80	13	69
129668	2021-01-06	80	13	69
129669	2021-01-07	64	14	69
129670	2021-01-08	63	14	69
129671	2021-01-09	63	14	69
129672	2021-01-10	80	13	69
129673	2021-01-11	80	13	69
129674	2021-01-12	63	14	69
129675	2021-01-13	80	13	69
129676	2021-01-14	80	13	69
129677	2021-01-15	80	13	69
129678	2021-01-16	64	14	69
129679	2021-01-17	80	13	69
129680	2021-01-18	80	13	69
129681	2021-01-19	80	13	69
129682	2021-01-20	80	13	69
129683	2021-01-21	80	13	69
129684	2021-01-22	64	14	69
129685	2021-01-23	63	14	69
129686	2021-01-24	80	13	69
129687	2021-01-25	80	13	69
129688	2021-01-26	80	13	69
129689	2021-01-27	63	14	69
129690	2021-01-28	80	13	69
129691	2021-01-29	80	13	69
129692	2021-01-30	64	14	69
129693	2021-01-31	84	14	69
129694	2021-01-01	64	14	46
129695	2021-01-02	84	14	46
129696	2021-01-03	63	14	46
129697	2021-01-04	80	13	46
129698	2021-01-05	80	13	46
129699	2021-01-06	63	14	46
129700	2021-01-07	80	13	46
129701	2021-01-08	80	13	46
129702	2021-01-09	80	13	46
129703	2021-01-10	80	13	46
129704	2021-01-11	64	14	46
129705	2021-01-12	63	14	46
129706	2021-01-13	80	13	46
129707	2021-01-14	80	13	46
129708	2021-01-15	80	13	46
129709	2021-01-16	80	13	46
129710	2021-01-17	64	14	46
129711	2021-01-18	80	13	46
129712	2021-01-19	80	13	46
129713	2021-01-20	63	14	46
129714	2021-01-21	80	13	46
129715	2021-01-22	80	13	46
129716	2021-01-23	80	13	46
129717	2021-01-24	64	14	46
129718	2021-01-25	63	14	46
129719	2021-01-26	80	13	46
129720	2021-01-27	80	13	46
129721	2021-01-28	80	13	46
129722	2021-01-29	64	14	46
129723	2021-01-30	80	13	46
129724	2021-01-31	80	13	46
129725	2021-01-01	64	14	60
129726	2021-01-02	80	13	60
129727	2021-01-03	80	13	60
129728	2021-01-04	63	14	60
129729	2021-01-05	63	14	60
129730	2021-01-06	80	13	60
129731	2021-01-07	80	13	60
129732	2021-01-08	80	13	60
129733	2021-01-09	64	14	60
129734	2021-01-10	80	13	60
129735	2021-01-11	80	13	60
129736	2021-01-12	80	13	60
129737	2021-01-13	80	13	60
129738	2021-01-14	63	14	60
129739	2021-01-15	64	14	60
129740	2021-01-16	80	13	60
129741	2021-01-17	80	13	60
129742	2021-01-18	80	13	60
129743	2021-01-19	80	13	60
129744	2021-01-20	80	13	60
129745	2021-01-21	64	14	60
129746	2021-01-22	80	13	60
129747	2021-01-23	80	13	60
129748	2021-01-24	63	14	60
129749	2021-01-25	84	14	60
129750	2021-01-26	80	13	60
129751	2021-01-27	80	13	60
129752	2021-01-28	64	14	60
129753	2021-01-29	63	14	60
129754	2021-01-30	80	13	60
129755	2021-01-31	80	13	60
129756	2021-01-01	64	14	64
129757	2021-01-02	84	14	64
129758	2021-01-03	63	14	64
129759	2021-01-04	80	13	64
129760	2021-01-05	80	13	64
129761	2021-01-06	63	14	64
129762	2021-01-07	80	13	64
129763	2021-01-08	80	13	64
129764	2021-01-09	80	13	64
129765	2021-01-10	64	14	64
129766	2021-01-11	63	14	64
129767	2021-01-12	63	14	64
129768	2021-01-13	80	13	64
129769	2021-01-14	80	13	64
129770	2021-01-15	80	13	64
129771	2021-01-16	80	13	64
129772	2021-01-17	80	13	64
129773	2021-01-18	80	13	64
129774	2021-01-19	64	14	64
129775	2021-01-20	80	13	64
129776	2021-01-21	80	13	64
129777	2021-01-22	63	14	64
129778	2021-01-23	80	13	64
129779	2021-01-24	80	13	64
129780	2021-01-25	80	13	64
129781	2021-01-26	64	14	64
129782	2021-01-27	80	13	64
129783	2021-01-28	80	13	64
129784	2021-01-29	80	13	64
129785	2021-01-30	64	14	64
129786	2021-01-31	80	13	64
129787	2021-01-01	64	14	65
129788	2021-01-02	80	13	65
129789	2021-01-03	80	13	65
129790	2021-01-04	63	14	65
129791	2021-01-05	80	13	65
129792	2021-01-06	80	13	65
129793	2021-01-07	64	14	65
129794	2021-01-08	80	13	65
129795	2021-01-09	80	13	65
129796	2021-01-10	63	14	65
129797	2021-01-11	63	14	65
129798	2021-01-12	80	13	65
129799	2021-01-13	80	13	65
129800	2021-01-14	80	13	65
129801	2021-01-15	64	14	65
129802	2021-01-16	63	14	65
129803	2021-01-17	80	13	65
129804	2021-01-18	80	13	65
129805	2021-01-19	80	13	65
129806	2021-01-20	84	14	65
129807	2021-01-21	64	14	65
129808	2021-01-22	80	13	65
129809	2021-01-23	80	13	65
129810	2021-01-24	80	13	65
129811	2021-01-25	63	14	65
129812	2021-01-26	80	13	65
129813	2021-01-27	80	13	65
129814	2021-01-28	80	13	65
129815	2021-01-29	80	13	65
129816	2021-01-30	64	14	65
129817	2021-01-31	80	13	65
129818	2021-01-01	64	14	51
129819	2021-01-02	84	14	51
129820	2021-01-03	63	14	51
129821	2021-01-04	80	13	51
129822	2021-01-05	80	13	51
129823	2021-01-06	63	14	51
129824	2021-01-07	64	14	51
129825	2021-01-08	80	13	51
129826	2021-01-09	80	13	51
129827	2021-01-10	80	13	51
129828	2021-01-11	80	13	51
129829	2021-01-12	63	14	51
129830	2021-01-13	80	13	51
129831	2021-01-14	80	13	51
129832	2021-01-15	80	13	51
129833	2021-01-16	80	13	51
129834	2021-01-17	80	13	51
129835	2021-01-18	64	14	51
129836	2021-01-19	63	14	51
129837	2021-01-20	80	13	51
129838	2021-01-21	80	13	51
129839	2021-01-22	80	13	51
129840	2021-01-23	80	13	51
129841	2021-01-24	80	13	51
129842	2021-01-25	64	14	51
129843	2021-01-26	80	13	51
129844	2021-01-27	80	13	51
129845	2021-01-28	63	14	51
129846	2021-01-29	64	14	51
129847	2021-01-30	80	13	51
129848	2021-01-31	80	13	51
129849	2021-01-01	64	14	57
129850	2021-01-02	80	13	57
129851	2021-01-03	80	13	57
129852	2021-01-04	80	13	57
129853	2021-01-05	80	13	57
129854	2021-01-06	63	14	57
129855	2021-01-07	64	14	57
129856	2021-01-08	63	14	57
129857	2021-01-09	80	13	57
129858	2021-01-10	80	13	57
129859	2021-01-11	63	14	57
129860	2021-01-12	80	13	57
129861	2021-01-13	80	13	57
129862	2021-01-14	64	14	57
129863	2021-01-15	80	13	57
129864	2021-01-16	80	13	57
129865	2021-01-17	63	14	57
129866	2021-01-18	80	13	57
129867	2021-01-19	80	13	57
129868	2021-01-20	64	14	57
129869	2021-01-21	80	13	57
129870	2021-01-22	80	13	57
129871	2021-01-23	80	13	57
129872	2021-01-24	84	14	57
129873	2021-01-25	80	13	57
129874	2021-01-26	80	13	57
129875	2021-01-27	64	14	57
129876	2021-01-28	80	13	57
129877	2021-01-29	80	13	57
129878	2021-01-30	80	13	57
129879	2021-01-31	63	14	57
129880	2021-01-01	64	14	71
129881	2021-01-02	80	13	71
129882	2021-01-03	80	13	71
129883	2021-01-04	63	14	71
129884	2021-01-05	84	14	71
129885	2021-01-06	80	13	71
129886	2021-01-07	80	13	71
129887	2021-01-08	64	14	71
129888	2021-01-09	63	14	71
129889	2021-01-10	80	13	71
129890	2021-01-11	80	13	71
129891	2021-01-12	80	13	71
129892	2021-01-13	63	14	71
129893	2021-01-14	80	13	71
129894	2021-01-15	80	13	71
129895	2021-01-16	80	13	71
129896	2021-01-17	64	14	71
129897	2021-01-18	63	14	71
129898	2021-01-19	80	13	71
129899	2021-01-20	80	13	71
129900	2021-01-21	80	13	71
129901	2021-01-22	80	13	71
129902	2021-01-23	64	14	71
129903	2021-01-24	63	14	71
129904	2021-01-25	80	13	71
129905	2021-01-26	80	13	71
129906	2021-01-27	80	13	71
129907	2021-01-28	80	13	71
129908	2021-01-29	80	13	71
129909	2021-01-30	80	13	71
129910	2021-01-31	64	14	71
129911	2021-01-01	64	14	78
129912	2021-01-02	80	13	78
129913	2021-01-03	80	13	78
129914	2021-01-04	80	13	78
129915	2021-01-05	63	14	78
129916	2021-01-06	80	13	78
129917	2021-01-07	80	13	78
129918	2021-01-08	64	14	78
129919	2021-01-09	63	14	78
129920	2021-01-10	80	13	78
129921	2021-01-11	80	13	78
129922	2021-01-12	84	14	78
129923	2021-01-13	63	14	78
129924	2021-01-14	64	14	78
129925	2021-01-15	80	13	78
129926	2021-01-16	80	13	78
129927	2021-01-17	80	13	78
129928	2021-01-18	80	13	78
129929	2021-01-19	80	13	78
129930	2021-01-20	80	13	78
129931	2021-01-21	64	14	78
129932	2021-01-22	63	14	78
129933	2021-01-23	80	13	78
129934	2021-01-24	80	13	78
129935	2021-01-25	80	13	78
129936	2021-01-26	80	13	78
129937	2021-01-27	64	14	78
129938	2021-01-28	63	14	78
129939	2021-01-29	80	13	78
129940	2021-01-30	80	13	78
129941	2021-01-31	80	13	78
129942	2021-01-01	64	14	79
129943	2021-01-02	84	14	79
129944	2021-01-03	63	14	79
129945	2021-01-04	63	14	79
129946	2021-01-05	80	13	79
129947	2021-01-06	80	13	79
129948	2021-01-07	80	13	79
129949	2021-01-08	80	13	79
129950	2021-01-09	64	14	79
129951	2021-01-10	63	14	79
129952	2021-01-11	80	13	79
129953	2021-01-12	80	13	79
129954	2021-01-13	63	14	79
129955	2021-01-14	80	13	79
129956	2021-01-15	80	13	79
129957	2021-01-16	64	14	79
129958	2021-01-17	80	13	79
129959	2021-01-18	80	13	79
129960	2021-01-19	80	13	79
129961	2021-01-20	80	13	79
129962	2021-01-21	80	13	79
129963	2021-01-22	80	13	79
129964	2021-01-23	64	14	79
129965	2021-01-24	80	13	79
129966	2021-01-25	80	13	79
129967	2021-01-26	63	14	79
129968	2021-01-27	80	13	79
129969	2021-01-28	80	13	79
129970	2021-01-29	64	14	79
129971	2021-01-30	80	13	79
129972	2021-01-31	80	13	79
129973	2021-01-01	64	14	56
129974	2021-01-02	63	14	56
129975	2021-01-03	63	14	56
129976	2021-01-04	81	13	56
129977	2021-01-05	81	13	56
129978	2021-01-06	63	14	56
129979	2021-01-07	64	14	56
129980	2021-01-08	81	13	56
129981	2021-01-09	81	13	56
129982	2021-01-10	81	13	56
129983	2021-01-11	81	13	56
129984	2021-01-12	81	13	56
129985	2021-01-13	81	13	56
129986	2021-01-14	64	14	56
129987	2021-01-15	81	13	56
129988	2021-01-16	81	13	56
129989	2021-01-17	81	13	56
129990	2021-01-18	81	13	56
129991	2021-01-19	81	13	56
129992	2021-01-20	81	13	56
129993	2021-01-21	64	14	56
129994	2021-01-22	81	13	56
129995	2021-01-23	81	13	56
129996	2021-01-24	63	14	56
129997	2021-01-25	63	14	56
129998	2021-01-26	81	13	56
129999	2021-01-27	81	13	56
130000	2021-01-28	64	14	56
130001	2021-01-29	81	13	56
130002	2021-01-30	81	13	56
130003	2021-01-31	84	14	56
130004	2021-01-01	64	14	62
130005	2021-01-02	81	13	62
130006	2021-01-03	81	13	62
130007	2021-01-04	63	14	62
130008	2021-01-05	81	13	62
130009	2021-01-06	81	13	62
130010	2021-01-07	81	13	62
130011	2021-01-08	64	14	62
130012	2021-01-09	63	14	62
130013	2021-01-10	63	14	62
130014	2021-01-11	81	13	62
130015	2021-01-12	81	13	62
130016	2021-01-13	81	13	62
130017	2021-01-14	81	13	62
130018	2021-01-15	64	14	62
130019	2021-01-16	81	13	62
130020	2021-01-17	81	13	62
130021	2021-01-18	81	13	62
130022	2021-01-19	63	14	62
130023	2021-01-20	81	13	62
130024	2021-01-21	81	13	62
130025	2021-01-22	81	13	62
130026	2021-01-23	64	14	62
130027	2021-01-24	81	13	62
130028	2021-01-25	81	13	62
130029	2021-01-26	84	14	62
130030	2021-01-27	81	13	62
130031	2021-01-28	81	13	62
130032	2021-01-29	64	14	62
130033	2021-01-30	63	14	62
130034	2021-01-31	81	13	62
130035	2021-01-01	64	14	63
130036	2021-01-02	81	13	63
130037	2021-01-03	81	13	63
130038	2021-01-04	63	14	63
130039	2021-01-05	63	14	63
130040	2021-01-06	63	14	63
130041	2021-01-07	81	13	63
130042	2021-01-08	81	13	63
130043	2021-01-09	64	14	63
130044	2021-01-10	81	13	63
130045	2021-01-11	81	13	63
130046	2021-01-12	81	13	63
130047	2021-01-13	63	14	63
130048	2021-01-14	84	14	63
130049	2021-01-15	81	13	63
130050	2021-01-16	81	13	63
130051	2021-01-17	81	13	63
130052	2021-01-18	64	14	63
130053	2021-01-19	81	13	63
130054	2021-01-20	81	13	63
130055	2021-01-21	81	13	63
130056	2021-01-22	81	13	63
130057	2021-01-23	81	13	63
130058	2021-01-24	81	13	63
130059	2021-01-25	64	14	63
130060	2021-01-26	63	14	63
130061	2021-01-27	81	13	63
130062	2021-01-28	81	13	63
130063	2021-01-29	64	14	63
130064	2021-01-30	81	13	63
130065	2021-01-31	81	13	63
130066	2021-01-01	64	14	67
130067	2021-01-02	81	13	67
130068	2021-01-03	81	13	67
130069	2021-01-04	63	14	67
130070	2021-01-05	81	13	67
130071	2021-01-06	81	13	67
130072	2021-01-07	64	14	67
130073	2021-01-08	63	14	67
130074	2021-01-09	81	13	67
130075	2021-01-10	81	13	67
130076	2021-01-11	81	13	67
130077	2021-01-12	63	14	67
130078	2021-01-13	81	13	67
130079	2021-01-14	81	13	67
130080	2021-01-15	64	14	67
130081	2021-01-16	84	14	67
130082	2021-01-17	81	13	67
130083	2021-01-18	81	13	67
130084	2021-01-19	63	14	67
130085	2021-01-20	81	13	67
130086	2021-01-21	81	13	67
130087	2021-01-22	64	14	67
130088	2021-01-23	63	14	67
130089	2021-01-24	81	13	67
130090	2021-01-25	81	13	67
130091	2021-01-26	81	13	67
130092	2021-01-27	81	13	67
130093	2021-01-28	64	14	67
130094	2021-01-29	81	13	67
130095	2021-01-30	81	13	67
130096	2021-01-31	81	13	67
130097	2021-01-01	64	14	73
130098	2021-01-02	81	13	73
130099	2021-01-03	81	13	73
130100	2021-01-04	81	13	73
130101	2021-01-05	63	14	73
130102	2021-01-06	81	13	73
130103	2021-01-07	81	13	73
130104	2021-01-08	64	14	73
130105	2021-01-09	63	14	73
130106	2021-01-10	84	14	73
130107	2021-01-11	81	13	73
130108	2021-01-12	81	13	73
130109	2021-01-13	63	14	73
130110	2021-01-14	64	14	73
130111	2021-01-15	81	13	73
130112	2021-01-16	81	13	73
130113	2021-01-17	81	13	73
130114	2021-01-18	63	14	73
130115	2021-01-19	81	13	73
130116	2021-01-20	81	13	73
130117	2021-01-21	81	13	73
130118	2021-01-22	81	13	73
130119	2021-01-23	64	14	73
130120	2021-01-24	81	13	73
130121	2021-01-25	81	13	73
130122	2021-01-26	81	13	73
130123	2021-01-27	81	13	73
130124	2021-01-28	81	13	73
130125	2021-01-29	81	13	73
130126	2021-01-30	64	14	73
130127	2021-01-31	63	14	73
130128	2021-01-01	64	14	66
130129	2021-01-02	63	14	66
130130	2021-01-03	63	14	66
130131	2021-01-04	81	13	66
130132	2021-01-05	81	13	66
130133	2021-01-06	84	14	66
130134	2021-01-07	81	13	66
130135	2021-01-08	81	13	66
130136	2021-01-09	81	13	66
130137	2021-01-10	64	14	66
130138	2021-01-11	63	14	66
130139	2021-01-12	63	14	66
130140	2021-01-13	81	13	66
130141	2021-01-14	81	13	66
130142	2021-01-15	81	13	66
130143	2021-01-16	81	13	66
130144	2021-01-17	64	14	66
130145	2021-01-18	81	13	66
130146	2021-01-19	81	13	66
130147	2021-01-20	63	14	66
130148	2021-01-21	64	14	66
130149	2021-01-22	81	13	66
130150	2021-01-23	81	13	66
130151	2021-01-24	81	13	66
130152	2021-01-25	81	13	66
130153	2021-01-26	81	13	66
130154	2021-01-27	81	13	66
130155	2021-01-28	64	14	66
130156	2021-01-29	81	13	66
130157	2021-01-30	81	13	66
130158	2021-01-31	81	13	66
130159	2021-01-01	64	14	55
130160	2021-01-02	63	14	55
130161	2021-01-03	63	14	55
130162	2021-01-04	81	13	55
130163	2021-01-05	81	13	55
130164	2021-01-06	63	14	55
130165	2021-01-07	64	14	55
130166	2021-01-08	81	13	55
130167	2021-01-09	81	13	55
130168	2021-01-10	81	13	55
130169	2021-01-11	63	14	55
130170	2021-01-12	84	14	55
130171	2021-01-13	81	13	55
130172	2021-01-14	81	13	55
130173	2021-01-15	81	13	55
130174	2021-01-16	81	13	55
130175	2021-01-17	64	14	55
130176	2021-01-18	81	13	55
130177	2021-01-19	81	13	55
130178	2021-01-20	81	13	55
130179	2021-01-21	63	14	55
130180	2021-01-22	81	13	55
130181	2021-01-23	81	13	55
130182	2021-01-24	64	14	55
130183	2021-01-25	81	13	55
130184	2021-01-26	81	13	55
130185	2021-01-27	64	14	55
130186	2021-01-28	81	13	55
130187	2021-01-29	81	13	55
130188	2021-01-30	81	13	55
130189	2021-01-31	81	13	55
130190	2021-01-01	64	14	45
130191	2021-01-02	83	13	45
130192	2021-01-03	83	13	45
130193	2021-01-04	83	13	45
130194	2021-01-05	83	13	45
130195	2021-01-06	84	14	45
130196	2021-01-07	64	14	45
130197	2021-01-08	63	14	45
130198	2021-01-09	83	13	45
130199	2021-01-10	83	13	45
130200	2021-01-11	83	13	45
130201	2021-01-12	83	13	45
130202	2021-01-13	64	14	45
130203	2021-01-14	63	14	45
130204	2021-01-15	83	13	45
130205	2021-01-16	83	13	45
130206	2021-01-17	83	13	45
130207	2021-01-18	83	13	45
130208	2021-01-19	64	14	45
130209	2021-01-20	63	14	45
130210	2021-01-21	63	14	45
130211	2021-01-22	83	13	45
130212	2021-01-23	83	13	45
130213	2021-01-24	83	13	45
130214	2021-01-25	83	13	45
130215	2021-01-26	83	13	45
130216	2021-01-27	64	14	45
130217	2021-01-28	83	13	45
130218	2021-01-29	83	13	45
130219	2021-01-30	63	14	45
130220	2021-01-31	83	13	45
130221	2021-01-01	64	14	68
130222	2021-01-02	63	14	68
130223	2021-01-03	83	13	68
130224	2021-01-04	83	13	68
130225	2021-01-05	63	14	68
130226	2021-01-06	83	13	68
130227	2021-01-07	83	13	68
130228	2021-01-08	83	13	68
130229	2021-01-09	64	14	68
130230	2021-01-10	83	13	68
130231	2021-01-11	83	13	68
130232	2021-01-12	63	14	68
130233	2021-01-13	83	13	68
130234	2021-01-14	83	13	68
130235	2021-01-15	83	13	68
130236	2021-01-16	64	14	68
130237	2021-01-17	63	14	68
130238	2021-01-18	83	13	68
130239	2021-01-19	83	13	68
130240	2021-01-20	83	13	68
130241	2021-01-21	83	13	68
130242	2021-01-22	83	13	68
130243	2021-01-23	83	13	68
130244	2021-01-24	64	14	68
130245	2021-01-25	63	14	68
130246	2021-01-26	83	13	68
130247	2021-01-27	83	13	68
130248	2021-01-28	84	14	68
130249	2021-01-29	64	14	68
130250	2021-01-30	83	13	68
130251	2021-01-31	83	13	68
130252	2021-01-01	64	14	53
130253	2021-01-02	84	14	53
130254	2021-01-03	63	14	53
130255	2021-01-04	63	14	53
130256	2021-01-05	83	13	53
130257	2021-01-06	83	13	53
130258	2021-01-07	83	13	53
130259	2021-01-08	83	13	53
130260	2021-01-09	64	14	53
130261	2021-01-10	83	13	53
130262	2021-01-11	83	13	53
130263	2021-01-12	63	14	53
130264	2021-01-13	83	13	53
130265	2021-01-14	83	13	53
130266	2021-01-15	83	13	53
130267	2021-01-16	64	14	53
130268	2021-01-17	83	13	53
130269	2021-01-18	83	13	53
130270	2021-01-19	63	14	53
130271	2021-01-20	83	13	53
130272	2021-01-21	83	13	53
130273	2021-01-22	83	13	53
130274	2021-01-23	83	13	53
130275	2021-01-24	64	14	53
130276	2021-01-25	83	13	53
130277	2021-01-26	83	13	53
130278	2021-01-27	83	13	53
130279	2021-01-28	63	14	53
130280	2021-01-29	64	14	53
130281	2021-01-30	83	13	53
130282	2021-01-31	83	13	53
130283	2021-01-01	64	14	54
130284	2021-01-02	83	13	54
130285	2021-01-03	83	13	54
130286	2021-01-04	83	13	54
130287	2021-01-05	63	14	54
130288	2021-01-06	83	13	54
130289	2021-01-07	83	13	54
130290	2021-01-08	64	14	54
130291	2021-01-09	63	14	54
130292	2021-01-10	63	14	54
130293	2021-01-11	83	13	54
130294	2021-01-12	83	13	54
130295	2021-01-13	63	14	54
130296	2021-01-14	64	14	54
130297	2021-01-15	83	13	54
130298	2021-01-16	83	13	54
130299	2021-01-17	84	14	54
130300	2021-01-18	83	13	54
130301	2021-01-19	83	13	54
130302	2021-01-20	83	13	54
130303	2021-01-21	83	13	54
130304	2021-01-22	64	14	54
130305	2021-01-23	63	14	54
130306	2021-01-24	83	13	54
130307	2021-01-25	83	13	54
130308	2021-01-26	83	13	54
130309	2021-01-27	64	14	54
130310	2021-01-28	83	13	54
130311	2021-01-29	83	13	54
130312	2021-01-30	83	13	54
130313	2021-01-31	83	13	54
130314	2021-01-01	64	14	49
130315	2021-01-02	83	13	49
130316	2021-01-03	83	13	49
130317	2021-01-04	83	13	49
130318	2021-01-05	63	14	49
130319	2021-01-06	63	14	49
130320	2021-01-07	64	14	49
130321	2021-01-08	84	14	49
130322	2021-01-09	83	13	49
130323	2021-01-10	83	13	49
130324	2021-01-11	63	14	49
130325	2021-01-12	63	14	49
130326	2021-01-13	64	14	49
130327	2021-01-14	83	13	49
130328	2021-01-15	83	13	49
130329	2021-01-16	83	13	49
130330	2021-01-17	83	13	49
130331	2021-01-18	83	13	49
130332	2021-01-19	83	13	49
130333	2021-01-20	64	14	49
130334	2021-01-21	83	13	49
130335	2021-01-22	83	13	49
130336	2021-01-23	83	13	49
130337	2021-01-24	83	13	49
130338	2021-01-25	63	14	49
130339	2021-01-26	83	13	49
130340	2021-01-27	83	13	49
130341	2021-01-28	83	13	49
130342	2021-01-29	83	13	49
130343	2021-01-30	83	13	49
130344	2021-01-31	64	14	49
130345	2021-01-01	64	14	50
130346	2021-01-02	63	14	50
130347	2021-01-03	63	14	50
130348	2021-01-04	63	14	50
130349	2021-01-05	83	13	50
130350	2021-01-06	83	13	50
130351	2021-01-07	64	14	50
130352	2021-01-08	83	13	50
130353	2021-01-09	83	13	50
130354	2021-01-10	63	14	50
130355	2021-01-11	63	14	50
130356	2021-01-12	83	13	50
130357	2021-01-13	83	13	50
130358	2021-01-14	83	13	50
130359	2021-01-15	64	14	50
130360	2021-01-16	83	13	50
130361	2021-01-17	83	13	50
130362	2021-01-18	84	14	50
130363	2021-01-19	83	13	50
130364	2021-01-20	83	13	50
130365	2021-01-21	64	14	50
130366	2021-01-22	83	13	50
130367	2021-01-23	83	13	50
130368	2021-01-24	83	13	50
130369	2021-01-25	83	13	50
130370	2021-01-26	64	14	50
130371	2021-01-27	83	13	50
130372	2021-01-28	83	13	50
130373	2021-01-29	83	13	50
130374	2021-01-30	83	13	50
130375	2021-01-31	83	13	50
130376	2021-01-01	63	14	43
130377	2021-01-02	63	14	43
130378	2021-01-03	64	14	43
130379	2021-01-04	82	16	43
130380	2021-01-05	82	16	43
130381	2021-01-06	82	16	43
130382	2021-01-07	82	16	43
130383	2021-01-08	82	16	43
130384	2021-01-09	63	14	43
130385	2021-01-10	64	14	43
130386	2021-01-11	82	16	43
130387	2021-01-12	84	14	43
130388	2021-01-13	82	16	43
130389	2021-01-14	82	16	43
130390	2021-01-15	82	16	43
130391	2021-01-16	63	14	43
130392	2021-01-17	64	14	43
130393	2021-01-18	82	16	43
130394	2021-01-19	82	16	43
130395	2021-01-20	82	16	43
130396	2021-01-21	82	16	43
130397	2021-01-22	82	16	43
130398	2021-01-23	63	14	43
130399	2021-01-24	64	14	43
130400	2021-01-25	82	16	43
130401	2021-01-26	82	16	43
130402	2021-01-27	82	16	43
130403	2021-01-28	82	16	43
130404	2021-01-29	82	16	43
130405	2021-01-30	63	14	43
130406	2021-01-31	64	14	43
130407	2021-01-01	63	14	44
130408	2021-01-02	63	14	44
130409	2021-01-03	64	14	44
130410	2021-01-04	82	16	44
130411	2021-01-05	82	16	44
130412	2021-01-06	82	16	44
130413	2021-01-07	82	16	44
130414	2021-01-08	82	16	44
130415	2021-01-09	63	14	44
130416	2021-01-10	64	14	44
130417	2021-01-11	82	16	44
130418	2021-01-12	84	14	44
130419	2021-01-13	82	16	44
130420	2021-01-14	82	16	44
130421	2021-01-15	82	16	44
130422	2021-01-16	63	14	44
130423	2021-01-17	64	14	44
130424	2021-01-18	82	16	44
130425	2021-01-19	82	16	44
130426	2021-01-20	82	16	44
130427	2021-01-21	82	16	44
130428	2021-01-22	82	16	44
130429	2021-01-23	63	14	44
130430	2021-01-24	64	14	44
130431	2021-01-25	82	16	44
130432	2021-01-26	82	16	44
130433	2021-01-27	82	16	44
130434	2021-01-28	82	16	44
130435	2021-01-29	82	16	44
130436	2021-01-30	63	14	44
130437	2021-01-31	64	14	44
130438	2021-02-01	80	13	47
130439	2021-02-02	80	13	47
130440	2021-02-03	64	14	47
130441	2021-02-04	80	13	47
130442	2021-02-05	80	13	47
130443	2021-02-06	84	14	47
130444	2021-02-07	63	14	47
130445	2021-02-08	80	13	47
130446	2021-02-09	80	13	47
130447	2021-02-10	80	13	47
130448	2021-02-11	80	13	47
130449	2021-02-12	64	14	47
130450	2021-02-13	63	14	47
130451	2021-02-14	63	14	47
130452	2021-02-15	84	14	47
130453	2021-02-16	84	14	47
130454	2021-02-17	80	13	47
130455	2021-02-18	80	13	47
130456	2021-02-19	64	14	47
130457	2021-02-20	63	14	47
130458	2021-02-21	80	13	47
130459	2021-02-22	80	13	47
130460	2021-02-23	80	13	47
130461	2021-02-24	80	13	47
130462	2021-02-25	64	14	47
130463	2021-02-26	84	14	47
130464	2021-02-27	80	13	47
130465	2021-02-28	80	13	47
130466	2021-02-01	64	14	69
130467	2021-02-02	63	14	69
130468	2021-02-03	80	13	69
130469	2021-02-04	80	13	69
130470	2021-02-05	63	14	69
130471	2021-02-06	80	13	69
130472	2021-02-07	80	13	69
130473	2021-02-08	80	13	69
130474	2021-02-09	64	14	69
130475	2021-02-10	63	14	69
130476	2021-02-11	80	13	69
130477	2021-02-12	84	14	69
130478	2021-02-13	63	14	69
130479	2021-02-14	84	14	69
130480	2021-02-15	80	13	69
130481	2021-02-16	80	13	69
130482	2021-02-17	80	13	69
130483	2021-02-18	64	14	69
130484	2021-02-19	80	13	69
130485	2021-02-20	80	13	69
130486	2021-02-21	84	14	69
130487	2021-02-22	84	14	69
130488	2021-02-23	80	13	69
130489	2021-02-24	80	13	69
130490	2021-02-25	80	13	69
130491	2021-02-26	64	14	69
130492	2021-02-27	80	13	69
130493	2021-02-28	80	13	69
130494	2021-02-01	64	14	46
130495	2021-02-02	63	14	46
130496	2021-02-03	80	13	46
130497	2021-02-04	80	13	46
130498	2021-02-05	84	14	46
130499	2021-02-06	80	13	46
130500	2021-02-07	80	13	46
130501	2021-02-08	80	13	46
130502	2021-02-09	80	13	46
130503	2021-02-10	64	14	46
130504	2021-02-11	80	13	46
130505	2021-02-12	84	14	46
130506	2021-02-13	84	14	46
130507	2021-02-14	63	14	46
130508	2021-02-15	80	13	46
130509	2021-02-16	80	13	46
130510	2021-02-17	64	14	46
130511	2021-02-18	84	14	46
130512	2021-02-19	80	13	46
130513	2021-02-20	80	13	46
130514	2021-02-21	80	13	46
130515	2021-02-22	80	13	46
130516	2021-02-23	64	14	46
130517	2021-02-24	63	14	46
130518	2021-02-25	80	13	46
130519	2021-02-26	80	13	46
130520	2021-02-27	80	13	46
130521	2021-02-28	63	14	46
130522	2021-02-01	80	13	60
130523	2021-02-02	80	13	60
130524	2021-02-03	80	13	60
130525	2021-02-04	64	14	60
130526	2021-02-05	80	13	60
130527	2021-02-06	80	13	60
130528	2021-02-07	80	13	60
130529	2021-02-08	63	14	60
130530	2021-02-09	80	13	60
130531	2021-02-10	80	13	60
130532	2021-02-11	64	14	60
130533	2021-02-12	84	14	60
130534	2021-02-13	84	14	60
130535	2021-02-14	63	14	60
130536	2021-02-15	84	14	60
130537	2021-02-16	84	14	60
130538	2021-02-17	80	13	60
130539	2021-02-18	80	13	60
130540	2021-02-19	64	14	60
130541	2021-02-20	63	14	60
130542	2021-02-21	80	13	60
130543	2021-02-22	80	13	60
130544	2021-02-23	80	13	60
130545	2021-02-24	63	14	60
130546	2021-02-25	80	13	60
130547	2021-02-26	80	13	60
130548	2021-02-27	64	14	60
130549	2021-02-28	80	13	60
130550	2021-02-01	80	13	64
130551	2021-02-02	80	13	64
130552	2021-02-03	64	14	64
130553	2021-02-04	63	14	64
130554	2021-02-05	84	14	64
130555	2021-02-06	80	13	64
130556	2021-02-07	80	13	64
130557	2021-02-08	63	14	64
130558	2021-02-09	64	14	64
130559	2021-02-10	80	13	64
130560	2021-02-11	80	13	64
130561	2021-02-12	63	14	64
130562	2021-02-13	84	14	64
130563	2021-02-14	84	14	64
130564	2021-02-15	80	13	64
130565	2021-02-16	80	13	64
130566	2021-02-17	80	13	64
130567	2021-02-18	64	14	64
130568	2021-02-19	84	14	64
130569	2021-02-20	63	14	64
130570	2021-02-21	80	13	64
130571	2021-02-22	80	13	64
130572	2021-02-23	80	13	64
130573	2021-02-24	80	13	64
130574	2021-02-25	80	13	64
130575	2021-02-26	64	14	64
130576	2021-02-27	80	13	64
130577	2021-02-28	80	13	64
130578	2021-02-01	64	14	65
130579	2021-02-02	63	14	65
130580	2021-02-03	80	13	65
130581	2021-02-04	80	13	65
130582	2021-02-05	63	14	65
130583	2021-02-06	80	13	65
130584	2021-02-07	80	13	65
130585	2021-02-08	64	14	65
130586	2021-02-09	84	14	65
130587	2021-02-10	80	13	65
130588	2021-02-11	80	13	65
130589	2021-02-12	63	14	65
130590	2021-02-13	63	14	65
130591	2021-02-14	64	14	65
130592	2021-02-15	80	13	65
130593	2021-02-16	80	13	65
130594	2021-02-17	84	14	65
130595	2021-02-18	80	13	65
130596	2021-02-19	80	13	65
130597	2021-02-20	80	13	65
130598	2021-02-21	64	14	65
130599	2021-02-22	80	13	65
130600	2021-02-23	80	13	65
130601	2021-02-24	80	13	65
130602	2021-02-25	84	14	65
130603	2021-02-26	80	13	65
130604	2021-02-27	80	13	65
130605	2021-02-28	84	14	65
130606	2021-02-01	80	13	51
130607	2021-02-02	80	13	51
130608	2021-02-03	64	14	51
130609	2021-02-04	63	14	51
130610	2021-02-05	80	13	51
130611	2021-02-06	80	13	51
130612	2021-02-07	63	14	51
130613	2021-02-08	80	13	51
130614	2021-02-09	80	13	51
130615	2021-02-10	64	14	51
130616	2021-02-11	84	14	51
130617	2021-02-12	84	14	51
130618	2021-02-13	63	14	51
130619	2021-02-14	84	14	51
130620	2021-02-15	63	14	51
130621	2021-02-16	64	14	51
130622	2021-02-17	80	13	51
130623	2021-02-18	80	13	51
130624	2021-02-19	84	14	51
130625	2021-02-20	80	13	51
130626	2021-02-21	80	13	51
130627	2021-02-22	80	13	51
130628	2021-02-23	80	13	51
130629	2021-02-24	64	14	51
130630	2021-02-25	80	13	51
130631	2021-02-26	80	13	51
130632	2021-02-27	80	13	51
130633	2021-02-28	80	13	51
130634	2021-02-01	64	14	57
130635	2021-02-02	84	14	57
130636	2021-02-03	80	13	57
130637	2021-02-04	80	13	57
130638	2021-02-05	80	13	57
130639	2021-02-06	84	14	57
130640	2021-02-07	64	14	57
130641	2021-02-08	80	13	57
130642	2021-02-09	80	13	57
130643	2021-02-10	80	13	57
130644	2021-02-11	80	13	57
130645	2021-02-12	63	14	57
130646	2021-02-13	64	14	57
130647	2021-02-14	63	14	57
130648	2021-02-15	84	14	57
130649	2021-02-16	63	14	57
130650	2021-02-17	80	13	57
130651	2021-02-18	80	13	57
130652	2021-02-19	80	13	57
130653	2021-02-20	64	14	57
130654	2021-02-21	80	13	57
130655	2021-02-22	80	13	57
130656	2021-02-23	63	14	57
130657	2021-02-24	80	13	57
130658	2021-02-25	80	13	57
130659	2021-02-26	80	13	57
130660	2021-02-27	80	13	57
130661	2021-02-28	84	14	57
130662	2021-02-01	80	13	71
130663	2021-02-02	80	13	71
130664	2021-02-03	64	14	71
130665	2021-02-04	80	13	71
130666	2021-02-05	80	13	71
130667	2021-02-06	63	14	71
130668	2021-02-07	63	14	71
130669	2021-02-08	80	13	71
130670	2021-02-09	80	13	71
130671	2021-02-10	64	14	71
130672	2021-02-11	63	14	71
130673	2021-02-12	84	14	71
130674	2021-02-13	84	14	71
130675	2021-02-14	63	14	71
130676	2021-02-15	80	13	71
130677	2021-02-16	80	13	71
130678	2021-02-17	64	14	71
130679	2021-02-18	80	13	71
130680	2021-02-19	80	13	71
130681	2021-02-20	80	13	71
130682	2021-02-21	80	13	71
130683	2021-02-22	80	13	71
130684	2021-02-23	64	14	71
130685	2021-02-24	84	14	71
130686	2021-02-25	84	14	71
130687	2021-02-26	80	13	71
130688	2021-02-27	80	13	71
130689	2021-02-28	80	13	71
130690	2021-02-01	80	13	78
130691	2021-02-02	80	13	78
130692	2021-02-03	80	13	78
130693	2021-02-04	64	14	78
130694	2021-02-05	84	14	78
130695	2021-02-06	80	13	78
130696	2021-02-07	80	13	78
130697	2021-02-08	84	14	78
130698	2021-02-09	63	14	78
130699	2021-02-10	64	14	78
130700	2021-02-11	80	13	78
130701	2021-02-12	63	14	78
130702	2021-02-13	84	14	78
130703	2021-02-14	63	14	78
130704	2021-02-15	80	13	78
130705	2021-02-16	80	13	78
130706	2021-02-17	80	13	78
130707	2021-02-18	64	14	78
130708	2021-02-19	80	13	78
130709	2021-02-20	80	13	78
130710	2021-02-21	80	13	78
130711	2021-02-22	63	14	78
130712	2021-02-23	80	13	78
130713	2021-02-24	80	13	78
130714	2021-02-25	80	13	78
130715	2021-02-26	64	14	78
130716	2021-02-27	84	14	78
130717	2021-02-28	80	13	78
130718	2021-02-01	64	14	79
130719	2021-02-02	84	14	79
130720	2021-02-03	80	13	79
130721	2021-02-04	80	13	79
130722	2021-02-05	80	13	79
130723	2021-02-06	63	14	79
130724	2021-02-07	64	14	79
130725	2021-02-08	80	13	79
130726	2021-02-09	80	13	79
130727	2021-02-10	80	13	79
130728	2021-02-11	84	14	79
130729	2021-02-12	63	14	79
130730	2021-02-13	64	14	79
130731	2021-02-14	84	14	79
130732	2021-02-15	80	13	79
130733	2021-02-16	80	13	79
130734	2021-02-17	80	13	79
130735	2021-02-18	80	13	79
130736	2021-02-19	80	13	79
130737	2021-02-20	80	13	79
130738	2021-02-21	64	14	79
130739	2021-02-22	84	14	79
130740	2021-02-23	80	13	79
130741	2021-02-24	80	13	79
130742	2021-02-25	80	13	79
130743	2021-02-26	80	13	79
130744	2021-02-27	63	14	79
130745	2021-02-28	63	14	79
130746	2021-02-01	64	14	56
130747	2021-02-02	84	14	56
130748	2021-02-03	81	13	56
130749	2021-02-04	81	13	56
130750	2021-02-05	81	13	56
130751	2021-02-06	63	14	56
130752	2021-02-07	64	14	56
130753	2021-02-08	81	13	56
130754	2021-02-09	81	13	56
130755	2021-02-10	84	14	56
130756	2021-02-11	63	14	56
130757	2021-02-12	63	14	56
130758	2021-02-13	64	14	56
130759	2021-02-14	63	14	56
130760	2021-02-15	81	13	56
130761	2021-02-16	81	13	56
130762	2021-02-17	81	13	56
130763	2021-02-18	81	13	56
130764	2021-02-19	81	13	56
130765	2021-02-20	81	13	56
130766	2021-02-21	64	14	56
130767	2021-02-22	81	13	56
130768	2021-02-23	81	13	56
130769	2021-02-24	81	13	56
130770	2021-02-25	84	14	56
130771	2021-02-26	81	13	56
130772	2021-02-27	81	13	56
130773	2021-02-28	84	14	56
130774	2021-02-01	81	13	62
130775	2021-02-02	81	13	62
130776	2021-02-03	81	13	62
130777	2021-02-04	64	14	62
130778	2021-02-05	84	14	62
130779	2021-02-06	81	13	62
130780	2021-02-07	81	13	62
130781	2021-02-08	63	14	62
130782	2021-02-09	63	14	62
130783	2021-02-10	81	13	62
130784	2021-02-11	81	13	62
130785	2021-02-12	64	14	62
130786	2021-02-13	84	14	62
130787	2021-02-14	63	14	62
130788	2021-02-15	63	14	62
130789	2021-02-16	81	13	62
130790	2021-02-17	81	13	62
130791	2021-02-18	64	14	62
130792	2021-02-19	81	13	62
130793	2021-02-20	81	13	62
130794	2021-02-21	81	13	62
130795	2021-02-22	81	13	62
130796	2021-02-23	84	14	62
130797	2021-02-24	64	14	62
130798	2021-02-25	81	13	62
130799	2021-02-26	81	13	62
130800	2021-02-27	84	14	62
130801	2021-02-28	81	13	62
130802	2021-02-01	64	14	63
130803	2021-02-02	63	14	63
130804	2021-02-03	84	14	63
130805	2021-02-04	84	14	63
130806	2021-02-05	81	13	63
130807	2021-02-06	81	13	63
130808	2021-02-07	81	13	63
130809	2021-02-08	81	13	63
130810	2021-02-09	81	13	63
130811	2021-02-10	64	14	63
130812	2021-02-11	63	14	63
130813	2021-02-12	63	14	63
130814	2021-02-13	84	14	63
130815	2021-02-14	63	14	63
130816	2021-02-15	81	13	63
130817	2021-02-16	81	13	63
130818	2021-02-17	81	13	63
130819	2021-02-18	81	13	63
130820	2021-02-19	81	13	63
130821	2021-02-20	81	13	63
130822	2021-02-21	64	14	63
130823	2021-02-22	84	14	63
130824	2021-02-23	81	13	63
130825	2021-02-24	81	13	63
130826	2021-02-25	64	14	63
130827	2021-02-26	81	13	63
130828	2021-02-27	81	13	63
130829	2021-02-28	81	13	63
130830	2021-02-01	64	14	67
130831	2021-02-02	63	14	67
130832	2021-02-03	84	14	67
130833	2021-02-04	81	13	67
130834	2021-02-05	81	13	67
130835	2021-02-06	84	14	67
130836	2021-02-07	81	13	67
130837	2021-02-08	81	13	67
130838	2021-02-09	81	13	67
130839	2021-02-10	81	13	67
130840	2021-02-11	81	13	67
130841	2021-02-12	64	14	67
130842	2021-02-13	63	14	67
130843	2021-02-14	84	14	67
130844	2021-02-15	63	14	67
130845	2021-02-16	63	14	67
130846	2021-02-17	81	13	67
130847	2021-02-18	81	13	67
130848	2021-02-19	81	13	67
130849	2021-02-20	64	14	67
130850	2021-02-21	81	13	67
130851	2021-02-22	81	13	67
130852	2021-02-23	84	14	67
130853	2021-02-24	81	13	67
130854	2021-02-25	81	13	67
130855	2021-02-26	81	13	67
130856	2021-02-27	64	14	67
130857	2021-02-28	81	13	67
130858	2021-02-01	81	13	73
130859	2021-02-02	81	13	73
130860	2021-02-03	64	14	73
130861	2021-02-04	81	13	73
130862	2021-02-05	81	13	73
130863	2021-02-06	81	13	73
130864	2021-02-07	84	14	73
130865	2021-02-08	63	14	73
130866	2021-02-09	64	14	73
130867	2021-02-10	84	14	73
130868	2021-02-11	84	14	73
130869	2021-02-12	63	14	73
130870	2021-02-13	84	14	73
130871	2021-02-14	63	14	73
130872	2021-02-15	81	13	73
130873	2021-02-16	81	13	73
130874	2021-02-17	81	13	73
130875	2021-02-18	81	13	73
130876	2021-02-19	64	14	73
130877	2021-02-20	81	13	73
130878	2021-02-21	81	13	73
130879	2021-02-22	81	13	73
130880	2021-02-23	63	14	73
130881	2021-02-24	81	13	73
130882	2021-02-25	81	13	73
130883	2021-02-26	81	13	73
130884	2021-02-27	81	13	73
130885	2021-02-28	64	14	73
130886	2021-02-01	81	13	66
130887	2021-02-02	81	13	66
130888	2021-02-03	81	13	66
130889	2021-02-04	64	14	66
130890	2021-02-05	84	14	66
130891	2021-02-06	84	14	66
130892	2021-02-07	84	14	66
130893	2021-02-08	63	14	66
130894	2021-02-09	81	13	66
130895	2021-02-10	81	13	66
130896	2021-02-11	81	13	66
130897	2021-02-12	64	14	66
130898	2021-02-13	63	14	66
130899	2021-02-14	84	14	66
130900	2021-02-15	81	13	66
130901	2021-02-16	81	13	66
130902	2021-02-17	81	13	66
130903	2021-02-18	81	13	66
130904	2021-02-19	81	13	66
130905	2021-02-20	64	14	66
130906	2021-02-21	81	13	66
130907	2021-02-22	81	13	66
130908	2021-02-23	81	13	66
130909	2021-02-24	63	14	66
130910	2021-02-25	63	14	66
130911	2021-02-26	81	13	66
130912	2021-02-27	81	13	66
130913	2021-02-28	64	14	66
130914	2021-02-01	81	13	55
130915	2021-02-02	81	13	55
130916	2021-02-03	81	13	55
130917	2021-02-04	64	14	55
130918	2021-02-05	84	14	55
130919	2021-02-06	81	13	55
130920	2021-02-07	81	13	55
130921	2021-02-08	81	13	55
130922	2021-02-09	84	14	55
130923	2021-02-10	64	14	55
130924	2021-02-11	81	13	55
130925	2021-02-12	63	14	55
130926	2021-02-13	84	14	55
130927	2021-02-14	63	14	55
130928	2021-02-15	81	13	55
130929	2021-02-16	81	13	55
130930	2021-02-17	64	14	55
130931	2021-02-18	63	14	55
130932	2021-02-19	84	14	55
130933	2021-02-20	81	13	55
130934	2021-02-21	81	13	55
130935	2021-02-22	63	14	55
130936	2021-02-23	81	13	55
130937	2021-02-24	81	13	55
130938	2021-02-25	81	13	55
130939	2021-02-26	64	14	55
130940	2021-02-27	81	13	55
130941	2021-02-28	81	13	55
130942	2021-02-01	64	14	45
130943	2021-02-02	83	13	45
130944	2021-02-03	83	13	45
130945	2021-02-04	83	13	45
130946	2021-02-05	84	14	45
130947	2021-02-06	63	14	45
130948	2021-02-07	83	13	45
130949	2021-02-08	83	13	45
130950	2021-02-09	64	14	45
130951	2021-02-10	84	14	45
130952	2021-02-11	83	13	45
130953	2021-02-12	63	14	45
130954	2021-02-13	63	14	45
130955	2021-02-14	84	14	45
130956	2021-02-15	83	13	45
130957	2021-02-16	83	13	45
130958	2021-02-17	64	14	45
130959	2021-02-18	83	13	45
130960	2021-02-19	83	13	45
130961	2021-02-20	83	13	45
130962	2021-02-21	83	13	45
130963	2021-02-22	84	14	45
130964	2021-02-23	64	14	45
130965	2021-02-24	83	13	45
130966	2021-02-25	83	13	45
130967	2021-02-26	63	14	45
130968	2021-02-27	83	13	45
130969	2021-02-28	83	13	45
130970	2021-02-01	83	13	68
130971	2021-02-02	83	13	68
130972	2021-02-03	64	14	68
130973	2021-02-04	83	13	68
130974	2021-02-05	83	13	68
130975	2021-02-06	83	13	68
130976	2021-02-07	63	14	68
130977	2021-02-08	84	14	68
130978	2021-02-09	83	13	68
130979	2021-02-10	83	13	68
130980	2021-02-11	64	14	68
130981	2021-02-12	63	14	68
130982	2021-02-13	84	14	68
130983	2021-02-14	84	14	68
130984	2021-02-15	63	14	68
130985	2021-02-16	83	13	68
130986	2021-02-17	83	13	68
130987	2021-02-18	64	14	68
130988	2021-02-19	83	13	68
130989	2021-02-20	83	13	68
130990	2021-02-21	84	14	68
130991	2021-02-22	83	13	68
130992	2021-02-23	83	13	68
130993	2021-02-24	83	13	68
130994	2021-02-25	83	13	68
130995	2021-02-26	83	13	68
130996	2021-02-27	64	14	68
130997	2021-02-28	63	14	68
130998	2021-02-01	64	14	53
130999	2021-02-02	63	14	53
131000	2021-02-03	83	13	53
131001	2021-02-04	83	13	53
131002	2021-02-05	63	14	53
131003	2021-02-06	84	14	53
131004	2021-02-07	83	13	53
131005	2021-02-08	83	13	53
131006	2021-02-09	64	14	53
131007	2021-02-10	63	14	53
131008	2021-02-11	84	14	53
131009	2021-02-12	84	14	53
131010	2021-02-13	63	14	53
131011	2021-02-14	84	14	53
131012	2021-02-15	83	13	53
131013	2021-02-16	83	13	53
131014	2021-02-17	83	13	53
131015	2021-02-18	83	13	53
131016	2021-02-19	83	13	53
131017	2021-02-20	83	13	53
131018	2021-02-21	64	14	53
131019	2021-02-22	83	13	53
131020	2021-02-23	83	13	53
131021	2021-02-24	83	13	53
131022	2021-02-25	83	13	53
131023	2021-02-26	64	14	53
131024	2021-02-27	83	13	53
131025	2021-02-28	83	13	53
131026	2021-02-01	83	13	54
131027	2021-02-02	83	13	54
131028	2021-02-03	64	14	54
131029	2021-02-04	84	14	54
131030	2021-02-05	84	14	54
131031	2021-02-06	83	13	54
131032	2021-02-07	83	13	54
131033	2021-02-08	63	14	54
131034	2021-02-09	64	14	54
131035	2021-02-10	83	13	54
131036	2021-02-11	83	13	54
131037	2021-02-12	84	14	54
131038	2021-02-13	63	14	54
131039	2021-02-14	63	14	54
131040	2021-02-15	83	13	54
131041	2021-02-16	83	13	54
131042	2021-02-17	83	13	54
131043	2021-02-18	83	13	54
131044	2021-02-19	64	14	54
131045	2021-02-20	63	14	54
131046	2021-02-21	83	13	54
131047	2021-02-22	83	13	54
131048	2021-02-23	84	14	54
131049	2021-02-24	83	13	54
131050	2021-02-25	83	13	54
131051	2021-02-26	83	13	54
131052	2021-02-27	64	14	54
131053	2021-02-28	83	13	54
131054	2021-02-01	64	14	49
131055	2021-02-02	84	14	49
131056	2021-02-03	83	13	49
131057	2021-02-04	83	13	49
131058	2021-02-05	83	13	49
131059	2021-02-06	63	14	49
131060	2021-02-07	64	14	49
131061	2021-02-08	84	14	49
131062	2021-02-09	83	13	49
131063	2021-02-10	83	13	49
131064	2021-02-11	83	13	49
131065	2021-02-12	63	14	49
131066	2021-02-13	64	14	49
131067	2021-02-14	63	14	49
131068	2021-02-15	83	13	49
131069	2021-02-16	83	13	49
131070	2021-02-17	83	13	49
131071	2021-02-18	63	14	49
131072	2021-02-19	83	13	49
131073	2021-02-20	83	13	49
131074	2021-02-21	83	13	49
131075	2021-02-22	64	14	49
131076	2021-02-23	83	13	49
131077	2021-02-24	83	13	49
131078	2021-02-25	84	14	49
131079	2021-02-26	83	13	49
131080	2021-02-27	83	13	49
131081	2021-02-28	84	14	49
131082	2021-02-01	83	13	50
131083	2021-02-02	83	13	50
131084	2021-02-03	64	14	50
131085	2021-02-04	84	14	50
131086	2021-02-05	83	13	50
131087	2021-02-06	83	13	50
131088	2021-02-07	63	14	50
131089	2021-02-08	83	13	50
131090	2021-02-09	83	13	50
131091	2021-02-10	64	14	50
131092	2021-02-11	63	14	50
131093	2021-02-12	84	14	50
131094	2021-02-13	63	14	50
131095	2021-02-14	84	14	50
131096	2021-02-15	84	14	50
131097	2021-02-16	64	14	50
131098	2021-02-17	63	14	50
131099	2021-02-18	83	13	50
131100	2021-02-19	83	13	50
131101	2021-02-20	83	13	50
131102	2021-02-21	83	13	50
131103	2021-02-22	83	13	50
131104	2021-02-23	83	13	50
131105	2021-02-24	64	14	50
131106	2021-02-25	83	13	50
131107	2021-02-26	83	13	50
131108	2021-02-27	83	13	50
131109	2021-02-28	83	13	50
131110	2021-02-01	82	16	43
131111	2021-02-02	82	16	43
131112	2021-02-03	82	16	43
131113	2021-02-04	82	16	43
131114	2021-02-05	82	16	43
131115	2021-02-06	63	14	43
131116	2021-02-07	64	14	43
131117	2021-02-08	82	16	43
131118	2021-02-09	82	16	43
131119	2021-02-10	82	16	43
131120	2021-02-11	84	14	43
131121	2021-02-12	84	14	43
131122	2021-02-13	63	14	43
131123	2021-02-14	64	14	43
131124	2021-02-15	84	14	43
131125	2021-02-16	84	14	43
131126	2021-02-17	82	16	43
131127	2021-02-18	82	16	43
131128	2021-02-19	82	16	43
131129	2021-02-20	63	14	43
131130	2021-02-21	64	14	43
131131	2021-02-22	82	16	43
131132	2021-02-23	82	16	43
131133	2021-02-24	82	16	43
131134	2021-02-25	82	16	43
131135	2021-02-26	82	16	43
131136	2021-02-27	63	14	43
131137	2021-02-28	64	14	43
131138	2021-02-01	82	16	44
131139	2021-02-02	82	16	44
131140	2021-02-03	82	16	44
131141	2021-02-04	82	16	44
131142	2021-02-05	82	16	44
131143	2021-02-06	63	14	44
131144	2021-02-07	64	14	44
131145	2021-02-08	82	16	44
131146	2021-02-09	82	16	44
131147	2021-02-10	82	16	44
131148	2021-02-11	84	14	44
131149	2021-02-12	84	14	44
131150	2021-02-13	63	14	44
131151	2021-02-14	64	14	44
131152	2021-02-15	84	14	44
131153	2021-02-16	84	14	44
131154	2021-02-17	82	16	44
131155	2021-02-18	82	16	44
131156	2021-02-19	82	16	44
131157	2021-02-20	63	14	44
131158	2021-02-21	64	14	44
131159	2021-02-22	82	16	44
131160	2021-02-23	82	16	44
131161	2021-02-24	82	16	44
131162	2021-02-25	82	16	44
131163	2021-02-26	82	16	44
131164	2021-02-27	63	14	44
131165	2021-02-28	64	14	44
131166	2020-06-01	80	13	47
131167	2020-06-02	80	13	47
131168	2020-06-03	64	14	47
131169	2020-06-04	80	13	47
131170	2020-06-05	80	13	47
131171	2020-06-06	63	14	47
131172	2020-06-07	80	13	47
131173	2020-06-08	80	13	47
131174	2020-06-09	80	13	47
131175	2020-06-10	64	14	47
131176	2020-06-11	80	13	47
131177	2020-06-12	80	13	47
131178	2020-06-13	80	13	47
131179	2020-06-14	80	13	47
131180	2020-06-15	63	14	47
131181	2020-06-16	80	13	47
131182	2020-06-17	80	13	47
131183	2020-06-18	80	13	47
131184	2020-06-19	80	13	47
131185	2020-06-20	64	14	47
131186	2020-06-21	80	13	47
131187	2020-06-22	80	13	47
131188	2020-06-23	80	13	47
131189	2020-06-24	63	14	47
131190	2020-06-25	80	13	47
131191	2020-06-26	80	13	47
131192	2020-06-27	80	13	47
131193	2020-06-28	64	14	47
131194	2020-06-29	63	14	47
131195	2020-06-30	80	13	47
131196	2020-06-01	64	14	69
131197	2020-06-02	63	14	69
131198	2020-06-03	80	13	69
131199	2020-06-04	80	13	69
131200	2020-06-05	80	13	69
131201	2020-06-06	80	13	69
131202	2020-06-07	80	13	69
131203	2020-06-08	64	14	69
131204	2020-06-09	80	13	69
131205	2020-06-10	80	13	69
131206	2020-06-11	63	14	69
131207	2020-06-12	80	13	69
131208	2020-06-13	80	13	69
131209	2020-06-14	80	13	69
131210	2020-06-15	80	13	69
131211	2020-06-16	80	13	69
131212	2020-06-17	80	13	69
131213	2020-06-18	64	14	69
131214	2020-06-19	63	14	69
131215	2020-06-20	80	13	69
131216	2020-06-21	80	13	69
131217	2020-06-22	80	13	69
131218	2020-06-23	80	13	69
131219	2020-06-24	80	13	69
131220	2020-06-25	64	14	69
131221	2020-06-26	80	13	69
131222	2020-06-27	80	13	69
131223	2020-06-28	80	13	69
131224	2020-06-29	80	13	69
131225	2020-06-30	63	14	69
131226	2020-06-01	80	13	46
131227	2020-06-02	80	13	46
131228	2020-06-03	80	13	46
131229	2020-06-04	64	14	46
131230	2020-06-05	63	14	46
131231	2020-06-06	80	13	46
131232	2020-06-07	80	13	46
131233	2020-06-08	80	13	46
131234	2020-06-09	63	14	46
131235	2020-06-10	80	13	46
131236	2020-06-11	80	13	46
131237	2020-06-12	64	14	46
131238	2020-06-13	63	14	46
131239	2020-06-14	80	13	46
131240	2020-06-15	80	13	46
131241	2020-06-16	63	14	46
131242	2020-06-17	80	13	46
131243	2020-06-18	80	13	46
131244	2020-06-19	80	13	46
131245	2020-06-20	80	13	46
131246	2020-06-21	80	13	46
131247	2020-06-22	80	13	46
131248	2020-06-23	64	14	46
131249	2020-06-24	80	13	46
131250	2020-06-25	80	13	46
131251	2020-06-26	80	13	46
131252	2020-06-27	80	13	46
131253	2020-06-28	80	13	46
131254	2020-06-29	64	14	46
131255	2020-06-30	80	13	46
131256	2020-06-01	80	13	60
131257	2020-06-02	80	13	60
131258	2020-06-03	80	13	60
131259	2020-06-04	80	13	60
131260	2020-06-05	80	13	60
131261	2020-06-06	80	13	60
131262	2020-06-07	64	14	60
131263	2020-06-08	63	14	60
131264	2020-06-09	80	13	60
131265	2020-06-10	80	13	60
131266	2020-06-11	80	13	60
131267	2020-06-12	80	13	60
131268	2020-06-13	80	13	60
131269	2020-06-14	64	14	60
131270	2020-06-15	80	13	60
131271	2020-06-16	80	13	60
131272	2020-06-17	63	14	60
131273	2020-06-18	80	13	60
131274	2020-06-19	80	13	60
131275	2020-06-20	80	13	60
131276	2020-06-21	64	14	60
131277	2020-06-22	63	14	60
131278	2020-06-23	80	13	60
131279	2020-06-24	80	13	60
131280	2020-06-25	80	13	60
131281	2020-06-26	63	14	60
131282	2020-06-27	64	14	60
131283	2020-06-28	80	13	60
131284	2020-06-29	80	13	60
131285	2020-06-30	80	13	60
131286	2020-06-01	64	14	64
131287	2020-06-02	63	14	64
131288	2020-06-03	80	13	64
131289	2020-06-04	80	13	64
131290	2020-06-05	80	13	64
131291	2020-06-06	80	13	64
131292	2020-06-07	80	13	64
131293	2020-06-08	80	13	64
131294	2020-06-09	64	14	64
131295	2020-06-10	80	13	64
131296	2020-06-11	80	13	64
131297	2020-06-12	63	14	64
131298	2020-06-13	80	13	64
131299	2020-06-14	80	13	64
131300	2020-06-15	64	14	64
131301	2020-06-16	80	13	64
131302	2020-06-17	80	13	64
131303	2020-06-18	80	13	64
131304	2020-06-19	63	14	64
131305	2020-06-20	80	13	64
131306	2020-06-21	80	13	64
131307	2020-06-22	64	14	64
131308	2020-06-23	80	13	64
131309	2020-06-24	80	13	64
131310	2020-06-25	80	13	64
131311	2020-06-26	80	13	64
131312	2020-06-27	80	13	64
131313	2020-06-28	63	14	64
131314	2020-06-29	80	13	64
131315	2020-06-30	80	13	64
131316	2020-06-01	80	13	65
131317	2020-06-02	80	13	65
131318	2020-06-03	80	13	65
131319	2020-06-04	64	14	65
131320	2020-06-05	80	13	65
131321	2020-06-06	80	13	65
131322	2020-06-07	63	14	65
131323	2020-06-08	80	13	65
131324	2020-06-09	80	13	65
131325	2020-06-10	64	14	65
131326	2020-06-11	80	13	65
131327	2020-06-12	80	13	65
131328	2020-06-13	80	13	65
131329	2020-06-14	80	13	65
131330	2020-06-15	80	13	65
131331	2020-06-16	80	13	65
131332	2020-06-17	64	14	65
131333	2020-06-18	63	14	65
131334	2020-06-19	80	13	65
131335	2020-06-20	80	13	65
131336	2020-06-21	63	14	65
131337	2020-06-22	80	13	65
131338	2020-06-23	80	13	65
131339	2020-06-24	80	13	65
131340	2020-06-25	80	13	65
131341	2020-06-26	64	14	65
131342	2020-06-27	80	13	65
131343	2020-06-28	80	13	65
131344	2020-06-29	80	13	65
131345	2020-06-30	63	14	65
131346	2020-06-01	80	13	51
131347	2020-06-02	80	13	51
131348	2020-06-03	64	14	51
131349	2020-06-04	80	13	51
131350	2020-06-05	80	13	51
131351	2020-06-06	80	13	51
131352	2020-06-07	80	13	51
131353	2020-06-08	63	14	51
131354	2020-06-09	80	13	51
131355	2020-06-10	80	13	51
131356	2020-06-11	64	14	51
131357	2020-06-12	63	14	51
131358	2020-06-13	80	13	51
131359	2020-06-14	80	13	51
131360	2020-06-15	63	14	51
131361	2020-06-16	63	14	51
131362	2020-06-17	80	13	51
131363	2020-06-18	80	13	51
131364	2020-06-19	80	13	51
131365	2020-06-20	80	13	51
131366	2020-06-21	80	13	51
131367	2020-06-22	80	13	51
131368	2020-06-23	64	14	51
131369	2020-06-24	80	13	51
131370	2020-06-25	80	13	51
131371	2020-06-26	80	13	51
131372	2020-06-27	64	14	51
131373	2020-06-28	80	13	51
131374	2020-06-29	80	13	51
131375	2020-06-30	80	13	51
131376	2020-06-01	80	13	57
131377	2020-06-02	80	13	57
131378	2020-06-03	80	13	57
131379	2020-06-04	64	14	57
131380	2020-06-05	63	14	57
131381	2020-06-06	80	13	57
131382	2020-06-07	80	13	57
131383	2020-06-08	80	13	57
131384	2020-06-09	80	13	57
131385	2020-06-10	64	14	57
131386	2020-06-11	80	13	57
131387	2020-06-12	80	13	57
131388	2020-06-13	63	14	57
131389	2020-06-14	80	13	57
131390	2020-06-15	80	13	57
131391	2020-06-16	80	13	57
131392	2020-06-17	64	14	57
131393	2020-06-18	80	13	57
131394	2020-06-19	80	13	57
131395	2020-06-20	80	13	57
131396	2020-06-21	80	13	57
131397	2020-06-22	80	13	57
131398	2020-06-23	64	14	57
131399	2020-06-24	63	14	57
131400	2020-06-25	80	13	57
131401	2020-06-26	80	13	57
131402	2020-06-27	80	13	57
131403	2020-06-28	80	13	57
131404	2020-06-29	80	13	57
131405	2020-06-30	63	14	57
131406	2020-06-01	80	13	71
131407	2020-06-02	80	13	71
131408	2020-06-03	64	14	71
131409	2020-06-04	80	13	71
131410	2020-06-05	80	13	71
131411	2020-06-06	63	14	71
131412	2020-06-07	63	14	71
131413	2020-06-08	80	13	71
131414	2020-06-09	80	13	71
131415	2020-06-10	80	13	71
131416	2020-06-11	80	13	71
131417	2020-06-12	80	13	71
131418	2020-06-13	80	13	71
131419	2020-06-14	64	14	71
131420	2020-06-15	80	13	71
131421	2020-06-16	80	13	71
131422	2020-06-17	80	13	71
131423	2020-06-18	63	14	71
131424	2020-06-19	63	14	71
131425	2020-06-20	80	13	71
131426	2020-06-21	80	13	71
131427	2020-06-22	80	13	71
131428	2020-06-23	80	13	71
131429	2020-06-24	64	14	71
131430	2020-06-25	64	14	71
131431	2020-06-26	80	13	71
131432	2020-06-27	80	13	71
131433	2020-06-28	80	13	71
131434	2020-06-29	80	13	71
131435	2020-06-30	80	13	71
131436	2020-06-01	64	14	78
131437	2020-06-02	63	14	78
131438	2020-06-03	80	13	78
131439	2020-06-04	80	13	78
131440	2020-06-05	80	13	78
131441	2020-06-06	80	13	78
131442	2020-06-07	80	13	78
131443	2020-06-08	80	13	78
131444	2020-06-09	64	14	78
131445	2020-06-10	80	13	78
131446	2020-06-11	80	13	78
131447	2020-06-12	80	13	78
131448	2020-06-13	80	13	78
131449	2020-06-14	80	13	78
131450	2020-06-15	80	13	78
131451	2020-06-16	64	14	78
131452	2020-06-17	80	13	78
131453	2020-06-18	80	13	78
131454	2020-06-19	80	13	78
131455	2020-06-20	80	13	78
131456	2020-06-21	80	13	78
131457	2020-06-22	64	14	78
131458	2020-06-23	80	13	78
131459	2020-06-24	80	13	78
131460	2020-06-25	63	14	78
131461	2020-06-26	63	14	78
131462	2020-06-27	80	13	78
131463	2020-06-28	80	13	78
131464	2020-06-29	63	14	78
131465	2020-06-30	80	13	78
131466	2020-06-01	80	13	79
131467	2020-06-02	80	13	79
131468	2020-06-03	80	13	79
131469	2020-06-04	80	13	79
131470	2020-06-05	64	14	79
131471	2020-06-06	80	13	79
131472	2020-06-07	80	13	79
131473	2020-06-08	63	14	79
131474	2020-06-09	80	13	79
131475	2020-06-10	80	13	79
131476	2020-06-11	64	14	79
131477	2020-06-12	80	13	79
131478	2020-06-13	80	13	79
131479	2020-06-14	63	14	79
131480	2020-06-15	80	13	79
131481	2020-06-16	80	13	79
131482	2020-06-17	64	14	79
131483	2020-06-18	80	13	79
131484	2020-06-19	80	13	79
131485	2020-06-20	63	14	79
131486	2020-06-21	80	13	79
131487	2020-06-22	80	13	79
131488	2020-06-23	80	13	79
131489	2020-06-24	80	13	79
131490	2020-06-25	64	14	79
131491	2020-06-26	80	13	79
131492	2020-06-27	80	13	79
131493	2020-06-28	80	13	79
131494	2020-06-29	63	14	79
131495	2020-06-30	80	13	79
131496	2020-06-01	64	14	56
131497	2020-06-02	63	14	56
131498	2020-06-03	63	14	56
131499	2020-06-04	81	13	56
131500	2020-06-05	81	13	56
131501	2020-06-06	81	13	56
131502	2020-06-07	81	13	56
131503	2020-06-08	64	14	56
131504	2020-06-09	81	13	56
131505	2020-06-10	81	13	56
131506	2020-06-11	81	13	56
131507	2020-06-12	81	13	56
131508	2020-06-13	63	14	56
131509	2020-06-14	81	13	56
131510	2020-06-15	81	13	56
131511	2020-06-16	64	14	56
131512	2020-06-17	81	13	56
131513	2020-06-18	81	13	56
131514	2020-06-19	81	13	56
131515	2020-06-20	81	13	56
131516	2020-06-21	81	13	56
131517	2020-06-22	81	13	56
131518	2020-06-23	64	14	56
131519	2020-06-24	81	13	56
131520	2020-06-25	81	13	56
131521	2020-06-26	81	13	56
131522	2020-06-27	81	13	56
131523	2020-06-28	81	13	56
131524	2020-06-29	81	13	56
131525	2020-06-30	63	14	56
131526	2020-06-01	81	13	62
131527	2020-06-02	81	13	62
131528	2020-06-03	81	13	62
131529	2020-06-04	81	13	62
131530	2020-06-05	81	13	62
131531	2020-06-06	64	14	62
131532	2020-06-07	81	13	62
131533	2020-06-08	81	13	62
131534	2020-06-09	81	13	62
131535	2020-06-10	63	14	62
131536	2020-06-11	81	13	62
131537	2020-06-12	81	13	62
131538	2020-06-13	81	13	62
131539	2020-06-14	64	14	62
131540	2020-06-15	63	14	62
131541	2020-06-16	81	13	62
131542	2020-06-17	81	13	62
131543	2020-06-18	63	14	62
131544	2020-06-19	81	13	62
131545	2020-06-20	81	13	62
131546	2020-06-21	64	14	62
131547	2020-06-22	63	14	62
131548	2020-06-23	81	13	62
131549	2020-06-24	81	13	62
131550	2020-06-25	81	13	62
131551	2020-06-26	64	14	62
131552	2020-06-27	81	13	62
131553	2020-06-28	81	13	62
131554	2020-06-29	81	13	62
131555	2020-06-30	81	13	62
131556	2020-06-01	81	13	63
131557	2020-06-02	81	13	63
131558	2020-06-03	81	13	63
131559	2020-06-04	81	13	63
131560	2020-06-05	64	14	63
131561	2020-06-06	81	13	63
131562	2020-06-07	81	13	63
131563	2020-06-08	63	14	63
131564	2020-06-09	63	14	63
131565	2020-06-10	81	13	63
131566	2020-06-11	81	13	63
131567	2020-06-12	81	13	63
131568	2020-06-13	81	13	63
131569	2020-06-14	81	13	63
131570	2020-06-15	81	13	63
131571	2020-06-16	64	14	63
131572	2020-06-17	81	13	63
131573	2020-06-18	81	13	63
131574	2020-06-19	81	13	63
131575	2020-06-20	63	14	63
131576	2020-06-21	81	13	63
131577	2020-06-22	81	13	63
131578	2020-06-23	64	14	63
131579	2020-06-24	81	13	63
131580	2020-06-25	81	13	63
131581	2020-06-26	63	14	63
131582	2020-06-27	81	13	63
131583	2020-06-28	81	13	63
131584	2020-06-29	64	14	63
131585	2020-06-30	81	13	63
131586	2020-06-01	64	14	67
131587	2020-06-02	63	14	67
131588	2020-06-03	81	13	67
131589	2020-06-04	81	13	67
131590	2020-06-05	81	13	67
131591	2020-06-06	81	13	67
131592	2020-06-07	81	13	67
131593	2020-06-08	81	13	67
131594	2020-06-09	64	14	67
131595	2020-06-10	81	13	67
131596	2020-06-11	81	13	67
131597	2020-06-12	63	14	67
131598	2020-06-13	81	13	67
131599	2020-06-14	81	13	67
131600	2020-06-15	81	13	67
131601	2020-06-16	81	13	67
131602	2020-06-17	64	14	67
131603	2020-06-18	63	14	67
131604	2020-06-19	81	13	67
131605	2020-06-20	81	13	67
131606	2020-06-21	81	13	67
131607	2020-06-22	81	13	67
131608	2020-06-23	81	13	67
131609	2020-06-24	64	14	67
131610	2020-06-25	81	13	67
131611	2020-06-26	81	13	67
131612	2020-06-27	81	13	67
131613	2020-06-28	81	13	67
131614	2020-06-29	81	13	67
131615	2020-06-30	63	14	67
131616	2020-06-01	81	13	73
131617	2020-06-02	81	13	73
131618	2020-06-03	64	14	73
131619	2020-06-04	63	14	73
131620	2020-06-05	63	14	73
131621	2020-06-06	81	13	73
131622	2020-06-07	81	13	73
131623	2020-06-08	81	13	73
131624	2020-06-09	81	13	73
131625	2020-06-10	81	13	73
131626	2020-06-11	81	13	73
131627	2020-06-12	64	14	73
131628	2020-06-13	81	13	73
131629	2020-06-14	81	13	73
131630	2020-06-15	81	13	73
131631	2020-06-16	81	13	73
131632	2020-06-17	63	14	73
131633	2020-06-18	81	13	73
131634	2020-06-19	81	13	73
131635	2020-06-20	81	13	73
131636	2020-06-21	81	13	73
131637	2020-06-22	64	14	73
131638	2020-06-23	81	13	73
131639	2020-06-24	81	13	73
131640	2020-06-25	63	14	73
131641	2020-06-26	81	13	73
131642	2020-06-27	81	13	73
131643	2020-06-28	81	13	73
131644	2020-06-29	64	14	73
131645	2020-06-30	81	13	73
131646	2020-06-01	64	14	66
131647	2020-06-02	81	13	66
131648	2020-06-03	81	13	66
131649	2020-06-04	63	14	66
131650	2020-06-05	81	13	66
131651	2020-06-06	81	13	66
131652	2020-06-07	81	13	66
131653	2020-06-08	81	13	66
131654	2020-06-09	81	13	66
131655	2020-06-10	64	14	66
131656	2020-06-11	63	14	66
131657	2020-06-12	81	13	66
131658	2020-06-13	81	13	66
131659	2020-06-14	81	13	66
131660	2020-06-15	81	13	66
131661	2020-06-16	64	14	66
131662	2020-06-17	81	13	66
131663	2020-06-18	81	13	66
131664	2020-06-19	63	14	66
131665	2020-06-20	81	13	66
131666	2020-06-21	81	13	66
131667	2020-06-22	81	13	66
131668	2020-06-23	81	13	66
131669	2020-06-24	64	14	66
131670	2020-06-25	81	13	66
131671	2020-06-26	81	13	66
131672	2020-06-27	63	14	66
131673	2020-06-28	81	13	66
131674	2020-06-29	81	13	66
131675	2020-06-30	81	13	66
131676	2020-06-01	81	13	55
131677	2020-06-02	81	13	55
131678	2020-06-03	64	14	55
131679	2020-06-04	81	13	55
131680	2020-06-05	81	13	55
131681	2020-06-06	81	13	55
131682	2020-06-07	63	14	55
131683	2020-06-08	81	13	55
131684	2020-06-09	81	13	55
131685	2020-06-10	64	14	55
131686	2020-06-11	63	14	55
131687	2020-06-12	81	13	55
131688	2020-06-13	81	13	55
131689	2020-06-14	81	13	55
131690	2020-06-15	63	14	55
131691	2020-06-16	81	13	55
131692	2020-06-17	81	13	55
131693	2020-06-18	81	13	55
131694	2020-06-19	64	14	55
131695	2020-06-20	81	13	55
131696	2020-06-21	81	13	55
131697	2020-06-22	81	13	55
131698	2020-06-23	81	13	55
131699	2020-06-24	81	13	55
131700	2020-06-25	64	14	55
131701	2020-06-26	81	13	55
131702	2020-06-27	81	13	55
131703	2020-06-28	63	14	55
131704	2020-06-29	81	13	55
131705	2020-06-30	81	13	55
131706	2020-06-01	83	13	45
131707	2020-06-02	83	13	45
131708	2020-06-03	64	14	45
131709	2020-06-04	83	13	45
131710	2020-06-05	83	13	45
131711	2020-06-06	63	14	45
131712	2020-06-07	83	13	45
131713	2020-06-08	83	13	45
131714	2020-06-09	83	13	45
131715	2020-06-10	64	14	45
131716	2020-06-11	83	13	45
131717	2020-06-12	83	13	45
131718	2020-06-13	83	13	45
131719	2020-06-14	63	14	45
131720	2020-06-15	63	14	45
131721	2020-06-16	83	13	45
131722	2020-06-17	83	13	45
131723	2020-06-18	83	13	45
131724	2020-06-19	83	13	45
131725	2020-06-20	64	14	45
131726	2020-06-21	83	13	45
131727	2020-06-22	83	13	45
131728	2020-06-23	83	13	45
131729	2020-06-24	63	14	45
131730	2020-06-25	83	13	45
131731	2020-06-26	83	13	45
131732	2020-06-27	64	14	45
131733	2020-06-28	83	13	45
131734	2020-06-29	83	13	45
131735	2020-06-30	83	13	45
131736	2020-06-01	83	13	68
131737	2020-06-02	83	13	68
131738	2020-06-03	83	13	68
131739	2020-06-04	83	13	68
131740	2020-06-05	83	13	68
131741	2020-06-06	83	13	68
131742	2020-06-07	64	14	68
131743	2020-06-08	63	14	68
131744	2020-06-09	83	13	68
131745	2020-06-10	83	13	68
131746	2020-06-11	83	13	68
131747	2020-06-12	83	13	68
131748	2020-06-13	64	14	68
131749	2020-06-14	83	13	68
131750	2020-06-15	83	13	68
131751	2020-06-16	83	13	68
131752	2020-06-17	83	13	68
131753	2020-06-18	63	14	68
131754	2020-06-19	83	13	68
131755	2020-06-20	83	13	68
131756	2020-06-21	83	13	68
131757	2020-06-22	64	14	68
131758	2020-06-23	83	13	68
131759	2020-06-24	83	13	68
131760	2020-06-25	63	14	68
131761	2020-06-26	83	13	68
131762	2020-06-27	83	13	68
131763	2020-06-28	64	14	68
131764	2020-06-29	63	14	68
131765	2020-06-30	83	13	68
131766	2020-06-01	64	14	53
131767	2020-06-02	63	14	53
131768	2020-06-03	83	13	53
131769	2020-06-04	83	13	53
131770	2020-06-05	83	13	53
131771	2020-06-06	83	13	53
131772	2020-06-07	83	13	53
131773	2020-06-08	64	14	53
131774	2020-06-09	83	13	53
131775	2020-06-10	83	13	53
131776	2020-06-11	63	14	53
131777	2020-06-12	83	13	53
131778	2020-06-13	83	13	53
131779	2020-06-14	83	13	53
131780	2020-06-15	83	13	53
131781	2020-06-16	83	13	53
131782	2020-06-17	83	13	53
131783	2020-06-18	64	14	53
131784	2020-06-19	83	13	53
131785	2020-06-20	83	13	53
131786	2020-06-21	63	14	53
131787	2020-06-22	83	13	53
131788	2020-06-23	83	13	53
131789	2020-06-24	83	13	53
131790	2020-06-25	83	13	53
131791	2020-06-26	64	14	53
131792	2020-06-27	83	13	53
131793	2020-06-28	83	13	53
131794	2020-06-29	83	13	53
131795	2020-06-30	63	14	53
131796	2020-06-01	64	14	54
131797	2020-06-02	63	14	54
131798	2020-06-03	83	13	54
131799	2020-06-04	83	13	54
131800	2020-06-05	63	14	54
131801	2020-06-06	83	13	54
131802	2020-06-07	83	13	54
131803	2020-06-08	83	13	54
131804	2020-06-09	83	13	54
131805	2020-06-10	64	14	54
131806	2020-06-11	83	13	54
131807	2020-06-12	83	13	54
131808	2020-06-13	83	13	54
131809	2020-06-14	83	13	54
131810	2020-06-15	83	13	54
131811	2020-06-16	83	13	54
131812	2020-06-17	64	14	54
131813	2020-06-18	83	13	54
131814	2020-06-19	83	13	54
131815	2020-06-20	83	13	54
131816	2020-06-21	83	13	54
131817	2020-06-22	83	13	54
131818	2020-06-23	64	14	54
131819	2020-06-24	83	13	54
131820	2020-06-25	83	13	54
131821	2020-06-26	63	14	54
131822	2020-06-27	83	13	54
131823	2020-06-28	83	13	54
131824	2020-06-29	83	13	54
131825	2020-06-30	63	14	54
131826	2020-06-01	83	13	49
131827	2020-06-02	83	13	49
131828	2020-06-03	83	13	49
131829	2020-06-04	64	14	49
131830	2020-06-05	63	14	49
131831	2020-06-06	83	13	49
131832	2020-06-07	83	13	49
131833	2020-06-08	83	13	49
131834	2020-06-09	83	13	49
131835	2020-06-10	83	13	49
131836	2020-06-11	83	13	49
131837	2020-06-12	64	14	49
131838	2020-06-13	83	13	49
131839	2020-06-14	83	13	49
131840	2020-06-15	83	13	49
131841	2020-06-16	63	14	49
131842	2020-06-17	83	13	49
131843	2020-06-18	83	13	49
131844	2020-06-19	64	14	49
131845	2020-06-20	83	13	49
131846	2020-06-21	83	13	49
131847	2020-06-22	63	14	49
131848	2020-06-23	83	13	49
131849	2020-06-24	83	13	49
131850	2020-06-25	64	14	49
131851	2020-06-26	83	13	49
131852	2020-06-27	83	13	49
131853	2020-06-28	83	13	49
131854	2020-06-29	63	14	49
131855	2020-06-30	83	13	49
131856	2020-06-01	83	13	50
131857	2020-06-02	83	13	50
131858	2020-06-03	64	14	50
131859	2020-06-04	63	14	50
131860	2020-06-05	83	13	50
131861	2020-06-06	83	13	50
131862	2020-06-07	83	13	50
131863	2020-06-08	83	13	50
131864	2020-06-09	64	14	50
131865	2020-06-10	83	13	50
131866	2020-06-11	83	13	50
131867	2020-06-12	83	13	50
131868	2020-06-13	83	13	50
131869	2020-06-14	83	13	50
131870	2020-06-15	64	14	50
131871	2020-06-16	63	14	50
131872	2020-06-17	83	13	50
131873	2020-06-18	83	13	50
131874	2020-06-19	63	14	50
131875	2020-06-20	83	13	50
131876	2020-06-21	83	13	50
131877	2020-06-22	83	13	50
131878	2020-06-23	64	14	50
131879	2020-06-24	63	14	50
131880	2020-06-25	83	13	50
131881	2020-06-26	83	13	50
131882	2020-06-27	83	13	50
131883	2020-06-28	83	13	50
131884	2020-06-29	83	13	50
131885	2020-06-30	83	13	50
131886	2020-06-01	82	16	43
131887	2020-06-02	82	16	43
131888	2020-06-03	82	16	43
131889	2020-06-04	82	16	43
131890	2020-06-05	82	16	43
131891	2020-06-06	63	14	43
131892	2020-06-07	64	14	43
131893	2020-06-08	82	16	43
131894	2020-06-09	82	16	43
131895	2020-06-10	82	16	43
131896	2020-06-11	82	16	43
131897	2020-06-12	82	16	43
131898	2020-06-13	63	14	43
131899	2020-06-14	64	14	43
131900	2020-06-15	82	16	43
131901	2020-06-16	82	16	43
131902	2020-06-17	82	16	43
131903	2020-06-18	82	16	43
131904	2020-06-19	82	16	43
131905	2020-06-20	63	14	43
131906	2020-06-21	64	14	43
131907	2020-06-22	82	16	43
131908	2020-06-23	82	16	43
131909	2020-06-24	82	16	43
131910	2020-06-25	82	16	43
131911	2020-06-26	82	16	43
131912	2020-06-27	63	14	43
131913	2020-06-28	64	14	43
131914	2020-06-29	82	16	43
131915	2020-06-30	82	16	43
131916	2020-06-01	82	16	44
131917	2020-06-02	82	16	44
131918	2020-06-03	82	16	44
131919	2020-06-04	82	16	44
131920	2020-06-05	82	16	44
131921	2020-06-06	63	14	44
131922	2020-06-07	64	14	44
131923	2020-06-08	82	16	44
131924	2020-06-09	82	16	44
131925	2020-06-10	82	16	44
131926	2020-06-11	82	16	44
131927	2020-06-12	82	16	44
131928	2020-06-13	63	14	44
131929	2020-06-14	64	14	44
131930	2020-06-15	82	16	44
131931	2020-06-16	82	16	44
131932	2020-06-17	82	16	44
131933	2020-06-18	82	16	44
131934	2020-06-19	82	16	44
131935	2020-06-20	63	14	44
131936	2020-06-21	64	14	44
131937	2020-06-22	82	16	44
131938	2020-06-23	82	16	44
131939	2020-06-24	82	16	44
131940	2020-06-25	82	16	44
131941	2020-06-26	82	16	44
131942	2020-06-27	63	14	44
131943	2020-06-28	64	14	44
131944	2020-06-29	82	16	44
131945	2020-06-30	82	16	44
134286	2020-09-01	64	14	47
134287	2020-09-02	63	14	47
134288	2020-09-03	80	13	47
134289	2020-09-04	80	13	47
134290	2020-09-05	80	13	47
134291	2020-09-06	80	13	47
134292	2020-09-07	80	13	47
134293	2020-09-08	80	13	47
134294	2020-09-09	64	14	47
134295	2020-09-10	80	13	47
134296	2020-09-11	80	13	47
134297	2020-09-12	80	13	47
134298	2020-09-13	80	13	47
134299	2020-09-14	80	13	47
134300	2020-09-15	64	14	47
134301	2020-09-16	63	14	47
134302	2020-09-17	80	13	47
134303	2020-09-18	80	13	47
134304	2020-09-19	80	13	47
134305	2020-09-20	63	14	47
134306	2020-09-21	80	13	47
134307	2020-09-22	80	13	47
134308	2020-09-23	80	13	47
134309	2020-09-24	80	13	47
134310	2020-09-25	80	13	47
134311	2020-09-26	80	13	47
134312	2020-09-27	64	14	47
134313	2020-09-28	84	14	47
134314	2020-09-29	63	14	47
134315	2020-09-30	80	13	47
134316	2020-09-01	80	13	69
134317	2020-09-02	80	13	69
134318	2020-09-03	80	13	69
134319	2020-09-04	64	14	69
134320	2020-09-05	84	14	69
134321	2020-09-06	63	14	69
134322	2020-09-07	63	14	69
134323	2020-09-08	63	14	69
134324	2020-09-09	80	13	69
134325	2020-09-10	80	13	69
134326	2020-09-11	80	13	69
134327	2020-09-12	80	13	69
134328	2020-09-13	80	13	69
134329	2020-09-14	64	14	69
134330	2020-09-15	80	13	69
134331	2020-09-16	80	13	69
134332	2020-09-17	80	13	69
134333	2020-09-18	80	13	69
134334	2020-09-19	80	13	69
134335	2020-09-20	80	13	69
134336	2020-09-21	64	14	69
134337	2020-09-22	80	13	69
134338	2020-09-23	80	13	69
134339	2020-09-24	63	14	69
134340	2020-09-25	80	13	69
134341	2020-09-26	80	13	69
134342	2020-09-27	80	13	69
134343	2020-09-28	80	13	69
134344	2020-09-29	64	14	69
134345	2020-09-30	80	13	69
134346	2020-09-01	80	13	46
134347	2020-09-02	80	13	46
134348	2020-09-03	64	14	46
134349	2020-09-04	80	13	46
134350	2020-09-05	80	13	46
134351	2020-09-06	63	14	46
134352	2020-09-07	80	13	46
134353	2020-09-08	80	13	46
134354	2020-09-09	80	13	46
134355	2020-09-10	64	14	46
134356	2020-09-11	63	14	46
134357	2020-09-12	63	14	46
134358	2020-09-13	63	14	46
134359	2020-09-14	80	13	46
134360	2020-09-15	80	13	46
134361	2020-09-16	80	13	46
134362	2020-09-17	80	13	46
134363	2020-09-18	80	13	46
134364	2020-09-19	64	14	46
134365	2020-09-20	84	14	46
134366	2020-09-21	80	13	46
134367	2020-09-22	80	13	46
134368	2020-09-23	65	15	46
134369	2020-09-24	80	13	46
134370	2020-09-25	80	13	46
134371	2020-09-26	80	13	46
134372	2020-09-27	64	14	46
134373	2020-09-28	80	13	46
134374	2020-09-29	80	13	46
134375	2020-09-30	80	13	46
134376	2020-09-01	80	13	60
134377	2020-09-02	64	14	60
134378	2020-09-03	80	13	60
134379	2020-09-04	80	13	60
134380	2020-09-05	80	13	60
134381	2020-09-06	80	13	60
134382	2020-09-07	80	13	60
134383	2020-09-08	80	13	60
134384	2020-09-09	64	14	60
134385	2020-09-10	80	13	60
134386	2020-09-11	80	13	60
134387	2020-09-12	63	14	60
134388	2020-09-13	80	13	60
134389	2020-09-14	80	13	60
134390	2020-09-15	80	13	60
134391	2020-09-16	80	13	60
134392	2020-09-17	64	14	60
134393	2020-09-18	84	14	60
134394	2020-09-19	80	13	60
134395	2020-09-20	80	13	60
134396	2020-09-21	80	13	60
134397	2020-09-22	63	14	60
134398	2020-09-23	80	13	60
134399	2020-09-24	80	13	60
134400	2020-09-25	64	14	60
134401	2020-09-26	63	14	60
134402	2020-09-27	80	13	60
134403	2020-09-28	80	13	60
134404	2020-09-29	80	13	60
134405	2020-09-30	63	14	60
134406	2020-09-01	64	14	64
134407	2020-09-02	63	14	64
134408	2020-09-03	80	13	64
134409	2020-09-04	80	13	64
134410	2020-09-05	84	14	64
134411	2020-09-06	63	14	64
134412	2020-09-07	80	13	64
134413	2020-09-08	80	13	64
134414	2020-09-09	80	13	64
134415	2020-09-10	80	13	64
134416	2020-09-11	80	13	64
134417	2020-09-12	80	13	64
134418	2020-09-13	64	14	64
134419	2020-09-14	80	13	64
134420	2020-09-15	80	13	64
134421	2020-09-16	80	13	64
134422	2020-09-17	80	13	64
134423	2020-09-18	80	13	64
134424	2020-09-19	80	13	64
134425	2020-09-20	64	14	64
134426	2020-09-21	63	14	64
134427	2020-09-22	63	14	64
134428	2020-09-23	80	13	64
134429	2020-09-24	80	13	64
134430	2020-09-25	80	13	64
134431	2020-09-26	64	14	64
134432	2020-09-27	80	13	64
134433	2020-09-28	80	13	64
134434	2020-09-29	80	13	64
134435	2020-09-30	80	13	64
134436	2020-09-01	80	13	65
134437	2020-09-02	80	13	65
134438	2020-09-03	80	13	65
134439	2020-09-04	80	13	65
134440	2020-09-05	80	13	65
134441	2020-09-06	64	14	65
134442	2020-09-07	63	14	65
134443	2020-09-08	63	14	65
134444	2020-09-09	80	13	65
134445	2020-09-10	80	13	65
134446	2020-09-11	63	14	65
134447	2020-09-12	64	14	65
134448	2020-09-13	80	13	65
134449	2020-09-14	80	13	65
134450	2020-09-15	80	13	65
134451	2020-09-16	80	13	65
134452	2020-09-17	63	14	65
134453	2020-09-18	80	13	65
134454	2020-09-19	80	13	65
134455	2020-09-20	80	13	65
134456	2020-09-21	80	13	65
134457	2020-09-22	80	13	65
134458	2020-09-23	80	13	65
134459	2020-09-24	64	14	65
134460	2020-09-25	80	13	65
134461	2020-09-26	80	13	65
134462	2020-09-27	84	14	65
134463	2020-09-28	64	14	65
134464	2020-09-29	80	13	65
134465	2020-09-30	80	13	65
134466	2020-09-01	80	13	51
134467	2020-09-02	80	13	51
134468	2020-09-03	80	13	51
134469	2020-09-04	64	14	51
134470	2020-09-05	80	13	51
134471	2020-09-06	63	14	51
134472	2020-09-07	80	13	51
134473	2020-09-08	80	13	51
134474	2020-09-09	63	14	51
134475	2020-09-10	64	14	51
134476	2020-09-11	63	14	51
134477	2020-09-12	80	13	51
134478	2020-09-13	80	13	51
134479	2020-09-14	80	13	51
134480	2020-09-15	80	13	51
134481	2020-09-16	64	14	51
134482	2020-09-17	63	14	51
134483	2020-09-18	80	13	51
134484	2020-09-19	80	13	51
134485	2020-09-20	80	13	51
134486	2020-09-21	80	13	51
134487	2020-09-22	80	13	51
134488	2020-09-23	80	13	51
134489	2020-09-24	64	14	51
134490	2020-09-25	80	13	51
134491	2020-09-26	80	13	51
134492	2020-09-27	80	13	51
134493	2020-09-28	80	13	51
134494	2020-09-29	84	14	51
134495	2020-09-30	80	13	51
134496	2020-09-01	80	13	57
134497	2020-09-02	80	13	57
134498	2020-09-03	64	14	57
134499	2020-09-04	80	13	57
134500	2020-09-05	80	13	57
134501	2020-09-06	63	14	57
134502	2020-09-07	80	13	57
134503	2020-09-08	80	13	57
134504	2020-09-09	64	14	57
134505	2020-09-10	80	13	57
134506	2020-09-11	80	13	57
134507	2020-09-12	63	14	57
134508	2020-09-13	80	13	57
134509	2020-09-14	80	13	57
134510	2020-09-15	64	14	57
134511	2020-09-16	80	13	57
134512	2020-09-17	80	13	57
134513	2020-09-18	63	14	57
134514	2020-09-19	80	13	57
134515	2020-09-20	80	13	57
134516	2020-09-21	80	13	57
134517	2020-09-22	80	13	57
134518	2020-09-23	80	13	57
134519	2020-09-24	80	13	57
134520	2020-09-25	64	14	57
134521	2020-09-26	80	13	57
134522	2020-09-27	80	13	57
134523	2020-09-28	80	13	57
134524	2020-09-29	84	14	57
134525	2020-09-30	63	14	57
134526	2020-09-01	80	13	71
134527	2020-09-02	80	13	71
134528	2020-09-03	64	14	71
134529	2020-09-04	80	13	71
134530	2020-09-05	80	13	71
134531	2020-09-06	63	14	71
134532	2020-09-07	80	13	71
134533	2020-09-08	80	13	71
134534	2020-09-09	80	13	71
134535	2020-09-10	64	14	71
134536	2020-09-11	84	14	71
134537	2020-09-12	80	13	71
134538	2020-09-13	80	13	71
134539	2020-09-14	63	14	71
134540	2020-09-15	80	13	71
134541	2020-09-16	80	13	71
134542	2020-09-17	80	13	71
134543	2020-09-18	64	14	71
134544	2020-09-19	80	13	71
134545	2020-09-20	80	13	71
134546	2020-09-21	80	13	71
134547	2020-09-22	80	13	71
134548	2020-09-23	63	14	71
134549	2020-09-24	80	13	71
134550	2020-09-25	80	13	71
134551	2020-09-26	80	13	71
134552	2020-09-27	64	14	71
134553	2020-09-28	63	14	71
134554	2020-09-29	80	13	71
134555	2020-09-30	80	13	71
134556	2020-09-01	80	13	78
134557	2020-09-02	80	13	78
134558	2020-09-03	64	14	78
134559	2020-09-04	63	14	78
134560	2020-09-05	63	14	78
134561	2020-09-06	63	14	78
134562	2020-09-07	80	13	78
134563	2020-09-08	80	13	78
134564	2020-09-09	80	13	78
134565	2020-09-10	80	13	78
134566	2020-09-11	80	13	78
134567	2020-09-12	64	14	78
134568	2020-09-13	84	14	78
134569	2020-09-14	80	13	78
134570	2020-09-15	80	13	78
134571	2020-09-16	80	13	78
134572	2020-09-17	80	13	78
134573	2020-09-18	80	13	78
134574	2020-09-19	64	14	78
134575	2020-09-20	80	13	78
134576	2020-09-21	80	13	78
134577	2020-09-22	63	14	78
134578	2020-09-23	80	13	78
134579	2020-09-24	80	13	78
134580	2020-09-25	64	14	78
134581	2020-09-26	80	13	78
134582	2020-09-27	80	13	78
134583	2020-09-28	80	13	78
134584	2020-09-29	80	13	78
134585	2020-09-30	80	13	78
134586	2020-09-01	64	14	79
134587	2020-09-02	63	14	79
134588	2020-09-03	80	13	79
134589	2020-09-04	80	13	79
134590	2020-09-05	84	14	79
134591	2020-09-06	63	14	79
134592	2020-09-07	64	14	79
134593	2020-09-08	63	14	79
134594	2020-09-09	80	13	79
134595	2020-09-10	80	13	79
134596	2020-09-11	80	13	79
134597	2020-09-12	80	13	79
134598	2020-09-13	80	13	79
134599	2020-09-14	80	13	79
134600	2020-09-15	64	14	79
134601	2020-09-16	80	13	79
134602	2020-09-17	80	13	79
134603	2020-09-18	80	13	79
134604	2020-09-19	63	14	79
134605	2020-09-20	80	13	79
134606	2020-09-21	80	13	79
134607	2020-09-22	80	13	79
134608	2020-09-23	80	13	79
134609	2020-09-24	80	13	79
134610	2020-09-25	80	13	79
134611	2020-09-26	64	14	79
134612	2020-09-27	80	13	79
134613	2020-09-28	80	13	79
134614	2020-09-29	80	13	79
134615	2020-09-30	80	13	79
134616	2020-09-01	64	14	56
134617	2020-09-02	81	13	56
134618	2020-09-03	81	13	56
134619	2020-09-04	63	14	56
134620	2020-09-05	81	13	56
134621	2020-09-06	63	14	56
134622	2020-09-07	81	13	56
134623	2020-09-08	81	13	56
134624	2020-09-09	81	13	56
134625	2020-09-10	64	14	56
134626	2020-09-11	81	13	56
134627	2020-09-12	81	13	56
134628	2020-09-13	63	14	56
134629	2020-09-14	81	13	56
134630	2020-09-15	81	13	56
134631	2020-09-16	81	13	56
134632	2020-09-17	64	14	56
134633	2020-09-18	84	14	56
134634	2020-09-19	81	13	56
134635	2020-09-20	81	13	56
134636	2020-09-21	81	13	56
134637	2020-09-22	81	13	56
134638	2020-09-23	81	13	56
134639	2020-09-24	81	13	56
134640	2020-09-25	64	14	56
134641	2020-09-26	81	13	56
134642	2020-09-27	81	13	56
134643	2020-09-28	81	13	56
134644	2020-09-29	81	13	56
134645	2020-09-30	63	14	56
134646	2020-09-01	81	13	62
134647	2020-09-02	81	13	62
134648	2020-09-03	64	14	62
134649	2020-09-04	81	13	62
134650	2020-09-05	81	13	62
134651	2020-09-06	63	14	62
134652	2020-09-07	81	13	62
134653	2020-09-08	63	14	62
134654	2020-09-09	81	13	62
134655	2020-09-10	81	13	62
134656	2020-09-11	81	13	62
134657	2020-09-12	81	13	62
134658	2020-09-13	81	13	62
134659	2020-09-14	81	13	62
134660	2020-09-15	64	14	62
134661	2020-09-16	63	14	62
134662	2020-09-17	81	13	62
134663	2020-09-18	81	13	62
134664	2020-09-19	63	14	62
134665	2020-09-20	84	14	62
134666	2020-09-21	81	13	62
134667	2020-09-22	81	13	62
134668	2020-09-23	81	13	62
134669	2020-09-24	64	14	62
134670	2020-09-25	81	13	62
134671	2020-09-26	81	13	62
134672	2020-09-27	81	13	62
134673	2020-09-28	81	13	62
134674	2020-09-29	64	14	62
134675	2020-09-30	81	13	62
134676	2020-09-01	81	13	63
134677	2020-09-02	81	13	63
134678	2020-09-03	64	14	63
134679	2020-09-04	81	13	63
134680	2020-09-05	81	13	63
134681	2020-09-06	84	14	63
134682	2020-09-07	81	13	63
134683	2020-09-08	81	13	63
134684	2020-09-09	81	13	63
134685	2020-09-10	81	13	63
134686	2020-09-11	64	14	63
134687	2020-09-12	63	14	63
134688	2020-09-13	63	14	63
134689	2020-09-14	81	13	63
134690	2020-09-15	81	13	63
134691	2020-09-16	81	13	63
134692	2020-09-17	81	13	63
134693	2020-09-18	64	14	63
134694	2020-09-19	81	13	63
134695	2020-09-20	81	13	63
134696	2020-09-21	81	13	63
134697	2020-09-22	81	13	63
134698	2020-09-23	63	14	63
134699	2020-09-24	81	13	63
134700	2020-09-25	81	13	63
134701	2020-09-26	81	13	63
134702	2020-09-27	81	13	63
134703	2020-09-28	81	13	63
134704	2020-09-29	64	14	63
134705	2020-09-30	63	14	63
134706	2020-09-01	81	13	67
134707	2020-09-02	81	13	67
134708	2020-09-03	64	14	67
134709	2020-09-04	63	14	67
134710	2020-09-05	81	13	67
134711	2020-09-06	84	14	67
134712	2020-09-07	63	14	67
134713	2020-09-08	63	14	67
134714	2020-09-09	64	14	67
134715	2020-09-10	81	13	67
134716	2020-09-11	81	13	67
134717	2020-09-12	81	13	67
134718	2020-09-13	81	13	67
134719	2020-09-14	63	14	67
134720	2020-09-15	81	13	67
134721	2020-09-16	81	13	67
134722	2020-09-17	81	13	67
134723	2020-09-18	81	13	67
134724	2020-09-19	81	13	67
134725	2020-09-20	81	13	67
134726	2020-09-21	64	14	67
134727	2020-09-22	81	13	67
134728	2020-09-23	81	13	67
134729	2020-09-24	81	13	67
134730	2020-09-25	81	13	67
134731	2020-09-26	81	13	67
134732	2020-09-27	64	14	67
134733	2020-09-28	81	13	67
134734	2020-09-29	81	13	67
134735	2020-09-30	81	13	67
134736	2020-09-01	64	14	73
134737	2020-09-02	63	14	73
134738	2020-09-03	81	13	73
134739	2020-09-04	81	13	73
134740	2020-09-05	81	13	73
134741	2020-09-06	84	14	73
134742	2020-09-07	64	14	73
134743	2020-09-08	63	14	73
134744	2020-09-09	63	14	73
134745	2020-09-10	63	14	73
134746	2020-09-11	81	13	73
134747	2020-09-12	81	13	73
134748	2020-09-13	81	13	73
134749	2020-09-14	81	13	73
134750	2020-09-15	81	13	73
134751	2020-09-16	81	13	73
134752	2020-09-17	64	14	73
134753	2020-09-18	81	13	73
134754	2020-09-19	81	13	73
134755	2020-09-20	81	13	73
134756	2020-09-21	81	13	73
134757	2020-09-22	81	13	73
134758	2020-09-23	81	13	73
134759	2020-09-24	64	14	73
134760	2020-09-25	81	13	73
134761	2020-09-26	81	13	73
134762	2020-09-27	81	13	73
134763	2020-09-28	81	13	73
134764	2020-09-29	81	13	73
134765	2020-09-30	81	13	73
134766	2020-09-01	81	13	66
134767	2020-09-02	81	13	66
134768	2020-09-03	81	13	66
134769	2020-09-04	64	14	66
134770	2020-09-05	63	14	66
134771	2020-09-06	63	14	66
134772	2020-09-07	81	13	66
134773	2020-09-08	81	13	66
134774	2020-09-09	81	13	66
134775	2020-09-10	64	14	66
134776	2020-09-11	63	14	66
134777	2020-09-12	63	14	66
134778	2020-09-13	81	13	66
134779	2020-09-14	81	13	66
134780	2020-09-15	84	14	66
134781	2020-09-16	81	13	66
134782	2020-09-17	81	13	66
134783	2020-09-18	81	13	66
134784	2020-09-19	81	13	66
134785	2020-09-20	81	13	66
134786	2020-09-21	81	13	66
134787	2020-09-22	64	14	66
134788	2020-09-23	81	13	66
134789	2020-09-24	81	13	66
134790	2020-09-25	64	14	66
134791	2020-09-26	81	13	66
134792	2020-09-27	81	13	66
134793	2020-09-28	81	13	66
134794	2020-09-29	81	13	66
134795	2020-09-30	81	13	66
134796	2020-09-01	64	14	55
134797	2020-09-02	63	14	55
134798	2020-09-03	81	13	55
134799	2020-09-04	81	13	55
134800	2020-09-05	63	14	55
134801	2020-09-06	63	14	55
134802	2020-09-07	81	13	55
134803	2020-09-08	81	13	55
134804	2020-09-09	81	13	55
134805	2020-09-10	81	13	55
134806	2020-09-11	81	13	55
134807	2020-09-12	81	13	55
134808	2020-09-13	64	14	55
134809	2020-09-14	81	13	55
134810	2020-09-15	81	13	55
134811	2020-09-16	81	13	55
134812	2020-09-17	81	13	55
134813	2020-09-18	81	13	55
134814	2020-09-19	64	14	55
134815	2020-09-20	84	14	55
134816	2020-09-21	81	13	55
134817	2020-09-22	81	13	55
134818	2020-09-23	81	13	55
134819	2020-09-24	81	13	55
134820	2020-09-25	81	13	55
134821	2020-09-26	64	14	55
134822	2020-09-27	81	13	55
134823	2020-09-28	63	14	55
134824	2020-09-29	81	13	55
134825	2020-09-30	81	13	55
134826	2020-09-01	83	13	45
134827	2020-09-02	83	13	45
134828	2020-09-03	64	14	45
134829	2020-09-04	63	14	45
134830	2020-09-05	83	13	45
134831	2020-09-06	63	14	45
134832	2020-09-07	83	13	45
134833	2020-09-08	83	13	45
134834	2020-09-09	83	13	45
134835	2020-09-10	83	13	45
134836	2020-09-11	64	14	45
134837	2020-09-12	83	13	45
134838	2020-09-13	83	13	45
134839	2020-09-14	83	13	45
134840	2020-09-15	63	14	45
134841	2020-09-16	84	14	45
134842	2020-09-17	83	13	45
134843	2020-09-18	83	13	45
134844	2020-09-19	83	13	45
134845	2020-09-20	64	14	45
134846	2020-09-21	63	14	45
134847	2020-09-22	65	15	45
134848	2020-09-23	83	13	45
134849	2020-09-24	83	13	45
134850	2020-09-25	83	13	45
134851	2020-09-26	64	14	45
134852	2020-09-27	83	13	45
134853	2020-09-28	83	13	45
134854	2020-09-29	67	14	45
134855	2020-09-30	72	14	45
134856	2020-09-01	64	14	68
134857	2020-09-02	83	13	68
134858	2020-09-03	83	13	68
134859	2020-09-04	83	13	68
134860	2020-09-05	83	13	68
134861	2020-09-06	63	14	68
134862	2020-09-07	83	13	68
134863	2020-09-08	64	14	68
134864	2020-09-09	83	13	68
134865	2020-09-10	83	13	68
134866	2020-09-11	83	13	68
134867	2020-09-12	63	14	68
134868	2020-09-13	83	13	68
134869	2020-09-14	83	13	68
134870	2020-09-15	83	13	68
134871	2020-09-16	83	13	68
134872	2020-09-17	64	14	68
134873	2020-09-18	84	14	68
134874	2020-09-19	83	13	68
134875	2020-09-20	83	13	68
134876	2020-09-21	83	13	68
134877	2020-09-22	83	13	68
134878	2020-09-23	64	14	68
134879	2020-09-24	83	13	68
134880	2020-09-25	83	13	68
134881	2020-09-26	83	13	68
134882	2020-09-27	63	14	68
134883	2020-09-28	63	14	68
134884	2020-09-29	83	13	68
134885	2020-09-30	83	13	68
134886	2020-09-01	64	14	53
134887	2020-09-02	63	14	53
134888	2020-09-03	83	13	53
134889	2020-09-04	83	13	53
134890	2020-09-05	83	13	53
134891	2020-09-06	84	14	53
134892	2020-09-07	83	13	53
134893	2020-09-08	83	13	53
134894	2020-09-09	83	13	53
134895	2020-09-10	64	14	53
134896	2020-09-11	63	14	53
134897	2020-09-12	83	13	53
134898	2020-09-13	83	13	53
134899	2020-09-14	83	13	53
134900	2020-09-15	83	13	53
134901	2020-09-16	83	13	53
134902	2020-09-17	83	13	53
134903	2020-09-18	64	14	53
134904	2020-09-19	83	13	53
134905	2020-09-20	63	14	53
134906	2020-09-21	83	13	53
134907	2020-09-22	83	13	53
134908	2020-09-23	63	14	53
134909	2020-09-24	83	13	53
134910	2020-09-25	83	13	53
134911	2020-09-26	64	14	53
134912	2020-09-27	83	13	53
134913	2020-09-28	83	13	53
134914	2020-09-29	83	13	53
134915	2020-09-30	83	13	53
134916	2020-09-01	64	14	54
134917	2020-09-02	63	14	54
134918	2020-09-03	83	13	54
134919	2020-09-04	83	13	54
134920	2020-09-05	84	14	54
134921	2020-09-06	63	14	54
134922	2020-09-07	83	13	54
134923	2020-09-08	83	13	54
134924	2020-09-09	64	14	54
134925	2020-09-10	83	13	54
134926	2020-09-11	83	13	54
134927	2020-09-12	63	14	54
134928	2020-09-13	63	14	54
134929	2020-09-14	83	13	54
134930	2020-09-15	83	13	54
134931	2020-09-16	83	13	54
134932	2020-09-17	83	13	54
134933	2020-09-18	83	13	54
134934	2020-09-19	64	14	54
134935	2020-09-20	83	13	54
134936	2020-09-21	83	13	54
134937	2020-09-22	83	13	54
134938	2020-09-23	83	13	54
134939	2020-09-24	83	13	54
134940	2020-09-25	64	14	54
134941	2020-09-26	83	13	54
134942	2020-09-27	83	13	54
134943	2020-09-28	83	13	54
134944	2020-09-29	83	13	54
134945	2020-09-30	83	13	54
134946	2020-09-01	83	13	49
134947	2020-09-02	83	13	49
134948	2020-09-03	64	14	49
134949	2020-09-04	84	14	49
134950	2020-09-05	83	13	49
134951	2020-09-06	63	14	49
134952	2020-09-07	63	14	49
134953	2020-09-08	63	14	49
134954	2020-09-09	83	13	49
134955	2020-09-10	64	14	49
134956	2020-09-11	83	13	49
134957	2020-09-12	83	13	49
134958	2020-09-13	83	13	49
134959	2020-09-14	83	13	49
134960	2020-09-15	83	13	49
134961	2020-09-16	83	13	49
134962	2020-09-17	64	14	49
134963	2020-09-18	83	13	49
134964	2020-09-19	83	13	49
134965	2020-09-20	83	13	49
134966	2020-09-21	83	13	49
134967	2020-09-22	83	13	49
134968	2020-09-23	83	13	49
134969	2020-09-24	64	14	49
134970	2020-09-25	83	13	49
134971	2020-09-26	83	13	49
134972	2020-09-27	83	13	49
134973	2020-09-28	83	13	49
134974	2020-09-29	83	13	49
134975	2020-09-30	63	14	49
134976	2020-09-01	83	13	50
134977	2020-09-02	83	13	50
134978	2020-09-03	83	13	50
134979	2020-09-04	83	13	50
134980	2020-09-05	64	14	50
134981	2020-09-06	63	14	50
134982	2020-09-07	83	13	50
134983	2020-09-08	84	14	50
134984	2020-09-09	83	13	50
134985	2020-09-10	83	13	50
134986	2020-09-11	64	14	50
134987	2020-09-12	83	13	50
134988	2020-09-13	63	14	50
134989	2020-09-14	63	14	50
134990	2020-09-15	63	14	50
134991	2020-09-16	83	13	50
134992	2020-09-17	83	13	50
134993	2020-09-18	83	13	50
134994	2020-09-19	83	13	50
134995	2020-09-20	83	13	50
134996	2020-09-21	83	13	50
134997	2020-09-22	64	14	50
134998	2020-09-23	83	13	50
134999	2020-09-24	83	13	50
135000	2020-09-25	83	13	50
135001	2020-09-26	83	13	50
135002	2020-09-27	83	13	50
135003	2020-09-28	83	13	50
135004	2020-09-29	64	14	50
135005	2020-09-30	83	13	50
135006	2020-09-01	84	14	43
135007	2020-09-02	82	16	43
135008	2020-09-03	82	16	43
135009	2020-09-04	82	16	43
135010	2020-09-05	63	14	43
135011	2020-09-06	64	14	43
135012	2020-09-07	82	16	43
135013	2020-09-08	82	16	43
135014	2020-09-09	82	16	43
135015	2020-09-10	82	16	43
135016	2020-09-11	82	16	43
135017	2020-09-12	63	14	43
135018	2020-09-13	64	14	43
135019	2020-09-14	82	16	43
135020	2020-09-15	82	16	43
135021	2020-09-16	82	16	43
135022	2020-09-17	82	16	43
135023	2020-09-18	82	16	43
135024	2020-09-19	63	14	43
135025	2020-09-20	64	14	43
135026	2020-09-21	82	16	43
135027	2020-09-22	82	16	43
135028	2020-09-23	82	16	43
135029	2020-09-24	82	16	43
135030	2020-09-25	82	16	43
135031	2020-09-26	63	14	43
135032	2020-09-27	64	14	43
135033	2020-09-28	82	16	43
135034	2020-09-29	82	16	43
135035	2020-09-30	82	16	43
135036	2020-09-01	84	14	44
135037	2020-09-02	82	16	44
135038	2020-09-03	82	16	44
135039	2020-09-04	82	16	44
135040	2020-09-05	63	14	44
135041	2020-09-06	64	14	44
135042	2020-09-07	82	16	44
135043	2020-09-08	82	16	44
135044	2020-09-09	82	16	44
135045	2020-09-10	82	16	44
135046	2020-09-11	82	16	44
135047	2020-09-12	63	14	44
135048	2020-09-13	64	14	44
135049	2020-09-14	82	16	44
135050	2020-09-15	82	16	44
135051	2020-09-16	82	16	44
135052	2020-09-17	82	16	44
135053	2020-09-18	82	16	44
135054	2020-09-19	63	14	44
135055	2020-09-20	64	14	44
135056	2020-09-21	82	16	44
135057	2020-09-22	82	16	44
135058	2020-09-23	82	16	44
135059	2020-09-24	82	16	44
135060	2020-09-25	82	16	44
135061	2020-09-26	63	14	44
135062	2020-09-27	64	14	44
135063	2020-09-28	82	16	44
135064	2020-09-29	82	16	44
135065	2020-09-30	82	16	44
135071	2020-11-01	80	13	47
135072	2020-11-02	80	13	47
135073	2020-11-03	64	14	47
135074	2020-11-04	80	13	47
135075	2020-11-05	80	13	47
135076	2020-11-06	80	13	47
135077	2020-11-07	80	13	47
135078	2020-11-08	80	13	47
135079	2020-11-09	64	14	47
135080	2020-11-10	63	14	47
135081	2020-11-11	80	13	47
135082	2020-11-12	80	13	47
135083	2020-11-13	80	13	47
135084	2020-11-14	80	13	47
135085	2020-11-15	64	14	47
135086	2020-11-16	63	14	47
135087	2020-11-17	63	14	47
135088	2020-11-18	63	14	47
135089	2020-11-19	80	13	47
135090	2020-11-20	80	13	47
135091	2020-11-21	80	13	47
135092	2020-11-22	80	13	47
135093	2020-11-23	64	14	47
135094	2020-11-24	80	13	47
135095	2020-11-25	80	13	47
135096	2020-11-26	80	13	47
135097	2020-11-27	80	13	47
135098	2020-11-28	64	14	47
135099	2020-11-29	80	13	47
135100	2020-11-30	80	13	47
135101	2020-11-01	80	13	69
135102	2020-11-02	80	13	69
135103	2020-11-03	80	13	69
135104	2020-11-04	64	14	69
135105	2020-11-05	80	13	69
135106	2020-11-06	63	14	69
135107	2020-11-07	63	14	69
135108	2020-11-08	63	14	69
135109	2020-11-09	80	13	69
135110	2020-11-10	80	13	69
135111	2020-11-11	80	13	69
135112	2020-11-12	80	13	69
135113	2020-11-13	80	13	69
135114	2020-11-14	64	14	69
135115	2020-11-15	80	13	69
135116	2020-11-16	80	13	69
135117	2020-11-17	80	13	69
135118	2020-11-18	80	13	69
135119	2020-11-19	80	13	69
135120	2020-11-20	80	13	69
135121	2020-11-21	64	14	69
135122	2020-11-22	80	13	69
135123	2020-11-23	80	13	69
135124	2020-11-24	80	13	69
135125	2020-11-25	80	13	69
135126	2020-11-26	63	14	69
135127	2020-11-27	64	14	69
135128	2020-11-28	80	13	69
135129	2020-11-29	80	13	69
135130	2020-11-30	64	14	69
135131	2020-11-01	67	14	46
135132	2020-11-02	64	14	46
135133	2020-11-03	80	13	46
135134	2020-11-04	80	13	46
135135	2020-11-05	63	14	46
135136	2020-11-06	63	14	46
135137	2020-11-07	80	13	46
135138	2020-11-08	80	13	46
135139	2020-11-09	80	13	46
135140	2020-11-10	80	13	46
135141	2020-11-11	80	13	46
135142	2020-11-12	64	14	46
135143	2020-11-13	63	14	46
135144	2020-11-14	63	14	46
135145	2020-11-15	80	13	46
135146	2020-11-16	80	13	46
135147	2020-11-17	80	13	46
135148	2020-11-18	80	13	46
135149	2020-11-19	64	14	46
135150	2020-11-20	64	14	46
135151	2020-11-21	80	13	46
135152	2020-11-22	80	13	46
135153	2020-11-23	80	13	46
135154	2020-11-24	64	14	46
135155	2020-11-25	80	13	46
135156	2020-11-26	80	13	46
135157	2020-11-27	80	13	46
135158	2020-11-28	80	13	46
135159	2020-11-29	80	13	46
135160	2020-11-30	80	13	46
135161	2020-11-01	80	13	64
135162	2020-11-02	80	13	64
135163	2020-11-03	80	13	64
135164	2020-11-04	80	13	64
135165	2020-11-05	64	14	64
135166	2020-11-06	80	13	64
135167	2020-11-07	80	13	64
135168	2020-11-08	63	14	64
135169	2020-11-09	80	13	64
135170	2020-11-10	80	13	64
135171	2020-11-11	80	13	64
135172	2020-11-12	64	14	64
135173	2020-11-13	63	14	64
135174	2020-11-14	80	13	64
135175	2020-11-15	80	13	64
135176	2020-11-16	63	14	64
135177	2020-11-17	63	14	64
135178	2020-11-18	80	13	64
135179	2020-11-19	80	13	64
135180	2020-11-20	80	13	64
135181	2020-11-21	64	14	64
135182	2020-11-22	64	14	64
135183	2020-11-23	80	13	64
135184	2020-11-24	80	13	64
135185	2020-11-25	80	13	64
135186	2020-11-26	80	13	64
135187	2020-11-27	80	13	64
135188	2020-11-28	80	13	64
135189	2020-11-29	64	14	64
135190	2020-11-30	80	13	64
135191	2020-11-01	64	14	65
135192	2020-11-02	63	14	65
135193	2020-11-03	80	13	65
135194	2020-11-04	80	13	65
135195	2020-11-05	80	13	65
135196	2020-11-06	80	13	65
135197	2020-11-07	80	13	65
135198	2020-11-08	64	14	65
135199	2020-11-09	80	13	65
135200	2020-11-10	63	14	65
135201	2020-11-11	63	14	65
135202	2020-11-12	80	13	65
135203	2020-11-13	80	13	65
135204	2020-11-14	80	13	65
135205	2020-11-15	80	13	65
135206	2020-11-16	64	14	65
135207	2020-11-17	80	13	65
135208	2020-11-18	80	13	65
135209	2020-11-19	80	13	65
135210	2020-11-20	80	13	65
135211	2020-11-21	63	14	65
135212	2020-11-22	80	13	65
135213	2020-11-23	80	13	65
135214	2020-11-24	64	14	65
135215	2020-11-25	80	13	65
135216	2020-11-26	80	13	65
135217	2020-11-27	64	14	65
135218	2020-11-28	80	13	65
135219	2020-11-29	80	13	65
135220	2020-11-30	80	13	65
135221	2020-11-01	64	14	51
135222	2020-11-02	63	14	51
135223	2020-11-03	80	13	51
135224	2020-11-04	80	13	51
135225	2020-11-05	80	13	51
135226	2020-11-06	63	14	51
135227	2020-11-07	80	13	51
135228	2020-11-08	80	13	51
135229	2020-11-09	80	13	51
135230	2020-11-10	64	14	51
135231	2020-11-11	63	14	51
135232	2020-11-12	80	13	51
135233	2020-11-13	80	13	51
135234	2020-11-14	80	13	51
135235	2020-11-15	80	13	51
135236	2020-11-16	80	13	51
135237	2020-11-17	80	13	51
135238	2020-11-18	64	14	51
135239	2020-11-19	80	13	51
135240	2020-11-20	80	13	51
135241	2020-11-21	80	13	51
135242	2020-11-22	80	13	51
135243	2020-11-23	80	13	51
135244	2020-11-24	80	13	51
135245	2020-11-25	64	14	51
135246	2020-11-26	63	14	51
135247	2020-11-27	64	14	51
135248	2020-11-28	80	13	51
135249	2020-11-29	80	13	51
135250	2020-11-30	80	13	51
135251	2020-11-01	80	13	57
135252	2020-11-02	80	13	57
135253	2020-11-03	64	14	57
135254	2020-11-04	80	13	57
135255	2020-11-05	80	13	57
135256	2020-11-06	63	14	57
135257	2020-11-07	63	14	57
135258	2020-11-08	80	13	57
135259	2020-11-09	80	13	57
135260	2020-11-10	80	13	57
135261	2020-11-11	80	13	57
135262	2020-11-12	80	13	57
135263	2020-11-13	80	13	57
135264	2020-11-14	64	14	57
135265	2020-11-15	63	14	57
135266	2020-11-16	80	13	57
135267	2020-11-17	80	13	57
135268	2020-11-18	80	13	57
135269	2020-11-19	80	13	57
135270	2020-11-20	64	14	57
135271	2020-11-21	80	13	57
135272	2020-11-22	80	13	57
135273	2020-11-23	80	13	57
135274	2020-11-24	63	14	57
135275	2020-11-25	80	13	57
135276	2020-11-26	80	13	57
135277	2020-11-27	80	13	57
135278	2020-11-28	80	13	57
135279	2020-11-29	64	14	57
135280	2020-11-30	64	14	57
135281	2020-11-01	64	14	71
135282	2020-11-02	63	14	71
135283	2020-11-03	80	13	71
135284	2020-11-04	80	13	71
135285	2020-11-05	80	13	71
135286	2020-11-06	80	13	71
135287	2020-11-07	80	13	71
135288	2020-11-08	80	13	71
135289	2020-11-09	64	14	71
135290	2020-11-10	63	14	71
135291	2020-11-11	63	14	71
135292	2020-11-12	80	13	71
135293	2020-11-13	80	13	71
135294	2020-11-14	80	13	71
135295	2020-11-15	80	13	71
135296	2020-11-16	80	13	71
135297	2020-11-17	64	14	71
135298	2020-11-18	80	13	71
135299	2020-11-19	80	13	71
135300	2020-11-20	80	13	71
135301	2020-11-21	80	13	71
135302	2020-11-22	80	13	71
135303	2020-11-23	64	14	71
135304	2020-11-24	80	13	71
135305	2020-11-25	80	13	71
135306	2020-11-26	63	14	71
135307	2020-11-27	80	13	71
135308	2020-11-28	80	13	71
135309	2020-11-29	64	14	71
135310	2020-11-30	80	13	71
135311	2020-11-01	80	13	78
135312	2020-11-02	80	13	78
135313	2020-11-03	64	14	78
135314	2020-11-04	63	14	78
135315	2020-11-05	63	14	78
135316	2020-11-06	80	13	78
135317	2020-11-07	80	13	78
135318	2020-11-08	80	13	78
135319	2020-11-09	64	14	78
135320	2020-11-10	80	13	78
135321	2020-11-11	80	13	78
135322	2020-11-12	63	14	78
135323	2020-11-13	63	14	78
135324	2020-11-14	80	13	78
135325	2020-11-15	80	13	78
135326	2020-11-16	80	13	78
135327	2020-11-17	80	13	78
135328	2020-11-18	80	13	78
135329	2020-11-19	64	14	78
135330	2020-11-20	80	13	78
135331	2020-11-21	80	13	78
135332	2020-11-22	64	14	78
135333	2020-11-23	80	13	78
135334	2020-11-24	80	13	78
135335	2020-11-25	80	13	78
135336	2020-11-26	80	13	78
135337	2020-11-27	80	13	78
135338	2020-11-28	64	14	78
135339	2020-11-29	80	13	78
135340	2020-11-30	80	13	78
135341	2020-11-01	80	13	79
135342	2020-11-02	80	13	79
135343	2020-11-03	64	14	79
135344	2020-11-04	63	14	79
135345	2020-11-05	63	14	79
135346	2020-11-06	63	14	79
135347	2020-11-07	63	14	79
135348	2020-11-08	64	14	79
135349	2020-11-09	80	13	79
135350	2020-11-10	80	13	79
135351	2020-11-11	80	13	79
135352	2020-11-12	80	13	79
135353	2020-11-13	80	13	79
135354	2020-11-14	80	13	79
135355	2020-11-15	64	14	79
135356	2020-11-16	80	13	79
135357	2020-11-17	80	13	79
135358	2020-11-18	80	13	79
135359	2020-11-19	80	13	79
135360	2020-11-20	80	13	79
135361	2020-11-21	80	13	79
135362	2020-11-22	64	14	79
135363	2020-11-23	80	13	79
135364	2020-11-24	80	13	79
135365	2020-11-25	64	14	79
135366	2020-11-26	80	13	79
135367	2020-11-27	80	13	79
135368	2020-11-28	80	13	79
135369	2020-11-29	80	13	79
135370	2020-11-30	80	13	79
135371	2020-11-01	81	13	56
135372	2020-11-02	81	13	56
135373	2020-11-03	81	13	56
135374	2020-11-04	81	13	56
135375	2020-11-05	64	14	56
135376	2020-11-06	63	14	56
135377	2020-11-07	81	13	56
135378	2020-11-08	63	14	56
135379	2020-11-09	63	14	56
135380	2020-11-10	81	13	56
135381	2020-11-11	81	13	56
135382	2020-11-12	81	13	56
135383	2020-11-13	64	14	56
135384	2020-11-14	81	13	56
135385	2020-11-15	81	13	56
135386	2020-11-16	81	13	56
135387	2020-11-17	81	13	56
135388	2020-11-18	81	13	56
135389	2020-11-19	64	14	56
135390	2020-11-20	63	14	56
135391	2020-11-21	81	13	56
135392	2020-11-22	81	13	56
135393	2020-11-23	81	13	56
135394	2020-11-24	64	14	56
135395	2020-11-25	81	13	56
135396	2020-11-26	81	13	56
135397	2020-11-27	64	14	56
135398	2020-11-28	81	13	56
135399	2020-11-29	81	13	56
135400	2020-11-30	81	13	56
135401	2020-11-01	81	13	62
135402	2020-11-02	81	13	62
135403	2020-11-03	64	14	62
135404	2020-11-04	81	13	62
135405	2020-11-05	81	13	62
135406	2020-11-06	81	13	62
135407	2020-11-07	63	14	62
135408	2020-11-08	63	14	62
135409	2020-11-09	64	14	62
135410	2020-11-10	81	13	62
135411	2020-11-11	81	13	62
135412	2020-11-12	81	13	62
135413	2020-11-13	81	13	62
135414	2020-11-14	63	14	62
135415	2020-11-15	64	14	62
135416	2020-11-16	81	13	62
135417	2020-11-17	81	13	62
135418	2020-11-18	81	13	62
135419	2020-11-19	81	13	62
135420	2020-11-20	81	13	62
135421	2020-11-21	81	13	62
135422	2020-11-22	64	14	62
135423	2020-11-23	81	13	62
135424	2020-11-24	81	13	62
135425	2020-11-25	81	13	62
135426	2020-11-26	63	14	62
135427	2020-11-27	81	13	62
135428	2020-11-28	81	13	62
135429	2020-11-29	81	13	62
135430	2020-11-30	64	14	62
135431	2020-11-01	81	13	63
135432	2020-11-02	81	13	63
135433	2020-11-03	64	14	63
135434	2020-11-04	81	13	63
135435	2020-11-05	81	13	63
135436	2020-11-06	63	14	63
135437	2020-11-07	63	14	63
135438	2020-11-08	81	13	63
135439	2020-11-09	81	13	63
135440	2020-11-10	81	13	63
135441	2020-11-11	64	14	63
135442	2020-11-12	81	13	63
135443	2020-11-13	81	13	63
135444	2020-11-14	81	13	63
135445	2020-11-15	81	13	63
135446	2020-11-16	81	13	63
135447	2020-11-17	81	13	63
135448	2020-11-18	64	14	63
135449	2020-11-19	81	13	63
135450	2020-11-20	81	13	63
135451	2020-11-21	81	13	63
135452	2020-11-22	81	13	63
135453	2020-11-23	63	14	63
135454	2020-11-24	81	13	63
135455	2020-11-25	81	13	63
135456	2020-11-26	81	13	63
135457	2020-11-27	81	13	63
135458	2020-11-28	64	14	63
135459	2020-11-29	63	14	63
135460	2020-11-30	64	14	63
135461	2020-11-01	64	14	67
135462	2020-11-02	63	14	67
135463	2020-11-03	81	13	67
135464	2020-11-04	81	13	67
135465	2020-11-05	81	13	67
135466	2020-11-06	63	14	67
135467	2020-11-07	81	13	67
135468	2020-11-08	81	13	67
135469	2020-11-09	64	14	67
135470	2020-11-10	81	13	67
135471	2020-11-11	81	13	67
135472	2020-11-12	63	14	67
135473	2020-11-13	63	14	67
135474	2020-11-14	64	14	67
135475	2020-11-15	81	13	67
135476	2020-11-16	81	13	67
135477	2020-11-17	81	13	67
135478	2020-11-18	81	13	67
135479	2020-11-19	81	13	67
135480	2020-11-20	81	13	67
135481	2020-11-21	64	14	67
135482	2020-11-22	81	13	67
135483	2020-11-23	81	13	67
135484	2020-11-24	81	13	67
135485	2020-11-25	64	14	67
135486	2020-11-26	81	13	67
135487	2020-11-27	81	13	67
135488	2020-11-28	81	13	67
135489	2020-11-29	81	13	67
135490	2020-11-30	81	13	67
135491	2020-11-01	81	13	73
135492	2020-11-02	81	13	73
135493	2020-11-03	64	14	73
135494	2020-11-04	63	14	73
135495	2020-11-05	81	13	73
135496	2020-11-06	81	13	73
135497	2020-11-07	63	14	73
135498	2020-11-08	63	14	73
135499	2020-11-09	81	13	73
135500	2020-11-10	64	14	73
135501	2020-11-11	81	13	73
135502	2020-11-12	81	13	73
135503	2020-11-13	63	14	73
135504	2020-11-14	81	13	73
135505	2020-11-15	81	13	73
135506	2020-11-16	81	13	73
135507	2020-11-17	64	14	73
135508	2020-11-18	81	13	73
135509	2020-11-19	81	13	73
135510	2020-11-20	81	13	73
135511	2020-11-21	81	13	73
135512	2020-11-22	81	13	73
135513	2020-11-23	81	13	73
135514	2020-11-24	64	14	73
135515	2020-11-25	81	13	73
135516	2020-11-26	81	13	73
135517	2020-11-27	81	13	73
135518	2020-11-28	64	14	73
135519	2020-11-29	81	13	73
135520	2020-11-30	81	13	73
135521	2020-11-01	81	13	66
135522	2020-11-02	81	13	66
135523	2020-11-03	81	13	66
135524	2020-11-04	64	14	66
135525	2020-11-05	63	14	66
135526	2020-11-06	81	13	66
135527	2020-11-07	81	13	66
135528	2020-11-08	63	14	66
135529	2020-11-09	63	14	66
135530	2020-11-10	64	14	66
135531	2020-11-11	63	14	66
135532	2020-11-12	81	13	66
135533	2020-11-13	81	13	66
135534	2020-11-14	81	13	66
135535	2020-11-15	64	14	66
135536	2020-11-16	81	13	66
135537	2020-11-17	81	13	66
135538	2020-11-18	81	13	66
135539	2020-11-19	81	13	66
135540	2020-11-20	81	13	66
135541	2020-11-21	81	13	66
135542	2020-11-22	64	14	66
135543	2020-11-23	81	13	66
135544	2020-11-24	81	13	66
135545	2020-11-25	81	13	66
135546	2020-11-26	81	13	66
135547	2020-11-27	81	13	66
135548	2020-11-28	81	13	66
135549	2020-11-29	64	14	66
135550	2020-11-30	81	13	66
135551	2020-11-01	64	14	55
135552	2020-11-02	63	14	55
135553	2020-11-03	81	13	55
135554	2020-11-04	81	13	55
135555	2020-11-05	63	14	55
135556	2020-11-06	81	13	55
135557	2020-11-07	81	13	55
135558	2020-11-08	81	13	55
135559	2020-11-09	81	13	55
135560	2020-11-10	81	13	55
135561	2020-11-11	64	14	55
135562	2020-11-12	63	14	55
135563	2020-11-13	81	13	55
135564	2020-11-14	81	13	55
135565	2020-11-15	81	13	55
135566	2020-11-16	63	14	55
135567	2020-11-17	81	13	55
135568	2020-11-18	81	13	55
135569	2020-11-19	64	14	55
135570	2020-11-20	64	14	55
135571	2020-11-21	81	13	55
135572	2020-11-22	81	13	55
135573	2020-11-23	81	13	55
135574	2020-11-24	81	13	55
135575	2020-11-25	81	13	55
135576	2020-11-26	81	13	55
135577	2020-11-27	64	14	55
135578	2020-11-28	81	13	55
135579	2020-11-29	81	13	55
135580	2020-11-30	81	13	55
135581	2020-11-01	83	13	68
135582	2020-11-02	83	13	68
135583	2020-11-03	83	13	68
135584	2020-11-04	64	14	68
135585	2020-11-05	63	14	68
135586	2020-11-06	63	14	68
135587	2020-11-07	83	13	68
135588	2020-11-08	83	13	68
135589	2020-11-09	63	14	68
135590	2020-11-10	83	13	68
135591	2020-11-11	83	13	68
135592	2020-11-12	83	13	68
135593	2020-11-13	83	13	68
135594	2020-11-14	64	14	68
135595	2020-11-15	83	13	68
135596	2020-11-16	83	13	68
135597	2020-11-17	83	13	68
135598	2020-11-18	83	13	68
135599	2020-11-19	83	13	68
135600	2020-11-20	64	14	68
135601	2020-11-21	83	13	68
135602	2020-11-22	83	13	68
135603	2020-11-23	83	13	68
135604	2020-11-24	83	13	68
135605	2020-11-25	63	14	68
135606	2020-11-26	64	14	68
135607	2020-11-27	83	13	68
135608	2020-11-28	83	13	68
135609	2020-11-29	83	13	68
135610	2020-11-30	64	14	68
135611	2020-11-01	64	14	80
135612	2020-11-02	63	14	80
135613	2020-11-03	83	13	80
135614	2020-11-04	83	13	80
135615	2020-11-05	83	13	80
135616	2020-11-06	83	13	80
135617	2020-11-07	83	13	80
135618	2020-11-08	64	14	80
135619	2020-11-09	83	13	80
135620	2020-11-10	83	13	80
135621	2020-11-11	63	14	80
135622	2020-11-12	63	14	80
135623	2020-11-13	83	13	80
135624	2020-11-14	83	13	80
135625	2020-11-15	64	14	80
135626	2020-11-16	83	13	80
135627	2020-11-17	83	13	80
135628	2020-11-18	83	13	80
135629	2020-11-19	63	14	80
135630	2020-11-20	83	13	80
135631	2020-11-21	83	13	80
135632	2020-11-22	64	14	80
135633	2020-11-23	83	13	80
135634	2020-11-24	83	13	80
135635	2020-11-25	83	13	80
135636	2020-11-26	83	13	80
135637	2020-11-27	83	13	80
135638	2020-11-28	64	14	80
135639	2020-11-29	83	13	80
135640	2020-11-30	83	13	80
135641	2020-11-01	83	13	60
135642	2020-11-02	83	13	60
135643	2020-11-03	64	14	60
135644	2020-11-04	83	13	60
135645	2020-11-05	83	13	60
135646	2020-11-06	83	13	60
135647	2020-11-07	63	14	60
135648	2020-11-08	83	13	60
135649	2020-11-09	83	13	60
135650	2020-11-10	64	14	60
135651	2020-11-11	83	13	60
135652	2020-11-12	83	13	60
135653	2020-11-13	63	14	60
135654	2020-11-14	83	13	60
135655	2020-11-15	83	13	60
135656	2020-11-16	64	14	60
135657	2020-11-17	63	14	60
135658	2020-11-18	63	14	60
135659	2020-11-19	83	13	60
135660	2020-11-20	83	13	60
135661	2020-11-21	64	14	60
135662	2020-11-22	83	13	60
135663	2020-11-23	83	13	60
135664	2020-11-24	83	13	60
135665	2020-11-25	83	13	60
135666	2020-11-26	83	13	60
135667	2020-11-27	64	14	60
135668	2020-11-28	83	13	60
135669	2020-11-29	83	13	60
135670	2020-11-30	83	13	60
135671	2020-11-01	83	13	53
135672	2020-11-02	83	13	53
135673	2020-11-03	64	14	53
135674	2020-11-04	63	14	53
135675	2020-11-05	83	13	53
135676	2020-11-06	83	13	53
135677	2020-11-07	63	14	53
135678	2020-11-08	63	14	53
135679	2020-11-09	83	13	53
135680	2020-11-10	83	13	53
135681	2020-11-11	64	14	53
135682	2020-11-12	83	13	53
135683	2020-11-13	83	13	53
135684	2020-11-14	83	13	53
135685	2020-11-15	83	13	53
135686	2020-11-16	83	13	53
135687	2020-11-17	83	13	53
135688	2020-11-18	64	14	53
135689	2020-11-19	83	13	53
135690	2020-11-20	63	14	53
135691	2020-11-21	64	14	53
135692	2020-11-22	83	13	53
135693	2020-11-23	83	13	53
135694	2020-11-24	83	13	53
135695	2020-11-25	83	13	53
135696	2020-11-26	64	14	53
135697	2020-11-27	83	13	53
135698	2020-11-28	83	13	53
135699	2020-11-29	83	13	53
135700	2020-11-30	83	13	53
135701	2020-11-01	64	14	54
135702	2020-11-02	63	14	54
135703	2020-11-03	83	13	54
135704	2020-11-04	83	13	54
135705	2020-11-05	83	13	54
135706	2020-11-06	63	14	54
135707	2020-11-07	83	13	54
135708	2020-11-08	83	13	54
135709	2020-11-09	64	14	54
135710	2020-11-10	83	13	54
135711	2020-11-11	83	13	54
135712	2020-11-12	63	14	54
135713	2020-11-13	63	14	54
135714	2020-11-14	83	13	54
135715	2020-11-15	83	13	54
135716	2020-11-16	83	13	54
135717	2020-11-17	83	13	54
135718	2020-11-18	83	13	54
135719	2020-11-19	64	14	54
135720	2020-11-20	83	13	54
135721	2020-11-21	83	13	54
135722	2020-11-22	83	13	54
135723	2020-11-23	83	13	54
135724	2020-11-24	64	14	54
135725	2020-11-25	64	14	54
135726	2020-11-26	83	13	54
135727	2020-11-27	83	13	54
135728	2020-11-28	83	13	54
135729	2020-11-29	83	13	54
135730	2020-11-30	63	14	54
135731	2020-11-01	64	14	49
135732	2020-11-02	63	14	49
135733	2020-11-03	83	13	49
135734	2020-11-04	83	13	49
135735	2020-11-05	83	13	49
135736	2020-11-06	83	13	49
135737	2020-11-07	83	13	49
135738	2020-11-08	64	14	49
135739	2020-11-09	83	13	49
135740	2020-11-10	63	14	49
135741	2020-11-11	63	14	49
135742	2020-11-12	83	13	49
135743	2020-11-13	83	13	49
135744	2020-11-14	83	13	49
135745	2020-11-15	83	13	49
135746	2020-11-16	64	14	49
135747	2020-11-17	63	14	49
135748	2020-11-18	83	13	49
135749	2020-11-19	83	13	49
135750	2020-11-20	83	13	49
135751	2020-11-21	83	13	49
135752	2020-11-22	83	13	49
135753	2020-11-23	64	14	49
135754	2020-11-24	83	13	49
135755	2020-11-25	83	13	49
135756	2020-11-26	83	13	49
135757	2020-11-27	64	14	49
135758	2020-11-28	63	14	49
135759	2020-11-29	83	13	49
135760	2020-11-30	83	13	49
135761	2020-11-01	83	13	50
135762	2020-11-02	83	13	50
135763	2020-11-03	64	14	50
135764	2020-11-04	63	14	50
135765	2020-11-05	63	14	50
135766	2020-11-06	63	14	50
135767	2020-11-07	83	13	50
135768	2020-11-08	83	13	50
135769	2020-11-09	83	13	50
135770	2020-11-10	83	13	50
135771	2020-11-11	83	13	50
135772	2020-11-12	83	13	50
135773	2020-11-13	64	14	50
135774	2020-11-14	63	14	50
135775	2020-11-15	64	14	50
135776	2020-11-16	83	13	50
135777	2020-11-17	83	13	50
135778	2020-11-18	83	13	50
135779	2020-11-19	83	13	50
135780	2020-11-20	83	13	50
135781	2020-11-21	83	13	50
135782	2020-11-22	64	14	50
135783	2020-11-23	83	13	50
135784	2020-11-24	83	13	50
135785	2020-11-25	83	13	50
135786	2020-11-26	83	13	50
135787	2020-11-27	83	13	50
135788	2020-11-28	83	13	50
135789	2020-11-29	64	14	50
135790	2020-11-30	83	13	50
135791	2020-11-01	64	14	43
135792	2020-11-02	82	16	43
135793	2020-11-03	82	16	43
135794	2020-11-04	82	16	43
135795	2020-11-05	82	16	43
135796	2020-11-06	82	16	43
135797	2020-11-07	63	14	43
135798	2020-11-08	64	14	43
135799	2020-11-09	82	16	43
135800	2020-11-10	82	16	43
135801	2020-11-11	82	16	43
135802	2020-11-12	82	16	43
135803	2020-11-13	82	16	43
135804	2020-11-14	63	14	43
135805	2020-11-15	64	14	43
135806	2020-11-16	82	16	43
135807	2020-11-17	82	16	43
135808	2020-11-18	82	16	43
135809	2020-11-19	82	16	43
135810	2020-11-20	82	16	43
135811	2020-11-21	63	14	43
135812	2020-11-22	64	14	43
135813	2020-11-23	82	16	43
135814	2020-11-24	82	16	43
135815	2020-11-25	82	16	43
135816	2020-11-26	82	16	43
135817	2020-11-27	82	16	43
135818	2020-11-28	63	14	43
135819	2020-11-29	64	14	43
135820	2020-11-30	82	16	43
135821	2020-11-01	64	14	44
135822	2020-11-02	82	16	44
135823	2020-11-03	82	16	44
135824	2020-11-04	82	16	44
135825	2020-11-05	82	16	44
135826	2020-11-06	82	16	44
135827	2020-11-07	63	14	44
135828	2020-11-08	64	14	44
135829	2020-11-09	82	16	44
135830	2020-11-10	82	16	44
135831	2020-11-11	82	16	44
135832	2020-11-12	82	16	44
135833	2020-11-13	82	16	44
135834	2020-11-14	63	14	44
135835	2020-11-15	64	14	44
135836	2020-11-16	82	16	44
135837	2020-11-17	82	16	44
135838	2020-11-18	82	16	44
135839	2020-11-19	82	16	44
135840	2020-11-20	82	16	44
135841	2020-11-21	63	14	44
135842	2020-11-22	64	14	44
135843	2020-11-23	82	16	44
135844	2020-11-24	82	16	44
135845	2020-11-25	82	16	44
135846	2020-11-26	82	16	44
135847	2020-11-27	82	16	44
135848	2020-11-28	63	14	44
135849	2020-11-29	64	14	44
135850	2020-11-30	82	16	44
135851	2020-10-01	80	13	47
135852	2020-10-02	80	13	47
135853	2020-10-03	80	13	47
135854	2020-10-04	80	13	47
135855	2020-10-05	64	14	47
135856	2020-10-06	63	14	47
135857	2020-10-07	63	14	47
135858	2020-10-08	80	13	47
135859	2020-10-09	80	13	47
135860	2020-10-10	80	13	47
135861	2020-10-11	80	13	47
135862	2020-10-12	80	13	47
135863	2020-10-13	80	13	47
135864	2020-10-14	64	14	47
135865	2020-10-15	63	14	47
135866	2020-10-16	63	14	47
135867	2020-10-17	80	13	47
135868	2020-10-18	80	13	47
135869	2020-10-19	80	13	47
135870	2020-10-20	80	13	47
135871	2020-10-21	64	14	47
135872	2020-10-22	80	13	47
135873	2020-10-23	80	13	47
135874	2020-10-24	80	13	47
135875	2020-10-25	63	14	47
135876	2020-10-26	80	13	47
135877	2020-10-27	80	13	47
135878	2020-10-28	80	13	47
135879	2020-10-29	64	14	47
135880	2020-10-30	80	13	47
135881	2020-10-31	80	13	47
135882	2020-10-01	80	13	69
135883	2020-10-02	63	14	69
135884	2020-10-03	63	14	69
135885	2020-10-04	80	13	69
135886	2020-10-05	80	13	69
135887	2020-10-06	80	13	69
135888	2020-10-07	80	13	69
135889	2020-10-08	80	13	69
135890	2020-10-09	64	14	69
135891	2020-10-10	63	14	69
135892	2020-10-11	80	13	69
135893	2020-10-12	80	13	69
135894	2020-10-13	63	14	69
135895	2020-10-14	80	13	69
135896	2020-10-15	80	13	69
135897	2020-10-16	80	13	69
135898	2020-10-17	64	14	69
135899	2020-10-18	80	13	69
135900	2020-10-19	80	13	69
135901	2020-10-20	80	13	69
135902	2020-10-21	80	13	69
135903	2020-10-22	63	14	69
135904	2020-10-23	80	13	69
135905	2020-10-24	80	13	69
135906	2020-10-25	80	13	69
135907	2020-10-26	80	13	69
135908	2020-10-27	64	14	69
135909	2020-10-28	64	14	69
135910	2020-10-29	80	13	69
135911	2020-10-30	80	13	69
135912	2020-10-31	80	13	69
135913	2020-10-01	63	14	46
135914	2020-10-02	80	13	46
135915	2020-10-03	80	13	46
135916	2020-10-04	64	14	46
135917	2020-10-05	80	13	46
135918	2020-10-06	80	13	46
135919	2020-10-07	80	13	46
135920	2020-10-08	63	14	46
135921	2020-10-09	80	13	46
135922	2020-10-10	80	13	46
135923	2020-10-11	80	13	46
135924	2020-10-12	64	14	46
135925	2020-10-13	80	13	46
135926	2020-10-14	80	13	46
135927	2020-10-15	80	13	46
135928	2020-10-16	80	13	46
135929	2020-10-17	80	13	46
135930	2020-10-18	64	14	46
135931	2020-10-19	63	14	46
135932	2020-10-20	80	13	46
135933	2020-10-21	80	13	46
135934	2020-10-22	80	13	46
135935	2020-10-23	80	13	46
135936	2020-10-24	80	13	46
135937	2020-10-25	80	13	46
135938	2020-10-26	64	14	46
135939	2020-10-27	80	13	46
135940	2020-10-28	80	13	46
135941	2020-10-29	80	13	46
135942	2020-10-30	63	14	46
135943	2020-10-31	63	14	46
135944	2020-10-01	63	14	64
135945	2020-10-02	80	13	64
135946	2020-10-03	80	13	64
135947	2020-10-04	80	13	64
135948	2020-10-05	80	13	64
135949	2020-10-06	64	14	64
135950	2020-10-07	80	13	64
135951	2020-10-08	80	13	64
135952	2020-10-09	80	13	64
135953	2020-10-10	63	14	64
135954	2020-10-11	80	13	64
135955	2020-10-12	80	13	64
135956	2020-10-13	64	14	64
135957	2020-10-14	80	13	64
135958	2020-10-15	80	13	64
135959	2020-10-16	63	14	64
135960	2020-10-17	80	13	64
135961	2020-10-18	80	13	64
135962	2020-10-19	64	14	64
135963	2020-10-20	80	13	64
135964	2020-10-21	80	13	64
135965	2020-10-22	80	13	64
135966	2020-10-23	80	13	64
135967	2020-10-24	63	14	64
135968	2020-10-25	80	13	64
135969	2020-10-26	80	13	64
135970	2020-10-27	64	14	64
135971	2020-10-28	80	13	64
135972	2020-10-29	80	13	64
135973	2020-10-30	63	14	64
135974	2020-10-31	80	13	64
135975	2020-10-01	80	13	65
135976	2020-10-02	80	13	65
135977	2020-10-03	80	13	65
135978	2020-10-04	80	13	65
135979	2020-10-05	64	14	65
135980	2020-10-06	80	13	65
135981	2020-10-07	80	13	65
135982	2020-10-08	63	14	65
135983	2020-10-09	63	14	65
135984	2020-10-10	80	13	65
135985	2020-10-11	80	13	65
135986	2020-10-12	80	13	65
135987	2020-10-13	80	13	65
135988	2020-10-14	64	14	65
135989	2020-10-15	63	14	65
135990	2020-10-16	80	13	65
135991	2020-10-17	80	13	65
135992	2020-10-18	80	13	65
135993	2020-10-19	80	13	65
135994	2020-10-20	64	14	65
135995	2020-10-21	80	13	65
135996	2020-10-22	80	13	65
135997	2020-10-23	80	13	65
135998	2020-10-24	63	14	65
135999	2020-10-25	80	13	65
136000	2020-10-26	80	13	65
136001	2020-10-27	64	14	65
136002	2020-10-28	63	14	65
136003	2020-10-29	80	13	65
136004	2020-10-30	80	13	65
136005	2020-10-31	80	13	65
136006	2020-10-01	80	13	51
136007	2020-10-02	80	13	51
136008	2020-10-03	80	13	51
136009	2020-10-04	64	14	51
136010	2020-10-05	63	14	51
136011	2020-10-06	80	13	51
136012	2020-10-07	80	13	51
136013	2020-10-08	80	13	51
136014	2020-10-09	63	14	51
136015	2020-10-10	80	13	51
136016	2020-10-11	80	13	51
136017	2020-10-12	80	13	51
136018	2020-10-13	80	13	51
136019	2020-10-14	80	13	51
136020	2020-10-15	80	13	51
136021	2020-10-16	64	14	51
136022	2020-10-17	63	14	51
136023	2020-10-18	80	13	51
136024	2020-10-19	80	13	51
136025	2020-10-20	63	14	51
136026	2020-10-21	80	13	51
136027	2020-10-22	80	13	51
136028	2020-10-23	80	13	51
136029	2020-10-24	80	13	51
136030	2020-10-25	64	14	51
136031	2020-10-26	80	13	51
136032	2020-10-27	80	13	51
136033	2020-10-28	80	13	51
136034	2020-10-29	63	14	51
136035	2020-10-30	64	14	51
136036	2020-10-31	80	13	51
136037	2020-10-01	64	14	57
136038	2020-10-02	63	14	57
136039	2020-10-03	80	13	57
136040	2020-10-04	80	13	57
136041	2020-10-05	63	14	57
136042	2020-10-06	80	13	57
136043	2020-10-07	80	13	57
136044	2020-10-08	80	13	57
136045	2020-10-09	80	13	57
136046	2020-10-10	80	13	57
136047	2020-10-11	80	13	57
136048	2020-10-12	64	14	57
136049	2020-10-13	80	13	57
136050	2020-10-14	80	13	57
136051	2020-10-15	80	13	57
136052	2020-10-16	80	13	57
136053	2020-10-17	80	13	57
136054	2020-10-18	64	14	57
136055	2020-10-19	80	13	57
136056	2020-10-20	80	13	57
136057	2020-10-21	63	14	57
136058	2020-10-22	63	14	57
136059	2020-10-23	80	13	57
136060	2020-10-24	80	13	57
136061	2020-10-25	80	13	57
136062	2020-10-26	64	14	57
136063	2020-10-27	80	13	57
136064	2020-10-28	80	13	57
136065	2020-10-29	63	14	57
136066	2020-10-30	80	13	57
136067	2020-10-31	80	13	57
136068	2020-10-01	80	13	71
136069	2020-10-02	80	13	71
136070	2020-10-03	64	14	71
136071	2020-10-04	80	13	71
136072	2020-10-05	80	13	71
136073	2020-10-06	80	13	71
136074	2020-10-07	63	14	71
136075	2020-10-08	80	13	71
136076	2020-10-09	80	13	71
136077	2020-10-10	80	13	71
136078	2020-10-11	64	14	71
136079	2020-10-12	80	13	71
136080	2020-10-13	80	13	71
136081	2020-10-14	80	13	71
136082	2020-10-15	80	13	71
136083	2020-10-16	80	13	71
136084	2020-10-17	80	13	71
136085	2020-10-18	64	14	71
136086	2020-10-19	80	13	71
136087	2020-10-20	80	13	71
136088	2020-10-21	63	14	71
136089	2020-10-22	63	14	71
136090	2020-10-23	63	14	71
136091	2020-10-24	80	13	71
136092	2020-10-25	80	13	71
136093	2020-10-26	80	13	71
136094	2020-10-27	64	14	71
136095	2020-10-28	63	14	71
136096	2020-10-29	80	13	71
136097	2020-10-30	80	13	71
136098	2020-10-31	80	13	71
136099	2020-10-01	80	13	78
136100	2020-10-02	64	14	78
136101	2020-10-03	80	13	78
136102	2020-10-04	80	13	78
136103	2020-10-05	80	13	78
136104	2020-10-06	80	13	78
136105	2020-10-07	80	13	78
136106	2020-10-08	64	14	78
136107	2020-10-09	80	13	78
136108	2020-10-10	80	13	78
136109	2020-10-11	80	13	78
136110	2020-10-12	63	14	78
136111	2020-10-13	63	14	78
136112	2020-10-14	64	14	78
136113	2020-10-15	80	13	78
136114	2020-10-16	80	13	78
136115	2020-10-17	80	13	78
136116	2020-10-18	80	13	78
136117	2020-10-19	63	14	78
136118	2020-10-20	80	13	78
136119	2020-10-21	80	13	78
136120	2020-10-22	80	13	78
136121	2020-10-23	64	14	78
136122	2020-10-24	80	13	78
136123	2020-10-25	80	13	78
136124	2020-10-26	80	13	78
136125	2020-10-27	80	13	78
136126	2020-10-28	63	14	78
136127	2020-10-29	63	14	78
136128	2020-10-30	80	13	78
136129	2020-10-31	80	13	78
136130	2020-10-01	80	13	79
136131	2020-10-02	80	13	79
136132	2020-10-03	64	14	79
136133	2020-10-04	80	13	79
136134	2020-10-05	80	13	79
136135	2020-10-06	63	14	79
136136	2020-10-07	63	14	79
136137	2020-10-08	80	13	79
136138	2020-10-09	80	13	79
136139	2020-10-10	80	13	79
136140	2020-10-11	64	14	79
136141	2020-10-12	80	13	79
136142	2020-10-13	80	13	79
136143	2020-10-14	80	13	79
136144	2020-10-15	63	14	79
136145	2020-10-16	80	13	79
136146	2020-10-17	80	13	79
136147	2020-10-18	80	13	79
136148	2020-10-19	80	13	79
136149	2020-10-20	64	14	79
136150	2020-10-21	80	13	79
136151	2020-10-22	80	13	79
136152	2020-10-23	63	14	79
136153	2020-10-24	80	13	79
136154	2020-10-25	80	13	79
136155	2020-10-26	64	14	79
136156	2020-10-27	80	13	79
136157	2020-10-28	80	13	79
136158	2020-10-29	80	13	79
136159	2020-10-30	80	13	79
136160	2020-10-31	63	14	79
136161	2020-10-01	64	14	56
136162	2020-10-02	81	13	56
136163	2020-10-03	81	13	56
136164	2020-10-04	81	13	56
136165	2020-10-05	63	14	56
136166	2020-10-06	81	13	56
136167	2020-10-07	81	13	56
136168	2020-10-08	81	13	56
136169	2020-10-09	81	13	56
136170	2020-10-10	64	14	56
136171	2020-10-11	63	14	56
136172	2020-10-12	81	13	56
136173	2020-10-13	81	13	56
136174	2020-10-14	81	13	56
136175	2020-10-15	81	13	56
136176	2020-10-16	81	13	56
136177	2020-10-17	81	13	56
136178	2020-10-18	64	14	56
136179	2020-10-19	63	14	56
136180	2020-10-20	81	13	56
136181	2020-10-21	81	13	56
136182	2020-10-22	81	13	56
136183	2020-10-23	81	13	56
136184	2020-10-24	81	13	56
136185	2020-10-25	81	13	56
136186	2020-10-26	64	14	56
136187	2020-10-27	63	14	56
136188	2020-10-28	81	13	56
136189	2020-10-29	81	13	56
136190	2020-10-30	81	13	56
136191	2020-10-31	63	14	56
136192	2020-10-01	81	13	62
136193	2020-10-02	81	13	62
136194	2020-10-03	63	14	62
136195	2020-10-04	81	13	62
136196	2020-10-05	81	13	62
136197	2020-10-06	81	13	62
136198	2020-10-07	81	13	62
136199	2020-10-08	81	13	62
136200	2020-10-09	64	14	62
136201	2020-10-10	81	13	62
136202	2020-10-11	81	13	62
136203	2020-10-12	81	13	62
136204	2020-10-13	81	13	62
136205	2020-10-14	63	14	62
136206	2020-10-15	81	13	62
136207	2020-10-16	81	13	62
136208	2020-10-17	64	14	62
136209	2020-10-18	81	13	62
136210	2020-10-19	81	13	62
136211	2020-10-20	81	13	62
136212	2020-10-21	63	14	62
136213	2020-10-22	63	14	62
136214	2020-10-23	81	13	62
136215	2020-10-24	81	13	62
136216	2020-10-25	64	14	62
136217	2020-10-26	81	13	62
136218	2020-10-27	81	13	62
136219	2020-10-28	63	14	62
136220	2020-10-29	64	14	62
136221	2020-10-30	81	13	62
136222	2020-10-31	81	13	62
136223	2020-10-01	63	14	63
136224	2020-10-02	81	13	63
136225	2020-10-03	81	13	63
136226	2020-10-04	81	13	63
136227	2020-10-05	64	14	63
136228	2020-10-06	63	14	63
136229	2020-10-07	81	13	63
136230	2020-10-08	81	13	63
136231	2020-10-09	81	13	63
136232	2020-10-10	81	13	63
136233	2020-10-11	81	13	63
136234	2020-10-12	81	13	63
136235	2020-10-13	64	14	63
136236	2020-10-14	63	14	63
136237	2020-10-15	81	13	63
136238	2020-10-16	81	13	63
136239	2020-10-17	81	13	63
136240	2020-10-18	81	13	63
136241	2020-10-19	64	14	63
136242	2020-10-20	63	14	63
136243	2020-10-21	81	13	63
136244	2020-10-22	81	13	63
136245	2020-10-23	81	13	63
136246	2020-10-24	81	13	63
136247	2020-10-25	64	14	63
136248	2020-10-26	81	13	63
136249	2020-10-27	81	13	63
136250	2020-10-28	81	13	63
136251	2020-10-29	63	14	63
136252	2020-10-30	81	13	63
136253	2020-10-31	81	13	63
136254	2020-10-01	81	13	67
136255	2020-10-02	63	14	67
136256	2020-10-03	81	13	67
136257	2020-10-04	81	13	67
136258	2020-10-05	81	13	67
136259	2020-10-06	81	13	67
136260	2020-10-07	81	13	67
136261	2020-10-08	64	14	67
136262	2020-10-09	63	14	67
136263	2020-10-10	81	13	67
136264	2020-10-11	81	13	67
136265	2020-10-12	63	14	67
136266	2020-10-13	81	13	67
136267	2020-10-14	81	13	67
136268	2020-10-15	64	14	67
136269	2020-10-16	63	14	67
136270	2020-10-17	81	13	67
136271	2020-10-18	81	13	67
136272	2020-10-19	81	13	67
136273	2020-10-20	63	14	67
136274	2020-10-21	81	13	67
136275	2020-10-22	81	13	67
136276	2020-10-23	64	14	67
136277	2020-10-24	81	13	67
136278	2020-10-25	81	13	67
136279	2020-10-26	64	14	67
136280	2020-10-27	81	13	67
136281	2020-10-28	81	13	67
136282	2020-10-29	81	13	67
136283	2020-10-30	81	13	67
136284	2020-10-31	81	13	67
136285	2020-10-01	64	14	73
136286	2020-10-02	81	13	73
136287	2020-10-03	81	13	73
136288	2020-10-04	81	13	73
136289	2020-10-05	81	13	73
136290	2020-10-06	63	14	73
136291	2020-10-07	81	13	73
136292	2020-10-08	81	13	73
136293	2020-10-09	81	13	73
136294	2020-10-10	64	14	73
136295	2020-10-11	81	13	73
136296	2020-10-12	81	13	73
136297	2020-10-13	81	13	73
136298	2020-10-14	81	13	73
136299	2020-10-15	63	14	73
136300	2020-10-16	81	13	73
136301	2020-10-17	81	13	73
136302	2020-10-18	64	14	73
136303	2020-10-19	81	13	73
136304	2020-10-20	81	13	73
136305	2020-10-21	81	13	73
136306	2020-10-22	63	14	73
136307	2020-10-23	81	13	73
136308	2020-10-24	81	13	73
136309	2020-10-25	81	13	73
136310	2020-10-26	81	13	73
136311	2020-10-27	64	14	73
136312	2020-10-28	63	14	73
136313	2020-10-29	63	14	73
136314	2020-10-30	81	13	73
136315	2020-10-31	81	13	73
136316	2020-10-01	81	13	66
136317	2020-10-02	64	14	66
136318	2020-10-03	81	13	66
136319	2020-10-04	81	13	66
136320	2020-10-05	81	13	66
136321	2020-10-06	81	13	66
136322	2020-10-07	63	14	66
136323	2020-10-08	64	14	66
136324	2020-10-09	81	13	66
136325	2020-10-10	81	13	66
136326	2020-10-11	81	13	66
136327	2020-10-12	81	13	66
136328	2020-10-13	63	14	66
136329	2020-10-14	64	14	66
136330	2020-10-15	81	13	66
136331	2020-10-16	81	13	66
136332	2020-10-17	81	13	66
136333	2020-10-18	81	13	66
136334	2020-10-19	81	13	66
136335	2020-10-20	81	13	66
136336	2020-10-21	64	14	66
136337	2020-10-22	81	13	66
136338	2020-10-23	81	13	66
136339	2020-10-24	81	13	66
136340	2020-10-25	81	13	66
136341	2020-10-26	81	13	66
136342	2020-10-27	81	13	66
136343	2020-10-28	63	14	66
136344	2020-10-29	81	13	66
136345	2020-10-30	63	14	66
136346	2020-10-31	63	14	66
136347	2020-10-01	81	13	55
136348	2020-10-02	81	13	55
136349	2020-10-03	64	14	55
136350	2020-10-04	63	14	55
136351	2020-10-05	81	13	55
136352	2020-10-06	81	13	55
136353	2020-10-07	63	14	55
136354	2020-10-08	81	13	55
136355	2020-10-09	81	13	55
136356	2020-10-10	81	13	55
136357	2020-10-11	64	14	55
136358	2020-10-12	63	14	55
136359	2020-10-13	81	13	55
136360	2020-10-14	81	13	55
136361	2020-10-15	81	13	55
136362	2020-10-16	63	14	55
136363	2020-10-17	81	13	55
136364	2020-10-18	81	13	55
136365	2020-10-19	81	13	55
136366	2020-10-20	81	13	55
136367	2020-10-21	81	13	55
136368	2020-10-22	81	13	55
136369	2020-10-23	64	14	55
136370	2020-10-24	63	14	55
136371	2020-10-25	81	13	55
136372	2020-10-26	81	13	55
136373	2020-10-27	81	13	55
136374	2020-10-28	81	13	55
136375	2020-10-29	81	13	55
136376	2020-10-30	64	14	55
136377	2020-10-31	81	13	55
136378	2020-10-01	64	14	68
136379	2020-10-02	63	14	68
136380	2020-10-03	83	13	68
136381	2020-10-04	83	13	68
136382	2020-10-05	83	13	68
136383	2020-10-06	83	13	68
136384	2020-10-07	64	14	68
136385	2020-10-08	63	14	68
136386	2020-10-09	83	13	68
136387	2020-10-10	83	13	68
136388	2020-10-11	63	14	68
136389	2020-10-12	83	13	68
136390	2020-10-13	83	13	68
136391	2020-10-14	64	14	68
136392	2020-10-15	83	13	68
136393	2020-10-16	83	13	68
136394	2020-10-17	83	13	68
136395	2020-10-18	63	14	68
136396	2020-10-19	83	13	68
136397	2020-10-20	83	13	68
136398	2020-10-21	83	13	68
136399	2020-10-22	64	14	68
136400	2020-10-23	83	13	68
136401	2020-10-24	83	13	68
136402	2020-10-25	83	13	68
136403	2020-10-26	83	13	68
136404	2020-10-27	83	13	68
136405	2020-10-28	83	13	68
136406	2020-10-29	63	14	68
136407	2020-10-30	83	13	68
136408	2020-10-31	83	13	68
136409	2020-10-01	83	13	80
136410	2020-10-02	83	13	80
136411	2020-10-03	83	13	80
136412	2020-10-04	83	13	80
136413	2020-10-05	64	14	80
136414	2020-10-06	63	14	80
136415	2020-10-07	83	13	80
136416	2020-10-08	83	13	80
136417	2020-10-09	83	13	80
136418	2020-10-10	83	13	80
136419	2020-10-11	83	13	80
136420	2020-10-12	83	13	80
136421	2020-10-13	64	14	80
136422	2020-10-14	83	13	80
136423	2020-10-15	83	13	80
136424	2020-10-16	63	14	80
136425	2020-10-17	63	14	80
136426	2020-10-18	83	13	80
136427	2020-10-19	83	13	80
136428	2020-10-20	83	13	80
136429	2020-10-21	83	13	80
136430	2020-10-22	83	13	80
136431	2020-10-23	64	14	80
136432	2020-10-24	63	14	80
136433	2020-10-25	63	14	80
136434	2020-10-26	83	13	80
136435	2020-10-27	83	13	80
136436	2020-10-28	83	13	80
136437	2020-10-29	83	13	80
136438	2020-10-30	64	14	80
136439	2020-10-31	83	13	80
136440	2020-10-01	83	13	60
136441	2020-10-02	83	13	60
136442	2020-10-03	64	14	60
136443	2020-10-04	83	13	60
136444	2020-10-05	83	13	60
136445	2020-10-06	83	13	60
136446	2020-10-07	83	13	60
136447	2020-10-08	83	13	60
136448	2020-10-09	64	14	60
136449	2020-10-10	83	13	60
136450	2020-10-11	83	13	60
136451	2020-10-12	63	14	60
136452	2020-10-13	83	13	60
136453	2020-10-14	83	13	60
136454	2020-10-15	64	14	60
136455	2020-10-16	83	13	60
136456	2020-10-17	83	13	60
136457	2020-10-18	83	13	60
136458	2020-10-19	63	14	60
136459	2020-10-20	83	13	60
136460	2020-10-21	83	13	60
136461	2020-10-22	83	13	60
136462	2020-10-23	83	13	60
136463	2020-10-24	83	13	60
136464	2020-10-25	83	13	60
136465	2020-10-26	64	14	60
136466	2020-10-27	63	14	60
136467	2020-10-28	63	14	60
136468	2020-10-29	83	13	60
136469	2020-10-30	83	13	60
136470	2020-10-31	63	14	60
136471	2020-10-01	63	14	53
136472	2020-10-02	83	13	53
136473	2020-10-03	83	13	53
136474	2020-10-04	83	13	53
136475	2020-10-05	64	14	53
136476	2020-10-06	83	13	53
136477	2020-10-07	83	13	53
136478	2020-10-08	83	13	53
136479	2020-10-09	83	13	53
136480	2020-10-10	83	13	53
136481	2020-10-11	83	13	53
136482	2020-10-12	64	14	53
136483	2020-10-13	83	13	53
136484	2020-10-14	83	13	53
136485	2020-10-15	83	13	53
136486	2020-10-16	63	14	53
136487	2020-10-17	83	13	53
136488	2020-10-18	83	13	53
136489	2020-10-19	64	14	53
136490	2020-10-20	83	13	53
136491	2020-10-21	83	13	53
136492	2020-10-22	63	14	53
136493	2020-10-23	63	14	53
136494	2020-10-24	83	13	53
136495	2020-10-25	83	13	53
136496	2020-10-26	83	13	53
136497	2020-10-27	83	13	53
136498	2020-10-28	64	14	53
136499	2020-10-29	83	13	53
136500	2020-10-30	83	13	53
136501	2020-10-31	63	14	53
136502	2020-10-01	83	13	54
136503	2020-10-02	64	14	54
136504	2020-10-03	83	13	54
136505	2020-10-04	83	13	54
136506	2020-10-05	63	14	54
136507	2020-10-06	83	13	54
136508	2020-10-07	83	13	54
136509	2020-10-08	64	14	54
136510	2020-10-09	63	14	54
136511	2020-10-10	83	13	54
136512	2020-10-11	83	13	54
136513	2020-10-12	83	13	54
136514	2020-10-13	83	13	54
136515	2020-10-14	64	14	54
136516	2020-10-15	63	14	54
136517	2020-10-16	83	13	54
136518	2020-10-17	83	13	54
136519	2020-10-18	83	13	54
136520	2020-10-19	83	13	54
136521	2020-10-20	83	13	54
136522	2020-10-21	64	14	54
136523	2020-10-22	63	14	54
136524	2020-10-23	83	13	54
136525	2020-10-24	83	13	54
136526	2020-10-25	83	13	54
136527	2020-10-26	83	13	54
136528	2020-10-27	83	13	54
136529	2020-10-28	83	13	54
136530	2020-10-29	63	14	54
136531	2020-10-30	83	13	54
136532	2020-10-31	83	13	54
136533	2020-10-01	83	13	49
136534	2020-10-02	83	13	49
136535	2020-10-03	64	14	49
136536	2020-10-04	63	14	49
136537	2020-10-05	83	13	49
136538	2020-10-06	83	13	49
136539	2020-10-07	63	14	49
136540	2020-10-08	83	13	49
136541	2020-10-09	83	13	49
136542	2020-10-10	64	14	49
136543	2020-10-11	83	13	49
136544	2020-10-12	83	13	49
136545	2020-10-13	83	13	49
136546	2020-10-14	83	13	49
136547	2020-10-15	63	14	49
136548	2020-10-16	83	13	49
136549	2020-10-17	83	13	49
136550	2020-10-18	83	13	49
136551	2020-10-19	83	13	49
136552	2020-10-20	64	14	49
136553	2020-10-21	83	13	49
136554	2020-10-22	83	13	49
136555	2020-10-23	83	13	49
136556	2020-10-24	83	13	49
136557	2020-10-25	83	13	49
136558	2020-10-26	64	14	49
136559	2020-10-27	63	14	49
136560	2020-10-28	83	13	49
136561	2020-10-29	83	13	49
136562	2020-10-30	63	14	49
136563	2020-10-31	83	13	49
136564	2020-10-01	83	13	50
136565	2020-10-02	63	14	50
136566	2020-10-03	83	13	50
136567	2020-10-04	83	13	50
136568	2020-10-05	83	13	50
136569	2020-10-06	64	14	50
136570	2020-10-07	83	13	50
136571	2020-10-08	83	13	50
136572	2020-10-09	63	14	50
136573	2020-10-10	83	13	50
136574	2020-10-11	83	13	50
136575	2020-10-12	64	14	50
136576	2020-10-13	63	14	50
136577	2020-10-14	83	13	50
136578	2020-10-15	83	13	50
136579	2020-10-16	83	13	50
136580	2020-10-17	83	13	50
136581	2020-10-18	83	13	50
136582	2020-10-19	83	13	50
136583	2020-10-20	64	14	50
136584	2020-10-21	63	14	50
136585	2020-10-22	83	13	50
136586	2020-10-23	83	13	50
136587	2020-10-24	83	13	50
136588	2020-10-25	83	13	50
136589	2020-10-26	64	14	50
136590	2020-10-27	83	13	50
136591	2020-10-28	83	13	50
136592	2020-10-29	83	13	50
136593	2020-10-30	63	14	50
136594	2020-10-31	83	13	50
136595	2020-10-01	82	16	43
136596	2020-10-02	82	16	43
136597	2020-10-03	63	14	43
136598	2020-10-04	64	14	43
136599	2020-10-05	82	16	43
136600	2020-10-06	82	16	43
136601	2020-10-07	82	16	43
136602	2020-10-08	82	16	43
136603	2020-10-09	82	16	43
136604	2020-10-10	63	14	43
136605	2020-10-11	64	14	43
136606	2020-10-12	82	16	43
136607	2020-10-13	82	16	43
136608	2020-10-14	82	16	43
136609	2020-10-15	82	16	43
136610	2020-10-16	82	16	43
136611	2020-10-17	63	14	43
136612	2020-10-18	64	14	43
136613	2020-10-19	82	16	43
136614	2020-10-20	82	16	43
136615	2020-10-21	82	16	43
136616	2020-10-22	82	16	43
136617	2020-10-23	82	16	43
136618	2020-10-24	63	14	43
136619	2020-10-25	64	14	43
136620	2020-10-26	82	16	43
136621	2020-10-27	82	16	43
136622	2020-10-28	82	16	43
136623	2020-10-29	82	16	43
136624	2020-10-30	82	16	43
136625	2020-10-31	63	14	43
136626	2020-10-01	82	16	44
136627	2020-10-02	82	16	44
136628	2020-10-03	63	14	44
136629	2020-10-04	64	14	44
136630	2020-10-05	82	16	44
136631	2020-10-06	82	16	44
136632	2020-10-07	82	16	44
136633	2020-10-08	82	16	44
136634	2020-10-09	82	16	44
136635	2020-10-10	63	14	44
136636	2020-10-11	64	14	44
136637	2020-10-12	82	16	44
136638	2020-10-13	82	16	44
136639	2020-10-14	82	16	44
136640	2020-10-15	82	16	44
136641	2020-10-16	82	16	44
136642	2020-10-17	63	14	44
136643	2020-10-18	64	14	44
136644	2020-10-19	82	16	44
136645	2020-10-20	82	16	44
136646	2020-10-21	82	16	44
136647	2020-10-22	82	16	44
136648	2020-10-23	82	16	44
136649	2020-10-24	63	14	44
136650	2020-10-25	64	14	44
136651	2020-10-26	82	16	44
136652	2020-10-27	82	16	44
136653	2020-10-28	82	16	44
136654	2020-10-29	82	16	44
136655	2020-10-30	82	16	44
136656	2020-10-31	63	14	44
\.


--
-- Data for Name: result_result; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.result_result (id, date, shift_id, station_id, user_id) FROM stdin;
7924	2020-09-01	64	14	47
7925	2020-09-02	63	14	47
7926	2020-09-03	80	13	47
7927	2020-09-04	80	13	47
7928	2020-09-05	80	13	47
7929	2020-09-06	80	13	47
7930	2020-09-07	80	13	47
7931	2020-09-08	80	13	47
7932	2020-09-09	64	14	47
7933	2020-09-10	80	13	47
7934	2020-09-11	80	13	47
7935	2020-09-12	80	13	47
7936	2020-09-13	80	13	47
7937	2020-09-14	80	13	47
7938	2020-09-15	64	14	47
7939	2020-09-16	63	14	47
7940	2020-09-17	80	13	47
7941	2020-09-18	80	13	47
7942	2020-09-19	80	13	47
7943	2020-09-20	63	14	47
7944	2020-09-21	80	13	47
7945	2020-09-22	80	13	47
7946	2020-09-23	80	13	47
7947	2020-09-24	80	13	47
7948	2020-09-25	80	13	47
7949	2020-09-26	80	13	47
7950	2020-09-27	64	14	47
7951	2020-09-28	84	14	47
7952	2020-09-29	63	14	47
7953	2020-09-30	80	13	47
7954	2020-09-01	80	13	69
7955	2020-09-02	80	13	69
7956	2020-09-03	80	13	69
7957	2020-09-04	64	14	69
7958	2020-09-05	84	14	69
7959	2020-09-06	63	14	69
7960	2020-09-07	63	14	69
7961	2020-09-08	63	14	69
7962	2020-09-09	80	13	69
7963	2020-09-10	80	13	69
7964	2020-09-11	80	13	69
7965	2020-09-12	80	13	69
7966	2020-09-13	80	13	69
7967	2020-09-14	64	14	69
7968	2020-09-15	80	13	69
7969	2020-09-16	80	13	69
7970	2020-09-17	80	13	69
7971	2020-09-18	80	13	69
7972	2020-09-19	80	13	69
7973	2020-09-20	80	13	69
7974	2020-09-21	64	14	69
7975	2020-09-22	80	13	69
7976	2020-09-23	80	13	69
7977	2020-09-24	63	14	69
7978	2020-09-25	80	13	69
7979	2020-09-26	80	13	69
7980	2020-09-27	80	13	69
7981	2020-09-28	80	13	69
7982	2020-09-29	64	14	69
7983	2020-09-30	80	13	69
7984	2020-09-01	80	13	46
7985	2020-09-02	80	13	46
7986	2020-09-03	64	14	46
7987	2020-09-04	80	13	46
7988	2020-09-05	80	13	46
7989	2020-09-06	63	14	46
7990	2020-09-07	80	13	46
7991	2020-09-08	80	13	46
7992	2020-09-09	80	13	46
7993	2020-09-10	64	14	46
7994	2020-09-11	63	14	46
7995	2020-09-12	63	14	46
7996	2020-09-13	63	14	46
7997	2020-09-14	80	13	46
7998	2020-09-15	80	13	46
7999	2020-09-16	80	13	46
8000	2020-09-17	80	13	46
8001	2020-09-18	80	13	46
8002	2020-09-19	64	14	46
8003	2020-09-20	84	14	46
8004	2020-09-21	80	13	46
8005	2020-09-22	80	13	46
8006	2020-09-23	65	15	46
8007	2020-09-24	80	13	46
8008	2020-09-25	80	13	46
8009	2020-09-26	80	13	46
8010	2020-09-27	64	14	46
8011	2020-09-28	80	13	46
8012	2020-09-29	80	13	46
8013	2020-09-30	80	13	46
8014	2020-09-01	80	13	60
8015	2020-09-02	64	14	60
8016	2020-09-03	80	13	60
8017	2020-09-04	80	13	60
8018	2020-09-05	80	13	60
8019	2020-09-06	80	13	60
8020	2020-09-07	80	13	60
8021	2020-09-08	80	13	60
8022	2020-09-09	64	14	60
8023	2020-09-10	80	13	60
8024	2020-09-11	80	13	60
8025	2020-09-12	63	14	60
8026	2020-09-13	80	13	60
8027	2020-09-14	80	13	60
8028	2020-09-15	80	13	60
8029	2020-09-16	80	13	60
8030	2020-09-17	64	14	60
8031	2020-09-18	84	14	60
8032	2020-09-19	80	13	60
8033	2020-09-20	80	13	60
8034	2020-09-21	80	13	60
8035	2020-09-22	63	14	60
8036	2020-09-23	80	13	60
8037	2020-09-24	80	13	60
8038	2020-09-25	64	14	60
8039	2020-09-26	63	14	60
8040	2020-09-27	80	13	60
8041	2020-09-28	80	13	60
8042	2020-09-29	80	13	60
8043	2020-09-30	63	14	60
8044	2020-09-01	64	14	64
8045	2020-09-02	63	14	64
8046	2020-09-03	80	13	64
8047	2020-09-04	80	13	64
8048	2020-09-05	84	14	64
8049	2020-09-06	63	14	64
8050	2020-09-07	80	13	64
8051	2020-09-08	80	13	64
8052	2020-09-09	80	13	64
8053	2020-09-10	80	13	64
8054	2020-09-11	80	13	64
8055	2020-09-12	80	13	64
8056	2020-09-13	64	14	64
8057	2020-09-14	80	13	64
8058	2020-09-15	80	13	64
8059	2020-09-16	80	13	64
8060	2020-09-17	80	13	64
8061	2020-09-18	80	13	64
8062	2020-09-19	80	13	64
8063	2020-09-20	64	14	64
8064	2020-09-21	63	14	64
8065	2020-09-22	63	14	64
8066	2020-09-23	80	13	64
8067	2020-09-24	80	13	64
8068	2020-09-25	80	13	64
8069	2020-09-26	64	14	64
8070	2020-09-27	80	13	64
8071	2020-09-28	80	13	64
8072	2020-09-29	80	13	64
8073	2020-09-30	80	13	64
8074	2020-09-01	80	13	65
8075	2020-09-02	80	13	65
8076	2020-09-03	80	13	65
8077	2020-09-04	80	13	65
8078	2020-09-05	80	13	65
8079	2020-09-06	64	14	65
8080	2020-09-07	63	14	65
8081	2020-09-08	63	14	65
8082	2020-09-09	80	13	65
8083	2020-09-10	80	13	65
8084	2020-09-11	63	14	65
8085	2020-09-12	64	14	65
8086	2020-09-13	80	13	65
8087	2020-09-14	80	13	65
8088	2020-09-15	80	13	65
8089	2020-09-16	80	13	65
8090	2020-09-17	63	14	65
8091	2020-09-18	80	13	65
8092	2020-09-19	80	13	65
8093	2020-09-20	80	13	65
8094	2020-09-21	80	13	65
8095	2020-09-22	80	13	65
8096	2020-09-23	80	13	65
8097	2020-09-24	64	14	65
8098	2020-09-25	80	13	65
8099	2020-09-26	80	13	65
8100	2020-09-27	84	14	65
8101	2020-09-28	64	14	65
8102	2020-09-29	80	13	65
8103	2020-09-30	80	13	65
8104	2020-09-01	80	13	51
8105	2020-09-02	80	13	51
8106	2020-09-03	80	13	51
8107	2020-09-04	64	14	51
8108	2020-09-05	80	13	51
8109	2020-09-06	63	14	51
8110	2020-09-07	80	13	51
8111	2020-09-08	80	13	51
8112	2020-09-09	63	14	51
8113	2020-09-10	64	14	51
8114	2020-09-11	63	14	51
8115	2020-09-12	80	13	51
8116	2020-09-13	80	13	51
8117	2020-09-14	80	13	51
8118	2020-09-15	80	13	51
8119	2020-09-16	64	14	51
8120	2020-09-17	63	14	51
8121	2020-09-18	80	13	51
8122	2020-09-19	80	13	51
8123	2020-09-20	80	13	51
8124	2020-09-21	80	13	51
8125	2020-09-22	80	13	51
8126	2020-09-23	80	13	51
8127	2020-09-24	64	14	51
8128	2020-09-25	80	13	51
8129	2020-09-26	80	13	51
8130	2020-09-27	80	13	51
8131	2020-09-28	80	13	51
8132	2020-09-29	84	14	51
8133	2020-09-30	80	13	51
8134	2020-09-01	80	13	57
8135	2020-09-02	80	13	57
8136	2020-09-03	64	14	57
8137	2020-09-04	80	13	57
8138	2020-09-05	80	13	57
8139	2020-09-06	63	14	57
8140	2020-09-07	80	13	57
8141	2020-09-08	80	13	57
8142	2020-09-09	64	14	57
8143	2020-09-10	80	13	57
8144	2020-09-11	80	13	57
8145	2020-09-12	63	14	57
8146	2020-09-13	80	13	57
8147	2020-09-14	80	13	57
8148	2020-09-15	64	14	57
8149	2020-09-16	80	13	57
8150	2020-09-17	80	13	57
8151	2020-09-18	63	14	57
8152	2020-09-19	80	13	57
8153	2020-09-20	80	13	57
8154	2020-09-21	80	13	57
8155	2020-09-22	80	13	57
8156	2020-09-23	80	13	57
8157	2020-09-24	80	13	57
8158	2020-09-25	64	14	57
8159	2020-09-26	80	13	57
8160	2020-09-27	80	13	57
8161	2020-09-28	80	13	57
8162	2020-09-29	84	14	57
8163	2020-09-30	63	14	57
8164	2020-09-01	80	13	71
8165	2020-09-02	80	13	71
8166	2020-09-03	64	14	71
8167	2020-09-04	80	13	71
8168	2020-09-05	80	13	71
8169	2020-09-06	63	14	71
8170	2020-09-07	80	13	71
8171	2020-09-08	80	13	71
8172	2020-09-09	80	13	71
8173	2020-09-10	64	14	71
8174	2020-09-11	84	14	71
8175	2020-09-12	80	13	71
8176	2020-09-13	80	13	71
8177	2020-09-14	63	14	71
8178	2020-09-15	80	13	71
8179	2020-09-16	80	13	71
8180	2020-09-17	80	13	71
8181	2020-09-18	64	14	71
8182	2020-09-19	80	13	71
8183	2020-09-20	80	13	71
8184	2020-09-21	80	13	71
8185	2020-09-22	80	13	71
8186	2020-09-23	63	14	71
8187	2020-09-24	80	13	71
8188	2020-09-25	80	13	71
8189	2020-09-26	80	13	71
8190	2020-09-27	64	14	71
8191	2020-09-28	63	14	71
8192	2020-09-29	80	13	71
8193	2020-09-30	80	13	71
8194	2020-09-01	80	13	78
8195	2020-09-02	80	13	78
8196	2020-09-03	64	14	78
8197	2020-09-04	63	14	78
8198	2020-09-05	63	14	78
8199	2020-09-06	63	14	78
8200	2020-09-07	80	13	78
8201	2020-09-08	80	13	78
8202	2020-09-09	80	13	78
8203	2020-09-10	80	13	78
8204	2020-09-11	80	13	78
8205	2020-09-12	64	14	78
8206	2020-09-13	84	14	78
8207	2020-09-14	80	13	78
8208	2020-09-15	80	13	78
8209	2020-09-16	80	13	78
8210	2020-09-17	80	13	78
8211	2020-09-18	80	13	78
8212	2020-09-19	64	14	78
8213	2020-09-20	80	13	78
8214	2020-09-21	80	13	78
8215	2020-09-22	63	14	78
8216	2020-09-23	80	13	78
8217	2020-09-24	80	13	78
8218	2020-09-25	64	14	78
8219	2020-09-26	80	13	78
8220	2020-09-27	80	13	78
8221	2020-09-28	80	13	78
8222	2020-09-29	80	13	78
8223	2020-09-30	80	13	78
8224	2020-09-01	64	14	79
8225	2020-09-02	63	14	79
8226	2020-09-03	80	13	79
8227	2020-09-04	80	13	79
8228	2020-09-05	84	14	79
8229	2020-09-06	63	14	79
8230	2020-09-07	64	14	79
8231	2020-09-08	63	14	79
8232	2020-09-09	80	13	79
8233	2020-09-10	80	13	79
8234	2020-09-11	80	13	79
8235	2020-09-12	80	13	79
8236	2020-09-13	80	13	79
8237	2020-09-14	80	13	79
8238	2020-09-15	64	14	79
8239	2020-09-16	80	13	79
8240	2020-09-17	80	13	79
8241	2020-09-18	80	13	79
8242	2020-09-19	63	14	79
8243	2020-09-20	80	13	79
8244	2020-09-21	80	13	79
8245	2020-09-22	80	13	79
8246	2020-09-23	80	13	79
8247	2020-09-24	80	13	79
8248	2020-09-25	80	13	79
8249	2020-09-26	64	14	79
8250	2020-09-27	80	13	79
8251	2020-09-28	80	13	79
8252	2020-09-29	80	13	79
8253	2020-09-30	80	13	79
8254	2020-09-01	64	14	56
8255	2020-09-02	81	13	56
8256	2020-09-03	81	13	56
8257	2020-09-04	63	14	56
8258	2020-09-05	81	13	56
8259	2020-09-06	63	14	56
8260	2020-09-07	81	13	56
8261	2020-09-08	81	13	56
8262	2020-09-09	81	13	56
8263	2020-09-10	64	14	56
8264	2020-09-11	81	13	56
8265	2020-09-12	81	13	56
8266	2020-09-13	63	14	56
8267	2020-09-14	81	13	56
8268	2020-09-15	81	13	56
8269	2020-09-16	81	13	56
8270	2020-09-17	64	14	56
8271	2020-09-18	84	14	56
8272	2020-09-19	81	13	56
8273	2020-09-20	81	13	56
8274	2020-09-21	81	13	56
8275	2020-09-22	81	13	56
8276	2020-09-23	81	13	56
8277	2020-09-24	81	13	56
8278	2020-09-25	64	14	56
8279	2020-09-26	81	13	56
8280	2020-09-27	81	13	56
8281	2020-09-28	81	13	56
8282	2020-09-29	81	13	56
8283	2020-09-30	63	14	56
8284	2020-09-01	81	13	62
8285	2020-09-02	81	13	62
8286	2020-09-03	64	14	62
8287	2020-09-04	81	13	62
8288	2020-09-05	81	13	62
8289	2020-09-06	63	14	62
8290	2020-09-07	81	13	62
8291	2020-09-08	63	14	62
8292	2020-09-09	81	13	62
8293	2020-09-10	81	13	62
8294	2020-09-11	81	13	62
8295	2020-09-12	81	13	62
8296	2020-09-13	81	13	62
8297	2020-09-14	81	13	62
8298	2020-09-15	64	14	62
8299	2020-09-16	63	14	62
8300	2020-09-17	81	13	62
8301	2020-09-18	81	13	62
8302	2020-09-19	63	14	62
8303	2020-09-20	84	14	62
8304	2020-09-21	81	13	62
8305	2020-09-22	81	13	62
8306	2020-09-23	81	13	62
8307	2020-09-24	64	14	62
8308	2020-09-25	81	13	62
8309	2020-09-26	81	13	62
8310	2020-09-27	81	13	62
8311	2020-09-28	81	13	62
8312	2020-09-29	64	14	62
8313	2020-09-30	81	13	62
8314	2020-09-01	81	13	63
8315	2020-09-02	81	13	63
8316	2020-09-03	64	14	63
8317	2020-09-04	81	13	63
8318	2020-09-05	81	13	63
8319	2020-09-06	84	14	63
8320	2020-09-07	81	13	63
8321	2020-09-08	81	13	63
8322	2020-09-09	81	13	63
8323	2020-09-10	81	13	63
8324	2020-09-11	64	14	63
8325	2020-09-12	63	14	63
8326	2020-09-13	63	14	63
8327	2020-09-14	81	13	63
8328	2020-09-15	81	13	63
8329	2020-09-16	81	13	63
8330	2020-09-17	81	13	63
8331	2020-09-18	64	14	63
8332	2020-09-19	81	13	63
8333	2020-09-20	81	13	63
8334	2020-09-21	81	13	63
8335	2020-09-22	81	13	63
8336	2020-09-23	63	14	63
8337	2020-09-24	81	13	63
8338	2020-09-25	81	13	63
8339	2020-09-26	81	13	63
8340	2020-09-27	81	13	63
8341	2020-09-28	81	13	63
8342	2020-09-29	64	14	63
8343	2020-09-30	63	14	63
8344	2020-09-01	81	13	67
8345	2020-09-02	81	13	67
8346	2020-09-03	64	14	67
8347	2020-09-04	63	14	67
8348	2020-09-05	81	13	67
8349	2020-09-06	84	14	67
8350	2020-09-07	63	14	67
8351	2020-09-08	63	14	67
8352	2020-09-09	64	14	67
8353	2020-09-10	81	13	67
8354	2020-09-11	81	13	67
8355	2020-09-12	81	13	67
8356	2020-09-13	81	13	67
8357	2020-09-14	63	14	67
8358	2020-09-15	81	13	67
8359	2020-09-16	81	13	67
8360	2020-09-17	81	13	67
8361	2020-09-18	81	13	67
8362	2020-09-19	81	13	67
8363	2020-09-20	81	13	67
8364	2020-09-21	64	14	67
8365	2020-09-22	81	13	67
8366	2020-09-23	81	13	67
8367	2020-09-24	81	13	67
8368	2020-09-25	81	13	67
8369	2020-09-26	81	13	67
8370	2020-09-27	64	14	67
8371	2020-09-28	81	13	67
8372	2020-09-29	81	13	67
8373	2020-09-30	81	13	67
8374	2020-09-01	64	14	73
8375	2020-09-02	63	14	73
8376	2020-09-03	81	13	73
8377	2020-09-04	81	13	73
8378	2020-09-05	81	13	73
8379	2020-09-06	84	14	73
8380	2020-09-07	64	14	73
8381	2020-09-08	63	14	73
8382	2020-09-09	63	14	73
8383	2020-09-10	63	14	73
8384	2020-09-11	81	13	73
8385	2020-09-12	81	13	73
8386	2020-09-13	81	13	73
8387	2020-09-14	81	13	73
8388	2020-09-15	81	13	73
8389	2020-09-16	81	13	73
8390	2020-09-17	64	14	73
8391	2020-09-18	81	13	73
8392	2020-09-19	81	13	73
8393	2020-09-20	81	13	73
8394	2020-09-21	81	13	73
8395	2020-09-22	81	13	73
8396	2020-09-23	81	13	73
8397	2020-09-24	64	14	73
8398	2020-09-25	81	13	73
8399	2020-09-26	81	13	73
8400	2020-09-27	81	13	73
8401	2020-09-28	81	13	73
8402	2020-09-29	81	13	73
8403	2020-09-30	81	13	73
8404	2020-09-01	81	13	66
8405	2020-09-02	81	13	66
8406	2020-09-03	81	13	66
8407	2020-09-04	64	14	66
8408	2020-09-05	63	14	66
8409	2020-09-06	63	14	66
8410	2020-09-07	81	13	66
8411	2020-09-08	81	13	66
8412	2020-09-09	81	13	66
8413	2020-09-10	64	14	66
8414	2020-09-11	63	14	66
8415	2020-09-12	63	14	66
8416	2020-09-13	81	13	66
8417	2020-09-14	81	13	66
8418	2020-09-15	84	14	66
8419	2020-09-16	81	13	66
8420	2020-09-17	81	13	66
8421	2020-09-18	81	13	66
8422	2020-09-19	81	13	66
8423	2020-09-20	81	13	66
8424	2020-09-21	81	13	66
8425	2020-09-22	64	14	66
8426	2020-09-23	81	13	66
8427	2020-09-24	81	13	66
8428	2020-09-25	64	14	66
8429	2020-09-26	81	13	66
8430	2020-09-27	81	13	66
8431	2020-09-28	81	13	66
8432	2020-09-29	81	13	66
8433	2020-09-30	81	13	66
8434	2020-09-01	64	14	55
8435	2020-09-02	63	14	55
8436	2020-09-03	81	13	55
8437	2020-09-04	81	13	55
8438	2020-09-05	63	14	55
8439	2020-09-06	63	14	55
8440	2020-09-07	81	13	55
8441	2020-09-08	81	13	55
8442	2020-09-09	81	13	55
8443	2020-09-10	81	13	55
8444	2020-09-11	81	13	55
8445	2020-09-12	81	13	55
8446	2020-09-13	64	14	55
8447	2020-09-14	81	13	55
8448	2020-09-15	81	13	55
8449	2020-09-16	81	13	55
8450	2020-09-17	81	13	55
8451	2020-09-18	81	13	55
8452	2020-09-19	64	14	55
8453	2020-09-20	84	14	55
8454	2020-09-21	81	13	55
8455	2020-09-22	81	13	55
8456	2020-09-23	81	13	55
8457	2020-09-24	81	13	55
8458	2020-09-25	81	13	55
8459	2020-09-26	64	14	55
8460	2020-09-27	81	13	55
8461	2020-09-28	63	14	55
8462	2020-09-29	81	13	55
8463	2020-09-30	81	13	55
8464	2020-09-01	83	13	45
8465	2020-09-02	83	13	45
8466	2020-09-03	64	14	45
8467	2020-09-04	63	14	45
8468	2020-09-05	83	13	45
8469	2020-09-06	63	14	45
8470	2020-09-07	83	13	45
8471	2020-09-08	83	13	45
8472	2020-09-09	83	13	45
8473	2020-09-10	83	13	45
8474	2020-09-11	64	14	45
8475	2020-09-12	83	13	45
8476	2020-09-13	83	13	45
8477	2020-09-14	83	13	45
8478	2020-09-15	63	14	45
8479	2020-09-16	84	14	45
8480	2020-09-17	83	13	45
8481	2020-09-18	83	13	45
8482	2020-09-19	83	13	45
8483	2020-09-20	64	14	45
8484	2020-09-21	63	14	45
8485	2020-09-22	65	15	45
8486	2020-09-23	83	13	45
8487	2020-09-24	83	13	45
8488	2020-09-25	83	13	45
8489	2020-09-26	64	14	45
8490	2020-09-27	83	13	45
8491	2020-09-28	83	13	45
8492	2020-09-29	67	14	45
8493	2020-09-30	72	14	45
8494	2020-09-01	64	14	68
8495	2020-09-02	83	13	68
8496	2020-09-03	83	13	68
8497	2020-09-04	83	13	68
8498	2020-09-05	83	13	68
8499	2020-09-06	63	14	68
8500	2020-09-07	83	13	68
8501	2020-09-08	64	14	68
8502	2020-09-09	83	13	68
8503	2020-09-10	83	13	68
8504	2020-09-11	83	13	68
8505	2020-09-12	63	14	68
8506	2020-09-13	83	13	68
8507	2020-09-14	83	13	68
8508	2020-09-15	83	13	68
8509	2020-09-16	83	13	68
8510	2020-09-17	64	14	68
8511	2020-09-18	84	14	68
8512	2020-09-19	83	13	68
8513	2020-09-20	83	13	68
8514	2020-09-21	83	13	68
8515	2020-09-22	83	13	68
8516	2020-09-23	64	14	68
8517	2020-09-24	83	13	68
8518	2020-09-25	83	13	68
8519	2020-09-26	83	13	68
8520	2020-09-27	63	14	68
8521	2020-09-28	63	14	68
8522	2020-09-29	83	13	68
8523	2020-09-30	83	13	68
8524	2020-09-01	64	14	53
8525	2020-09-02	63	14	53
8526	2020-09-03	83	13	53
8527	2020-09-04	83	13	53
8528	2020-09-05	83	13	53
8529	2020-09-06	84	14	53
8530	2020-09-07	83	13	53
8531	2020-09-08	83	13	53
8532	2020-09-09	83	13	53
8533	2020-09-10	64	14	53
8534	2020-09-11	63	14	53
8535	2020-09-12	83	13	53
8536	2020-09-13	83	13	53
8537	2020-09-14	83	13	53
8538	2020-09-15	83	13	53
8539	2020-09-16	83	13	53
8540	2020-09-17	83	13	53
8541	2020-09-18	64	14	53
8542	2020-09-19	83	13	53
8543	2020-09-20	63	14	53
8544	2020-09-21	83	13	53
8545	2020-09-22	83	13	53
8546	2020-09-23	63	14	53
8547	2020-09-24	83	13	53
8548	2020-09-25	83	13	53
8549	2020-09-26	64	14	53
8550	2020-09-27	83	13	53
8551	2020-09-28	83	13	53
8552	2020-09-29	83	13	53
8553	2020-09-30	83	13	53
8554	2020-09-01	64	14	54
8555	2020-09-02	63	14	54
8556	2020-09-03	83	13	54
8557	2020-09-04	83	13	54
8558	2020-09-05	84	14	54
8559	2020-09-06	63	14	54
8560	2020-09-07	83	13	54
8561	2020-09-08	83	13	54
8562	2020-09-09	64	14	54
8563	2020-09-10	83	13	54
8564	2020-09-11	83	13	54
8565	2020-09-12	63	14	54
8566	2020-09-13	63	14	54
8567	2020-09-14	83	13	54
8568	2020-09-15	83	13	54
8569	2020-09-16	83	13	54
8570	2020-09-17	83	13	54
8571	2020-09-18	83	13	54
8572	2020-09-19	64	14	54
8573	2020-09-20	83	13	54
8574	2020-09-21	83	13	54
8575	2020-09-22	83	13	54
8576	2020-09-23	83	13	54
8577	2020-09-24	83	13	54
8578	2020-09-25	64	14	54
8579	2020-09-26	83	13	54
8580	2020-09-27	83	13	54
8581	2020-09-28	83	13	54
8582	2020-09-29	83	13	54
8583	2020-09-30	83	13	54
8584	2020-09-01	83	13	49
8585	2020-09-02	83	13	49
8586	2020-09-03	64	14	49
8587	2020-09-04	84	14	49
8588	2020-09-05	83	13	49
8589	2020-09-06	63	14	49
8590	2020-09-07	63	14	49
8591	2020-09-08	63	14	49
8592	2020-09-09	83	13	49
8593	2020-09-10	64	14	49
8594	2020-09-11	83	13	49
8595	2020-09-12	83	13	49
8596	2020-09-13	83	13	49
8597	2020-09-14	83	13	49
8598	2020-09-15	83	13	49
8599	2020-09-16	83	13	49
8600	2020-09-17	64	14	49
8601	2020-09-18	83	13	49
8602	2020-09-19	83	13	49
8603	2020-09-20	83	13	49
8604	2020-09-21	83	13	49
8605	2020-09-22	83	13	49
8606	2020-09-23	83	13	49
8607	2020-09-24	64	14	49
8608	2020-09-25	83	13	49
8609	2020-09-26	83	13	49
8610	2020-09-27	83	13	49
8611	2020-09-28	83	13	49
8612	2020-09-29	83	13	49
8613	2020-09-30	63	14	49
8614	2020-09-01	83	13	50
8615	2020-09-02	83	13	50
8616	2020-09-03	83	13	50
8617	2020-09-04	83	13	50
8618	2020-09-05	64	14	50
8619	2020-09-06	63	14	50
8620	2020-09-07	83	13	50
8621	2020-09-08	84	14	50
8622	2020-09-09	83	13	50
8623	2020-09-10	83	13	50
8624	2020-09-11	64	14	50
8625	2020-09-12	83	13	50
8626	2020-09-13	63	14	50
8627	2020-09-14	63	14	50
8628	2020-09-15	63	14	50
8629	2020-09-16	83	13	50
8630	2020-09-17	83	13	50
8631	2020-09-18	83	13	50
8632	2020-09-19	83	13	50
8633	2020-09-20	83	13	50
8634	2020-09-21	83	13	50
8635	2020-09-22	64	14	50
8636	2020-09-23	83	13	50
8637	2020-09-24	83	13	50
8638	2020-09-25	83	13	50
8639	2020-09-26	83	13	50
8640	2020-09-27	83	13	50
8641	2020-09-28	83	13	50
8642	2020-09-29	64	14	50
8643	2020-09-30	83	13	50
8644	2020-09-01	84	14	43
8645	2020-09-02	82	16	43
8646	2020-09-03	82	16	43
8647	2020-09-04	82	16	43
8648	2020-09-05	63	14	43
8649	2020-09-06	64	14	43
8650	2020-09-07	82	16	43
8651	2020-09-08	82	16	43
8652	2020-09-09	82	16	43
8653	2020-09-10	82	16	43
8654	2020-09-11	82	16	43
8655	2020-09-12	63	14	43
8656	2020-09-13	64	14	43
8657	2020-09-14	82	16	43
8658	2020-09-15	82	16	43
8659	2020-09-16	82	16	43
8660	2020-09-17	82	16	43
8661	2020-09-18	82	16	43
8662	2020-09-19	63	14	43
8663	2020-09-20	64	14	43
8664	2020-09-21	82	16	43
8665	2020-09-22	82	16	43
8666	2020-09-23	82	16	43
8667	2020-09-24	82	16	43
8668	2020-09-25	82	16	43
8669	2020-09-26	63	14	43
8670	2020-09-27	64	14	43
8671	2020-09-28	82	16	43
8672	2020-09-29	82	16	43
8673	2020-09-30	82	16	43
8674	2020-09-01	84	14	44
8675	2020-09-02	82	16	44
8676	2020-09-03	82	16	44
8677	2020-09-04	82	16	44
8678	2020-09-05	63	14	44
8679	2020-09-06	64	14	44
8680	2020-09-07	82	16	44
8681	2020-09-08	82	16	44
8682	2020-09-09	82	16	44
8683	2020-09-10	82	16	44
8684	2020-09-11	82	16	44
8685	2020-09-12	63	14	44
8686	2020-09-13	64	14	44
8687	2020-09-14	82	16	44
8688	2020-09-15	82	16	44
8689	2020-09-16	82	16	44
8690	2020-09-17	82	16	44
8691	2020-09-18	82	16	44
8692	2020-09-19	63	14	44
8693	2020-09-20	64	14	44
8694	2020-09-21	82	16	44
8695	2020-09-22	82	16	44
8696	2020-09-23	82	16	44
8697	2020-09-24	82	16	44
8698	2020-09-25	82	16	44
8699	2020-09-26	63	14	44
8700	2020-09-27	64	14	44
8701	2020-09-28	82	16	44
8702	2020-09-29	82	16	44
8703	2020-09-30	82	16	44
8704	2020-11-01	80	13	47
8705	2020-11-02	80	13	47
8706	2020-11-03	64	14	47
8707	2020-11-04	80	13	47
8708	2020-11-05	80	13	47
8709	2020-11-06	80	13	47
8710	2020-11-07	80	13	47
8711	2020-11-08	80	13	47
8712	2020-11-09	64	14	47
8713	2020-11-10	63	14	47
8714	2020-11-11	80	13	47
8715	2020-11-12	80	13	47
8716	2020-11-13	80	13	47
8717	2020-11-14	80	13	47
8718	2020-11-15	64	14	47
8719	2020-11-16	63	14	47
8720	2020-11-17	63	14	47
8721	2020-11-18	63	14	47
8722	2020-11-19	80	13	47
8723	2020-11-20	80	13	47
8724	2020-11-21	80	13	47
8725	2020-11-22	80	13	47
8726	2020-11-23	64	14	47
8727	2020-11-24	80	13	47
8728	2020-11-25	80	13	47
8729	2020-11-26	80	13	47
8730	2020-11-27	80	13	47
8731	2020-11-28	64	14	47
8732	2020-11-29	80	13	47
8733	2020-11-30	80	13	47
8734	2020-11-01	80	13	69
8735	2020-11-02	80	13	69
8736	2020-11-03	80	13	69
8737	2020-11-04	64	14	69
8738	2020-11-05	80	13	69
8739	2020-11-06	63	14	69
8740	2020-11-07	63	14	69
8741	2020-11-08	63	14	69
8742	2020-11-09	80	13	69
8743	2020-11-10	80	13	69
8744	2020-11-11	80	13	69
8745	2020-11-12	80	13	69
8746	2020-11-13	80	13	69
8747	2020-11-14	64	14	69
8748	2020-11-15	80	13	69
8749	2020-11-16	80	13	69
8750	2020-11-17	80	13	69
8751	2020-11-18	80	13	69
8752	2020-11-19	80	13	69
8753	2020-11-20	80	13	69
8754	2020-11-21	64	14	69
8755	2020-11-22	80	13	69
8756	2020-11-23	80	13	69
8757	2020-11-24	80	13	69
8758	2020-11-25	80	13	69
8759	2020-11-26	63	14	69
8760	2020-11-27	64	14	69
8761	2020-11-28	80	13	69
8762	2020-11-29	80	13	69
8763	2020-11-30	64	14	69
8764	2020-11-01	67	14	46
8765	2020-11-02	64	14	46
8766	2020-11-03	80	13	46
8767	2020-11-04	80	13	46
8768	2020-11-05	63	14	46
8769	2020-11-06	63	14	46
8770	2020-11-07	80	13	46
8771	2020-11-08	80	13	46
8772	2020-11-09	80	13	46
8773	2020-11-10	80	13	46
8774	2020-11-11	80	13	46
8775	2020-11-12	64	14	46
8776	2020-11-13	63	14	46
8777	2020-11-14	63	14	46
8778	2020-11-15	80	13	46
8779	2020-11-16	80	13	46
8780	2020-11-17	80	13	46
8781	2020-11-18	80	13	46
8782	2020-11-19	64	14	46
8783	2020-11-20	64	14	46
8784	2020-11-21	80	13	46
8785	2020-11-22	80	13	46
8786	2020-11-23	80	13	46
8787	2020-11-24	64	14	46
8788	2020-11-25	80	13	46
8789	2020-11-26	80	13	46
8790	2020-11-27	80	13	46
8791	2020-11-28	80	13	46
8792	2020-11-29	80	13	46
8793	2020-11-30	80	13	46
8794	2020-11-01	80	13	64
8795	2020-11-02	80	13	64
8796	2020-11-03	80	13	64
8797	2020-11-04	80	13	64
8798	2020-11-05	64	14	64
8799	2020-11-06	80	13	64
8800	2020-11-07	80	13	64
8801	2020-11-08	63	14	64
8802	2020-11-09	80	13	64
8803	2020-11-10	80	13	64
8804	2020-11-11	80	13	64
8805	2020-11-12	64	14	64
8806	2020-11-13	63	14	64
8807	2020-11-14	80	13	64
8808	2020-11-15	80	13	64
8809	2020-11-16	63	14	64
8810	2020-11-17	63	14	64
8811	2020-11-18	80	13	64
8812	2020-11-19	80	13	64
8813	2020-11-20	80	13	64
8814	2020-11-21	64	14	64
8815	2020-11-22	64	14	64
8816	2020-11-23	80	13	64
8817	2020-11-24	80	13	64
8818	2020-11-25	80	13	64
8819	2020-11-26	80	13	64
8820	2020-11-27	80	13	64
8821	2020-11-28	80	13	64
8822	2020-11-29	64	14	64
8823	2020-11-30	80	13	64
8824	2020-11-01	64	14	65
8825	2020-11-02	63	14	65
8826	2020-11-03	80	13	65
8827	2020-11-04	80	13	65
8828	2020-11-05	80	13	65
8829	2020-11-06	80	13	65
8830	2020-11-07	80	13	65
8831	2020-11-08	64	14	65
8832	2020-11-09	80	13	65
8833	2020-11-10	63	14	65
8834	2020-11-11	63	14	65
8835	2020-11-12	80	13	65
8836	2020-11-13	80	13	65
8837	2020-11-14	80	13	65
8838	2020-11-15	80	13	65
8839	2020-11-16	64	14	65
8840	2020-11-17	80	13	65
8841	2020-11-18	80	13	65
8842	2020-11-19	80	13	65
8843	2020-11-20	80	13	65
8844	2020-11-21	63	14	65
8845	2020-11-22	80	13	65
8846	2020-11-23	80	13	65
8847	2020-11-24	64	14	65
8848	2020-11-25	80	13	65
8849	2020-11-26	80	13	65
8850	2020-11-27	64	14	65
8851	2020-11-28	80	13	65
8852	2020-11-29	80	13	65
8853	2020-11-30	80	13	65
8854	2020-11-01	64	14	51
8855	2020-11-02	63	14	51
8856	2020-11-03	80	13	51
8857	2020-11-04	80	13	51
8858	2020-11-05	80	13	51
8859	2020-11-06	63	14	51
8860	2020-11-07	80	13	51
8861	2020-11-08	80	13	51
8862	2020-11-09	80	13	51
8863	2020-11-10	64	14	51
8864	2020-11-11	63	14	51
8865	2020-11-12	80	13	51
8866	2020-11-13	80	13	51
8867	2020-11-14	80	13	51
8868	2020-11-15	80	13	51
8869	2020-11-16	80	13	51
8870	2020-11-17	80	13	51
8871	2020-11-18	64	14	51
8872	2020-11-19	80	13	51
8873	2020-11-20	80	13	51
8874	2020-11-21	80	13	51
8875	2020-11-22	80	13	51
8876	2020-11-23	80	13	51
8877	2020-11-24	80	13	51
8878	2020-11-25	64	14	51
8879	2020-11-26	63	14	51
8880	2020-11-27	64	14	51
8881	2020-11-28	80	13	51
8882	2020-11-29	80	13	51
8883	2020-11-30	80	13	51
8884	2020-11-01	80	13	57
8885	2020-11-02	80	13	57
8886	2020-11-03	64	14	57
8887	2020-11-04	80	13	57
8888	2020-11-05	80	13	57
8889	2020-11-06	63	14	57
8890	2020-11-07	63	14	57
8891	2020-11-08	80	13	57
8892	2020-11-09	80	13	57
8893	2020-11-10	80	13	57
8894	2020-11-11	80	13	57
8895	2020-11-12	80	13	57
8896	2020-11-13	80	13	57
8897	2020-11-14	64	14	57
8898	2020-11-15	63	14	57
8899	2020-11-16	80	13	57
8900	2020-11-17	80	13	57
8901	2020-11-18	80	13	57
8902	2020-11-19	80	13	57
8903	2020-11-20	64	14	57
8904	2020-11-21	80	13	57
8905	2020-11-22	80	13	57
8906	2020-11-23	80	13	57
8907	2020-11-24	63	14	57
8908	2020-11-25	80	13	57
8909	2020-11-26	80	13	57
8910	2020-11-27	80	13	57
8911	2020-11-28	80	13	57
8912	2020-11-29	64	14	57
8913	2020-11-30	64	14	57
8914	2020-11-01	64	14	71
8915	2020-11-02	63	14	71
8916	2020-11-03	80	13	71
8917	2020-11-04	80	13	71
8918	2020-11-05	80	13	71
8919	2020-11-06	80	13	71
8920	2020-11-07	80	13	71
8921	2020-11-08	80	13	71
8922	2020-11-09	64	14	71
8923	2020-11-10	63	14	71
8924	2020-11-11	63	14	71
8925	2020-11-12	80	13	71
8926	2020-11-13	80	13	71
8927	2020-11-14	80	13	71
8928	2020-11-15	80	13	71
8929	2020-11-16	80	13	71
8930	2020-11-17	64	14	71
8931	2020-11-18	80	13	71
8932	2020-11-19	80	13	71
8933	2020-11-20	80	13	71
8934	2020-11-21	80	13	71
8935	2020-11-22	80	13	71
8936	2020-11-23	64	14	71
8937	2020-11-24	80	13	71
8938	2020-11-25	80	13	71
8939	2020-11-26	63	14	71
8940	2020-11-27	80	13	71
8941	2020-11-28	80	13	71
8942	2020-11-29	64	14	71
8943	2020-11-30	80	13	71
8944	2020-11-01	80	13	78
8945	2020-11-02	80	13	78
8946	2020-11-03	64	14	78
8947	2020-11-04	63	14	78
8948	2020-11-05	63	14	78
8949	2020-11-06	80	13	78
8950	2020-11-07	80	13	78
8951	2020-11-08	80	13	78
8952	2020-11-09	64	14	78
8953	2020-11-10	80	13	78
8954	2020-11-11	80	13	78
8955	2020-11-12	63	14	78
8956	2020-11-13	63	14	78
8957	2020-11-14	80	13	78
8958	2020-11-15	80	13	78
8959	2020-11-16	80	13	78
8960	2020-11-17	80	13	78
8961	2020-11-18	80	13	78
8962	2020-11-19	64	14	78
8963	2020-11-20	80	13	78
8964	2020-11-21	80	13	78
8965	2020-11-22	64	14	78
8966	2020-11-23	80	13	78
8967	2020-11-24	80	13	78
8968	2020-11-25	80	13	78
8969	2020-11-26	80	13	78
8970	2020-11-27	80	13	78
8971	2020-11-28	64	14	78
8972	2020-11-29	80	13	78
8973	2020-11-30	80	13	78
8974	2020-11-01	80	13	79
8975	2020-11-02	80	13	79
8976	2020-11-03	64	14	79
8977	2020-11-04	63	14	79
8978	2020-11-05	63	14	79
8979	2020-11-06	63	14	79
8980	2020-11-07	63	14	79
8981	2020-11-08	64	14	79
8982	2020-11-09	80	13	79
8983	2020-11-10	80	13	79
8984	2020-11-11	80	13	79
8985	2020-11-12	80	13	79
8986	2020-11-13	80	13	79
8987	2020-11-14	80	13	79
8988	2020-11-15	64	14	79
8989	2020-11-16	80	13	79
8990	2020-11-17	80	13	79
8991	2020-11-18	80	13	79
8992	2020-11-19	80	13	79
8993	2020-11-20	80	13	79
8994	2020-11-21	80	13	79
8995	2020-11-22	64	14	79
8996	2020-11-23	80	13	79
8997	2020-11-24	80	13	79
8998	2020-11-25	64	14	79
8999	2020-11-26	80	13	79
9000	2020-11-27	80	13	79
9001	2020-11-28	80	13	79
9002	2020-11-29	80	13	79
9003	2020-11-30	80	13	79
9004	2020-11-01	81	13	56
9005	2020-11-02	81	13	56
9006	2020-11-03	81	13	56
9007	2020-11-04	81	13	56
9008	2020-11-05	64	14	56
9009	2020-11-06	63	14	56
9010	2020-11-07	81	13	56
9011	2020-11-08	63	14	56
9012	2020-11-09	63	14	56
9013	2020-11-10	81	13	56
9014	2020-11-11	81	13	56
9015	2020-11-12	81	13	56
9016	2020-11-13	64	14	56
9017	2020-11-14	81	13	56
9018	2020-11-15	81	13	56
9019	2020-11-16	81	13	56
9020	2020-11-17	81	13	56
9021	2020-11-18	81	13	56
9022	2020-11-19	64	14	56
9023	2020-11-20	63	14	56
9024	2020-11-21	81	13	56
9025	2020-11-22	81	13	56
9026	2020-11-23	81	13	56
9027	2020-11-24	64	14	56
9028	2020-11-25	81	13	56
9029	2020-11-26	81	13	56
9030	2020-11-27	64	14	56
9031	2020-11-28	81	13	56
9032	2020-11-29	81	13	56
9033	2020-11-30	81	13	56
9034	2020-11-01	81	13	62
9035	2020-11-02	81	13	62
9036	2020-11-03	64	14	62
9037	2020-11-04	81	13	62
9038	2020-11-05	81	13	62
9039	2020-11-06	81	13	62
9040	2020-11-07	63	14	62
9041	2020-11-08	63	14	62
9042	2020-11-09	64	14	62
9043	2020-11-10	81	13	62
9044	2020-11-11	81	13	62
9045	2020-11-12	81	13	62
9046	2020-11-13	81	13	62
9047	2020-11-14	63	14	62
9048	2020-11-15	64	14	62
9049	2020-11-16	81	13	62
9050	2020-11-17	81	13	62
9051	2020-11-18	81	13	62
9052	2020-11-19	81	13	62
9053	2020-11-20	81	13	62
9054	2020-11-21	81	13	62
9055	2020-11-22	64	14	62
9056	2020-11-23	81	13	62
9057	2020-11-24	81	13	62
9058	2020-11-25	81	13	62
9059	2020-11-26	63	14	62
9060	2020-11-27	81	13	62
9061	2020-11-28	81	13	62
9062	2020-11-29	81	13	62
9063	2020-11-30	64	14	62
9064	2020-11-01	81	13	63
9065	2020-11-02	81	13	63
9066	2020-11-03	64	14	63
9067	2020-11-04	81	13	63
9068	2020-11-05	81	13	63
9069	2020-11-06	63	14	63
9070	2020-11-07	63	14	63
9071	2020-11-08	81	13	63
9072	2020-11-09	81	13	63
9073	2020-11-10	81	13	63
9074	2020-11-11	64	14	63
9075	2020-11-12	81	13	63
9076	2020-11-13	81	13	63
9077	2020-11-14	81	13	63
9078	2020-11-15	81	13	63
9079	2020-11-16	81	13	63
9080	2020-11-17	81	13	63
9081	2020-11-18	64	14	63
9082	2020-11-19	81	13	63
9083	2020-11-20	81	13	63
9084	2020-11-21	81	13	63
9085	2020-11-22	81	13	63
9086	2020-11-23	63	14	63
9087	2020-11-24	81	13	63
9088	2020-11-25	81	13	63
9089	2020-11-26	81	13	63
9090	2020-11-27	81	13	63
9091	2020-11-28	64	14	63
9092	2020-11-29	63	14	63
9093	2020-11-30	64	14	63
9094	2020-11-01	64	14	67
9095	2020-11-02	63	14	67
9096	2020-11-03	81	13	67
9097	2020-11-04	81	13	67
9098	2020-11-05	81	13	67
9099	2020-11-06	63	14	67
9100	2020-11-07	81	13	67
9101	2020-11-08	81	13	67
9102	2020-11-09	64	14	67
9103	2020-11-10	81	13	67
9104	2020-11-11	81	13	67
9105	2020-11-12	63	14	67
9106	2020-11-13	63	14	67
9107	2020-11-14	64	14	67
9108	2020-11-15	81	13	67
9109	2020-11-16	81	13	67
9110	2020-11-17	81	13	67
9111	2020-11-18	81	13	67
9112	2020-11-19	81	13	67
9113	2020-11-20	81	13	67
9114	2020-11-21	64	14	67
9115	2020-11-22	81	13	67
9116	2020-11-23	81	13	67
9117	2020-11-24	81	13	67
9118	2020-11-25	64	14	67
9119	2020-11-26	81	13	67
9120	2020-11-27	81	13	67
9121	2020-11-28	81	13	67
9122	2020-11-29	81	13	67
9123	2020-11-30	81	13	67
9124	2020-11-01	81	13	73
9125	2020-11-02	81	13	73
9126	2020-11-03	64	14	73
9127	2020-11-04	63	14	73
9128	2020-11-05	81	13	73
9129	2020-11-06	81	13	73
9130	2020-11-07	63	14	73
9131	2020-11-08	63	14	73
9132	2020-11-09	81	13	73
9133	2020-11-10	64	14	73
9134	2020-11-11	81	13	73
9135	2020-11-12	81	13	73
9136	2020-11-13	63	14	73
9137	2020-11-14	81	13	73
9138	2020-11-15	81	13	73
9139	2020-11-16	81	13	73
9140	2020-11-17	64	14	73
9141	2020-11-18	81	13	73
9142	2020-11-19	81	13	73
9143	2020-11-20	81	13	73
9144	2020-11-21	81	13	73
9145	2020-11-22	81	13	73
9146	2020-11-23	81	13	73
9147	2020-11-24	64	14	73
9148	2020-11-25	81	13	73
9149	2020-11-26	81	13	73
9150	2020-11-27	81	13	73
9151	2020-11-28	64	14	73
9152	2020-11-29	81	13	73
9153	2020-11-30	81	13	73
9154	2020-11-01	81	13	66
9155	2020-11-02	81	13	66
9156	2020-11-03	81	13	66
9157	2020-11-04	64	14	66
9158	2020-11-05	63	14	66
9159	2020-11-06	81	13	66
9160	2020-11-07	81	13	66
9161	2020-11-08	63	14	66
9162	2020-11-09	63	14	66
9163	2020-11-10	64	14	66
9164	2020-11-11	63	14	66
9165	2020-11-12	81	13	66
9166	2020-11-13	81	13	66
9167	2020-11-14	81	13	66
9168	2020-11-15	64	14	66
9169	2020-11-16	81	13	66
9170	2020-11-17	81	13	66
9171	2020-11-18	81	13	66
9172	2020-11-19	81	13	66
9173	2020-11-20	81	13	66
9174	2020-11-21	81	13	66
9175	2020-11-22	64	14	66
9176	2020-11-23	81	13	66
9177	2020-11-24	81	13	66
9178	2020-11-25	81	13	66
9179	2020-11-26	81	13	66
9180	2020-11-27	81	13	66
9181	2020-11-28	81	13	66
9182	2020-11-29	64	14	66
9183	2020-11-30	81	13	66
9184	2020-11-01	64	14	55
9185	2020-11-02	63	14	55
9186	2020-11-03	81	13	55
9187	2020-11-04	81	13	55
9188	2020-11-05	63	14	55
9189	2020-11-06	81	13	55
9190	2020-11-07	81	13	55
9191	2020-11-08	81	13	55
9192	2020-11-09	81	13	55
9193	2020-11-10	81	13	55
9194	2020-11-11	64	14	55
9195	2020-11-12	63	14	55
9196	2020-11-13	81	13	55
9197	2020-11-14	81	13	55
9198	2020-11-15	81	13	55
9199	2020-11-16	63	14	55
9200	2020-11-17	81	13	55
9201	2020-11-18	81	13	55
9202	2020-11-19	64	14	55
9203	2020-11-20	64	14	55
9204	2020-11-21	81	13	55
9205	2020-11-22	81	13	55
9206	2020-11-23	81	13	55
9207	2020-11-24	81	13	55
9208	2020-11-25	81	13	55
9209	2020-11-26	81	13	55
9210	2020-11-27	64	14	55
9211	2020-11-28	81	13	55
9212	2020-11-29	81	13	55
9213	2020-11-30	81	13	55
9214	2020-11-01	83	13	68
9215	2020-11-02	83	13	68
9216	2020-11-03	83	13	68
9217	2020-11-04	64	14	68
9218	2020-11-05	63	14	68
9219	2020-11-06	63	14	68
9220	2020-11-07	83	13	68
9221	2020-11-08	83	13	68
9222	2020-11-09	63	14	68
9223	2020-11-10	83	13	68
9224	2020-11-11	83	13	68
9225	2020-11-12	83	13	68
9226	2020-11-13	83	13	68
9227	2020-11-14	64	14	68
9228	2020-11-15	83	13	68
9229	2020-11-16	83	13	68
9230	2020-11-17	83	13	68
9231	2020-11-18	83	13	68
9232	2020-11-19	83	13	68
9233	2020-11-20	64	14	68
9234	2020-11-21	83	13	68
9235	2020-11-22	83	13	68
9236	2020-11-23	83	13	68
9237	2020-11-24	83	13	68
9238	2020-11-25	63	14	68
9239	2020-11-26	64	14	68
9240	2020-11-27	83	13	68
9241	2020-11-28	83	13	68
9242	2020-11-29	83	13	68
9243	2020-11-30	64	14	68
9244	2020-11-01	64	14	80
9245	2020-11-02	63	14	80
9246	2020-11-03	83	13	80
9247	2020-11-04	83	13	80
9248	2020-11-05	83	13	80
9249	2020-11-06	83	13	80
9250	2020-11-07	83	13	80
9251	2020-11-08	64	14	80
9252	2020-11-09	83	13	80
9253	2020-11-10	83	13	80
9254	2020-11-11	63	14	80
9255	2020-11-12	63	14	80
9256	2020-11-13	83	13	80
9257	2020-11-14	83	13	80
9258	2020-11-15	64	14	80
9259	2020-11-16	83	13	80
9260	2020-11-17	83	13	80
9261	2020-11-18	83	13	80
9262	2020-11-19	63	14	80
9263	2020-11-20	83	13	80
9264	2020-11-21	83	13	80
9265	2020-11-22	64	14	80
9266	2020-11-23	83	13	80
9267	2020-11-24	83	13	80
9268	2020-11-25	83	13	80
9269	2020-11-26	83	13	80
9270	2020-11-27	83	13	80
9271	2020-11-28	64	14	80
9272	2020-11-29	83	13	80
9273	2020-11-30	83	13	80
9274	2020-11-01	83	13	60
9275	2020-11-02	83	13	60
9276	2020-11-03	64	14	60
9277	2020-11-04	83	13	60
9278	2020-11-05	83	13	60
9279	2020-11-06	83	13	60
9280	2020-11-07	63	14	60
9281	2020-11-08	83	13	60
9282	2020-11-09	83	13	60
9283	2020-11-10	64	14	60
9284	2020-11-11	83	13	60
9285	2020-11-12	83	13	60
9286	2020-11-13	63	14	60
9287	2020-11-14	83	13	60
9288	2020-11-15	83	13	60
9289	2020-11-16	64	14	60
9290	2020-11-17	63	14	60
9291	2020-11-18	63	14	60
9292	2020-11-19	83	13	60
9293	2020-11-20	83	13	60
9294	2020-11-21	64	14	60
9295	2020-11-22	83	13	60
9296	2020-11-23	83	13	60
9297	2020-11-24	83	13	60
9298	2020-11-25	83	13	60
9299	2020-11-26	83	13	60
9300	2020-11-27	64	14	60
9301	2020-11-28	83	13	60
9302	2020-11-29	83	13	60
9303	2020-11-30	83	13	60
9304	2020-11-01	83	13	53
9305	2020-11-02	83	13	53
9306	2020-11-03	64	14	53
9307	2020-11-04	63	14	53
9308	2020-11-05	83	13	53
9309	2020-11-06	83	13	53
9310	2020-11-07	63	14	53
9311	2020-11-08	63	14	53
9312	2020-11-09	83	13	53
9313	2020-11-10	83	13	53
9314	2020-11-11	64	14	53
9315	2020-11-12	83	13	53
9316	2020-11-13	83	13	53
9317	2020-11-14	83	13	53
9318	2020-11-15	83	13	53
9319	2020-11-16	83	13	53
9320	2020-11-17	83	13	53
9321	2020-11-18	64	14	53
9322	2020-11-19	83	13	53
9323	2020-11-20	63	14	53
9324	2020-11-21	64	14	53
9325	2020-11-22	83	13	53
9326	2020-11-23	83	13	53
9327	2020-11-24	83	13	53
9328	2020-11-25	83	13	53
9329	2020-11-26	64	14	53
9330	2020-11-27	83	13	53
9331	2020-11-28	83	13	53
9332	2020-11-29	83	13	53
9333	2020-11-30	83	13	53
9334	2020-11-01	64	14	54
9335	2020-11-02	63	14	54
9336	2020-11-03	83	13	54
9337	2020-11-04	83	13	54
9338	2020-11-05	83	13	54
9339	2020-11-06	63	14	54
9340	2020-11-07	83	13	54
9341	2020-11-08	83	13	54
9342	2020-11-09	64	14	54
9343	2020-11-10	83	13	54
9344	2020-11-11	83	13	54
9345	2020-11-12	63	14	54
9346	2020-11-13	63	14	54
9347	2020-11-14	83	13	54
9348	2020-11-15	83	13	54
9349	2020-11-16	83	13	54
9350	2020-11-17	83	13	54
9351	2020-11-18	83	13	54
9352	2020-11-19	64	14	54
9353	2020-11-20	83	13	54
9354	2020-11-21	83	13	54
9355	2020-11-22	83	13	54
9356	2020-11-23	83	13	54
9357	2020-11-24	64	14	54
9358	2020-11-25	64	14	54
9359	2020-11-26	83	13	54
9360	2020-11-27	83	13	54
9361	2020-11-28	83	13	54
9362	2020-11-29	83	13	54
9363	2020-11-30	63	14	54
9364	2020-11-01	64	14	49
9365	2020-11-02	63	14	49
9366	2020-11-03	83	13	49
9367	2020-11-04	83	13	49
9368	2020-11-05	83	13	49
9369	2020-11-06	83	13	49
9370	2020-11-07	83	13	49
9371	2020-11-08	64	14	49
9372	2020-11-09	83	13	49
9373	2020-11-10	63	14	49
9374	2020-11-11	63	14	49
9375	2020-11-12	83	13	49
9376	2020-11-13	83	13	49
9377	2020-11-14	83	13	49
9378	2020-11-15	83	13	49
9379	2020-11-16	64	14	49
9380	2020-11-17	63	14	49
9381	2020-11-18	83	13	49
9382	2020-11-19	83	13	49
9383	2020-11-20	83	13	49
9384	2020-11-21	83	13	49
9385	2020-11-22	83	13	49
9386	2020-11-23	64	14	49
9387	2020-11-24	83	13	49
9388	2020-11-25	83	13	49
9389	2020-11-26	83	13	49
9390	2020-11-27	64	14	49
9391	2020-11-28	63	14	49
9392	2020-11-29	83	13	49
9393	2020-11-30	83	13	49
9394	2020-11-01	83	13	50
9395	2020-11-02	83	13	50
9396	2020-11-03	64	14	50
9397	2020-11-04	63	14	50
9398	2020-11-05	63	14	50
9399	2020-11-06	63	14	50
9400	2020-11-07	83	13	50
9401	2020-11-08	83	13	50
9402	2020-11-09	83	13	50
9403	2020-11-10	83	13	50
9404	2020-11-11	83	13	50
9405	2020-11-12	83	13	50
9406	2020-11-13	64	14	50
9407	2020-11-14	63	14	50
9408	2020-11-15	64	14	50
9409	2020-11-16	83	13	50
9410	2020-11-17	83	13	50
9411	2020-11-18	83	13	50
9412	2020-11-19	83	13	50
9413	2020-11-20	83	13	50
9414	2020-11-21	83	13	50
9415	2020-11-22	64	14	50
9416	2020-11-23	83	13	50
9417	2020-11-24	83	13	50
9418	2020-11-25	83	13	50
9419	2020-11-26	83	13	50
9420	2020-11-27	83	13	50
9421	2020-11-28	83	13	50
9422	2020-11-29	64	14	50
9423	2020-11-30	83	13	50
9424	2020-11-01	64	14	43
9425	2020-11-02	82	16	43
9426	2020-11-03	82	16	43
9427	2020-11-04	82	16	43
9428	2020-11-05	82	16	43
9429	2020-11-06	82	16	43
9430	2020-11-07	63	14	43
9431	2020-11-08	64	14	43
9432	2020-11-09	82	16	43
9433	2020-11-10	82	16	43
9434	2020-11-11	82	16	43
9435	2020-11-12	82	16	43
9436	2020-11-13	82	16	43
9437	2020-11-14	63	14	43
9438	2020-11-15	64	14	43
9439	2020-11-16	82	16	43
9440	2020-11-17	82	16	43
9441	2020-11-18	82	16	43
9442	2020-11-19	82	16	43
9443	2020-11-20	82	16	43
9444	2020-11-21	63	14	43
9445	2020-11-22	64	14	43
9446	2020-11-23	82	16	43
9447	2020-11-24	82	16	43
9448	2020-11-25	82	16	43
9449	2020-11-26	82	16	43
9450	2020-11-27	82	16	43
9451	2020-11-28	63	14	43
9452	2020-11-29	64	14	43
9453	2020-11-30	82	16	43
9454	2020-11-01	64	14	44
9455	2020-11-02	82	16	44
9456	2020-11-03	82	16	44
9457	2020-11-04	82	16	44
9458	2020-11-05	82	16	44
9459	2020-11-06	82	16	44
9460	2020-11-07	63	14	44
9461	2020-11-08	64	14	44
9462	2020-11-09	82	16	44
9463	2020-11-10	82	16	44
9464	2020-11-11	82	16	44
9465	2020-11-12	82	16	44
9466	2020-11-13	82	16	44
9467	2020-11-14	63	14	44
9468	2020-11-15	64	14	44
9469	2020-11-16	82	16	44
9470	2020-11-17	82	16	44
9471	2020-11-18	82	16	44
9472	2020-11-19	82	16	44
9473	2020-11-20	82	16	44
9474	2020-11-21	63	14	44
9475	2020-11-22	64	14	44
9476	2020-11-23	82	16	44
9477	2020-11-24	82	16	44
9478	2020-11-25	82	16	44
9479	2020-11-26	82	16	44
9480	2020-11-27	82	16	44
9481	2020-11-28	63	14	44
9482	2020-11-29	64	14	44
9483	2020-11-30	82	16	44
\.


--
-- Data for Name: result_timeadjustment; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.result_timeadjustment (id, date, hours, adjustment_type, adjustment_item, remark, user_id) FROM stdin;
16	2020-11-06	8	0	1	白班	47
26	2020-11-20	8	0	1	白班	46
28	2020-11-21	8	0	1	白班	51
29	2020-11-19	8	0	1	小夜	54
30	2020-09-14	8	0	1	白班	64
31	2020-09-16	8	0	1	白班	65
33	2020-11-06	8	0	1	白班	69
34	2020-11-19	8	0	1	白班	78
35	2020-11-18	8	0	1	白班	79
37	2020-11-21	8	0	1	白班	64
38	2020-11-22	8	0	1	白班	65
41	2020-11-19	8	0	1	白班	71
44	2020-11-21	8	0	1	白班	62
45	2020-11-14	8	0	1	白班	57
48	2021-01-08	8	0	1	白班	45
49	2021-01-06	8	0	1	白班	46
50	2020-09-03	8	0	1	白班	47
51	2020-09-03	8	0	1	白班	53
52	2020-09-23	8	0	1	白班	45
53	2020-09-24	2	1	5	白班	47
58	2020-11-05	8	0	0	白班	46
59	2020-11-06	8	0	0	小夜	46
\.


--
-- Data for Name: shift_shift; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.shift_shift (id, name, shift_type, code, start_time, end_time, work_hours, department_id) FROM stdin;
63	休息	5		00:00:00	00:00:00	0	4
64	例假	5		00:00:00	00:00:00	0	4
65	公假	3		00:00:00	00:00:00	8	4
67	事假	6		00:00:00	00:00:00	0	4
68	家庭照顧假	6		00:00:00	00:00:00	0	4
69	無薪病假	6		00:00:00	00:00:00	0	4
70	產假	5		00:00:00	00:00:00	0	4
71	生理假	5		00:00:00	00:00:00	0	4
72	特休	5		00:00:00	00:00:00	0	4
73	補休	5		00:00:00	00:00:00	0	4
74	婚假	5		00:00:00	00:00:00	0	4
75	計薪病假	5		00:00:00	00:00:00	0	4
76	喪假	5		00:00:00	00:00:00	0	4
77	安胎休養假	5		00:00:00	00:00:00	0	4
78	產檢假	5		00:00:00	00:00:00	0	4
79	陪產假	5		00:00:00	00:00:00	0	4
80	白班	0	A	08:00:00	16:00:00	8	4
81	小夜	1	E	16:00:00	00:00:00	8	4
82	行政	7	B	08:00:00	17:00:00	8	4
83	大夜	2	N	23:59:00	08:00:00	8	4
84	國定假日	5	H	00:00:00	00:00:00	0	4
\.


--
-- Data for Name: station_station; Type: TABLE DATA; Schema: public; Owner: schedule_user
--

COPY public.station_station (id, name, department_id) FROM stdin;
13	護理站	4
14	休假	4
15	公假	4
16	行政	4
\.


--
-- Name: account_customuser_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.account_customuser_groups_id_seq', 1, false);


--
-- Name: account_customuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.account_customuser_id_seq', 80, true);


--
-- Name: account_customuser_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.account_customuser_user_permissions_id_seq', 1, false);


--
-- Name: account_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.account_department_id_seq', 4, true);


--
-- Name: account_departmentmanager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.account_departmentmanager_id_seq', 1, false);


--
-- Name: account_liscense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.account_liscense_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 116, true);


--
-- Name: date_h_calendar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.date_h_calendar_id_seq', 4271, true);


--
-- Name: demand_demandofstation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.demand_demandofstation_id_seq', 22, true);


--
-- Name: demand_demandusertable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.demand_demandusertable_id_seq', 66, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 29, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 40, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 1, false);


--
-- Name: remarks_preresultremark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.remarks_preresultremark_id_seq', 1, false);


--
-- Name: remarks_remarksquare_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.remarks_remarksquare_id_seq', 1, false);


--
-- Name: remarks_resultremark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.remarks_resultremark_id_seq', 1, false);


--
-- Name: remarks_userremark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.remarks_userremark_id_seq', 1, false);


--
-- Name: reservation_promiseshift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.reservation_promiseshift_id_seq', 18, true);


--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.reservation_reservation_id_seq', 305, true);


--
-- Name: result_afterresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.result_afterresult_id_seq', 1, false);


--
-- Name: result_exchangeapplication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.result_exchangeapplication_id_seq', 3, true);


--
-- Name: result_historyresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.result_historyresult_id_seq', 1, false);


--
-- Name: result_preresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.result_preresult_id_seq', 136656, true);


--
-- Name: result_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.result_result_id_seq', 9483, true);


--
-- Name: result_timeadjustment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.result_timeadjustment_id_seq', 59, true);


--
-- Name: shift_shift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.shift_shift_id_seq', 84, true);


--
-- Name: station_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: schedule_user
--

SELECT pg_catalog.setval('public.station_station_id_seq', 16, true);


--
-- Name: account_customuser idx_16390_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser
    ADD CONSTRAINT idx_16390_primary PRIMARY KEY (id);


--
-- Name: account_customuser_groups idx_16395_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser_groups
    ADD CONSTRAINT idx_16395_primary PRIMARY KEY (id);


--
-- Name: account_customuser_user_permissions idx_16398_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser_user_permissions
    ADD CONSTRAINT idx_16398_primary PRIMARY KEY (id);


--
-- Name: account_department idx_16401_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_department
    ADD CONSTRAINT idx_16401_primary PRIMARY KEY (id);


--
-- Name: account_departmentmanager idx_16404_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_departmentmanager
    ADD CONSTRAINT idx_16404_primary PRIMARY KEY (id);


--
-- Name: account_liscense idx_16407_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_liscense
    ADD CONSTRAINT idx_16407_primary PRIMARY KEY (id);


--
-- Name: auth_group idx_16410_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.auth_group
    ADD CONSTRAINT idx_16410_primary PRIMARY KEY (id);


--
-- Name: auth_group_permissions idx_16413_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.auth_group_permissions
    ADD CONSTRAINT idx_16413_primary PRIMARY KEY (id);


--
-- Name: auth_permission idx_16416_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.auth_permission
    ADD CONSTRAINT idx_16416_primary PRIMARY KEY (id);


--
-- Name: date_h_calendar idx_16419_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.date_h_calendar
    ADD CONSTRAINT idx_16419_primary PRIMARY KEY (id);


--
-- Name: demand_demandofstation idx_16424_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.demand_demandofstation
    ADD CONSTRAINT idx_16424_primary PRIMARY KEY (id);


--
-- Name: demand_demandusertable idx_16427_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.demand_demandusertable
    ADD CONSTRAINT idx_16427_primary PRIMARY KEY (id);


--
-- Name: django_admin_log idx_16430_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.django_admin_log
    ADD CONSTRAINT idx_16430_primary PRIMARY KEY (id);


--
-- Name: django_content_type idx_16435_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.django_content_type
    ADD CONSTRAINT idx_16435_primary PRIMARY KEY (id);


--
-- Name: django_migrations idx_16438_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.django_migrations
    ADD CONSTRAINT idx_16438_primary PRIMARY KEY (id);


--
-- Name: django_session idx_16443_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.django_session
    ADD CONSTRAINT idx_16443_primary PRIMARY KEY (session_key);


--
-- Name: notifications_notification idx_16448_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.notifications_notification
    ADD CONSTRAINT idx_16448_primary PRIMARY KEY (id);


--
-- Name: remarks_preresultremark idx_16453_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_preresultremark
    ADD CONSTRAINT idx_16453_primary PRIMARY KEY (id);


--
-- Name: remarks_remarksquare idx_16456_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_remarksquare
    ADD CONSTRAINT idx_16456_primary PRIMARY KEY (id);


--
-- Name: remarks_resultremark idx_16459_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_resultremark
    ADD CONSTRAINT idx_16459_primary PRIMARY KEY (id);


--
-- Name: remarks_userremark idx_16462_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_userremark
    ADD CONSTRAINT idx_16462_primary PRIMARY KEY (id);


--
-- Name: reservation_promiseshift idx_16467_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.reservation_promiseshift
    ADD CONSTRAINT idx_16467_primary PRIMARY KEY (id);


--
-- Name: reservation_reservation idx_16470_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.reservation_reservation
    ADD CONSTRAINT idx_16470_primary PRIMARY KEY (id);


--
-- Name: result_afterresult idx_16473_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_afterresult
    ADD CONSTRAINT idx_16473_primary PRIMARY KEY (id);


--
-- Name: result_exchangeapplication idx_16476_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_exchangeapplication
    ADD CONSTRAINT idx_16476_primary PRIMARY KEY (id);


--
-- Name: result_historyresult idx_16479_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_historyresult
    ADD CONSTRAINT idx_16479_primary PRIMARY KEY (id);


--
-- Name: result_preresult idx_16482_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_preresult
    ADD CONSTRAINT idx_16482_primary PRIMARY KEY (id);


--
-- Name: result_result idx_16485_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_result
    ADD CONSTRAINT idx_16485_primary PRIMARY KEY (id);


--
-- Name: result_timeadjustment idx_16488_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_timeadjustment
    ADD CONSTRAINT idx_16488_primary PRIMARY KEY (id);


--
-- Name: shift_shift idx_16491_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.shift_shift
    ADD CONSTRAINT idx_16491_primary PRIMARY KEY (id);


--
-- Name: station_station idx_16494_primary; Type: CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.station_station
    ADD CONSTRAINT idx_16494_primary PRIMARY KEY (id);


--
-- Name: account_customuser_groups account_customuser_groups_customuser_id_group_id_7e51db7b_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_groups
    ADD CONSTRAINT account_customuser_groups_customuser_id_group_id_7e51db7b_uniq UNIQUE (customuser_id, group_id);


--
-- Name: account_customuser_groups account_customuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_groups
    ADD CONSTRAINT account_customuser_groups_pkey PRIMARY KEY (id);


--
-- Name: account_customuser account_customuser_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser
    ADD CONSTRAINT account_customuser_pkey PRIMARY KEY (id);


--
-- Name: account_customuser_user_permissions account_customuser_user__customuser_id_permission_650e378f_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_user_permissions
    ADD CONSTRAINT account_customuser_user__customuser_id_permission_650e378f_uniq UNIQUE (customuser_id, permission_id);


--
-- Name: account_customuser_user_permissions account_customuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_user_permissions
    ADD CONSTRAINT account_customuser_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: account_customuser account_customuser_username_key; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser
    ADD CONSTRAINT account_customuser_username_key UNIQUE (username);


--
-- Name: account_department account_department_detail_key; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_department
    ADD CONSTRAINT account_department_detail_key UNIQUE (detail);


--
-- Name: account_department account_department_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_department
    ADD CONSTRAINT account_department_pkey PRIMARY KEY (id);


--
-- Name: account_departmentmanager account_departmentmanager_department_id_key; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_departmentmanager
    ADD CONSTRAINT account_departmentmanager_department_id_key UNIQUE (department_id);


--
-- Name: account_departmentmanager account_departmentmanager_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_departmentmanager
    ADD CONSTRAINT account_departmentmanager_pkey PRIMARY KEY (id);


--
-- Name: account_liscense account_liscense_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_liscense
    ADD CONSTRAINT account_liscense_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: date_h_calendar date_h_calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.date_h_calendar
    ADD CONSTRAINT date_h_calendar_pkey PRIMARY KEY (id);


--
-- Name: demand_demandofstation demand_demandofstation_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.demand_demandofstation
    ADD CONSTRAINT demand_demandofstation_pkey PRIMARY KEY (id);


--
-- Name: demand_demandofstation demand_demandofstation_station_id_shift_id_level_dd4bacdb_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.demand_demandofstation
    ADD CONSTRAINT demand_demandofstation_station_id_shift_id_level_dd4bacdb_uniq UNIQUE (station_id, shift_id, level);


--
-- Name: demand_demandusertable demand_demandusertable_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.demand_demandusertable
    ADD CONSTRAINT demand_demandusertable_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: notifications_notification notifications_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.notifications_notification
    ADD CONSTRAINT notifications_notification_pkey PRIMARY KEY (id);


--
-- Name: remarks_preresultremark remarks_preresultremark_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_preresultremark
    ADD CONSTRAINT remarks_preresultremark_pkey PRIMARY KEY (id);


--
-- Name: remarks_preresultremark remarks_preresultremark_result_id_key; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_preresultremark
    ADD CONSTRAINT remarks_preresultremark_result_id_key UNIQUE (result_id);


--
-- Name: remarks_remarksquare remarks_remarksquare_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_remarksquare
    ADD CONSTRAINT remarks_remarksquare_pkey PRIMARY KEY (id);


--
-- Name: remarks_resultremark remarks_resultremark_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_resultremark
    ADD CONSTRAINT remarks_resultremark_pkey PRIMARY KEY (id);


--
-- Name: remarks_resultremark remarks_resultremark_result_id_key; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_resultremark
    ADD CONSTRAINT remarks_resultremark_result_id_key UNIQUE (result_id);


--
-- Name: remarks_userremark remarks_userremark_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_userremark
    ADD CONSTRAINT remarks_userremark_pkey PRIMARY KEY (id);


--
-- Name: remarks_userremark remarks_userremark_user_id_month_1f25516c_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_userremark
    ADD CONSTRAINT remarks_userremark_user_id_month_1f25516c_uniq UNIQUE (user_id, month);


--
-- Name: reservation_promiseshift reservation_promiseshift_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.reservation_promiseshift
    ADD CONSTRAINT reservation_promiseshift_pkey PRIMARY KEY (id);


--
-- Name: reservation_promiseshift reservation_promiseshift_user_id_date_1e9d2d6b_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.reservation_promiseshift
    ADD CONSTRAINT reservation_promiseshift_user_id_date_1e9d2d6b_uniq UNIQUE (user_id, date);


--
-- Name: reservation_reservation reservation_reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.reservation_reservation
    ADD CONSTRAINT reservation_reservation_pkey PRIMARY KEY (id);


--
-- Name: result_afterresult result_afterresult_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_afterresult
    ADD CONSTRAINT result_afterresult_pkey PRIMARY KEY (id);


--
-- Name: result_afterresult result_afterresult_user_id_date_786175ee_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_afterresult
    ADD CONSTRAINT result_afterresult_user_id_date_786175ee_uniq UNIQUE (user_id, date);


--
-- Name: result_exchangeapplication result_exchangeapplication_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_exchangeapplication
    ADD CONSTRAINT result_exchangeapplication_pkey PRIMARY KEY (id);


--
-- Name: result_historyresult result_historyresult_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_historyresult
    ADD CONSTRAINT result_historyresult_pkey PRIMARY KEY (id);


--
-- Name: result_preresult result_preresult_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_preresult
    ADD CONSTRAINT result_preresult_pkey PRIMARY KEY (id);


--
-- Name: result_preresult result_preresult_user_id_date_6a18d0ad_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_preresult
    ADD CONSTRAINT result_preresult_user_id_date_6a18d0ad_uniq UNIQUE (user_id, date);


--
-- Name: result_result result_result_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_result
    ADD CONSTRAINT result_result_pkey PRIMARY KEY (id);


--
-- Name: result_result result_result_user_id_date_e7594f14_uniq; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_result
    ADD CONSTRAINT result_result_user_id_date_e7594f14_uniq UNIQUE (user_id, date);


--
-- Name: result_timeadjustment result_timeadjustment_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_timeadjustment
    ADD CONSTRAINT result_timeadjustment_pkey PRIMARY KEY (id);


--
-- Name: shift_shift shift_shift_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.shift_shift
    ADD CONSTRAINT shift_shift_pkey PRIMARY KEY (id);


--
-- Name: station_station station_station_pkey; Type: CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.station_station
    ADD CONSTRAINT station_station_pkey PRIMARY KEY (id);


--
-- Name: idx_16390_account_customuser_department_id_4fed400d_fk_account_; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16390_account_customuser_department_id_4fed400d_fk_account_ ON db.account_customuser USING btree (department_id);


--
-- Name: idx_16390_username; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16390_username ON db.account_customuser USING btree (username);


--
-- Name: idx_16395_account_customuser_groups_customuser_id_group_id_7e51; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16395_account_customuser_groups_customuser_id_group_id_7e51 ON db.account_customuser_groups USING btree (customuser_id, group_id);


--
-- Name: idx_16395_account_customuser_groups_group_id_2be9f6d7_fk_auth_g; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16395_account_customuser_groups_group_id_2be9f6d7_fk_auth_g ON db.account_customuser_groups USING btree (group_id);


--
-- Name: idx_16398_account_customuser_u_permission_id_f4aec423_fk_auth_p; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16398_account_customuser_u_permission_id_f4aec423_fk_auth_p ON db.account_customuser_user_permissions USING btree (permission_id);


--
-- Name: idx_16398_account_customuser_user__customuser_id_permission_650; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16398_account_customuser_user__customuser_id_permission_650 ON db.account_customuser_user_permissions USING btree (customuser_id, permission_id);


--
-- Name: idx_16401_detail; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16401_detail ON db.account_department USING btree (detail);


--
-- Name: idx_16404_account_departmentma_manager_one_id_873d07c5_fk_accou; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16404_account_departmentma_manager_one_id_873d07c5_fk_accou ON db.account_departmentmanager USING btree (manager_one_id);


--
-- Name: idx_16404_account_departmentma_manager_two_id_cf9a4f7d_fk_accou; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16404_account_departmentma_manager_two_id_cf9a4f7d_fk_accou ON db.account_departmentmanager USING btree (manager_two_id);


--
-- Name: idx_16404_department_id; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16404_department_id ON db.account_departmentmanager USING btree (department_id);


--
-- Name: idx_16407_account_liscense_user_id_13bc59a2_fk_account_customus; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16407_account_liscense_user_id_13bc59a2_fk_account_customus ON db.account_liscense USING btree (user_id);


--
-- Name: idx_16410_name; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16410_name ON db.auth_group USING btree (name);


--
-- Name: idx_16413_auth_group_permissio_permission_id_84c5c92e_fk_auth_p; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16413_auth_group_permissio_permission_id_84c5c92e_fk_auth_p ON db.auth_group_permissions USING btree (permission_id);


--
-- Name: idx_16413_auth_group_permissions_group_id_permission_id_0cd325b; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16413_auth_group_permissions_group_id_permission_id_0cd325b ON db.auth_group_permissions USING btree (group_id, permission_id);


--
-- Name: idx_16416_auth_permission_content_type_id_codename_01ab375a_uni; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16416_auth_permission_content_type_id_codename_01ab375a_uni ON db.auth_permission USING btree (content_type_id, codename);


--
-- Name: idx_16424_demand_demandofstation_shift_id_e589e74e_fk_shift_shi; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16424_demand_demandofstation_shift_id_e589e74e_fk_shift_shi ON db.demand_demandofstation USING btree (shift_id);


--
-- Name: idx_16424_demand_demandofstation_station_id_shift_id_level_dd4b; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16424_demand_demandofstation_station_id_shift_id_level_dd4b ON db.demand_demandofstation USING btree (station_id, shift_id, level);


--
-- Name: idx_16427_demand_demandusertab_demand_id_21c0f5c4_fk_demand_de; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16427_demand_demandusertab_demand_id_21c0f5c4_fk_demand_de ON db.demand_demandusertable USING btree (demand_id);


--
-- Name: idx_16427_demand_demandusertable_user_id_4dcd72e3_fk_account_cu; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16427_demand_demandusertable_user_id_4dcd72e3_fk_account_cu ON db.demand_demandusertable USING btree (user_id);


--
-- Name: idx_16430_django_admin_log_content_type_id_c4bce8eb_fk_django_c; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16430_django_admin_log_content_type_id_c4bce8eb_fk_django_c ON db.django_admin_log USING btree (content_type_id);


--
-- Name: idx_16430_django_admin_log_user_id_c564eba6_fk_account_customus; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16430_django_admin_log_user_id_c564eba6_fk_account_customus ON db.django_admin_log USING btree (user_id);


--
-- Name: idx_16435_django_content_type_app_label_model_76bd3d3b_uniq; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16435_django_content_type_app_label_model_76bd3d3b_uniq ON db.django_content_type USING btree (app_label, model);


--
-- Name: idx_16443_django_session_expire_date_a5c62663; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16443_django_session_expire_date_a5c62663 ON db.django_session USING btree (expire_date);


--
-- Name: idx_16448_notifications_notifi_action_object_conten_7d2b8ee9_fk; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notifi_action_object_conten_7d2b8ee9_fk ON db.notifications_notification USING btree (action_object_content_type_id);


--
-- Name: idx_16448_notifications_notifi_actor_content_type_i_0c69d7b7_fk; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notifi_actor_content_type_i_0c69d7b7_fk ON db.notifications_notification USING btree (actor_content_type_id);


--
-- Name: idx_16448_notifications_notifi_target_content_type__ccb24d88_fk; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notifi_target_content_type__ccb24d88_fk ON db.notifications_notification USING btree (target_content_type_id);


--
-- Name: idx_16448_notifications_notification_deleted_b32b69e6; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notification_deleted_b32b69e6 ON db.notifications_notification USING btree (deleted);


--
-- Name: idx_16448_notifications_notification_emailed_23a5ad81; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notification_emailed_23a5ad81 ON db.notifications_notification USING btree (emailed);


--
-- Name: idx_16448_notifications_notification_public_1bc30b1c; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notification_public_1bc30b1c ON db.notifications_notification USING btree (public);


--
-- Name: idx_16448_notifications_notification_recipient_id_unread_253aad; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notification_recipient_id_unread_253aad ON db.notifications_notification USING btree (recipient_id, unread);


--
-- Name: idx_16448_notifications_notification_timestamp_6a797bad; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notification_timestamp_6a797bad ON db.notifications_notification USING btree ("timestamp");


--
-- Name: idx_16448_notifications_notification_unread_cce4be30; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16448_notifications_notification_unread_cce4be30 ON db.notifications_notification USING btree (unread);


--
-- Name: idx_16453_remarks_preresultrem_content_id_325633fb_fk_remarks_r; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16453_remarks_preresultrem_content_id_325633fb_fk_remarks_r ON db.remarks_preresultremark USING btree (content_id);


--
-- Name: idx_16453_result_id; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16453_result_id ON db.remarks_preresultremark USING btree (result_id);


--
-- Name: idx_16456_remarks_remarksquare_department_id_458d2357_fk_accoun; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16456_remarks_remarksquare_department_id_458d2357_fk_accoun ON db.remarks_remarksquare USING btree (department_id);


--
-- Name: idx_16459_remarks_resultremark_content_id_ba47e5b7_fk_remarks_r; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16459_remarks_resultremark_content_id_ba47e5b7_fk_remarks_r ON db.remarks_resultremark USING btree (content_id);


--
-- Name: idx_16459_result_id; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16459_result_id ON db.remarks_resultremark USING btree (result_id);


--
-- Name: idx_16462_remarks_userremark_user_id_month_1f25516c_uniq; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16462_remarks_userremark_user_id_month_1f25516c_uniq ON db.remarks_userremark USING btree (user_id, month);


--
-- Name: idx_16467_reservation_promiseshift_user_id_date_1e9d2d6b_uniq; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16467_reservation_promiseshift_user_id_date_1e9d2d6b_uniq ON db.reservation_promiseshift USING btree (user_id, date);


--
-- Name: idx_16470_reservation_reservat_user_id_261c5876_fk_account_c; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16470_reservation_reservat_user_id_261c5876_fk_account_c ON db.reservation_reservation USING btree (user_id);


--
-- Name: idx_16473_result_afterresult_shift_id_dae263b5_fk_shift_shift_i; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16473_result_afterresult_shift_id_dae263b5_fk_shift_shift_i ON db.result_afterresult USING btree (shift_id);


--
-- Name: idx_16473_result_afterresult_station_id_cf2a0d7d_fk_station_sta; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16473_result_afterresult_station_id_cf2a0d7d_fk_station_sta ON db.result_afterresult USING btree (station_id);


--
-- Name: idx_16473_result_afterresult_user_id_date_786175ee_uniq; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16473_result_afterresult_user_id_date_786175ee_uniq ON db.result_afterresult USING btree (user_id, date);


--
-- Name: idx_16476_result_exchangeappli_shift_apply_id_4678120b_fk_shift; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16476_result_exchangeappli_shift_apply_id_4678120b_fk_shift ON db.result_exchangeapplication USING btree (shift_apply_id);


--
-- Name: idx_16476_result_exchangeappli_shift_receive_id_532416cb_fk_shi; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16476_result_exchangeappli_shift_receive_id_532416cb_fk_shi ON db.result_exchangeapplication USING btree (shift_receive_id);


--
-- Name: idx_16476_result_exchangeappli_station_apply_id_5f3c0c25_fk_sta; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16476_result_exchangeappli_station_apply_id_5f3c0c25_fk_sta ON db.result_exchangeapplication USING btree (station_apply_id);


--
-- Name: idx_16476_result_exchangeappli_station_receive_id_c27ee112_fk_s; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16476_result_exchangeappli_station_receive_id_c27ee112_fk_s ON db.result_exchangeapplication USING btree (station_receive_id);


--
-- Name: idx_16476_result_exchangeappli_user_apply_id_29b81d76_fk_accoun; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16476_result_exchangeappli_user_apply_id_29b81d76_fk_accoun ON db.result_exchangeapplication USING btree (user_apply_id);


--
-- Name: idx_16476_result_exchangeappli_user_receive_id_220c6f95_fk_acco; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16476_result_exchangeappli_user_receive_id_220c6f95_fk_acco ON db.result_exchangeapplication USING btree (user_receive_id);


--
-- Name: idx_16479_result_historyresult_shift_id_d3f90054_fk_shift_shift; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16479_result_historyresult_shift_id_d3f90054_fk_shift_shift ON db.result_historyresult USING btree (shift_id);


--
-- Name: idx_16479_result_historyresult_station_id_7b926797_fk_station_s; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16479_result_historyresult_station_id_7b926797_fk_station_s ON db.result_historyresult USING btree (station_id);


--
-- Name: idx_16479_result_historyresult_user_id_e30f8045_fk_account_cust; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16479_result_historyresult_user_id_e30f8045_fk_account_cust ON db.result_historyresult USING btree (user_id);


--
-- Name: idx_16482_result_preresult_shift_id_bce1b74c_fk_shift_shift_id; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16482_result_preresult_shift_id_bce1b74c_fk_shift_shift_id ON db.result_preresult USING btree (shift_id);


--
-- Name: idx_16482_result_preresult_station_id_735099a8_fk_station_stati; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16482_result_preresult_station_id_735099a8_fk_station_stati ON db.result_preresult USING btree (station_id);


--
-- Name: idx_16482_result_preresult_user_id_date_6a18d0ad_uniq; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16482_result_preresult_user_id_date_6a18d0ad_uniq ON db.result_preresult USING btree (user_id, date);


--
-- Name: idx_16485_result_result_shift_id_6131f426_fk_shift_shift_id; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16485_result_result_shift_id_6131f426_fk_shift_shift_id ON db.result_result USING btree (shift_id);


--
-- Name: idx_16485_result_result_station_id_b78a4c99_fk_station_station_; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16485_result_result_station_id_b78a4c99_fk_station_station_ ON db.result_result USING btree (station_id);


--
-- Name: idx_16485_result_result_user_id_date_e7594f14_uniq; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE UNIQUE INDEX idx_16485_result_result_user_id_date_e7594f14_uniq ON db.result_result USING btree (user_id, date);


--
-- Name: idx_16488_result_timeadjustment_user_id_09796a97_fk_account_cus; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16488_result_timeadjustment_user_id_09796a97_fk_account_cus ON db.result_timeadjustment USING btree (user_id);


--
-- Name: idx_16491_shift_shift_department_id_fe52b080_fk_account_departm; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16491_shift_shift_department_id_fe52b080_fk_account_departm ON db.shift_shift USING btree (department_id);


--
-- Name: idx_16494_station_station_department_id_2611f8a4_fk_account_dep; Type: INDEX; Schema: db; Owner: schedule_user
--

CREATE INDEX idx_16494_station_station_department_id_2611f8a4_fk_account_dep ON db.station_station USING btree (department_id);


--
-- Name: account_customuser_department_id_4fed400d; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_customuser_department_id_4fed400d ON public.account_customuser USING btree (department_id);


--
-- Name: account_customuser_groups_customuser_id_b6c60904; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_customuser_groups_customuser_id_b6c60904 ON public.account_customuser_groups USING btree (customuser_id);


--
-- Name: account_customuser_groups_group_id_2be9f6d7; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_customuser_groups_group_id_2be9f6d7 ON public.account_customuser_groups USING btree (group_id);


--
-- Name: account_customuser_user_permissions_customuser_id_03bcc114; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_customuser_user_permissions_customuser_id_03bcc114 ON public.account_customuser_user_permissions USING btree (customuser_id);


--
-- Name: account_customuser_user_permissions_permission_id_f4aec423; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_customuser_user_permissions_permission_id_f4aec423 ON public.account_customuser_user_permissions USING btree (permission_id);


--
-- Name: account_customuser_username_724ae020_like; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_customuser_username_724ae020_like ON public.account_customuser USING btree (username varchar_pattern_ops);


--
-- Name: account_department_detail_dded2664_like; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_department_detail_dded2664_like ON public.account_department USING btree (detail varchar_pattern_ops);


--
-- Name: account_departmentmanager_manager_one_id_873d07c5; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_departmentmanager_manager_one_id_873d07c5 ON public.account_departmentmanager USING btree (manager_one_id);


--
-- Name: account_departmentmanager_manager_two_id_cf9a4f7d; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_departmentmanager_manager_two_id_cf9a4f7d ON public.account_departmentmanager USING btree (manager_two_id);


--
-- Name: account_liscense_user_id_13bc59a2; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX account_liscense_user_id_13bc59a2 ON public.account_liscense USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: demand_demandofstation_shift_id_e589e74e; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX demand_demandofstation_shift_id_e589e74e ON public.demand_demandofstation USING btree (shift_id);


--
-- Name: demand_demandofstation_station_id_3875a36e; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX demand_demandofstation_station_id_3875a36e ON public.demand_demandofstation USING btree (station_id);


--
-- Name: demand_demandusertable_demand_id_21c0f5c4; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX demand_demandusertable_demand_id_21c0f5c4 ON public.demand_demandusertable USING btree (demand_id);


--
-- Name: demand_demandusertable_user_id_4dcd72e3; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX demand_demandusertable_user_id_4dcd72e3 ON public.demand_demandusertable USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: notifications_notification_action_object_content_type_7d2b8ee9; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_action_object_content_type_7d2b8ee9 ON public.notifications_notification USING btree (action_object_content_type_id);


--
-- Name: notifications_notification_actor_content_type_id_0c69d7b7; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_actor_content_type_id_0c69d7b7 ON public.notifications_notification USING btree (actor_content_type_id);


--
-- Name: notifications_notification_deleted_b32b69e6; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_deleted_b32b69e6 ON public.notifications_notification USING btree (deleted);


--
-- Name: notifications_notification_emailed_23a5ad81; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_emailed_23a5ad81 ON public.notifications_notification USING btree (emailed);


--
-- Name: notifications_notification_public_1bc30b1c; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_public_1bc30b1c ON public.notifications_notification USING btree (public);


--
-- Name: notifications_notification_recipient_id_d055f3f0; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_recipient_id_d055f3f0 ON public.notifications_notification USING btree (recipient_id);


--
-- Name: notifications_notification_recipient_id_unread_253aadc9_idx; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_recipient_id_unread_253aadc9_idx ON public.notifications_notification USING btree (recipient_id, unread);


--
-- Name: notifications_notification_target_content_type_id_ccb24d88; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_target_content_type_id_ccb24d88 ON public.notifications_notification USING btree (target_content_type_id);


--
-- Name: notifications_notification_timestamp_6a797bad; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_timestamp_6a797bad ON public.notifications_notification USING btree ("timestamp");


--
-- Name: notifications_notification_unread_cce4be30; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX notifications_notification_unread_cce4be30 ON public.notifications_notification USING btree (unread);


--
-- Name: remarks_preresultremark_content_id_325633fb; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX remarks_preresultremark_content_id_325633fb ON public.remarks_preresultremark USING btree (content_id);


--
-- Name: remarks_remarksquare_department_id_458d2357; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX remarks_remarksquare_department_id_458d2357 ON public.remarks_remarksquare USING btree (department_id);


--
-- Name: remarks_resultremark_content_id_ba47e5b7; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX remarks_resultremark_content_id_ba47e5b7 ON public.remarks_resultremark USING btree (content_id);


--
-- Name: remarks_userremark_user_id_2dbf2107; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX remarks_userremark_user_id_2dbf2107 ON public.remarks_userremark USING btree (user_id);


--
-- Name: reservation_promiseshift_user_id_0e45fd67; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX reservation_promiseshift_user_id_0e45fd67 ON public.reservation_promiseshift USING btree (user_id);


--
-- Name: reservation_reservation_user_id_261c5876; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX reservation_reservation_user_id_261c5876 ON public.reservation_reservation USING btree (user_id);


--
-- Name: result_afterresult_shift_id_dae263b5; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_afterresult_shift_id_dae263b5 ON public.result_afterresult USING btree (shift_id);


--
-- Name: result_afterresult_station_id_cf2a0d7d; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_afterresult_station_id_cf2a0d7d ON public.result_afterresult USING btree (station_id);


--
-- Name: result_afterresult_user_id_25b44a05; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_afterresult_user_id_25b44a05 ON public.result_afterresult USING btree (user_id);


--
-- Name: result_exchangeapplication_shift_apply_id_4678120b; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_exchangeapplication_shift_apply_id_4678120b ON public.result_exchangeapplication USING btree (shift_apply_id);


--
-- Name: result_exchangeapplication_shift_receive_id_532416cb; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_exchangeapplication_shift_receive_id_532416cb ON public.result_exchangeapplication USING btree (shift_receive_id);


--
-- Name: result_exchangeapplication_station_apply_id_5f3c0c25; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_exchangeapplication_station_apply_id_5f3c0c25 ON public.result_exchangeapplication USING btree (station_apply_id);


--
-- Name: result_exchangeapplication_station_receive_id_c27ee112; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_exchangeapplication_station_receive_id_c27ee112 ON public.result_exchangeapplication USING btree (station_receive_id);


--
-- Name: result_exchangeapplication_user_apply_id_29b81d76; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_exchangeapplication_user_apply_id_29b81d76 ON public.result_exchangeapplication USING btree (user_apply_id);


--
-- Name: result_exchangeapplication_user_receive_id_220c6f95; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_exchangeapplication_user_receive_id_220c6f95 ON public.result_exchangeapplication USING btree (user_receive_id);


--
-- Name: result_historyresult_shift_id_d3f90054; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_historyresult_shift_id_d3f90054 ON public.result_historyresult USING btree (shift_id);


--
-- Name: result_historyresult_station_id_7b926797; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_historyresult_station_id_7b926797 ON public.result_historyresult USING btree (station_id);


--
-- Name: result_historyresult_user_id_e30f8045; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_historyresult_user_id_e30f8045 ON public.result_historyresult USING btree (user_id);


--
-- Name: result_preresult_shift_id_bce1b74c; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_preresult_shift_id_bce1b74c ON public.result_preresult USING btree (shift_id);


--
-- Name: result_preresult_station_id_735099a8; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_preresult_station_id_735099a8 ON public.result_preresult USING btree (station_id);


--
-- Name: result_preresult_user_id_9486c598; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_preresult_user_id_9486c598 ON public.result_preresult USING btree (user_id);


--
-- Name: result_result_shift_id_6131f426; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_result_shift_id_6131f426 ON public.result_result USING btree (shift_id);


--
-- Name: result_result_station_id_b78a4c99; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_result_station_id_b78a4c99 ON public.result_result USING btree (station_id);


--
-- Name: result_result_user_id_a71f8551; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_result_user_id_a71f8551 ON public.result_result USING btree (user_id);


--
-- Name: result_timeadjustment_user_id_09796a97; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX result_timeadjustment_user_id_09796a97 ON public.result_timeadjustment USING btree (user_id);


--
-- Name: shift_shift_department_id_fe52b080; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX shift_shift_department_id_fe52b080 ON public.shift_shift USING btree (department_id);


--
-- Name: station_station_department_id_2611f8a4; Type: INDEX; Schema: public; Owner: schedule_user
--

CREATE INDEX station_station_department_id_2611f8a4 ON public.station_station USING btree (department_id);


--
-- Name: account_customuser account_customuser_department_id_4fed400d_fk_account_d; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser
    ADD CONSTRAINT account_customuser_department_id_4fed400d_fk_account_d FOREIGN KEY (department_id) REFERENCES db.account_department(id);


--
-- Name: account_customuser_groups account_customuser_g_customuser_id_b6c60904_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser_groups
    ADD CONSTRAINT account_customuser_g_customuser_id_b6c60904_fk_account_c FOREIGN KEY (customuser_id) REFERENCES db.account_customuser(id);


--
-- Name: account_customuser_groups account_customuser_groups_group_id_2be9f6d7_fk_auth_group_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser_groups
    ADD CONSTRAINT account_customuser_groups_group_id_2be9f6d7_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES db.auth_group(id);


--
-- Name: account_customuser_user_permissions account_customuser_u_customuser_id_03bcc114_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser_user_permissions
    ADD CONSTRAINT account_customuser_u_customuser_id_03bcc114_fk_account_c FOREIGN KEY (customuser_id) REFERENCES db.account_customuser(id);


--
-- Name: account_customuser_user_permissions account_customuser_u_permission_id_f4aec423_fk_auth_perm; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_customuser_user_permissions
    ADD CONSTRAINT account_customuser_u_permission_id_f4aec423_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES db.auth_permission(id);


--
-- Name: account_departmentmanager account_departmentma_department_id_af924835_fk_account_d; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_departmentmanager
    ADD CONSTRAINT account_departmentma_department_id_af924835_fk_account_d FOREIGN KEY (department_id) REFERENCES db.account_department(id);


--
-- Name: account_departmentmanager account_departmentma_manager_one_id_873d07c5_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_departmentmanager
    ADD CONSTRAINT account_departmentma_manager_one_id_873d07c5_fk_account_c FOREIGN KEY (manager_one_id) REFERENCES db.account_customuser(id);


--
-- Name: account_departmentmanager account_departmentma_manager_two_id_cf9a4f7d_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_departmentmanager
    ADD CONSTRAINT account_departmentma_manager_two_id_cf9a4f7d_fk_account_c FOREIGN KEY (manager_two_id) REFERENCES db.account_customuser(id);


--
-- Name: account_liscense account_liscense_user_id_13bc59a2_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.account_liscense
    ADD CONSTRAINT account_liscense_user_id_13bc59a2_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES db.auth_permission(id);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES db.auth_group(id);


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES db.django_content_type(id);


--
-- Name: demand_demandofstation demand_demandofstation_shift_id_e589e74e_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.demand_demandofstation
    ADD CONSTRAINT demand_demandofstation_shift_id_e589e74e_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES db.shift_shift(id);


--
-- Name: demand_demandofstation demand_demandofstation_station_id_3875a36e_fk_station_station_i; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.demand_demandofstation
    ADD CONSTRAINT demand_demandofstation_station_id_3875a36e_fk_station_station_i FOREIGN KEY (station_id) REFERENCES db.station_station(id);


--
-- Name: demand_demandusertable demand_demandusertab_demand_id_21c0f5c4_fk_demand_de; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.demand_demandusertable
    ADD CONSTRAINT demand_demandusertab_demand_id_21c0f5c4_fk_demand_de FOREIGN KEY (demand_id) REFERENCES db.demand_demandofstation(id);


--
-- Name: demand_demandusertable demand_demandusertable_user_id_4dcd72e3_fk_account_customuser_i; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.demand_demandusertable
    ADD CONSTRAINT demand_demandusertable_user_id_4dcd72e3_fk_account_customuser_i FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES db.django_content_type(id);


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: notifications_notification notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.notifications_notification
    ADD CONSTRAINT notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co FOREIGN KEY (action_object_content_type_id) REFERENCES db.django_content_type(id);


--
-- Name: notifications_notification notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.notifications_notification
    ADD CONSTRAINT notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co FOREIGN KEY (actor_content_type_id) REFERENCES db.django_content_type(id);


--
-- Name: notifications_notification notifications_notifi_recipient_id_d055f3f0_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.notifications_notification
    ADD CONSTRAINT notifications_notifi_recipient_id_d055f3f0_fk_account_c FOREIGN KEY (recipient_id) REFERENCES db.account_customuser(id);


--
-- Name: notifications_notification notifications_notifi_target_content_type__ccb24d88_fk_django_co; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.notifications_notification
    ADD CONSTRAINT notifications_notifi_target_content_type__ccb24d88_fk_django_co FOREIGN KEY (target_content_type_id) REFERENCES db.django_content_type(id);


--
-- Name: remarks_preresultremark remarks_preresultrem_content_id_325633fb_fk_remarks_r; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_preresultremark
    ADD CONSTRAINT remarks_preresultrem_content_id_325633fb_fk_remarks_r FOREIGN KEY (content_id) REFERENCES db.remarks_remarksquare(id);


--
-- Name: remarks_preresultremark remarks_preresultrem_result_id_169d8e25_fk_result_pr; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_preresultremark
    ADD CONSTRAINT remarks_preresultrem_result_id_169d8e25_fk_result_pr FOREIGN KEY (result_id) REFERENCES db.result_preresult(id);


--
-- Name: remarks_remarksquare remarks_remarksquare_department_id_458d2357_fk_account_d; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_remarksquare
    ADD CONSTRAINT remarks_remarksquare_department_id_458d2357_fk_account_d FOREIGN KEY (department_id) REFERENCES db.account_department(id);


--
-- Name: remarks_resultremark remarks_resultremark_content_id_ba47e5b7_fk_remarks_r; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_resultremark
    ADD CONSTRAINT remarks_resultremark_content_id_ba47e5b7_fk_remarks_r FOREIGN KEY (content_id) REFERENCES db.remarks_remarksquare(id);


--
-- Name: remarks_resultremark remarks_resultremark_result_id_bde0061b_fk_result_result_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_resultremark
    ADD CONSTRAINT remarks_resultremark_result_id_bde0061b_fk_result_result_id FOREIGN KEY (result_id) REFERENCES db.result_result(id);


--
-- Name: remarks_userremark remarks_userremark_user_id_2dbf2107_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.remarks_userremark
    ADD CONSTRAINT remarks_userremark_user_id_2dbf2107_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: reservation_promiseshift reservation_promises_user_id_0e45fd67_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.reservation_promiseshift
    ADD CONSTRAINT reservation_promises_user_id_0e45fd67_fk_account_c FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: reservation_reservation reservation_reservat_user_id_261c5876_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.reservation_reservation
    ADD CONSTRAINT reservation_reservat_user_id_261c5876_fk_account_c FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: result_afterresult result_afterresult_shift_id_dae263b5_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_afterresult
    ADD CONSTRAINT result_afterresult_shift_id_dae263b5_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES db.shift_shift(id);


--
-- Name: result_afterresult result_afterresult_station_id_cf2a0d7d_fk_station_station_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_afterresult
    ADD CONSTRAINT result_afterresult_station_id_cf2a0d7d_fk_station_station_id FOREIGN KEY (station_id) REFERENCES db.station_station(id);


--
-- Name: result_afterresult result_afterresult_user_id_25b44a05_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_afterresult
    ADD CONSTRAINT result_afterresult_user_id_25b44a05_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: result_exchangeapplication result_exchangeappli_shift_apply_id_4678120b_fk_shift_shi; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_shift_apply_id_4678120b_fk_shift_shi FOREIGN KEY (shift_apply_id) REFERENCES db.shift_shift(id);


--
-- Name: result_exchangeapplication result_exchangeappli_shift_receive_id_532416cb_fk_shift_shi; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_shift_receive_id_532416cb_fk_shift_shi FOREIGN KEY (shift_receive_id) REFERENCES db.shift_shift(id);


--
-- Name: result_exchangeapplication result_exchangeappli_station_apply_id_5f3c0c25_fk_station_s; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_station_apply_id_5f3c0c25_fk_station_s FOREIGN KEY (station_apply_id) REFERENCES db.station_station(id);


--
-- Name: result_exchangeapplication result_exchangeappli_station_receive_id_c27ee112_fk_station_s; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_station_receive_id_c27ee112_fk_station_s FOREIGN KEY (station_receive_id) REFERENCES db.station_station(id);


--
-- Name: result_exchangeapplication result_exchangeappli_user_apply_id_29b81d76_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_user_apply_id_29b81d76_fk_account_c FOREIGN KEY (user_apply_id) REFERENCES db.account_customuser(id);


--
-- Name: result_exchangeapplication result_exchangeappli_user_receive_id_220c6f95_fk_account_c; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_user_receive_id_220c6f95_fk_account_c FOREIGN KEY (user_receive_id) REFERENCES db.account_customuser(id);


--
-- Name: result_historyresult result_historyresult_shift_id_d3f90054_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_historyresult
    ADD CONSTRAINT result_historyresult_shift_id_d3f90054_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES db.shift_shift(id);


--
-- Name: result_historyresult result_historyresult_station_id_7b926797_fk_station_station_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_historyresult
    ADD CONSTRAINT result_historyresult_station_id_7b926797_fk_station_station_id FOREIGN KEY (station_id) REFERENCES db.station_station(id);


--
-- Name: result_historyresult result_historyresult_user_id_e30f8045_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_historyresult
    ADD CONSTRAINT result_historyresult_user_id_e30f8045_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: result_preresult result_preresult_shift_id_bce1b74c_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_preresult
    ADD CONSTRAINT result_preresult_shift_id_bce1b74c_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES db.shift_shift(id);


--
-- Name: result_preresult result_preresult_station_id_735099a8_fk_station_station_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_preresult
    ADD CONSTRAINT result_preresult_station_id_735099a8_fk_station_station_id FOREIGN KEY (station_id) REFERENCES db.station_station(id);


--
-- Name: result_preresult result_preresult_user_id_9486c598_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_preresult
    ADD CONSTRAINT result_preresult_user_id_9486c598_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: result_result result_result_shift_id_6131f426_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_result
    ADD CONSTRAINT result_result_shift_id_6131f426_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES db.shift_shift(id);


--
-- Name: result_result result_result_station_id_b78a4c99_fk_station_station_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_result
    ADD CONSTRAINT result_result_station_id_b78a4c99_fk_station_station_id FOREIGN KEY (station_id) REFERENCES db.station_station(id);


--
-- Name: result_result result_result_user_id_a71f8551_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_result
    ADD CONSTRAINT result_result_user_id_a71f8551_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: result_timeadjustment result_timeadjustment_user_id_09796a97_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.result_timeadjustment
    ADD CONSTRAINT result_timeadjustment_user_id_09796a97_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES db.account_customuser(id);


--
-- Name: shift_shift shift_shift_department_id_fe52b080_fk_account_department_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.shift_shift
    ADD CONSTRAINT shift_shift_department_id_fe52b080_fk_account_department_id FOREIGN KEY (department_id) REFERENCES db.account_department(id);


--
-- Name: station_station station_station_department_id_2611f8a4_fk_account_department_id; Type: FK CONSTRAINT; Schema: db; Owner: schedule_user
--

ALTER TABLE ONLY db.station_station
    ADD CONSTRAINT station_station_department_id_2611f8a4_fk_account_department_id FOREIGN KEY (department_id) REFERENCES db.account_department(id);


--
-- Name: account_customuser account_customuser_department_id_4fed400d_fk_account_d; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser
    ADD CONSTRAINT account_customuser_department_id_4fed400d_fk_account_d FOREIGN KEY (department_id) REFERENCES public.account_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_customuser_groups account_customuser_g_customuser_id_b6c60904_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_groups
    ADD CONSTRAINT account_customuser_g_customuser_id_b6c60904_fk_account_c FOREIGN KEY (customuser_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_customuser_groups account_customuser_groups_group_id_2be9f6d7_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_groups
    ADD CONSTRAINT account_customuser_groups_group_id_2be9f6d7_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_customuser_user_permissions account_customuser_u_customuser_id_03bcc114_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_user_permissions
    ADD CONSTRAINT account_customuser_u_customuser_id_03bcc114_fk_account_c FOREIGN KEY (customuser_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_customuser_user_permissions account_customuser_u_permission_id_f4aec423_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_customuser_user_permissions
    ADD CONSTRAINT account_customuser_u_permission_id_f4aec423_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_departmentmanager account_departmentma_department_id_af924835_fk_account_d; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_departmentmanager
    ADD CONSTRAINT account_departmentma_department_id_af924835_fk_account_d FOREIGN KEY (department_id) REFERENCES public.account_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_departmentmanager account_departmentma_manager_one_id_873d07c5_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_departmentmanager
    ADD CONSTRAINT account_departmentma_manager_one_id_873d07c5_fk_account_c FOREIGN KEY (manager_one_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_departmentmanager account_departmentma_manager_two_id_cf9a4f7d_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_departmentmanager
    ADD CONSTRAINT account_departmentma_manager_two_id_cf9a4f7d_fk_account_c FOREIGN KEY (manager_two_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_liscense account_liscense_user_id_13bc59a2_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.account_liscense
    ADD CONSTRAINT account_liscense_user_id_13bc59a2_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: demand_demandofstation demand_demandofstati_station_id_3875a36e_fk_station_s; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.demand_demandofstation
    ADD CONSTRAINT demand_demandofstati_station_id_3875a36e_fk_station_s FOREIGN KEY (station_id) REFERENCES public.station_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: demand_demandofstation demand_demandofstation_shift_id_e589e74e_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.demand_demandofstation
    ADD CONSTRAINT demand_demandofstation_shift_id_e589e74e_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES public.shift_shift(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: demand_demandusertable demand_demandusertab_demand_id_21c0f5c4_fk_demand_de; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.demand_demandusertable
    ADD CONSTRAINT demand_demandusertab_demand_id_21c0f5c4_fk_demand_de FOREIGN KEY (demand_id) REFERENCES public.demand_demandofstation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: demand_demandusertable demand_demandusertab_user_id_4dcd72e3_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.demand_demandusertable
    ADD CONSTRAINT demand_demandusertab_user_id_4dcd72e3_fk_account_c FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_notification notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.notifications_notification
    ADD CONSTRAINT notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co FOREIGN KEY (action_object_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_notification notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.notifications_notification
    ADD CONSTRAINT notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co FOREIGN KEY (actor_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_notification notifications_notifi_recipient_id_d055f3f0_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.notifications_notification
    ADD CONSTRAINT notifications_notifi_recipient_id_d055f3f0_fk_account_c FOREIGN KEY (recipient_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_notification notifications_notifi_target_content_type__ccb24d88_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.notifications_notification
    ADD CONSTRAINT notifications_notifi_target_content_type__ccb24d88_fk_django_co FOREIGN KEY (target_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: remarks_preresultremark remarks_preresultrem_content_id_325633fb_fk_remarks_r; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_preresultremark
    ADD CONSTRAINT remarks_preresultrem_content_id_325633fb_fk_remarks_r FOREIGN KEY (content_id) REFERENCES public.remarks_remarksquare(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: remarks_preresultremark remarks_preresultrem_result_id_169d8e25_fk_result_pr; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_preresultremark
    ADD CONSTRAINT remarks_preresultrem_result_id_169d8e25_fk_result_pr FOREIGN KEY (result_id) REFERENCES public.result_preresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: remarks_remarksquare remarks_remarksquare_department_id_458d2357_fk_account_d; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_remarksquare
    ADD CONSTRAINT remarks_remarksquare_department_id_458d2357_fk_account_d FOREIGN KEY (department_id) REFERENCES public.account_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: remarks_resultremark remarks_resultremark_content_id_ba47e5b7_fk_remarks_r; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_resultremark
    ADD CONSTRAINT remarks_resultremark_content_id_ba47e5b7_fk_remarks_r FOREIGN KEY (content_id) REFERENCES public.remarks_remarksquare(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: remarks_resultremark remarks_resultremark_result_id_bde0061b_fk_result_result_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_resultremark
    ADD CONSTRAINT remarks_resultremark_result_id_bde0061b_fk_result_result_id FOREIGN KEY (result_id) REFERENCES public.result_result(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: remarks_userremark remarks_userremark_user_id_2dbf2107_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.remarks_userremark
    ADD CONSTRAINT remarks_userremark_user_id_2dbf2107_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reservation_promiseshift reservation_promises_user_id_0e45fd67_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.reservation_promiseshift
    ADD CONSTRAINT reservation_promises_user_id_0e45fd67_fk_account_c FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reservation_reservation reservation_reservat_user_id_261c5876_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.reservation_reservation
    ADD CONSTRAINT reservation_reservat_user_id_261c5876_fk_account_c FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_afterresult result_afterresult_shift_id_dae263b5_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_afterresult
    ADD CONSTRAINT result_afterresult_shift_id_dae263b5_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES public.shift_shift(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_afterresult result_afterresult_station_id_cf2a0d7d_fk_station_station_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_afterresult
    ADD CONSTRAINT result_afterresult_station_id_cf2a0d7d_fk_station_station_id FOREIGN KEY (station_id) REFERENCES public.station_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_afterresult result_afterresult_user_id_25b44a05_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_afterresult
    ADD CONSTRAINT result_afterresult_user_id_25b44a05_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_exchangeapplication result_exchangeappli_shift_apply_id_4678120b_fk_shift_shi; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_shift_apply_id_4678120b_fk_shift_shi FOREIGN KEY (shift_apply_id) REFERENCES public.shift_shift(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_exchangeapplication result_exchangeappli_shift_receive_id_532416cb_fk_shift_shi; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_shift_receive_id_532416cb_fk_shift_shi FOREIGN KEY (shift_receive_id) REFERENCES public.shift_shift(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_exchangeapplication result_exchangeappli_station_apply_id_5f3c0c25_fk_station_s; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_station_apply_id_5f3c0c25_fk_station_s FOREIGN KEY (station_apply_id) REFERENCES public.station_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_exchangeapplication result_exchangeappli_station_receive_id_c27ee112_fk_station_s; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_station_receive_id_c27ee112_fk_station_s FOREIGN KEY (station_receive_id) REFERENCES public.station_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_exchangeapplication result_exchangeappli_user_apply_id_29b81d76_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_user_apply_id_29b81d76_fk_account_c FOREIGN KEY (user_apply_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_exchangeapplication result_exchangeappli_user_receive_id_220c6f95_fk_account_c; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_exchangeapplication
    ADD CONSTRAINT result_exchangeappli_user_receive_id_220c6f95_fk_account_c FOREIGN KEY (user_receive_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_historyresult result_historyresult_shift_id_d3f90054_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_historyresult
    ADD CONSTRAINT result_historyresult_shift_id_d3f90054_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES public.shift_shift(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_historyresult result_historyresult_station_id_7b926797_fk_station_station_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_historyresult
    ADD CONSTRAINT result_historyresult_station_id_7b926797_fk_station_station_id FOREIGN KEY (station_id) REFERENCES public.station_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_historyresult result_historyresult_user_id_e30f8045_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_historyresult
    ADD CONSTRAINT result_historyresult_user_id_e30f8045_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_preresult result_preresult_shift_id_bce1b74c_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_preresult
    ADD CONSTRAINT result_preresult_shift_id_bce1b74c_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES public.shift_shift(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_preresult result_preresult_station_id_735099a8_fk_station_station_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_preresult
    ADD CONSTRAINT result_preresult_station_id_735099a8_fk_station_station_id FOREIGN KEY (station_id) REFERENCES public.station_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_preresult result_preresult_user_id_9486c598_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_preresult
    ADD CONSTRAINT result_preresult_user_id_9486c598_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_result result_result_shift_id_6131f426_fk_shift_shift_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_result
    ADD CONSTRAINT result_result_shift_id_6131f426_fk_shift_shift_id FOREIGN KEY (shift_id) REFERENCES public.shift_shift(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_result result_result_station_id_b78a4c99_fk_station_station_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_result
    ADD CONSTRAINT result_result_station_id_b78a4c99_fk_station_station_id FOREIGN KEY (station_id) REFERENCES public.station_station(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_result result_result_user_id_a71f8551_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_result
    ADD CONSTRAINT result_result_user_id_a71f8551_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: result_timeadjustment result_timeadjustment_user_id_09796a97_fk_account_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.result_timeadjustment
    ADD CONSTRAINT result_timeadjustment_user_id_09796a97_fk_account_customuser_id FOREIGN KEY (user_id) REFERENCES public.account_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: shift_shift shift_shift_department_id_fe52b080_fk_account_department_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.shift_shift
    ADD CONSTRAINT shift_shift_department_id_fe52b080_fk_account_department_id FOREIGN KEY (department_id) REFERENCES public.account_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: station_station station_station_department_id_2611f8a4_fk_account_department_id; Type: FK CONSTRAINT; Schema: public; Owner: schedule_user
--

ALTER TABLE ONLY public.station_station
    ADD CONSTRAINT station_station_department_id_2611f8a4_fk_account_department_id FOREIGN KEY (department_id) REFERENCES public.account_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict dHeysdjj6B7EwVbzXvIWOF3uC3Y4W8iDKXHIkRFGvAePpxwpxpOiuC1GLjcCuF2

