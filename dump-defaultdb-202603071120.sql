--
-- PostgreSQL database dump
--

-- Dumped from database version 17.9
-- Dumped by pg_dump version 17.0

-- Started on 2026-03-07 11:20:50

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 16454)
-- Name: public; Type: SCHEMA; Schema: -; Owner: avnadmin
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO avnadmin;

--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: avnadmin
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 294 (class 1255 OID 17390)
-- Name: on_update_current_timestamp_directus_sessions(); Type: FUNCTION; Schema: public; Owner: avnadmin
--

CREATE FUNCTION public.on_update_current_timestamp_directus_sessions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.expires = now();
   RETURN NEW;
END;
$$;


ALTER FUNCTION public.on_update_current_timestamp_directus_sessions() OWNER TO avnadmin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16455)
-- Name: directus_access; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_access (
    id character(36) NOT NULL,
    role character(36) DEFAULT NULL::bpchar,
    "user" character(36) DEFAULT NULL::bpchar,
    policy character(36) NOT NULL,
    sort bigint
);


ALTER TABLE public.directus_access OWNER TO avnadmin;

--
-- TOC entry 221 (class 1259 OID 16461)
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_activity (
    id bigint NOT NULL,
    action character varying(45) NOT NULL,
    "user" character(36) DEFAULT NULL::bpchar,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) DEFAULT NULL::character varying,
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.directus_activity OWNER TO avnadmin;

--
-- TOC entry 220 (class 1259 OID 16460)
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO avnadmin;

--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 220
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- TOC entry 222 (class 1259 OID 16471)
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64) DEFAULT NULL::character varying,
    note text,
    display_template character varying(255) DEFAULT NULL::character varying,
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations text,
    archive_field character varying(64) DEFAULT NULL::character varying,
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255) DEFAULT NULL::character varying,
    unarchive_value character varying(255) DEFAULT NULL::character varying,
    sort_field character varying(64) DEFAULT NULL::character varying,
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255) DEFAULT NULL::character varying,
    item_duplication_fields text,
    sort bigint,
    "group" character varying(64) DEFAULT NULL::character varying,
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255) DEFAULT NULL::character varying,
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO avnadmin;

--
-- TOC entry 223 (class 1259 OID 16491)
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_comments (
    id character(36) NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created character(36) DEFAULT NULL::bpchar,
    user_updated character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_comments OWNER TO avnadmin;

--
-- TOC entry 224 (class 1259 OID 16500)
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_dashboards (
    id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created character(36) DEFAULT NULL::bpchar,
    color character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.directus_dashboards OWNER TO avnadmin;

--
-- TOC entry 225 (class 1259 OID 16509)
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id character(36) NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_extensions OWNER TO avnadmin;

--
-- TOC entry 227 (class 1259 OID 16517)
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_fields (
    id bigint NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64) DEFAULT NULL::character varying,
    interface character varying(64) DEFAULT NULL::character varying,
    options text,
    display character varying(64) DEFAULT NULL::character varying,
    display_options text,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort bigint,
    width character varying(30) DEFAULT 'full'::character varying,
    translations text,
    note text,
    conditions text,
    required boolean DEFAULT false,
    "group" character varying(64) DEFAULT NULL::character varying,
    validation text,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO avnadmin;

--
-- TOC entry 226 (class 1259 OID 16516)
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO avnadmin;

--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 226
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- TOC entry 228 (class 1259 OID 16531)
-- Name: directus_files; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_files (
    id character(36) NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255) DEFAULT NULL::character varying,
    filename_download character varying(255) NOT NULL,
    title character varying(255) DEFAULT NULL::character varying,
    type character varying(255) DEFAULT NULL::character varying,
    folder character(36) DEFAULT NULL::bpchar,
    uploaded_by character(36) DEFAULT NULL::bpchar,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by character(36) DEFAULT NULL::bpchar,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50) DEFAULT NULL::character varying,
    filesize bigint,
    width bigint,
    height bigint,
    duration bigint,
    embed character varying(200) DEFAULT NULL::character varying,
    description text,
    location text,
    tags text,
    metadata text,
    focal_point_x bigint,
    focal_point_y bigint,
    tus_id character varying(64) DEFAULT NULL::character varying,
    tus_data text,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO avnadmin;

--
-- TOC entry 229 (class 1259 OID 16547)
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_flows (
    id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(255) DEFAULT NULL::character varying,
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255) DEFAULT NULL::character varying,
    accountability character varying(255) DEFAULT 'all'::character varying,
    options text,
    operation character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_flows OWNER TO avnadmin;

--
-- TOC entry 230 (class 1259 OID 16560)
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_folders (
    id character(36) NOT NULL,
    name character varying(255) NOT NULL,
    parent character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_folders OWNER TO avnadmin;

--
-- TOC entry 231 (class 1259 OID 16564)
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO avnadmin;

--
-- TOC entry 233 (class 1259 OID 16571)
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_notifications (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient character(36) NOT NULL,
    sender character(36) DEFAULT NULL::bpchar,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64) DEFAULT NULL::character varying,
    item character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.directus_notifications OWNER TO avnadmin;

--
-- TOC entry 232 (class 1259 OID 16570)
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO avnadmin;

--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 232
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- TOC entry 234 (class 1259 OID 16582)
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_operations (
    id character(36) NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x bigint NOT NULL,
    position_y bigint NOT NULL,
    options text,
    resolve character(36) DEFAULT NULL::bpchar,
    reject character(36) DEFAULT NULL::bpchar,
    flow character(36) NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_operations OWNER TO avnadmin;

--
-- TOC entry 235 (class 1259 OID 16592)
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_panels (
    id character(36) NOT NULL,
    dashboard character(36) NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10) DEFAULT NULL::character varying,
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x bigint NOT NULL,
    position_y bigint NOT NULL,
    width bigint NOT NULL,
    height bigint NOT NULL,
    options text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_panels OWNER TO avnadmin;

--
-- TOC entry 237 (class 1259 OID 16604)
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_permissions (
    id bigint NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions text,
    validation text,
    presets text,
    fields text,
    policy character(36) NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO avnadmin;

--
-- TOC entry 236 (class 1259 OID 16603)
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO avnadmin;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 236
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- TOC entry 238 (class 1259 OID 16610)
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_policies (
    id character(36) NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO avnadmin;

--
-- TOC entry 240 (class 1259 OID 16620)
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_presets (
    id bigint NOT NULL,
    bookmark character varying(255) DEFAULT NULL::character varying,
    "user" character(36) DEFAULT NULL::bpchar,
    role character(36) DEFAULT NULL::bpchar,
    collection character varying(64) DEFAULT NULL::character varying,
    search character varying(100) DEFAULT NULL::character varying,
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query text,
    layout_options text,
    refresh_interval bigint,
    filter text,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.directus_presets OWNER TO avnadmin;

--
-- TOC entry 239 (class 1259 OID 16619)
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_presets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO avnadmin;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 239
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- TOC entry 242 (class 1259 OID 16635)
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_relations (
    id bigint NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64) DEFAULT NULL::character varying,
    one_field character varying(64) DEFAULT NULL::character varying,
    one_collection_field character varying(64) DEFAULT NULL::character varying,
    one_allowed_collections text,
    junction_field character varying(64) DEFAULT NULL::character varying,
    sort_field character varying(64) DEFAULT NULL::character varying,
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO avnadmin;

--
-- TOC entry 241 (class 1259 OID 16634)
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO avnadmin;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 241
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- TOC entry 244 (class 1259 OID 16648)
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_revisions (
    id bigint NOT NULL,
    activity bigint NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data text,
    delta text,
    parent bigint,
    version character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_revisions OWNER TO avnadmin;

--
-- TOC entry 243 (class 1259 OID 16647)
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_revisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO avnadmin;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 243
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- TOC entry 245 (class 1259 OID 16655)
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_roles (
    id character(36) NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_roles OWNER TO avnadmin;

--
-- TOC entry 246 (class 1259 OID 16662)
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" character(36) DEFAULT NULL::bpchar,
    expires timestamp with time zone,
    ip character varying(255) DEFAULT NULL::character varying,
    user_agent text,
    share character(36) DEFAULT NULL::bpchar,
    origin character varying(255) DEFAULT NULL::character varying,
    next_token character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public.directus_sessions OWNER TO avnadmin;

--
-- TOC entry 248 (class 1259 OID 16673)
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_settings (
    id bigint NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255) DEFAULT NULL::character varying,
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo character(36) DEFAULT NULL::bpchar,
    public_foreground character(36) DEFAULT NULL::bpchar,
    public_background character(36) DEFAULT NULL::bpchar,
    public_note text,
    auth_login_attempts bigint DEFAULT '25'::bigint,
    auth_password_policy character varying(100) DEFAULT NULL::character varying,
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets text,
    custom_css text,
    storage_default_folder character(36) DEFAULT NULL::bpchar,
    basemaps text,
    mapbox_key character varying(255) DEFAULT NULL::character varying,
    module_bar text,
    project_descriptor character varying(100) DEFAULT NULL::character varying,
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios text,
    public_favicon character(36) DEFAULT NULL::bpchar,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255) DEFAULT NULL::character varying,
    theme_light_overrides text,
    default_theme_dark character varying(255) DEFAULT NULL::character varying,
    theme_dark_overrides text,
    report_error_url character varying(255) DEFAULT NULL::character varying,
    report_bug_url character varying(255) DEFAULT NULL::character varying,
    report_feature_url character varying(255) DEFAULT NULL::character varying,
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role character(36) DEFAULT NULL::bpchar,
    public_registration_email_filter text,
    visual_editor_urls text,
    accepted_terms boolean DEFAULT false,
    project_id uuid
);


ALTER TABLE public.directus_settings OWNER TO avnadmin;

--
-- TOC entry 247 (class 1259 OID 16672)
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO avnadmin;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 247
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- TOC entry 249 (class 1259 OID 16702)
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_shares (
    id character(36) NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role character(36) DEFAULT NULL::bpchar,
    password character varying(255) DEFAULT NULL::character varying,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used bigint DEFAULT '0'::bigint,
    max_uses bigint
);


ALTER TABLE public.directus_shares OWNER TO avnadmin;

--
-- TOC entry 250 (class 1259 OID 16713)
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_translations (
    id character(36) NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO avnadmin;

--
-- TOC entry 251 (class 1259 OID 16718)
-- Name: directus_users; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_users (
    id character(36) NOT NULL,
    first_name character varying(50) DEFAULT NULL::character varying,
    last_name character varying(50) DEFAULT NULL::character varying,
    email character varying(128) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT NULL::character varying,
    location character varying(255) DEFAULT NULL::character varying,
    title character varying(50) DEFAULT NULL::character varying,
    description text,
    tags text,
    avatar character(36) DEFAULT NULL::bpchar,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255) DEFAULT NULL::character varying,
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role character(36) DEFAULT NULL::bpchar,
    token character varying(255) DEFAULT NULL::character varying,
    last_access timestamp with time zone,
    last_page character varying(255) DEFAULT NULL::character varying,
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255) DEFAULT NULL::character varying,
    auth_data text,
    email_notifications boolean DEFAULT true,
    appearance character varying(255) DEFAULT NULL::character varying,
    theme_dark character varying(255) DEFAULT NULL::character varying,
    theme_light character varying(255) DEFAULT NULL::character varying,
    theme_light_overrides text,
    theme_dark_overrides text,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO avnadmin;

--
-- TOC entry 252 (class 1259 OID 16742)
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_versions (
    id character(36) NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255) DEFAULT NULL::character varying,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created character(36) DEFAULT NULL::bpchar,
    user_updated character(36) DEFAULT NULL::bpchar,
    delta text
);


ALTER TABLE public.directus_versions OWNER TO avnadmin;

--
-- TOC entry 254 (class 1259 OID 16754)
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.directus_webhooks (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers text,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.directus_webhooks OWNER TO avnadmin;

--
-- TOC entry 253 (class 1259 OID 16753)
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO avnadmin;

--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 253
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- TOC entry 256 (class 1259 OID 16766)
-- Name: educations; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.educations (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    institution character varying(255) DEFAULT NULL::character varying,
    major character varying(255) DEFAULT NULL::character varying,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    sequence bigint,
    education_type character varying(255) DEFAULT NULL::character varying,
    detail text
);


ALTER TABLE public.educations OWNER TO avnadmin;

--
-- TOC entry 255 (class 1259 OID 16765)
-- Name: educations_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.educations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.educations_id_seq OWNER TO avnadmin;

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 255
-- Name: educations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.educations_id_seq OWNED BY public.educations.id;


--
-- TOC entry 258 (class 1259 OID 16779)
-- Name: experiences; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.experiences (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    company character varying(255) DEFAULT NULL::character varying,
    "position" character varying(255) DEFAULT NULL::character varying,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    job_detail text,
    job_type bigint,
    sequence bigint
);


ALTER TABLE public.experiences OWNER TO avnadmin;

--
-- TOC entry 257 (class 1259 OID 16778)
-- Name: experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.experiences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experiences_id_seq OWNER TO avnadmin;

--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 257
-- Name: experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.experiences_id_seq OWNED BY public.experiences.id;


--
-- TOC entry 280 (class 1259 OID 18114)
-- Name: experiences_skills; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.experiences_skills (
    id integer NOT NULL,
    experiences_id bigint,
    skills_id bigint
);


ALTER TABLE public.experiences_skills OWNER TO avnadmin;

--
-- TOC entry 279 (class 1259 OID 18113)
-- Name: experiences_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.experiences_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experiences_skills_id_seq OWNER TO avnadmin;

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 279
-- Name: experiences_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.experiences_skills_id_seq OWNED BY public.experiences_skills.id;


--
-- TOC entry 260 (class 1259 OID 16791)
-- Name: job_types; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.job_types (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.job_types OWNER TO avnadmin;

--
-- TOC entry 259 (class 1259 OID 16790)
-- Name: job_types_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.job_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_types_id_seq OWNER TO avnadmin;

--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 259
-- Name: job_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.job_types_id_seq OWNED BY public.job_types.id;


--
-- TOC entry 262 (class 1259 OID 16802)
-- Name: languanges; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.languanges (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    name character varying(255) DEFAULT NULL::character varying,
    level_types text
);


ALTER TABLE public.languanges OWNER TO avnadmin;

--
-- TOC entry 261 (class 1259 OID 16801)
-- Name: languanges_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.languanges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.languanges_id_seq OWNER TO avnadmin;

--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 261
-- Name: languanges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.languanges_id_seq OWNED BY public.languanges.id;


--
-- TOC entry 264 (class 1259 OID 16813)
-- Name: languanges_undefined; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.languanges_undefined (
    id bigint NOT NULL,
    languanges_id bigint,
    item character varying(255) DEFAULT NULL::character varying,
    collection character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.languanges_undefined OWNER TO avnadmin;

--
-- TOC entry 263 (class 1259 OID 16812)
-- Name: languanges_undefined_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.languanges_undefined_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.languanges_undefined_id_seq OWNER TO avnadmin;

--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 263
-- Name: languanges_undefined_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.languanges_undefined_id_seq OWNED BY public.languanges_undefined.id;


--
-- TOC entry 266 (class 1259 OID 16822)
-- Name: main_contents; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.main_contents (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    about_desc text,
    project_desc text,
    education_desc text,
    experience_desc text
);


ALTER TABLE public.main_contents OWNER TO avnadmin;

--
-- TOC entry 265 (class 1259 OID 16821)
-- Name: main_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.main_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.main_contents_id_seq OWNER TO avnadmin;

--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 265
-- Name: main_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.main_contents_id_seq OWNED BY public.main_contents.id;


--
-- TOC entry 272 (class 1259 OID 16849)
-- Name: project_types; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.project_types (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    name character varying(255) DEFAULT NULL::character varying,
    icon character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.project_types OWNER TO avnadmin;

--
-- TOC entry 271 (class 1259 OID 16848)
-- Name: project_types_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.project_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_types_id_seq OWNER TO avnadmin;

--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 271
-- Name: project_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.project_types_id_seq OWNED BY public.project_types.id;


--
-- TOC entry 268 (class 1259 OID 16832)
-- Name: projects; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    title character varying(255) DEFAULT NULL::character varying,
    description text,
    detail text,
    type bigint,
    "repo_Link" text,
    "Url" text
);


ALTER TABLE public.projects OWNER TO avnadmin;

--
-- TOC entry 270 (class 1259 OID 16843)
-- Name: projects_files; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.projects_files (
    id bigint NOT NULL,
    projects_id bigint,
    directus_files_id character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.projects_files OWNER TO avnadmin;

--
-- TOC entry 269 (class 1259 OID 16842)
-- Name: projects_files_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.projects_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_files_id_seq OWNER TO avnadmin;

--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 269
-- Name: projects_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.projects_files_id_seq OWNED BY public.projects_files.id;


--
-- TOC entry 267 (class 1259 OID 16831)
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO avnadmin;

--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 267
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- TOC entry 278 (class 1259 OID 18096)
-- Name: projects_skills; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.projects_skills (
    id integer NOT NULL,
    projects_id bigint,
    skills_id bigint
);


ALTER TABLE public.projects_skills OWNER TO avnadmin;

--
-- TOC entry 282 (class 1259 OID 18137)
-- Name: projects_skills_1; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.projects_skills_1 (
    id integer NOT NULL,
    projects_id bigint,
    skills_id bigint
);


ALTER TABLE public.projects_skills_1 OWNER TO avnadmin;

--
-- TOC entry 281 (class 1259 OID 18136)
-- Name: projects_skills_1_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.projects_skills_1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_skills_1_id_seq OWNER TO avnadmin;

--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 281
-- Name: projects_skills_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.projects_skills_1_id_seq OWNED BY public.projects_skills_1.id;


--
-- TOC entry 277 (class 1259 OID 18095)
-- Name: projects_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.projects_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_skills_id_seq OWNER TO avnadmin;

--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 277
-- Name: projects_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.projects_skills_id_seq OWNED BY public.projects_skills.id;


--
-- TOC entry 274 (class 1259 OID 16861)
-- Name: skills; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.skills (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    title character varying(255) DEFAULT NULL::character varying,
    icon character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.skills OWNER TO avnadmin;

--
-- TOC entry 273 (class 1259 OID 16860)
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_id_seq OWNER TO avnadmin;

--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 273
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- TOC entry 276 (class 1259 OID 16873)
-- Name: specialties; Type: TABLE; Schema: public; Owner: avnadmin
--

CREATE TABLE public.specialties (
    id bigint NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    sort bigint,
    user_created character(36) DEFAULT NULL::bpchar,
    date_created timestamp with time zone,
    user_updated character(36) DEFAULT NULL::bpchar,
    date_updated timestamp with time zone,
    title character varying(255) DEFAULT NULL::character varying,
    description text,
    icon character(36) DEFAULT NULL::bpchar
);


ALTER TABLE public.specialties OWNER TO avnadmin;

--
-- TOC entry 275 (class 1259 OID 16872)
-- Name: specialties_id_seq; Type: SEQUENCE; Schema: public; Owner: avnadmin
--

CREATE SEQUENCE public.specialties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specialties_id_seq OWNER TO avnadmin;

--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 275
-- Name: specialties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: avnadmin
--

ALTER SEQUENCE public.specialties_id_seq OWNED BY public.specialties.id;


--
-- TOC entry 4462 (class 2604 OID 16464)
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- TOC entry 4492 (class 2604 OID 16520)
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- TOC entry 4522 (class 2604 OID 16574)
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- TOC entry 4539 (class 2604 OID 16607)
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- TOC entry 4544 (class 2604 OID 16623)
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- TOC entry 4553 (class 2604 OID 16638)
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- TOC entry 4560 (class 2604 OID 16651)
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- TOC entry 4569 (class 2604 OID 16676)
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- TOC entry 4626 (class 2604 OID 16757)
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- TOC entry 4632 (class 2604 OID 16769)
-- Name: educations id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.educations ALTER COLUMN id SET DEFAULT nextval('public.educations_id_seq'::regclass);


--
-- TOC entry 4639 (class 2604 OID 16782)
-- Name: experiences id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences ALTER COLUMN id SET DEFAULT nextval('public.experiences_id_seq'::regclass);


--
-- TOC entry 4688 (class 2604 OID 18117)
-- Name: experiences_skills id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences_skills ALTER COLUMN id SET DEFAULT nextval('public.experiences_skills_id_seq'::regclass);


--
-- TOC entry 4645 (class 2604 OID 16794)
-- Name: job_types id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.job_types ALTER COLUMN id SET DEFAULT nextval('public.job_types_id_seq'::regclass);


--
-- TOC entry 4650 (class 2604 OID 16805)
-- Name: languanges id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.languanges ALTER COLUMN id SET DEFAULT nextval('public.languanges_id_seq'::regclass);


--
-- TOC entry 4655 (class 2604 OID 16816)
-- Name: languanges_undefined id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.languanges_undefined ALTER COLUMN id SET DEFAULT nextval('public.languanges_undefined_id_seq'::regclass);


--
-- TOC entry 4658 (class 2604 OID 16825)
-- Name: main_contents id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.main_contents ALTER COLUMN id SET DEFAULT nextval('public.main_contents_id_seq'::regclass);


--
-- TOC entry 4669 (class 2604 OID 16852)
-- Name: project_types id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.project_types ALTER COLUMN id SET DEFAULT nextval('public.project_types_id_seq'::regclass);


--
-- TOC entry 4662 (class 2604 OID 16835)
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- TOC entry 4667 (class 2604 OID 16846)
-- Name: projects_files id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_files ALTER COLUMN id SET DEFAULT nextval('public.projects_files_id_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 18099)
-- Name: projects_skills id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills ALTER COLUMN id SET DEFAULT nextval('public.projects_skills_id_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 18140)
-- Name: projects_skills_1 id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills_1 ALTER COLUMN id SET DEFAULT nextval('public.projects_skills_1_id_seq'::regclass);


--
-- TOC entry 4675 (class 2604 OID 16864)
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- TOC entry 4681 (class 2604 OID 16876)
-- Name: specialties id; Type: DEFAULT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.specialties ALTER COLUMN id SET DEFAULT nextval('public.specialties_id_seq'::regclass);


--
-- TOC entry 5071 (class 0 OID 16455)
-- Dependencies: 219
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
4c7bf091-93e7-4fec-8cf3-c9a5e0985d39	8a883d4d-af7e-4354-98a4-176b474e9fcc	\N	92e59311-464c-4d00-9257-23c39aa0324c	\N
75adc3f9-1874-4865-a8c9-bb09d6f79b7c	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
\.


--
-- TOC entry 5073 (class 0 OID 16461)
-- Dependencies: 221
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:50:03+00	172.28.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
2	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:50:34+00	172.28.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	0fcda0d3-1462-44ff-bbf2-089b329221f8	http://localhost:8055
3	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:50:43+00	172.28.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
4	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:56:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	0fcda0d3-1462-44ff-bbf2-089b329221f8	http://localhost:8055
5	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:57:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	edbfd472-67cc-4dd9-a032-17c13e755b77	http://localhost:8055
6	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:57:22+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
7	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:58:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	edbfd472-67cc-4dd9-a032-17c13e755b77	http://localhost:8055
8	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:58:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	edd7abe3-0790-40f8-9a31-c8c308171741	http://localhost:8055
9	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:59:17+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
10	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:11:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
11	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:11:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
12	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:11:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
13	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:11:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
14	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:11:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
15	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:11:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
16	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:11:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
17	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
18	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
19	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
20	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
21	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
22	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	12	http://localhost:8055
23	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
24	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
25	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
26	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
27	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
28	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
29	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
30	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
31	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
32	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
33	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
34	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
35	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
36	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:49+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
37	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:12:49+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	12	http://localhost:8055
38	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	13	http://localhost:8055
39	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	14	http://localhost:8055
40	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	15	http://localhost:8055
41	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	16	http://localhost:8055
42	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	17	http://localhost:8055
43	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	18	http://localhost:8055
44	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	19	http://localhost:8055
45	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
46	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	20	http://localhost:8055
47	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	21	http://localhost:8055
48	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
49	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	23	http://localhost:8055
50	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	24	http://localhost:8055
51	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	25	http://localhost:8055
52	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	26	http://localhost:8055
53	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:13:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
54	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
55	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	28	http://localhost:8055
56	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	29	http://localhost:8055
57	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	30	http://localhost:8055
58	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	31	http://localhost:8055
59	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
60	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
61	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	33	http://localhost:8055
62	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	34	http://localhost:8055
63	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	35	http://localhost:8055
64	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	36	http://localhost:8055
65	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	37	http://localhost:8055
66	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	38	http://localhost:8055
67	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	39	http://localhost:8055
68	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
69	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	40	http://localhost:8055
70	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	41	http://localhost:8055
71	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	42	http://localhost:8055
72	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	43	http://localhost:8055
73	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	44	http://localhost:8055
74	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	45	http://localhost:8055
75	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	46	http://localhost:8055
76	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:14:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
77	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:15:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
78	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:15:56+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
79	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:16:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
80	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 14:17:07+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
81	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:27:15+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
82	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	47	http://localhost:8055
83	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	48	http://localhost:8055
84	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	49	http://localhost:8055
85	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	50	http://localhost:8055
86	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	51	http://localhost:8055
87	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	52	http://localhost:8055
88	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	53	http://localhost:8055
89	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	specialties	http://localhost:8055
90	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	54	http://localhost:8055
91	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	55	http://localhost:8055
92	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	56	http://localhost:8055
93	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	57	http://localhost:8055
94	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	58	http://localhost:8055
95	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	59	http://localhost:8055
96	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	60	http://localhost:8055
97	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	languanges	http://localhost:8055
98	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:29:52+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	languanges	http://localhost:8055
99	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	specialties	http://localhost:8055
100	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	specialties	http://localhost:8055
101	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
102	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
103	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	languanges	http://localhost:8055
104	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
105	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
106	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
107	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
108	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
109	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
110	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	languanges	http://localhost:8055
111	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
112	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
113	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:50+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
114	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:50+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
115	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:50+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
116	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:50+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	languanges	http://localhost:8055
117	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:50+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
118	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:47+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
119	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
120	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	specialties	http://localhost:8055
121	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
122	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
123	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
124	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
125	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:30:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	languanges	http://localhost:8055
126	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	61	http://localhost:8055
127	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:36+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
128	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:36+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	61	http://localhost:8055
129	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:36+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	28	http://localhost:8055
130	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:36+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	29	http://localhost:8055
131	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:36+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	30	http://localhost:8055
132	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:36+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	31	http://localhost:8055
133	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:36+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
134	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	62	http://localhost:8055
135	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
136	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	61	http://localhost:8055
137	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	62	http://localhost:8055
138	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	28	http://localhost:8055
139	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	29	http://localhost:8055
140	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	30	http://localhost:8055
141	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	31	http://localhost:8055
142	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:38:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
143	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:09+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	63	http://localhost:8055
144	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
145	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	61	http://localhost:8055
146	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	62	http://localhost:8055
147	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	63	http://localhost:8055
148	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	28	http://localhost:8055
149	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	29	http://localhost:8055
150	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	30	http://localhost:8055
151	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	31	http://localhost:8055
152	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
153	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	64	http://localhost:8055
154	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
155	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	61	http://localhost:8055
156	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	62	http://localhost:8055
157	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	63	http://localhost:8055
158	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	64	http://localhost:8055
159	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	28	http://localhost:8055
160	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	29	http://localhost:8055
161	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	30	http://localhost:8055
162	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	31	http://localhost:8055
163	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:39:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
164	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	65	http://localhost:8055
165	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	66	http://localhost:8055
166	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	67	http://localhost:8055
167	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	68	http://localhost:8055
168	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	69	http://localhost:8055
169	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	70	http://localhost:8055
170	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	71	http://localhost:8055
171	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:28+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	language_levels	http://localhost:8055
172	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:40+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	language_levels	http://localhost:8055
173	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	language_levels	http://localhost:8055
174	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
175	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
176	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
177	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
178	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:47:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
179	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:48:38+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	72	http://localhost:8055
180	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:49:09+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	73	http://localhost:8055
181	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:49:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	73	http://localhost:8055
182	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:51:25+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	74	http://localhost:8055
183	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 21:51:37+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	74	http://localhost:8055
184	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:06:38+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	75	http://localhost:8055
185	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:08:18+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	76	http://localhost:8055
186	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:08:26+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	75	http://localhost:8055
187	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:09:40+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	77	http://localhost:8055
188	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:09:56+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	76	http://localhost:8055
189	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:10:35+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	78	http://localhost:8055
190	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:10:53+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	79	http://localhost:8055
191	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:12:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	80	http://localhost:8055
192	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:12:35+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	81	http://localhost:8055
193	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:15:05+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	82	http://localhost:8055
194	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:16:03+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	83	http://localhost:8055
195	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:18:26+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	84	http://localhost:8055
196	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:18:58+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	85	http://localhost:8055
197	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:19:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	86	http://localhost:8055
198	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:20:44+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	87	http://localhost:8055
199	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:20:59+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	88	http://localhost:8055
200	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:21:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	89	http://localhost:8055
201	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:21:44+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	90	http://localhost:8055
202	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:22:33+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	91	http://localhost:8055
203	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:23:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	92	http://localhost:8055
204	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:24:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	93	http://localhost:8055
205	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:28:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	94	http://localhost:8055
206	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:28:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	95	http://localhost:8055
207	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:28:21+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	projects_files	http://localhost:8055
208	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:28:22+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	96	http://localhost:8055
209	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:28:22+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	97	http://localhost:8055
210	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:28:37+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	98	http://localhost:8055
211	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:29:42+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	99	http://localhost:8055
212	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:45:00+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	100	http://localhost:8055
213	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:45:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	100	http://localhost:8055
214	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-14 22:45:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	101	http://localhost:8055
215	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 20:57:58+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
216	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:02:18+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
221	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:04:25+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	languanges	1	http://localhost:8055
222	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:07:53+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	76	http://localhost:8055
223	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:08:26+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	102	http://localhost:8055
224	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:08:26+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	103	http://localhost:8055
225	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:08:26+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_collections	languanges_language_levels	http://localhost:8055
226	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:08:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	104	http://localhost:8055
227	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:08:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	105	http://localhost:8055
232	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:08:52+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	languanges	1	http://localhost:8055
237	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:09:13+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
238	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:14:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	educations	1	http://localhost:8055
239	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:16:10+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	educations	2	http://localhost:8055
240	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:17:26+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	educations	3	http://localhost:8055
241	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:18:46+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	educations	4	http://localhost:8055
242	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:39:35+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
243	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:40:35+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	projects	1	http://localhost:8055
244	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:42:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	93	http://localhost:8055
245	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:42:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	projects	2	http://localhost:8055
246	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 20:36:57+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
247	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:35:33+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	38808ea0-ac80-475b-998d-b4aa6788c58f	http://localhost:8055
248	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:36:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	specialties	1	http://localhost:8055
249	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:36:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	7e228bab-3258-4919-97d2-95cd07fe7cc6	http://localhost:8055
250	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:36:56+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	specialties	2	http://localhost:8055
251	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:37:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	bb9979d1-0ee2-4ea0-a926-aafba0432619	http://localhost:8055
252	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:37:38+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	specialties	3	http://localhost:8055
253	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:38:13+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	cb0092ff-3471-474d-8b0e-270664d600fa	http://localhost:8055
254	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:38:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	cb0092ff-3471-474d-8b0e-270664d600fa	http://localhost:8055
255	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:38:38+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	b5761b06-fdc3-405d-9e2e-9fb176400c86	http://localhost:8055
256	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:38:47+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	specialties	4	http://localhost:8055
257	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:39:09+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	74	http://localhost:8055
258	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:46:37+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	106	http://localhost:8055
259	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:46:43+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	101	http://localhost:8055
260	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:46:53+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_fields	106	http://localhost:8055
261	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:47:10+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	7e0aaaf6-fc6f-45d5-8736-7035c6f044dc	http://localhost:8055
262	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:47:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	60913cc8-ac74-4123-8054-e645daf166f3	http://localhost:8055
263	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:48:06+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	skills	1	http://localhost:8055
264	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:48:23+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	0bbcdfb5-3d07-4877-9047-d96c480bc3c3	http://localhost:8055
265	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:48:46+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	skills	2	http://localhost:8055
266	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:03+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	d4a3abb5-6770-4e03-a792-8192b8b92138	http://localhost:8055
267	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:10+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	skills	3	http://localhost:8055
268	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:35+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	directus_files	cb7e94b4-45ab-4edb-8d67-94e93f4d6702	http://localhost:8055
269	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:48+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	skills	4	http://localhost:8055
270	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:18:19+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
271	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	1	http://localhost:8055
272	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	2	http://localhost:8055
273	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	3	http://localhost:8055
274	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	4	http://localhost:8055
275	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	5	http://localhost:8055
276	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	6	http://localhost:8055
277	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	7	http://localhost:8055
278	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	8	http://localhost:8055
279	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	9	http://localhost:8055
280	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	10	http://localhost:8055
281	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
282	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:54:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	http://localhost:8055
283	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	2	http://localhost:8055
284	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	3	http://localhost:8055
285	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	4	http://localhost:8055
286	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	5	http://localhost:8055
287	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	6	http://localhost:8055
288	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	7	http://localhost:8055
289	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	1	http://localhost:8055
290	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	8	http://localhost:8055
291	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	9	http://localhost:8055
292	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	10	http://localhost:8055
293	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
294	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:56:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	http://localhost:8055
295	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:57:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	projects	1	http://localhost:8055
296	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 20:57:11+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	projects	2	http://localhost:8055
297	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	107	http://localhost:8055
298	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	108	http://localhost:8055
299	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	109	http://localhost:8055
300	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	110	http://localhost:8055
301	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	111	http://localhost:8055
302	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	112	http://localhost:8055
303	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	113	http://localhost:8055
304	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:08:29+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_collections	project_types	http://localhost:8055
305	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:11:59+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	114	http://localhost:8055
306	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	107	http://localhost:8055
307	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	114	http://localhost:8055
308	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	108	http://localhost:8055
309	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	109	http://localhost:8055
310	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	110	http://localhost:8055
311	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	111	http://localhost:8055
312	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	112	http://localhost:8055
313	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:12:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	113	http://localhost:8055
314	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:14:30+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	115	http://localhost:8055
315	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:14:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	93	http://localhost:8055
316	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	project_types	1	http://localhost:8055
317	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:22+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	project_types	2	http://localhost:8055
318	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:31+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	project_types	3	http://localhost:8055
319	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:49+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	project_types	4	http://localhost:8055
320	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:16:04+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	projects	1	http://localhost:8055
321	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:16:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	115	http://localhost:8055
322	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:16:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	projects	2	http://localhost:8055
323	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:17:10+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	11	http://localhost:8055
324	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:17:10+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
325	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:17:10+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	http://localhost:8055
326	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:22:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
327	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:24:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	83	http://localhost:8055
328	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:24:58+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	educations	1	http://localhost:8055
329	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:25:02+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	educations	2	http://localhost:8055
330	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:25:46+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	87	http://localhost:8055
331	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:26:38+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	87	http://localhost:8055
332	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:27:41+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	87	http://localhost:8055
333	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:37:16+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	87	http://localhost:8055
334	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:37:31+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
335	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:01+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	87	http://localhost:8055
336	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	116	http://localhost:8055
337	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	117	http://localhost:8055
338	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	118	http://localhost:8055
339	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	119	http://localhost:8055
340	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	120	http://localhost:8055
341	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	121	http://localhost:8055
342	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	122	http://localhost:8055
343	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:24+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_collections	job_types	http://localhost:8055
344	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:35+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	123	http://localhost:8055
345	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	116	http://localhost:8055
346	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	123	http://localhost:8055
347	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	117	http://localhost:8055
348	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	118	http://localhost:8055
349	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	119	http://localhost:8055
350	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	120	http://localhost:8055
351	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	121	http://localhost:8055
352	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:41:39+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	122	http://localhost:8055
353	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:42:12+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	124	http://localhost:8055
354	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:42:27+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	job_types	1	http://localhost:8055
355	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:42:34+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	job_types	2	http://localhost:8055
356	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:44:31+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
357	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:44:55+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	124	http://localhost:8055
358	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 01:12:54+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
359	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 01:53:45+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	64e895f2-499f-4854-b12d-ca8c275c4e0d	http://localhost:8055
360	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 01:53:46+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	64e895f2-499f-4854-b12d-ca8c275c4e0d	http://localhost:8055
361	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 01:54:13+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	72093f65-8ce2-4300-b9ba-3059b281d7b2	http://localhost:8055
362	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 01:54:14+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	72093f65-8ce2-4300-b9ba-3059b281d7b2	http://localhost:8055
363	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 02:06:02+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	087543f8-ff31-4bea-8566-7f62107d5b16	http://localhost:8055
364	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 02:06:03+00	172.29.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	087543f8-ff31-4bea-8566-7f62107d5b16	http://localhost:8055
365	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 02:45:18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	da01b238-2d05-4f4e-b2ef-d1c4706d219d	http://localhost:8055
366	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-21 02:45:19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_files	da01b238-2d05-4f4e-b2ef-d1c4706d219d	http://localhost:8055
367	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 21:49:49+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
368	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 21:59:10+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
369	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:03:54+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_permissions	7	http://localhost:8055
370	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:03:54+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
371	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:03:54+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	http://localhost:8055
372	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:10:34+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	specialties	1	http://localhost:8055
373	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:10:40+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	specialties	2	http://localhost:8055
374	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:10:44+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	specialties	3	http://localhost:8055
375	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:10:47+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	specialties	4	http://localhost:8055
380	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:54:39+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
381	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:54:51+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
386	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:55:02+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
387	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:55:41+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
388	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:56:58+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	102	http://localhost:8055
389	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:57:20+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	102	http://localhost:8055
394	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:57:43+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
399	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 22:57:52+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
400	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:00:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	102	http://localhost:8055
401	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:04:31+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	125	http://localhost:8055
402	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:05:30+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	languanges	1	http://localhost:8055
403	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:06:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	125	http://localhost:8055
404	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:09:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	126	http://localhost:8055
405	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:09:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	127	http://localhost:8055
406	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:09:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_collections	languanges_undefined	http://localhost:8055
407	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:09:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	128	http://localhost:8055
408	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:09:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	129	http://localhost:8055
409	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-03 23:09:26+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	directus_fields	130	http://localhost:8055
410	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 09:45:42+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
415	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:05:32+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
418	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:05:48+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
419	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:06:43+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	126	http://localhost:8055
420	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:09:17+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	126	http://localhost:8055
421	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:09:25+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
422	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:10:56+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	126	http://localhost:8055
423	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:12:23+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	126	http://localhost:8055
424	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:13:09+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	126	http://localhost:8055
425	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:14:02+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_undefined	http://localhost:8055
426	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:26:08+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	131	http://localhost:8055
427	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:26:34+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
428	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:28:43+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	102	http://localhost:8055
429	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:41:59+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	131	http://localhost:8055
430	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:42:06+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	126	http://localhost:8055
431	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:44:13+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	132	http://localhost:8055
432	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:44:52+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
433	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:45:18+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	132	http://localhost:8055
434	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:49:28+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_permissions	12	http://localhost:8055
435	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:49:28+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
436	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:49:28+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	http://localhost:8055
437	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:50:28+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_permissions	12	http://localhost:8055
438	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:50:28+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
439	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:50:28+00	172.19.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	http://localhost:8055
440	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:55:04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	133	http://localhost:8055
441	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:55:04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	134	http://localhost:8055
442	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:55:04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_language_levels_1	http://localhost:8055
443	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:55:04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	135	http://localhost:8055
444	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:55:04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	136	http://localhost:8055
445	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:55:05+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	137	http://localhost:8055
446	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:55:46+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	135	http://localhost:8055
447	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:56:08+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	133	http://localhost:8055
448	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:57:26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	138	http://localhost:8055
449	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:57:26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	139	http://localhost:8055
450	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:57:26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_language_levels_2	http://localhost:8055
451	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:57:26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	140	http://localhost:8055
452	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:57:26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	141	http://localhost:8055
457	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:57:48+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	1	http://localhost:8055
462	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 10:58:01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
463	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:05:23+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	138	http://localhost:8055
464	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:05:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	132	http://localhost:8055
465	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:06:51+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	142	http://localhost:8055
466	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:06:57+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	102	http://localhost:8055
467	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	1	http://localhost:8055
468	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:10+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
469	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_language_levels	http://localhost:8055
470	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	103	http://localhost:8055
471	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	104	http://localhost:8055
472	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	105	http://localhost:8055
473	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_language_levels_1	http://localhost:8055
474	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	134	http://localhost:8055
475	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	136	http://localhost:8055
476	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:07:58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	137	http://localhost:8055
477	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_language_levels_2	http://localhost:8055
478	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	139	http://localhost:8055
479	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	140	http://localhost:8055
480	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	141	http://localhost:8055
481	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	language_levels	http://localhost:8055
482	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	65	http://localhost:8055
483	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	66	http://localhost:8055
484	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	67	http://localhost:8055
485	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	68	http://localhost:8055
486	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	69	http://localhost:8055
487	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	70	http://localhost:8055
488	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	71	http://localhost:8055
489	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-07 11:08:06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	77	http://localhost:8055
490	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-16 20:45:19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
491	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-16 21:11:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	projects	2	http://localhost:8055
492	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-16 21:43:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	37ba7a02-2f69-483e-9898-26016a4c773a	http://localhost:8055
493	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-18 21:12:03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
494	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-21 06:28:14+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
495	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-21 06:29:09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	d0db82ce-7358-48d0-8182-2c1b969426c9	http://localhost:8055
496	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:23:38+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
497	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	project_types	http://localhost:8055
498	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
499	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
500	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
501	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
502	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
503	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	job_types	http://localhost:8055
504	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_undefined	http://localhost:8055
505	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	projects_files	http://localhost:8055
506	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
507	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
508	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
509	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	job_types	http://localhost:8055
510	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
511	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
512	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_undefined	http://localhost:8055
513	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:40+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	projects_files	http://localhost:8055
514	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	job_types	http://localhost:8055
515	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	main_contents	http://localhost:8055
516	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	educations	http://localhost:8055
517	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	experiences	http://localhost:8055
518	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	projects	http://localhost:8055
519	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	skills	http://localhost:8055
520	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	languanges_undefined	http://localhost:8055
521	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:42:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_collections	projects_files	http://localhost:8055
522	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:47:15+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	143	http://localhost:8055
523	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:51:41+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	66e4e062-7f67-47f8-9eef-bbce6b99cae6	http://localhost:8055
524	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:03:32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	project_types	1	http://localhost:8055
525	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	bf067a9b-72b9-47a2-a180-89188ba321d1	http://localhost:8055
526	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:08+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	project_types	1	http://localhost:8055
527	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	16a5c261-5fdd-4d5b-b8fa-169f40cb9217	http://localhost:8055
528	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:28+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	project_types	2	http://localhost:8055
529	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:39+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	8d8ec497-dbfa-4a64-babd-a4b067c40c81	http://localhost:8055
530	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	project_types	3	http://localhost:8055
531	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	74eee123-fd90-4c6b-9356-766d9ff7afe7	http://localhost:8055
532	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:09:02+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	project_types	4	http://localhost:8055
533	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:48:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	eba4f0dd-0e95-48f4-84c2-f5b52812bbbf	http://localhost:8055
534	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 11:06:53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	e152b968-e69a-4ffe-98e9-462259279d9a	http://localhost:8055
535	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 20:43:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_permissions	13	http://localhost:8055
536	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 20:43:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
537	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 20:43:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	http://localhost:8055
538	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	skills	2	http://localhost:8055
539	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	skills	3	http://localhost:8055
540	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:31+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	skills	4	http://localhost:8055
541	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:41+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	29037cce-65cc-4e03-a759-301e5c9fb41a	http://localhost:8055
542	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	skills	5	http://localhost:8055
543	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:15:50+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	dab08913-0289-4378-9344-81799ff98187	http://localhost:8055
544	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:15:58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	skills	6	http://localhost:8055
545	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:16:09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_files	12046594-82f6-4690-bd96-051087e33065	http://localhost:8055
546	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:16:16+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	skills	7	http://localhost:8055
547	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:02:02+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
548	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:33:53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	2	http://localhost:8055
549	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:33:57+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	languanges	1	http://localhost:8055
550	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:35:04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	experiences	2	http://localhost:8055
551	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:35:18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	educations	3	http://localhost:8055
552	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:35:23+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	educations	4	http://localhost:8055
553	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:45:58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	experiences	3	http://localhost:8055
554	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:47:20+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	experiences	3	http://localhost:8055
555	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:53:09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	educations	5	http://localhost:8055
556	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:54:09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	directus_fields	144	http://localhost:8055
557	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:54:48+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	experiences	3	http://localhost:8055
558	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:54:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	experiences	2	http://localhost:8055
559	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:54:59+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
560	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	educations	5	http://localhost:8055
561	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:36+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	educations	1	http://localhost:8055
562	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:41+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	educations	2	http://localhost:8055
563	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:57+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	educations	3	http://localhost:8055
564	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:04:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
565	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:21:09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
566	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:21:43+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
567	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:34:34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	specialties	1	http://localhost:8055
568	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:35:53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	specialties	1	http://localhost:8055
569	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:36:21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	specialties	1	http://localhost:8055
570	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:37:03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	specialties	2	http://localhost:8055
571	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:37:28+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	specialties	2	http://localhost:8055
572	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:38:24+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	specialties	3	http://localhost:8055
573	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:38:56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	specialties	4	http://localhost:8055
574	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-02 22:02:21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
575	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-09 21:06:59+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
576	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 21:55:19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
577	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:15:44+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	3	http://localhost:8055
578	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:16:18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	4	http://localhost:8055
579	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:16:43+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	5	http://localhost:8055
580	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:17:11+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	6	http://localhost:8055
581	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 20:40:08+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
582	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 20:45:07+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_files	36af366b-87fb-4c43-b278-d14f36a032e2	http://localhost:8055
583	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 20:45:18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects_files	1	http://localhost:8055
584	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 20:45:18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	1	http://localhost:8055
585	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 20:59:18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	2	http://localhost:8055
586	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 21:08:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_files	2d36b909-4f2f-4199-bd59-3abf7cbc7b41	http://localhost:8055
587	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 21:08:55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects_files	2	http://localhost:8055
588	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 21:08:55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	3	http://localhost:8055
589	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 21:14:08+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	4	http://localhost:8055
590	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 21:16:38+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	5	http://localhost:8055
591	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 21:18:08+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	6	http://localhost:8055
592	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-20 14:15:30+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
593	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-20 17:09:21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	7	http://localhost:8055
594	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:27:12+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
595	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:30:27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_files	bf689c1e-723f-4720-80ce-0d8dc8433f30	http://localhost:8055
596	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:30:54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	2	http://localhost:8055
597	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:43:51+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	2	http://localhost:8055
598	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:44:22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	2	http://localhost:8055
599	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:46:55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	2	http://localhost:8055
600	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:51:41+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	2	http://localhost:8055
601	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:58:15+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
602	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:58:25+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
603	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:58:32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	experiences	2	http://localhost:8055
604	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:58:58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	experiences	1	http://localhost:8055
605	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 23:03:43+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	experiences	2	http://localhost:8055
606	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-29 08:44:42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
607	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-29 08:45:51+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
608	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-04 15:42:33.068+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	http://localhost:8055
609	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-04 15:43:01.701+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
610	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-04 15:43:18.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	http://localhost:8055
611	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-07 01:30:46.784+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
612	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-07 01:30:57.381+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_settings	2	https://cms.itsanam.my.id
613	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-07 05:07:15.905+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	2	https://cms.itsanam.my.id
614	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-07 23:34:44.649+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_permissions	14	https://cms.itsanam.my.id
615	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-07 23:34:44.726+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	https://cms.itsanam.my.id
616	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-07 23:50:52.62+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	https://cms.itsanam.my.id
617	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-08 00:04:47.027+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	experiences	2	https://cms.itsanam.my.id
618	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-12 03:56:04.157+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
619	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-12 03:59:08.973+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	8	https://cms.itsanam.my.id
620	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-12 04:04:47.704+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	projects	9	https://cms.itsanam.my.id
621	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-12 09:55:55.253+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	main_contents	1	https://cms.itsanam.my.id
622	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 12:53:26.206+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
623	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 12:59:35.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_fields	94	https://cms.itsanam.my.id
624	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:00:44.919+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_fields	94	https://cms.itsanam.my.id
625	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:04:00.644+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	https://cms.itsanam.my.id
626	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:04:00.775+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	https://cms.itsanam.my.id
627	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:11:22.405+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	https://cms.itsanam.my.id
628	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:56:46.152+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_files	a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55	https://cms.itsanam.my.id
629	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:57:29.55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_files	ca6bc938-1974-4e0d-8eae-83b1c77e518e	https://cms.itsanam.my.id
630	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:57:38.098+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	projects_files	3	https://cms.itsanam.my.id
631	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:57:38.159+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	projects_files	4	https://cms.itsanam.my.id
632	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:57:38.206+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	projects	3	https://cms.itsanam.my.id
633	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:02:28.995+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_files	6bbda258-d18c-45c5-a58b-1877d057e78e	https://cms.itsanam.my.id
634	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:03:03.631+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_files	fcbfac4f-7837-48ce-956c-fc3fa87ae2fd	https://cms.itsanam.my.id
635	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:03:21.63+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_files	e6c66500-f365-432b-b15e-35b57caafd68	https://cms.itsanam.my.id
636	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:03:28.913+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	projects_files	5	https://cms.itsanam.my.id
637	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:03:28.973+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	projects	3	https://cms.itsanam.my.id
638	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-27 00:07:13.602+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
639	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-08 02:40:08.381+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
640	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 14:57:27.691+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
641	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:04:47.66+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	2	https://cms.itsanam.my.id
642	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:04:47.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	3	https://cms.itsanam.my.id
643	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:04:47.693+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	4	https://cms.itsanam.my.id
644	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:04:47.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	5	https://cms.itsanam.my.id
645	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:04:47.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	3	https://cms.itsanam.my.id
646	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:04:52.868+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	1	https://cms.itsanam.my.id
647	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:04:52.922+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
648	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:08.496+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	ff8ea093-91e8-4dc3-ac3f-aa552e89cfe4	https://cms.itsanam.my.id
649	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:08.532+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	2e781692-8cea-4eb2-a8e5-58fc0cd76095	https://cms.itsanam.my.id
650	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:19.577+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	abbc5f31-bef7-48b7-8524-38fcd16832f8	https://cms.itsanam.my.id
651	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:35.407+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	e67f18a7-970f-498d-992f-17f8b6873deb	https://cms.itsanam.my.id
652	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:58.855+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	7fcff390-a543-4e4f-abf9-2eae212261dd	https://cms.itsanam.my.id
653	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:06:18.541+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	bb279472-b39d-4e64-af00-87a62860614c	https://cms.itsanam.my.id
654	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:06:36.788+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	afa75bc7-8fb1-4eb2-82a9-2a43493ce4f7	https://cms.itsanam.my.id
655	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:06:55.656+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	e59518c0-ac31-4f5c-a8fb-e3972821c5e9	https://cms.itsanam.my.id
656	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:07:05.829+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	6	https://cms.itsanam.my.id
657	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:07:05.904+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	7	https://cms.itsanam.my.id
658	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:07:05.976+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	8	https://cms.itsanam.my.id
659	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:07:06.056+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	9	https://cms.itsanam.my.id
660	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:07:06.122+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
661	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:47:36.866+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	6	https://cms.itsanam.my.id
662	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:47:36.887+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	7	https://cms.itsanam.my.id
663	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:47:36.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	8	https://cms.itsanam.my.id
664	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:47:36.922+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	9	https://cms.itsanam.my.id
665	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:47:37.022+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
666	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:55:37.239+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	908bb409-ebbf-48b1-a25d-cd9e6f30bea1	https://cms.itsanam.my.id
667	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:55:54.865+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	8	https://cms.itsanam.my.id
668	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:14.077+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	7c6ecc43-2d33-4658-8f3d-786ea359a14e	https://cms.itsanam.my.id
669	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:21.493+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	9	https://cms.itsanam.my.id
670	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:35.43+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	a062e730-f061-4cf0-be31-c06e0c47aa10	https://cms.itsanam.my.id
671	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:41.347+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	10	https://cms.itsanam.my.id
672	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:50.91+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	dc9db38f-d94d-4ee6-8db3-07fd4f729ad0	https://cms.itsanam.my.id
673	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:59.353+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	11	https://cms.itsanam.my.id
674	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:57:08.724+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	8bf85679-a3c9-4051-9e18-f87f1869bcf1	https://cms.itsanam.my.id
675	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:57:16.75+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	12	https://cms.itsanam.my.id
676	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:57:25.182+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	efaa7459-6942-4d8c-bd1c-cd42b1b5d9b7	https://cms.itsanam.my.id
677	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:58:36.841+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	13	https://cms.itsanam.my.id
678	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:58:45.845+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	64fb2000-857f-4936-82f9-35c1ec187957	https://cms.itsanam.my.id
679	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:58:52.925+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	14	https://cms.itsanam.my.id
680	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:04.344+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	b2728846-3610-4198-95f5-24fbf46c53fe	https://cms.itsanam.my.id
681	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:12.848+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	15	https://cms.itsanam.my.id
682	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:20.172+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	ec9d495e-e6bc-49db-803c-a0f25d0229f0	https://cms.itsanam.my.id
683	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:28.236+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	16	https://cms.itsanam.my.id
684	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:37.643+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	66f7e096-70ac-4bc3-afba-6fed73813cee	https://cms.itsanam.my.id
685	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:53.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	17	https://cms.itsanam.my.id
686	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:02.509+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	133327f2-4105-4866-a7c9-74491c28d826	https://cms.itsanam.my.id
687	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:08.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	18	https://cms.itsanam.my.id
688	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:19.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	69c7d811-7545-49a3-a314-239ac7866fb1	https://cms.itsanam.my.id
689	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:27.899+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	19	https://cms.itsanam.my.id
690	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:45.587+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	7eb8efc8-adbc-4c70-ba33-63fba2a0a935	https://cms.itsanam.my.id
691	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:53.177+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	20	https://cms.itsanam.my.id
692	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:09.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	6382aa4d-ee74-497f-9325-a43d0b0de8a9	https://cms.itsanam.my.id
693	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:20.942+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	21	https://cms.itsanam.my.id
694	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:31.099+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	114e369d-06b3-41e9-b544-e6437a6349e5	https://cms.itsanam.my.id
695	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:40.073+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	22	https://cms.itsanam.my.id
696	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:01:05.837+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	10	https://cms.itsanam.my.id
697	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:02:32.734+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	9236a3ed-40c1-41b0-83a5-9e2ea3106514	https://cms.itsanam.my.id
698	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:02:51.553+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	cd26c3bb-27ec-4203-9847-2e5c251a2a52	https://cms.itsanam.my.id
699	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:05.777+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	bf531657-9d74-43b2-9be3-fb8d9f534e76	https://cms.itsanam.my.id
700	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:16.957+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	aee44348-e25e-4d33-b889-d32a61ac7b22	https://cms.itsanam.my.id
701	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:46.664+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	10	https://cms.itsanam.my.id
702	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:46.73+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	11	https://cms.itsanam.my.id
703	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:46.806+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	12	https://cms.itsanam.my.id
704	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:46.871+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	13	https://cms.itsanam.my.id
705	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:46.921+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	10	https://cms.itsanam.my.id
706	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:13:09.488+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	b9d3f4cf-3f8a-45d0-a061-b82529624510	https://cms.itsanam.my.id
707	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:13:18.186+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	14	https://cms.itsanam.my.id
708	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:13:18.237+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	7	https://cms.itsanam.my.id
709	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:17:42.74+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	7	https://cms.itsanam.my.id
710	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:23:17.19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	76b87f11-940b-4e7e-860b-9b833ab012de	https://cms.itsanam.my.id
711	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:23:27.342+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	a6e3ea76-cc7f-4309-95c8-eae897aa1cd3	https://cms.itsanam.my.id
712	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:23:38.552+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	61a7d17f-61e4-491f-9119-0975c3164ff0	https://cms.itsanam.my.id
713	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:24:02.547+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	15	https://cms.itsanam.my.id
714	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:24:02.612+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	16	https://cms.itsanam.my.id
715	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:24:02.676+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	17	https://cms.itsanam.my.id
716	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:24:02.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	5	https://cms.itsanam.my.id
717	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:34:43.142+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	90dd5416-6216-4e07-b513-792c3ac14543	https://cms.itsanam.my.id
718	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:34:53.889+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	5b7f3df1-bf8b-48df-b1da-4afa49cb7f4b	https://cms.itsanam.my.id
719	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:19.963+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	11e3fb3f-5625-4060-a99e-76e628694e0d	https://cms.itsanam.my.id
720	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:19.985+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	f80e1f7d-f5d7-4849-afa3-f53168898a70	https://cms.itsanam.my.id
721	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:35.72+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	18	https://cms.itsanam.my.id
722	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:35.782+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	19	https://cms.itsanam.my.id
723	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:35.845+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	20	https://cms.itsanam.my.id
724	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:35.911+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	21	https://cms.itsanam.my.id
725	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:35.975+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	8	https://cms.itsanam.my.id
726	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:40:00.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
727	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:25.78+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	6886e984-68de-4348-9bae-dda44b898d44	https://cms.itsanam.my.id
728	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:37.316+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	70073d8e-ccea-47d3-8f45-a3c1c9c657fc	https://cms.itsanam.my.id
729	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:45.332+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	68727a44-9735-472f-89e3-d9f570959082	https://cms.itsanam.my.id
730	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:50.946+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	22	https://cms.itsanam.my.id
731	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:51.016+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	23	https://cms.itsanam.my.id
732	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:51.084+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	24	https://cms.itsanam.my.id
733	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:51.138+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	4	https://cms.itsanam.my.id
734	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:45:46.5+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	11	https://cms.itsanam.my.id
735	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:09:57.836+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
736	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:12:12.231+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	145	https://cms.itsanam.my.id
737	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:12:40.263+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	146	https://cms.itsanam.my.id
738	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:14:51.903+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	147	https://cms.itsanam.my.id
739	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:15:45.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	147	https://cms.itsanam.my.id
740	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:17:28.35+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	148	https://cms.itsanam.my.id
741	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:17:28.917+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	149	https://cms.itsanam.my.id
742	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:17:28.971+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	projects_skills	https://cms.itsanam.my.id
743	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:17:29.373+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	150	https://cms.itsanam.my.id
744	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:17:29.937+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	151	https://cms.itsanam.my.id
745	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:18:18.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	1	https://cms.itsanam.my.id
746	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:18:18.878+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	2	https://cms.itsanam.my.id
747	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:18:18.943+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	3	https://cms.itsanam.my.id
748	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:18:19.004+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	4	https://cms.itsanam.my.id
749	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:18:19.051+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	11	https://cms.itsanam.my.id
750	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:19:34.494+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	148	https://cms.itsanam.my.id
751	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:44:43.189+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	152	https://cms.itsanam.my.id
752	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:44:43.752+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	153	https://cms.itsanam.my.id
753	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:44:43.803+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	experiences_skills	https://cms.itsanam.my.id
754	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:44:44.209+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	154	https://cms.itsanam.my.id
755	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:44:44.73+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	155	https://cms.itsanam.my.id
756	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:45:08.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	152	https://cms.itsanam.my.id
757	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:44:51.87+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
758	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:47:29.439+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
759	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:48:49.145+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	1cf2fb7b-3769-44b2-ae07-a994962832ef	https://cms.itsanam.my.id
760	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	820e72f9-7f20-4cbb-9987-7f13fa3bbce0	https://cms.itsanam.my.id
761	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.307+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	b2082e6b-fe28-4efa-a4ff-dde9500ec387	https://cms.itsanam.my.id
762	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	f92c9844-67d7-41c5-9a65-1e0b0f00323f	https://cms.itsanam.my.id
763	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.366+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	6f0eb1fd-3211-469e-8fab-93e1aa3e1fca	https://cms.itsanam.my.id
764	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.379+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	75d5253c-8e5f-450c-8c95-01dc67b3d263	https://cms.itsanam.my.id
765	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.404+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	b10f20fe-f1dc-4c82-8215-9e1879003e2e	https://cms.itsanam.my.id
766	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:03.215+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	55e1011d-e96a-4695-9336-651c71c831d8	https://cms.itsanam.my.id
767	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:03.551+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	c509123f-2c9d-4075-97df-011667a4b2d2	https://cms.itsanam.my.id
768	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:07.96+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	25	https://cms.itsanam.my.id
769	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.023+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	26	https://cms.itsanam.my.id
770	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.089+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	27	https://cms.itsanam.my.id
771	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.154+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	28	https://cms.itsanam.my.id
772	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.216+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	29	https://cms.itsanam.my.id
773	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.285+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	30	https://cms.itsanam.my.id
774	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.353+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	31	https://cms.itsanam.my.id
775	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.421+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	32	https://cms.itsanam.my.id
776	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.485+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	33	https://cms.itsanam.my.id
777	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:08.538+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
778	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:50:49.911+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
779	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:51:44.004+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	2	https://cms.itsanam.my.id
780	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:55:58.618+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	9220109c-9f88-41b2-9ebf-ee5404242c39	https://cms.itsanam.my.id
781	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:56:37.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a	https://cms.itsanam.my.id
782	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:56:53.268+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	d0044ddf-3cf7-43cb-bdb8-0a3f413134a5	https://cms.itsanam.my.id
783	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:04.067+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	8936ab46-9022-4823-8ac5-728d4de7813b	https://cms.itsanam.my.id
785	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:23.698+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	34	https://cms.itsanam.my.id
786	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:23.759+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	35	https://cms.itsanam.my.id
787	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:23.821+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	36	https://cms.itsanam.my.id
788	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:23.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	37	https://cms.itsanam.my.id
789	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:23.955+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	38	https://cms.itsanam.my.id
790	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:24.003+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	6	https://cms.itsanam.my.id
784	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:13.862+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	dc50a198-a095-49e9-b3de-d5682a3fb6ca	https://cms.itsanam.my.id
791	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:11.015+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	34	https://cms.itsanam.my.id
792	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:11.03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	35	https://cms.itsanam.my.id
793	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:11.046+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	36	https://cms.itsanam.my.id
794	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:11.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	37	https://cms.itsanam.my.id
795	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:11.077+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	38	https://cms.itsanam.my.id
796	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:11.186+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	6	https://cms.itsanam.my.id
797	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:39.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	5d8052af-cc38-42ea-a128-e0094a3a4fac	https://cms.itsanam.my.id
798	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:56.469+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	9d40c598-32a6-432b-87b5-7d413339057f	https://cms.itsanam.my.id
799	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:09.289+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	008a7468-4d4d-49d1-9e6b-8859a853a63a	https://cms.itsanam.my.id
801	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:52.169+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	f8905818-2843-4a3a-aef7-59bc22cac963	https://cms.itsanam.my.id
804	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:02.914+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	d1fbaed4-1e6f-492d-9baf-9ef64a2ec15b	https://cms.itsanam.my.id
800	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:34.626+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	75d60b48-6440-4a4a-932a-b53cbcf184bb	https://cms.itsanam.my.id
802	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:52.183+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	94d8529c-eb6a-43ae-bfe6-483a1afb7a20	https://cms.itsanam.my.id
803	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:02.909+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	85b47526-2052-445c-a7bf-f316f30f3035	https://cms.itsanam.my.id
805	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:09.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	39	https://cms.itsanam.my.id
806	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:09.772+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	40	https://cms.itsanam.my.id
807	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:09.832+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	41	https://cms.itsanam.my.id
808	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:09.892+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	42	https://cms.itsanam.my.id
809	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:09.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	43	https://cms.itsanam.my.id
810	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:10.021+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	44	https://cms.itsanam.my.id
811	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:10.09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	45	https://cms.itsanam.my.id
812	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:10.177+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	46	https://cms.itsanam.my.id
813	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:10.223+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	6	https://cms.itsanam.my.id
814	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:06:19.091+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	10	https://cms.itsanam.my.id
815	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:10:43.353+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	4	https://cms.itsanam.my.id
816	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:11:10.258+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	4	https://cms.itsanam.my.id
817	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:11:57.078+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	4	https://cms.itsanam.my.id
818	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.337+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	e66d6211-0c08-467d-86a3-e54ba0db0aca	https://cms.itsanam.my.id
819	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.345+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	7de1c245-4eeb-42f6-94ef-48cc8da3b05b	https://cms.itsanam.my.id
820	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.364+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	fc920da1-e2f8-4d09-95e9-e219aae8ab51	https://cms.itsanam.my.id
821	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.445+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	de5b72f7-374d-4b21-aea9-da0fe567ac84	https://cms.itsanam.my.id
822	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.764+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	e2c3417e-6db1-455e-9930-a65e4bc117c3	https://cms.itsanam.my.id
823	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.766+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	56be0d32-b44d-40fa-9cbe-13aa24fed0d6	https://cms.itsanam.my.id
824	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.783+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	4935c5ea-d91a-4a6a-a1e0-351b61032b42	https://cms.itsanam.my.id
825	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.795+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	88084266-e7f7-413f-b5a8-8fc3bbb8ca4c	https://cms.itsanam.my.id
826	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.927+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	a298debe-c993-41ba-91c1-05f8d5f9eaf1	https://cms.itsanam.my.id
827	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:47.836+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	3	https://cms.itsanam.my.id
828	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.288+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	cf3b2f9b-441a-4d93-88b3-c23f40d0f529	https://cms.itsanam.my.id
829	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.29+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	be68b2f9-89c6-4b8e-86ed-db5243fd8400	https://cms.itsanam.my.id
830	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.36+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	eff256be-a612-46c6-bbe2-071c7d942118	https://cms.itsanam.my.id
831	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.359+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	1cc182f4-1afe-4937-869b-f17be5cde070	https://cms.itsanam.my.id
833	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.787+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	04323344-2faf-4a30-ad5f-97a18c73c831	https://cms.itsanam.my.id
832	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.782+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	10a8bdb0-e9f0-4bbf-8321-b0829672a492	https://cms.itsanam.my.id
836	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.886+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	933dfe12-6859-4f78-b3f7-79ba83b5b888	https://cms.itsanam.my.id
834	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.806+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	d33b2a90-dfa1-48e5-996a-058c542090c5	https://cms.itsanam.my.id
835	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.804+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	07985fe1-d1a7-46b6-ac0e-0e848f6e34a8	https://cms.itsanam.my.id
837	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.385+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	47	https://cms.itsanam.my.id
838	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.45+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	48	https://cms.itsanam.my.id
839	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.515+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	49	https://cms.itsanam.my.id
840	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.575+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	50	https://cms.itsanam.my.id
841	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.636+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	51	https://cms.itsanam.my.id
842	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.696+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	52	https://cms.itsanam.my.id
843	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.758+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	53	https://cms.itsanam.my.id
844	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.818+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	54	https://cms.itsanam.my.id
845	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.887+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_files	55	https://cms.itsanam.my.id
846	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:33.945+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	3	https://cms.itsanam.my.id
847	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 05:21:54.9+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	5	https://cms.itsanam.my.id
848	login	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:01:04.299+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	https://cms.itsanam.my.id
849	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:01:53.404+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	156	https://cms.itsanam.my.id
850	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:01:54.073+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	157	https://cms.itsanam.my.id
851	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:01:54.131+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	projects_skills_1	https://cms.itsanam.my.id
852	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:01:54.564+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	158	https://cms.itsanam.my.id
853	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:01:55.149+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	159	https://cms.itsanam.my.id
854	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:03:04.887+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills_1	1	https://cms.itsanam.my.id
855	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:03:04.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills_1	2	https://cms.itsanam.my.id
856	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:03:05.023+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	9	https://cms.itsanam.my.id
857	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:04:19.656+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	156	https://cms.itsanam.my.id
858	delete	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:04:58.334+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	156	https://cms.itsanam.my.id
859	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:05:19.715+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	5	https://cms.itsanam.my.id
860	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:05:19.778+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	6	https://cms.itsanam.my.id
861	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:05:19.843+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	7	https://cms.itsanam.my.id
862	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:05:19.9+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	9	https://cms.itsanam.my.id
863	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.547+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	8	https://cms.itsanam.my.id
864	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.612+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	9	https://cms.itsanam.my.id
865	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.678+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	10	https://cms.itsanam.my.id
866	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	11	https://cms.itsanam.my.id
867	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.806+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	12	https://cms.itsanam.my.id
868	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.868+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	13	https://cms.itsanam.my.id
869	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.928+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	14	https://cms.itsanam.my.id
870	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.999+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	15	https://cms.itsanam.my.id
871	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:40.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	16	https://cms.itsanam.my.id
872	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:40.108+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	5	https://cms.itsanam.my.id
873	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:26:37.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_permissions	1	https://cms.itsanam.my.id
874	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:26:37.293+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	https://cms.itsanam.my.id
875	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:39:54.521+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_permissions	1	https://cms.itsanam.my.id
876	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:39:54.619+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_permissions	9	https://cms.itsanam.my.id
877	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:39:54.706+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	https://cms.itsanam.my.id
878	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:40:35.523+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_permissions	15	https://cms.itsanam.my.id
879	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:40:35.583+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_permissions	16	https://cms.itsanam.my.id
880	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:40:35.638+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_permissions	17	https://cms.itsanam.my.id
881	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:40:35.69+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	https://cms.itsanam.my.id
882	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:10.884+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	17	https://cms.itsanam.my.id
883	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:10.954+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	18	https://cms.itsanam.my.id
884	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.021+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	19	https://cms.itsanam.my.id
885	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.083+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	20	https://cms.itsanam.my.id
886	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.146+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	21	https://cms.itsanam.my.id
887	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.209+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	22	https://cms.itsanam.my.id
888	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.272+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	23	https://cms.itsanam.my.id
889	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	24	https://cms.itsanam.my.id
890	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.399+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	25	https://cms.itsanam.my.id
891	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.471+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	26	https://cms.itsanam.my.id
892	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.534+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	27	https://cms.itsanam.my.id
893	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:11.584+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	1	https://cms.itsanam.my.id
894	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:00:23.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	28	https://cms.itsanam.my.id
895	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:00:23.627+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	29	https://cms.itsanam.my.id
896	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:00:23.694+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	30	https://cms.itsanam.my.id
897	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:00:23.745+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	7	https://cms.itsanam.my.id
898	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:01:28.985+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	31	https://cms.itsanam.my.id
899	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:01:29.048+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	32	https://cms.itsanam.my.id
900	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:01:29.115+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	33	https://cms.itsanam.my.id
901	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:01:29.164+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	8	https://cms.itsanam.my.id
902	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:02:11.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	34	https://cms.itsanam.my.id
903	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:02:11.159+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	35	https://cms.itsanam.my.id
904	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:02:11.226+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	36	https://cms.itsanam.my.id
905	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:02:11.286+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	4	https://cms.itsanam.my.id
906	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:22.796+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	37	https://cms.itsanam.my.id
907	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:22.858+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	38	https://cms.itsanam.my.id
908	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:22.927+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	39	https://cms.itsanam.my.id
909	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:22.99+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	40	https://cms.itsanam.my.id
910	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.058+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	41	https://cms.itsanam.my.id
911	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.123+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	42	https://cms.itsanam.my.id
912	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.196+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	43	https://cms.itsanam.my.id
913	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.274+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	44	https://cms.itsanam.my.id
914	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	45	https://cms.itsanam.my.id
915	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.405+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	46	https://cms.itsanam.my.id
916	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.478+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	47	https://cms.itsanam.my.id
917	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:23.528+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	3	https://cms.itsanam.my.id
918	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.398+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	48	https://cms.itsanam.my.id
919	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.469+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	49	https://cms.itsanam.my.id
920	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.536+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	50	https://cms.itsanam.my.id
921	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.607+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	51	https://cms.itsanam.my.id
922	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.679+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	52	https://cms.itsanam.my.id
923	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.743+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	53	https://cms.itsanam.my.id
924	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.803+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	54	https://cms.itsanam.my.id
925	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.866+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	55	https://cms.itsanam.my.id
926	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.927+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	56	https://cms.itsanam.my.id
927	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:15.975+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	6	https://cms.itsanam.my.id
928	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.188+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	57	https://cms.itsanam.my.id
929	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.256+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	58	https://cms.itsanam.my.id
930	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.33+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	59	https://cms.itsanam.my.id
931	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.396+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	60	https://cms.itsanam.my.id
932	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.463+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	61	https://cms.itsanam.my.id
933	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.527+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	62	https://cms.itsanam.my.id
934	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.58+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	2	https://cms.itsanam.my.id
935	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:06:22.079+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	63	https://cms.itsanam.my.id
936	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:06:22.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	64	https://cms.itsanam.my.id
937	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:06:22.217+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	65	https://cms.itsanam.my.id
938	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:06:22.305+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	66	https://cms.itsanam.my.id
939	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:06:22.369+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	67	https://cms.itsanam.my.id
940	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:06:22.432+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	68	https://cms.itsanam.my.id
941	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:06:22.49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	10	https://cms.itsanam.my.id
942	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:07:04.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	59b61074-3cb5-406c-a9b8-5f0d84d83f96	https://cms.itsanam.my.id
943	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:07:15.086+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	23	https://cms.itsanam.my.id
944	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:02.206+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_files	34a4e7c8-9709-43a3-bdb5-87fd0864d516	https://cms.itsanam.my.id
945	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:09.95+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	skills	24	https://cms.itsanam.my.id
946	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:29.348+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	69	https://cms.itsanam.my.id
947	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:29.405+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	6	https://cms.itsanam.my.id
948	create	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:45.974+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects_skills	70	https://cms.itsanam.my.id
949	update	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:46.022+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	projects	10	https://cms.itsanam.my.id
\.


--
-- TOC entry 5074 (class 0 OID 16471)
-- Dependencies: 222
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
educations	school	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	2	\N	open	\N	f
experiences	work	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	3	\N	open	\N	f
job_types	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	1	experiences	open	\N	f
languanges	select_to_speak	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	2	main_contents	open	\N	f
languanges_undefined	import_export	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	6	\N	open	\N	f
main_contents	\N	\N	\N	f	t	\N	status	t	archived	draft	\N	all	\N	\N	1	\N	open	\N	f
project_types	\N	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	1	projects	open	\N	f
projects	workspace_premium	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	4	\N	open	\N	f
projects_files	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	7	\N	open	\N	f
skills	interactive_space	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	5	\N	open	\N	f
specialties	eda	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	1	main_contents	open	\N	f
projects_skills	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
experiences_skills	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
projects_skills_1	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- TOC entry 5075 (class 0 OID 16491)
-- Dependencies: 223
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- TOC entry 5076 (class 0 OID 16500)
-- Dependencies: 224
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- TOC entry 5077 (class 0 OID 16509)
-- Dependencies: 225
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- TOC entry 5079 (class 0 OID 16517)
-- Dependencies: 227
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
13	educations	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
14	educations	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
15	educations	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
16	educations	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
17	educations	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
18	educations	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	6	half	\N	\N	\N	f	\N	\N	\N
19	educations	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
20	experiences	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
21	experiences	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
22	experiences	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
23	experiences	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
24	experiences	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
25	experiences	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	6	half	\N	\N	\N	f	\N	\N	\N
26	experiences	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
27	main_contents	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
28	main_contents	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	6	full	\N	\N	\N	f	\N	\N	\N
29	main_contents	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	7	half	\N	\N	\N	f	\N	\N	\N
30	main_contents	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	8	half	\N	\N	\N	f	\N	\N	\N
31	main_contents	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	9	half	\N	\N	\N	f	\N	\N	\N
32	main_contents	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	10	half	\N	\N	\N	f	\N	\N	\N
33	projects	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
34	projects	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
35	projects	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
36	projects	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
37	projects	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
38	projects	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	6	half	\N	\N	\N	f	\N	\N	\N
39	projects	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
40	skills	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
41	skills	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
42	skills	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
43	skills	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
44	skills	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
45	skills	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	6	half	\N	\N	\N	f	\N	\N	\N
46	skills	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
47	specialties	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
48	specialties	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
49	specialties	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
50	specialties	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
51	specialties	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
52	specialties	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	6	half	\N	\N	\N	f	\N	\N	\N
53	specialties	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
54	languanges	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
55	languanges	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
56	languanges	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
57	languanges	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N
58	languanges	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N
59	languanges	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	6	half	\N	\N	\N	f	\N	\N	\N
60	languanges	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
61	main_contents	about_desc	\N	input-multiline	{"softLength": null}	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
62	main_contents	project_desc	\N	input-multiline	{"softLength": null}	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
63	main_contents	education_desc	\N	input-multiline	{"softLength": null}	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
64	main_contents	experience_desc	\N	input-multiline	{"softLength": null}	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
72	specialties	title	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
73	specialties	description	\N	input-multiline	\N	\N	\N	f	f	9	full	\N	\N	\N	t	\N	\N	\N
74	specialties	icon	file	file-image	{}	image	{}	f	f	10	full	\N	\N	\N	t	\N	\N	\N
75	languanges	name	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
78	educations	institution	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
79	educations	major	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	t	\N	\N	\N
80	educations	date_start	\N	datetime	{}	\N	\N	f	f	10	full	\N	\N	\N	t	\N	\N	\N
81	educations	date_end	\N	datetime	{"use24": false}	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N
82	educations	sequence	\N	input	{"min": 0}	\N	\N	f	f	12	full	\N	\N	\N	f	\N	\N	\N
83	educations	education_type	\N	input	\N	formatted-value	\N	f	f	13	full	\N	\N	\N	t	\N	\N	\N
84	educations	detail	\N	input-rich-text-html	\N	\N	\N	f	f	14	full	\N	\N	\N	f	\N	\N	\N
85	experiences	company	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
86	experiences	position	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	t	\N	\N	\N
88	experiences	date_start	\N	datetime	{"use24": false}	\N	\N	f	f	11	full	\N	\N	\N	t	\N	\N	\N
89	experiences	date_end	\N	datetime	{"use24": false}	\N	\N	f	f	12	full	\N	\N	\N	f	\N	\N	\N
90	experiences	job_detail	\N	input-rich-text-html	\N	\N	\N	f	f	13	full	\N	\N	\N	f	\N	\N	\N
91	projects	title	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
92	projects	description	\N	input-multiline	\N	\N	\N	f	f	9	full	\N	\N	\N	t	\N	\N	\N
95	projects_files	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
96	projects_files	projects_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
97	projects_files	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
98	projects	detail	\N	input-rich-text-html	\N	\N	\N	f	f	12	full	\N	\N	\N	f	\N	\N	\N
99	skills	title	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
106	skills	icon	file	file-image	{}	image	\N	f	f	10	full	\N	\N	\N	t	\N	\N	\N
107	project_types	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
108	project_types	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	3	full	\N	\N	\N	f	\N	\N	\N
109	project_types	sort	\N	input	\N	\N	\N	f	t	4	full	\N	\N	\N	f	\N	\N	\N
110	project_types	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	5	half	\N	\N	\N	f	\N	\N	\N
111	project_types	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	6	half	\N	\N	\N	f	\N	\N	\N
112	project_types	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	7	half	\N	\N	\N	f	\N	\N	\N
113	project_types	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	8	half	\N	\N	\N	f	\N	\N	\N
114	project_types	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N
115	projects	type	m2o	select-dropdown-m2o	{"template": "{{name}}"}	related-values	{"template": "{{name}}"}	f	f	13	full	\N	\N	\N	t	\N	\N	\N
116	job_types	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
117	job_types	status	\N	select-dropdown	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}	labels	{"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}	f	f	3	full	\N	\N	\N	f	\N	\N	\N
118	job_types	sort	\N	input	\N	\N	\N	f	t	4	full	\N	\N	\N	f	\N	\N	\N
119	job_types	user_created	user-created	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	5	half	\N	\N	\N	f	\N	\N	\N
120	job_types	date_created	date-created	datetime	\N	datetime	{"relative": true}	t	t	6	half	\N	\N	\N	f	\N	\N	\N
121	job_types	user_updated	user-updated	select-dropdown-m2o	{"template": "{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	7	half	\N	\N	\N	f	\N	\N	\N
122	job_types	date_updated	date-updated	datetime	\N	datetime	{"relative": true}	t	t	8	half	\N	\N	\N	f	\N	\N	\N
123	job_types	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
124	experiences	job_type	m2o	select-dropdown-m2o	{"template": "{{name}}"}	related-values	{"template": "{{name}}"}	f	f	14	full	\N	\N	\N	t	\N	\N	\N
127	languanges_undefined	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
128	languanges_undefined	languanges_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
129	languanges_undefined	item	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
130	languanges_undefined	collection	\N	\N	\N	\N	\N	f	t	4	full	\N	\N	\N	f	\N	\N	\N
142	languanges	level_types	cast-json	select-multiple-checkbox	{"choices": [{"text": "Written", "value": "Written"}, {"text": "Read", "value": "Read"}, {"text": "Listening", "value": "Listening"}, {"text": "Spoken", "value": "Spoken"}]}	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N
143	project_types	icon	file	file-image	{}	\N	\N	f	f	9	full	\N	\N	\N	t	\N	\N	\N
144	experiences	sequence	\N	input	\N	\N	\N	f	f	15	full	\N	\N	\N	f	\N	\N	\N
94	projects	images	files	files	{"template":"{{directus_files_id.filename_download}}"}	related-values	{"template":"{{directus_files_id.filename_download}}"}	f	f	11	full	\N	\N	\N	f	\N	\N	\N
145	projects	repo_Link	\N	input	{"placeholder":"Enter Repo Link","iconLeft":"github"}	\N	\N	f	f	131	full	\N	\N	\N	f	\N	\N	\N
146	projects	Url	\N	input	{"placeholder":"Enter Url"}	\N	\N	f	f	1311	full	\N	\N	\N	f	\N	\N	\N
149	projects_skills	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
150	projects_skills	projects_id	\N	\N	\N	\N	\N	f	t	11	full	\N	\N	\N	f	\N	\N	\N
151	projects_skills	skills_id	\N	\N	\N	\N	\N	f	t	111	full	\N	\N	\N	f	\N	\N	\N
148	projects	skills_used	m2m	list-m2m	{"enableLink":true,"template":"{{skills_id.title}}"}	\N	\N	f	f	13111	full	\N	\N	\N	f	\N	\N	\N
153	experiences_skills	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
154	experiences_skills	experiences_id	\N	\N	\N	\N	\N	f	t	11	full	\N	\N	\N	f	\N	\N	\N
155	experiences_skills	skills_id	\N	\N	\N	\N	\N	f	t	111	full	\N	\N	\N	f	\N	\N	\N
152	experiences	skills_used	m2m	list-m2m	{"enableLink":true,"template":"{{skills_id.title}}"}	\N	\N	f	f	151	full	\N	\N	\N	f	\N	\N	\N
157	projects_skills_1	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
158	projects_skills_1	projects_id	\N	\N	\N	\N	\N	f	t	11	full	\N	\N	\N	f	\N	\N	\N
159	projects_skills_1	skills_id	\N	\N	\N	\N	\N	f	t	111	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- TOC entry 5080 (class 0 OID 16531)
-- Dependencies: 228
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
0bbcdfb5-3d07-4877-9047-d96c480bc3c3	cloudinary	0bbcdfb5-3d07-4877-9047-d96c480bc3c3.png	icons8-javascript-96.png	Icons8 Javascript 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:48:23+00	\N	2025-04-23 21:48:36+00	\N	1345	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:48:36+00
12046594-82f6-4690-bd96-051087e33065	cloudinary	12046594-82f6-4690-bd96-051087e33065.png	icons8-tailwind-css-24.png	Icons8 Tailwind CSS 24	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:16:09+00	\N	2025-06-22 21:16:14+00	\N	328	24	24	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 21:16:14+00
16a5c261-5fdd-4d5b-b8fa-169f40cb9217	cloudinary	16a5c261-5fdd-4d5b-b8fa-169f40cb9217.png	icons8-bar-chart-96 (1).png	Icons8 Bar Chart 96 (1)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:22+00	\N	2025-06-22 10:08:25+00	\N	1637	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 10:08:25+00
29037cce-65cc-4e03-a759-301e5c9fb41a	cloudinary	29037cce-65cc-4e03-a759-301e5c9fb41a.png	icons8-laravel-100.png	Icons8 Laravel 100	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:41+00	\N	2025-06-22 21:12:47+00	\N	1937	100	100	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 21:12:47+00
2d36b909-4f2f-4199-bd59-3abf7cbc7b41	cloudinary	2d36b909-4f2f-4199-bd59-3abf7cbc7b41.png	Screenshot 2025-07-16 210614.png	Screenshot 2025 07 16 210614	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 21:08:42+00	\N	2025-07-16 21:08:48+00	\N	40111	1662	957	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-07-16 21:08:48+00
36af366b-87fb-4c43-b278-d14f36a032e2	cloudinary	36af366b-87fb-4c43-b278-d14f36a032e2.png	Screenshot 2025-07-16 204405.png	Screenshot 2025 07 16 204405	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-16 20:45:07+00	\N	2025-07-16 20:45:14+00	\N	45328	1772	913	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-07-16 20:45:14+00
37ba7a02-2f69-483e-9898-26016a4c773a	local	37ba7a02-2f69-483e-9898-26016a4c773a.png	Unicharm_company_logo.png	Unicharm Company Logo	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-16 21:43:42+00	\N	2025-06-16 21:43:42+00	\N	97421	1287	1515	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-16 21:43:42+00
38808ea0-ac80-475b-998d-b4aa6788c58f	cloudinary	38808ea0-ac80-475b-998d-b4aa6788c58f.png	icons8-web-development-96.png	Icons8 Web Development 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:35:33+00	\N	2025-04-23 21:35:54+00	\N	1038	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:35:54+00
60913cc8-ac74-4123-8054-e645daf166f3	cloudinary	60913cc8-ac74-4123-8054-e645daf166f3.png	icons8-typescript-100.png	Icons8 Typescript 100	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:47:45+00	\N	2025-04-23 21:47:58+00	\N	971	100	100	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:47:58+00
66e4e062-7f67-47f8-9eef-bbce6b99cae6	cloudinary	66e4e062-7f67-47f8-9eef-bbce6b99cae6.png	icons8-web-development-96 (1).png	Icons8 Web Development 96 (1)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 09:51:41+00	\N	2025-06-22 09:51:45+00	\N	1038	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 09:51:45+00
74eee123-fd90-4c6b-9356-766d9ff7afe7	cloudinary	74eee123-fd90-4c6b-9356-766d9ff7afe7.png	icons8-employee-96 (1).png	Icons8 Employee 96 (1)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:56+00	\N	2025-06-22 10:08:58+00	\N	1739	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 10:08:58+00
7e0aaaf6-fc6f-45d5-8736-7035c6f044dc	cloudinary	\N	icons8-typescript-100.png	Icons8 Typescript 100	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:47:10+00	\N	2025-04-23 21:47:09+00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7e228bab-3258-4919-97d2-95cd07fe7cc6	cloudinary	7e228bab-3258-4919-97d2-95cd07fe7cc6.png	icons8-positive-dynamic-96.png	Icons8 Positive Dynamic 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:36:39+00	\N	2025-04-23 21:36:48+00	\N	1154	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:36:48+00
8d8ec497-dbfa-4a64-babd-a4b067c40c81	cloudinary	8d8ec497-dbfa-4a64-babd-a4b067c40c81.png	icons8-mockup-96 (3).png	Icons8 Mockup 96 (3)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:39+00	\N	2025-06-22 10:08:41+00	\N	1316	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 10:08:41+00
b5761b06-fdc3-405d-9e2e-9fb176400c86	cloudinary	b5761b06-fdc3-405d-9e2e-9fb176400c86.png	icons8-mockup-96.png	Icons8 Mockup 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:38:38+00	\N	2025-04-23 21:38:28+00	\N	929	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:38:28+00
bb9979d1-0ee2-4ea0-a926-aafba0432619	cloudinary	bb9979d1-0ee2-4ea0-a926-aafba0432619.png	icons8-employee-96.png	Icons8 Employee 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:37:24+00	\N	2025-04-23 21:37:35+00	\N	1253	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:37:35+00
bf067a9b-72b9-47a2-a180-89188ba321d1	cloudinary	bf067a9b-72b9-47a2-a180-89188ba321d1.png	icons8-web-development-96 (3).png	Icons8 Web Development 96 (3)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:01+00	\N	2025-06-22 10:08:03+00	\N	1681	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 10:08:03+00
bf689c1e-723f-4720-80ce-0d8dc8433f30	cloudinary	bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg	WhatsApp Image 2025-07-22 at 14.03.07_314a44e8.jpg	Whats App Image 2025 07 22 at 14.03.07 314a44e8	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:30:27+00	\N	2025-07-28 22:30:34+00	\N	447848	4080	3060	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-07-28 22:30:34+00
cb7e94b4-45ab-4edb-8d67-94e93f4d6702	cloudinary	cb7e94b4-45ab-4edb-8d67-94e93f4d6702.png	icons8-css-filetype-96.png	Icons8 CSS Filetype 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:35+00	\N	2025-04-23 21:49:45+00	\N	1271	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:49:45+00
d0db82ce-7358-48d0-8182-2c1b969426c9	cloudinary	d0db82ce-7358-48d0-8182-2c1b969426c9.png	icons8-warning-96 (1).png	Icons8 Warning 96 (1)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-21 06:29:09+00	\N	2025-06-21 06:29:13+00	\N	2721	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-21 06:29:13+00
d4a3abb5-6770-4e03-a792-8192b8b92138	cloudinary	d4a3abb5-6770-4e03-a792-8192b8b92138.png	icons8-html-96.png	Icons8 HTML 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:03+00	\N	2025-04-23 21:49:08+00	\N	1182	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-04-23 21:49:08+00
dab08913-0289-4378-9344-81799ff98187	cloudinary	dab08913-0289-4378-9344-81799ff98187.png	icons8-vue.js-48.png	Icons8 Vue.js 48	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:15:50+00	\N	2025-06-22 21:15:55+00	\N	747	48	48	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 21:15:55+00
e152b968-e69a-4ffe-98e9-462259279d9a	cloudinary	e152b968-e69a-4ffe-98e9-462259279d9a.png	icons8-work-96.png	Icons8 Work 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 11:06:53+00	\N	2025-06-22 11:06:54+00	\N	1063	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 11:06:54+00
eba4f0dd-0e95-48f4-84c2-f5b52812bbbf	cloudinary	eba4f0dd-0e95-48f4-84c2-f5b52812bbbf.png	icons8-education-96.png	Icons8 Education 96	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:48:54+00	\N	2025-06-22 10:48:57+00	\N	2599	96	96	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-06-22 10:48:57+00
edd7abe3-0790-40f8-9a31-c8c308171741	cloudinary	edd7abe3-0790-40f8-9a31-c8c308171741.JPG	P1150823.JPG	P1150823	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-13 13:58:45+00	\N	2025-04-13 13:58:59+00	\N	7361536	4592	2584	\N	\N	\N	\N	\N	{"exif": {"FNumber": 8, "FocalLength": 39, "ExposureTime": 0.02, "ISOSpeedRatings": 25600}, "ifd0": {"Make": "Panasonic", "Model": "DMC-G7"}}	\N	\N	\N	\N	2025-04-13 13:58:59+00
a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55	cloudinary	a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55.png	Screenshot 2025-07-29 090007.png	Screenshot 2025 07 29 090007	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:56:46.125+00	\N	2025-08-20 13:56:52.722+00	\N	300906	1918	905	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-08-20 13:56:52.707+00
ca6bc938-1974-4e0d-8eae-83b1c77e518e	cloudinary	ca6bc938-1974-4e0d-8eae-83b1c77e518e.png	Group 503.png	Group 503	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 13:57:29.531+00	\N	2025-08-20 13:57:35.872+00	\N	838652	1918	972	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-08-20 13:57:35.857+00
6bbda258-d18c-45c5-a58b-1877d057e78e	cloudinary	6bbda258-d18c-45c5-a58b-1877d057e78e.jpg	WhatsApp Image 2025-07-03 at 13.13.26_5496ee1e.jpg	Whats App Image 2025 07 03 at 13.13.26 5496ee1e	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:02:28.976+00	\N	2025-08-20 14:02:33.739+00	\N	153682	963	1280	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-08-20 14:02:33.724+00
fcbfac4f-7837-48ce-956c-fc3fa87ae2fd	cloudinary	fcbfac4f-7837-48ce-956c-fc3fa87ae2fd.png	Slice 1.png	Slice 1	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:03:03.615+00	\N	2025-08-20 14:03:09.264+00	\N	207898	1886	956	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-08-20 14:03:09.249+00
e6c66500-f365-432b-b15e-35b57caafd68	cloudinary	e6c66500-f365-432b-b15e-35b57caafd68.jpg	WhatsApp Image 2025-08-13 at 21.22.52_1306fb39.jpg	Whats App Image 2025 08 13 at 21.22.52 1306fb39	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-20 14:03:21.614+00	\N	2025-08-20 14:03:26.289+00	\N	71829	1599	846	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-08-20 14:03:26.275+00
ff8ea093-91e8-4dc3-ac3f-aa552e89cfe4	cloudinary	ff8ea093-91e8-4dc3-ac3f-aa552e89cfe4.jpg	RMS Hari Penting.jpg	Rms Hari Penting	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:08.475+00	\N	2025-09-11 15:05:13.436+00	\N	148602	1080	1080	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:05:13.42+00
2e781692-8cea-4eb2-a8e5-58fc0cd76095	cloudinary	2e781692-8cea-4eb2-a8e5-58fc0cd76095.mp4	RMS Hari Penting (1).mp4	Rms Hari Penting (1)	video/mp4	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:08.507+00	\N	2025-09-11 15:05:15.354+00	\N	381485	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-11 15:05:15.337+00
abbc5f31-bef7-48b7-8524-38fcd16832f8	cloudinary	abbc5f31-bef7-48b7-8524-38fcd16832f8.jpg	RMS Hari Penting.jpg	Rms Hari Penting	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:19.56+00	\N	2025-09-11 15:05:25.552+00	\N	148602	1080	1080	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:05:25.537+00
e67f18a7-970f-498d-992f-17f8b6873deb	cloudinary	e67f18a7-970f-498d-992f-17f8b6873deb.mp4	RMS Hari Penting (1).mp4	Rms Hari Penting (1)	video/mp4	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:35.392+00	\N	2025-09-11 15:05:54.409+00	\N	381485	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-11 15:05:54.391+00
7fcff390-a543-4e4f-abf9-2eae212261dd	cloudinary	7fcff390-a543-4e4f-abf9-2eae212261dd.png	upscaled_logo.png	Upscaled Logo	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:05:58.838+00	\N	2025-09-11 15:06:04.151+00	\N	125112	784	392	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:06:04.133+00
bb279472-b39d-4e64-af00-87a62860614c	cloudinary	bb279472-b39d-4e64-af00-87a62860614c.png	RMS Hari Penting (4).png	Rms Hari Penting (4)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:06:18.524+00	\N	2025-09-11 15:06:23.954+00	\N	321355	1080	1080	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:06:23.938+00
afa75bc7-8fb1-4eb2-82a9-2a43493ce4f7	cloudinary	afa75bc7-8fb1-4eb2-82a9-2a43493ce4f7.jpg	avatar_20241102_082602_image_cropper_1730510744766.jpg	Avatar 20241102 082602 Image Cropper 1730510744766	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:06:36.77+00	\N	2025-09-11 15:06:43.882+00	\N	293513	1500	1500	\N	\N	\N	\N	\N	{"ifd0":{"Make":"realme","Model":"realme C12"},"exif":{"FNumber":2.4,"ExposureTime":0.01,"FocalLength":2.18,"ISOSpeedRatings":135}}	\N	\N	\N	\N	2025-09-11 15:06:43.867+00
e59518c0-ac31-4f5c-a8fb-e3972821c5e9	cloudinary	e59518c0-ac31-4f5c-a8fb-e3972821c5e9.mov	0820.mov	0820	video/quicktime	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:06:55.639+00	\N	2025-09-11 15:07:01.124+00	\N	430147	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-11 15:07:01.106+00
908bb409-ebbf-48b1-a25d-cd9e6f30bea1	cloudinary	908bb409-ebbf-48b1-a25d-cd9e6f30bea1.png	mingcute--github-line.png	Mingcute  GitHub Line	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:55:37.219+00	\N	2025-09-11 15:55:40.577+00	\N	20719	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:55:40.562+00
7c6ecc43-2d33-4658-8f3d-786ea359a14e	cloudinary	7c6ecc43-2d33-4658-8f3d-786ea359a14e.png	iconoir--git.png	Iconoir  Git	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:14.06+00	\N	2025-09-11 15:56:19.257+00	\N	26348	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:56:19.242+00
a062e730-f061-4cf0-be31-c06e0c47aa10	cloudinary	a062e730-f061-4cf0-be31-c06e0c47aa10.png	solar--figma-broken.png	Solar  Figma Broken	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:35.414+00	\N	2025-09-11 15:56:39.644+00	\N	21722	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:56:39.628+00
dc9db38f-d94d-4ee6-8db3-07fd4f729ad0	cloudinary	dc9db38f-d94d-4ee6-8db3-07fd4f729ad0.png	lineicons--postman.png	Lineicons  Postman	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:50.894+00	\N	2025-09-11 15:56:53.581+00	\N	22634	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:56:53.566+00
8bf85679-a3c9-4051-9e18-f87f1869bcf1	cloudinary	8bf85679-a3c9-4051-9e18-f87f1869bcf1.png	devicon--express.png	Devicon  Express	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:57:08.708+00	\N	2025-09-11 15:57:12.962+00	\N	23115	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:57:12.947+00
efaa7459-6942-4d8c-bd1c-cd42b1b5d9b7	cloudinary	efaa7459-6942-4d8c-bd1c-cd42b1b5d9b7.png	bx--spreadsheet.png	Bx  Spreadsheet	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:57:25.161+00	\N	2025-09-11 15:57:30.333+00	\N	10198	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:57:30.318+00
64fb2000-857f-4936-82f9-35c1ec187957	cloudinary	64fb2000-857f-4936-82f9-35c1ec187957.png	arcticons--microsoft-power-bi.png	Arcticons  Microsoft Power BI	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:58:45.826+00	\N	2025-09-11 15:58:48.119+00	\N	10611	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:58:48.104+00
b2728846-3610-4198-95f5-24fbf46c53fe	cloudinary	b2728846-3610-4198-95f5-24fbf46c53fe.png	simple-icons--bun.png	Simple Icons  Bun	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:04.327+00	\N	2025-09-11 15:59:07.527+00	\N	23336	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:59:07.51+00
ec9d495e-e6bc-49db-803c-a0f25d0229f0	cloudinary	ec9d495e-e6bc-49db-803c-a0f25d0229f0.png	simple-icons--looker.png	Simple Icons  Looker	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:20.154+00	\N	2025-09-11 15:59:21.725+00	\N	22274	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:59:21.71+00
66f7e096-70ac-4bc3-afba-6fed73813cee	cloudinary	66f7e096-70ac-4bc3-afba-6fed73813cee.png	lineicons--mysql.png	Lineicons  MySQL	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:37.622+00	\N	2025-09-11 15:59:42.008+00	\N	21075	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 15:59:41.993+00
133327f2-4105-4866-a7c9-74491c28d826	cloudinary	133327f2-4105-4866-a7c9-74491c28d826.png	tabler--sql.png	Tabler  SQL	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:02.489+00	\N	2025-09-11 16:00:06.201+00	\N	14232	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 16:00:06.184+00
69c7d811-7545-49a3-a314-239ac7866fb1	cloudinary	69c7d811-7545-49a3-a314-239ac7866fb1.png	teenyicons--mongodb-outline.png	Teenyicons  Mongodb Outline	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:19.941+00	\N	2025-09-11 16:00:23.404+00	\N	18350	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 16:00:23.389+00
7eb8efc8-adbc-4c70-ba33-63fba2a0a935	cloudinary	7eb8efc8-adbc-4c70-ba33-63fba2a0a935.png	icon-park-outline--excel.png	Icon Park Outline  Excel	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:45.57+00	\N	2025-09-11 16:00:49.066+00	\N	16210	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 16:00:49.05+00
6382aa4d-ee74-497f-9325-a43d0b0de8a9	cloudinary	6382aa4d-ee74-497f-9325-a43d0b0de8a9.png	teenyicons--docker-outline.png	Teenyicons  Docker Outline	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:09.691+00	\N	2025-09-11 16:01:13.737+00	\N	17048	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 16:01:13.722+00
114e369d-06b3-41e9-b544-e6437a6349e5	cloudinary	114e369d-06b3-41e9-b544-e6437a6349e5.png	ri--nodejs-fill.png	Ri  Nodejs Fill	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:31.077+00	\N	2025-09-11 16:01:34.658+00	\N	23767	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-11 16:01:34.643+00
9236a3ed-40c1-41b0-83a5-9e2ea3106514	cloudinary	9236a3ed-40c1-41b0-83a5-9e2ea3106514.png	Screenshot 2025-09-12 085538.png	Screenshot 2025 09 12 085538	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:02:32.717+00	\N	2025-09-12 02:02:40.833+00	\N	638146	1149	559	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:02:40.817+00
cd26c3bb-27ec-4203-9847-2e5c251a2a52	cloudinary	cd26c3bb-27ec-4203-9847-2e5c251a2a52.png	Screenshot 2025-09-12 085638.png	Screenshot 2025 09 12 085638	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:02:51.532+00	\N	2025-09-12 02:02:58.259+00	\N	566991	1895	896	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:02:58.241+00
bf531657-9d74-43b2-9be3-fb8d9f534e76	cloudinary	bf531657-9d74-43b2-9be3-fb8d9f534e76.png	Screenshot 2025-09-12 085705.png	Screenshot 2025 09 12 085705	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:05.759+00	\N	2025-09-12 02:03:10.561+00	\N	138969	1919	914	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:03:10.541+00
aee44348-e25e-4d33-b889-d32a61ac7b22	cloudinary	aee44348-e25e-4d33-b889-d32a61ac7b22.png	Screenshot 2025-09-12 085601.png	Screenshot 2025 09 12 085601	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:03:16.94+00	\N	2025-09-12 02:03:22.533+00	\N	287936	1151	552	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:03:22.517+00
b9d3f4cf-3f8a-45d0-a061-b82529624510	cloudinary	b9d3f4cf-3f8a-45d0-a061-b82529624510.jpg	WhatsApp Image 2025-09-12 at 09.10.17_3f16bd5b.jpg	Whats App Image 2025 09 12 at 09.10.17 3f16bd5b	image/jpeg	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:13:09.467+00	\N	2025-09-12 02:13:14.559+00	\N	128606	1004	843	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:13:14.544+00
76b87f11-940b-4e7e-860b-9b833ab012de	cloudinary	76b87f11-940b-4e7e-860b-9b833ab012de.png	Screenshot 2025-09-12 092056.png	Screenshot 2025 09 12 092056	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:23:17.173+00	\N	2025-09-12 02:23:22.355+00	\N	599897	1892	883	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:23:22.34+00
a6e3ea76-cc7f-4309-95c8-eae897aa1cd3	cloudinary	a6e3ea76-cc7f-4309-95c8-eae897aa1cd3.png	Screenshot 2025-09-12 092133.png	Screenshot 2025 09 12 092133	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:23:27.325+00	\N	2025-09-12 02:23:33.326+00	\N	500227	1897	897	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:23:33.309+00
61a7d17f-61e4-491f-9119-0975c3164ff0	cloudinary	61a7d17f-61e4-491f-9119-0975c3164ff0.png	Screenshot 2025-09-12 092155.png	Screenshot 2025 09 12 092155	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:23:38.536+00	\N	2025-09-12 02:23:43.741+00	\N	643926	1897	887	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:23:43.726+00
90dd5416-6216-4e07-b513-792c3ac14543	cloudinary	90dd5416-6216-4e07-b513-792c3ac14543.png	Group 526.png	Group 526	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:34:43.12+00	\N	2025-09-12 02:34:47.593+00	\N	121898	1490	808	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:34:47.577+00
5b7f3df1-bf8b-48df-b1da-4afa49cb7f4b	cloudinary	5b7f3df1-bf8b-48df-b1da-4afa49cb7f4b.png	Group 525.png	Group 525	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:34:53.87+00	\N	2025-09-12 02:35:05.622+00	\N	683503	3129	1702	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:35:05.606+00
f80e1f7d-f5d7-4849-afa3-f53168898a70	cloudinary	f80e1f7d-f5d7-4849-afa3-f53168898a70.png	Screenshot 2025-09-12 092657.png	Screenshot 2025 09 12 092657	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:19.954+00	\N	2025-09-12 02:35:25.7+00	\N	66214	1838	843	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:35:25.683+00
11e3fb3f-5625-4060-a99e-76e628694e0d	cloudinary	11e3fb3f-5625-4060-a99e-76e628694e0d.png	Screenshot 2025-09-12 092527.png	Screenshot 2025 09 12 092527	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:35:19.941+00	\N	2025-09-12 02:35:34.107+00	\N	173490	1725	902	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-12 02:35:34.091+00
6886e984-68de-4348-9bae-dda44b898d44	cloudinary	6886e984-68de-4348-9bae-dda44b898d44.png	Group 526 (1).png	Group 526 (1)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:25.76+00	\N	2025-09-13 03:41:30.645+00	\N	128422	973	577	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-13 03:41:30.629+00
70073d8e-ccea-47d3-8f45-a3c1c9c657fc	cloudinary	70073d8e-ccea-47d3-8f45-a3c1c9c657fc.png	Group 525 (1).png	Group 525 (1)	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:37.299+00	\N	2025-09-13 03:41:40.955+00	\N	125339	967	566	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-13 03:41:40.939+00
68727a44-9735-472f-89e3-d9f570959082	cloudinary	68727a44-9735-472f-89e3-d9f570959082.png	Group 528.png	Group 528	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:41:45.316+00	\N	2025-09-13 03:41:49.401+00	\N	172282	1207	755	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-13 03:41:49.386+00
1cf2fb7b-3769-44b2-ae07-a994962832ef	cloudinary	1cf2fb7b-3769-44b2-ae07-a994962832ef.png	Picture1.png	Picture1	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:48:49.124+00	\N	2025-09-25 02:48:53.845+00	\N	189522	618	339	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:48:53.828+00
b10f20fe-f1dc-4c82-8215-9e1879003e2e	cloudinary	b10f20fe-f1dc-4c82-8215-9e1879003e2e.png	Picture6.png	Picture6	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.389+00	\N	2025-09-25 02:49:03.015+00	\N	38115	384	210	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:02.999+00
f92c9844-67d7-41c5-9a65-1e0b0f00323f	cloudinary	f92c9844-67d7-41c5-9a65-1e0b0f00323f.png	Picture2.png	Picture2	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.295+00	\N	2025-09-25 02:49:03.393+00	\N	37119	383	208	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:03.378+00
b2082e6b-fe28-4efa-a4ff-dde9500ec387	cloudinary	b2082e6b-fe28-4efa-a4ff-dde9500ec387.png	Picture7.png	Picture7	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.282+00	\N	2025-09-25 02:49:03.542+00	\N	23143	345	186	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:03.528+00
820e72f9-7f20-4cbb-9987-7f13fa3bbce0	cloudinary	820e72f9-7f20-4cbb-9987-7f13fa3bbce0.png	Picture3.png	Picture3	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.233+00	\N	2025-09-25 02:49:03.667+00	\N	30123	355	194	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:03.651+00
6f0eb1fd-3211-469e-8fab-93e1aa3e1fca	cloudinary	6f0eb1fd-3211-469e-8fab-93e1aa3e1fca.png	Picture4.png	Picture4	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.342+00	\N	2025-09-25 02:49:03.685+00	\N	30088	355	196	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:03.668+00
75d5253c-8e5f-450c-8c95-01dc67b3d263	cloudinary	75d5253c-8e5f-450c-8c95-01dc67b3d263.png	Picture5.png	Picture5	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:00.363+00	\N	2025-09-25 02:49:04.093+00	\N	62100	394	209	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:04.079+00
c509123f-2c9d-4075-97df-011667a4b2d2	cloudinary	c509123f-2c9d-4075-97df-011667a4b2d2.png	Picture9.png	Picture9	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:03.535+00	\N	2025-09-25 02:49:05.394+00	\N	18797	357	167	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:05.379+00
55e1011d-e96a-4695-9336-651c71c831d8	cloudinary	55e1011d-e96a-4695-9336-651c71c831d8.png	Picture8.png	Picture8	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:49:03.2+00	\N	2025-09-25 02:49:05.688+00	\N	80804	392	190	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:49:05.673+00
9220109c-9f88-41b2-9ebf-ee5404242c39	cloudinary	9220109c-9f88-41b2-9ebf-ee5404242c39.png	image 134.png	Image 134	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:55:58.597+00	\N	2025-09-25 02:56:04.319+00	\N	376604	1893	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:56:04.3+00
66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a	cloudinary	66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a.png	image 133.png	Image 133	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:56:37.028+00	\N	2025-09-25 02:56:42.666+00	\N	683898	1138	543	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:56:42.651+00
d0044ddf-3cf7-43cb-bdb8-0a3f413134a5	cloudinary	d0044ddf-3cf7-43cb-bdb8-0a3f413134a5.png	image 136.png	Image 136	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:56:53.251+00	\N	2025-09-25 02:56:58.723+00	\N	359385	408	739	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:56:58.707+00
8936ab46-9022-4823-8ac5-728d4de7813b	cloudinary	8936ab46-9022-4823-8ac5-728d4de7813b.png	image 135.png	Image 135	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:04.051+00	\N	2025-09-25 02:57:08.833+00	\N	107008	1899	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:57:08.818+00
dc50a198-a095-49e9-b3de-d5682a3fb6ca	cloudinary	dc50a198-a095-49e9-b3de-d5682a3fb6ca.png	image 137.png	Image 137	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 02:57:13.844+00	\N	2025-09-25 02:57:19.351+00	\N	149685	1361	846	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 02:57:19.336+00
5d8052af-cc38-42ea-a128-e0094a3a4fac	cloudinary	5d8052af-cc38-42ea-a128-e0094a3a4fac.png	image 133.png	Image 133	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:39.208+00	\N	2025-09-25 03:01:45.107+00	\N	683898	1138	543	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:01:45.091+00
9d40c598-32a6-432b-87b5-7d413339057f	cloudinary	9d40c598-32a6-432b-87b5-7d413339057f.png	Screenshot 2025-09-25 095935.png	Screenshot 2025 09 25 095935	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:01:56.446+00	\N	2025-09-25 03:02:01.775+00	\N	286713	410	738	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:02:01.76+00
008a7468-4d4d-49d1-9e6b-8859a853a63a	cloudinary	008a7468-4d4d-49d1-9e6b-8859a853a63a.png	Screenshot 2025-09-25 100036.png	Screenshot 2025 09 25 100036	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:09.27+00	\N	2025-09-25 03:02:13.328+00	\N	64933	412	742	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:02:13.314+00
75d60b48-6440-4a4a-932a-b53cbcf184bb	cloudinary	75d60b48-6440-4a4a-932a-b53cbcf184bb.png	image 136.png	Image 136	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:34.608+00	\N	2025-09-25 03:02:39.856+00	\N	359385	408	739	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:02:39.841+00
f8905818-2843-4a3a-aef7-59bc22cac963	cloudinary	f8905818-2843-4a3a-aef7-59bc22cac963.png	image 134.png	Image 134	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:52.154+00	\N	2025-09-25 03:02:56.274+00	\N	376604	1893	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:02:56.258+00
94d8529c-eb6a-43ae-bfe6-483a1afb7a20	cloudinary	94d8529c-eb6a-43ae-bfe6-483a1afb7a20.png	image 135.png	Image 135	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:02:52.166+00	\N	2025-09-25 03:02:56.335+00	\N	107008	1899	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:02:56.321+00
85b47526-2052-445c-a7bf-f316f30f3035	cloudinary	85b47526-2052-445c-a7bf-f316f30f3035.png	image 137.png	Image 137	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:02.887+00	\N	2025-09-25 03:03:07.7+00	\N	149685	1361	846	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:03:07.681+00
d1fbaed4-1e6f-492d-9baf-9ef64a2ec15b	cloudinary	d1fbaed4-1e6f-492d-9baf-9ef64a2ec15b.png	image 136.png	Image 136	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:03:02.893+00	\N	2025-09-25 03:03:07.788+00	\N	359385	408	739	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:03:07.774+00
7de1c245-4eeb-42f6-94ef-48cc8da3b05b	cloudinary	7de1c245-4eeb-42f6-94ef-48cc8da3b05b.png	image 140PDP.png	Image 140 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.308+00	\N	2025-09-25 03:30:28.213+00	\N	253592	1919	913	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:28.198+00
e66d6211-0c08-467d-86a3-e54ba0db0aca	cloudinary	e66d6211-0c08-467d-86a3-e54ba0db0aca.png	image 138PDP.png	Image 138 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.295+00	\N	2025-09-25 03:30:28.278+00	\N	228512	1903	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:28.263+00
de5b72f7-374d-4b21-aea9-da0fe567ac84	cloudinary	de5b72f7-374d-4b21-aea9-da0fe567ac84.png	image 141PDP.png	Image 141 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.423+00	\N	2025-09-25 03:30:28.653+00	\N	243009	1919	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:28.638+00
fc920da1-e2f8-4d09-95e9-e219aae8ab51	cloudinary	fc920da1-e2f8-4d09-95e9-e219aae8ab51.png	image 139PDP.png	Image 139 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:24.338+00	\N	2025-09-25 03:30:28.825+00	\N	206277	1919	909	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:28.81+00
88084266-e7f7-413f-b5a8-8fc3bbb8ca4c	cloudinary	88084266-e7f7-413f-b5a8-8fc3bbb8ca4c.png	image 143PDP.png	Image 143 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.775+00	\N	2025-09-25 03:30:38.843+00	\N	230502	1919	909	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:38.827+00
4935c5ea-d91a-4a6a-a1e0-351b61032b42	cloudinary	4935c5ea-d91a-4a6a-a1e0-351b61032b42.png	image 144PDP.png	Image 144 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.762+00	\N	2025-09-25 03:30:38.845+00	\N	154397	566	1033	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:38.83+00
a298debe-c993-41ba-91c1-05f8d5f9eaf1	cloudinary	a298debe-c993-41ba-91c1-05f8d5f9eaf1.png	image 146PDP.png	Image 146 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.911+00	\N	2025-09-25 03:30:38.963+00	\N	183277	566	1025	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:38.948+00
56be0d32-b44d-40fa-9cbe-13aa24fed0d6	cloudinary	56be0d32-b44d-40fa-9cbe-13aa24fed0d6.png	image 142PDP.png	Image 142 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.748+00	\N	2025-09-25 03:30:39.024+00	\N	177638	1919	911	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:39.007+00
e2c3417e-6db1-455e-9930-a65e4bc117c3	cloudinary	e2c3417e-6db1-455e-9930-a65e4bc117c3.png	image 145PDP.png	Image 145 Pdp	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:30:35.746+00	\N	2025-09-25 03:30:39.565+00	\N	98907	568	1033	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:30:39.55+00
cf3b2f9b-441a-4d93-88b3-c23f40d0f529	cloudinary	cf3b2f9b-441a-4d93-88b3-c23f40d0f529.png	Group 537.png	Group 537	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.259+00	\N	2025-09-25 03:39:08.628+00	\N	157918	1903	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:08.613+00
eff256be-a612-46c6-bbe2-071c7d942118	cloudinary	eff256be-a612-46c6-bbe2-071c7d942118.png	Group 538.png	Group 538	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.329+00	\N	2025-09-25 03:39:09.006+00	\N	190937	1919	909	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:08.991+00
be68b2f9-89c6-4b8e-86ed-db5243fd8400	cloudinary	be68b2f9-89c6-4b8e-86ed-db5243fd8400.png	Group 540.png	Group 540	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.262+00	\N	2025-09-25 03:39:09.268+00	\N	194846	1919	909	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:09.253+00
1cc182f4-1afe-4937-869b-f17be5cde070	cloudinary	1cc182f4-1afe-4937-869b-f17be5cde070.png	Group 539.png	Group 539	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:05.327+00	\N	2025-09-25 03:39:09.876+00	\N	174404	1919	911	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:09.861+00
04323344-2faf-4a30-ad5f-97a18c73c831	cloudinary	04323344-2faf-4a30-ad5f-97a18c73c831.png	Group 541.png	Group 541	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.772+00	\N	2025-09-25 03:39:24.7+00	\N	207763	1919	908	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:24.685+00
10a8bdb0-e9f0-4bbf-8321-b0829672a492	cloudinary	10a8bdb0-e9f0-4bbf-8321-b0829672a492.png	Group 544.png	Group 544	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.76+00	\N	2025-09-25 03:39:24.776+00	\N	92220	568	1033	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:24.762+00
d33b2a90-dfa1-48e5-996a-058c542090c5	cloudinary	d33b2a90-dfa1-48e5-996a-058c542090c5.png	Group 542.png	Group 542	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.789+00	\N	2025-09-25 03:39:24.849+00	\N	250402	1919	913	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:24.834+00
07985fe1-d1a7-46b6-ac0e-0e848f6e34a8	cloudinary	07985fe1-d1a7-46b6-ac0e-0e848f6e34a8.png	Group 543.png	Group 543	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.784+00	\N	2025-09-25 03:39:24.93+00	\N	102500	566	1025	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:24.913+00
933dfe12-6859-4f78-b3f7-79ba83b5b888	cloudinary	933dfe12-6859-4f78-b3f7-79ba83b5b888.png	Group 545.png	Group 545	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-25 03:39:20.87+00	\N	2025-09-25 03:39:25.039+00	\N	145821	566	1033	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-09-25 03:39:25.024+00
59b61074-3cb5-406c-a9b8-5f0d84d83f96	cloudinary	59b61074-3cb5-406c-a9b8-5f0d84d83f96.png	mdi--react.png	Mdi  React	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:07:04.215+00	\N	2025-10-08 15:07:08.985+00	\N	29192	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-10-08 15:07:08.969+00
34a4e7c8-9709-43a3-bdb5-87fd0864d516	cloudinary	34a4e7c8-9709-43a3-bdb5-87fd0864d516.png	simple-icons--nuxt.png	Simple Icons  Nuxt	image/png	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:02.188+00	\N	2025-10-08 15:08:06.311+00	\N	19152	512	512	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-10-08 15:08:06.293+00
\.


--
-- TOC entry 5081 (class 0 OID 16547)
-- Dependencies: 229
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- TOC entry 5082 (class 0 OID 16560)
-- Dependencies: 230
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- TOC entry 5083 (class 0 OID 16564)
-- Dependencies: 231
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-04-13 12:06:01+00
20201029A	Remove System Relations	2025-04-13 12:06:01+00
20201029B	Remove System Collections	2025-04-13 12:06:01+00
20201029C	Remove System Fields	2025-04-13 12:06:01+00
20201105A	Add Cascade System Relations	2025-04-13 12:06:03+00
20201105B	Change Webhook URL Type	2025-04-13 12:06:03+00
20210225A	Add Relations Sort Field	2025-04-13 12:06:03+00
20210304A	Remove Locked Fields	2025-04-13 12:06:03+00
20210312A	Webhooks Collections Text	2025-04-13 12:06:03+00
20210331A	Add Refresh Interval	2025-04-13 12:06:03+00
20210415A	Make Filesize Nullable	2025-04-13 12:06:03+00
20210416A	Add Collections Accountability	2025-04-13 12:06:03+00
20210422A	Remove Files Interface	2025-04-13 12:06:03+00
20210506A	Rename Interfaces	2025-04-13 12:06:03+00
20210510A	Restructure Relations	2025-04-13 12:06:03+00
20210518A	Add Foreign Key Constraints	2025-04-13 12:06:03+00
20210519A	Add System Fk Triggers	2025-04-13 12:06:04+00
20210521A	Add Collections Icon Color	2025-04-13 12:06:04+00
20210525A	Add Insights	2025-04-13 12:06:04+00
20210608A	Add Deep Clone Config	2025-04-13 12:06:04+00
20210626A	Change Filesize Bigint	2025-04-13 12:06:04+00
20210716A	Add Conditions to Fields	2025-04-13 12:06:04+00
20210721A	Add Default Folder	2025-04-13 12:06:04+00
20210802A	Replace Groups	2025-04-13 12:06:04+00
20210803A	Add Required to Fields	2025-04-13 12:06:05+00
20210805A	Update Groups	2025-04-13 12:06:05+00
20210805B	Change Image Metadata Structure	2025-04-13 12:06:05+00
20210811A	Add Geometry Config	2025-04-13 12:06:05+00
20210831A	Remove Limit Column	2025-04-13 12:06:05+00
20210903A	Add Auth Provider	2025-04-13 12:06:05+00
20210907A	Webhooks Collections Not Null	2025-04-13 12:06:05+00
20210910A	Move Module Setup	2025-04-13 12:06:05+00
20210920A	Webhooks URL Not Null	2025-04-13 12:06:05+00
20210924A	Add Collection Organization	2025-04-13 12:06:05+00
20210927A	Replace Fields Group	2025-04-13 12:06:05+00
20210927B	Replace M2M Interface	2025-04-13 12:06:05+00
20210929A	Rename Login Action	2025-04-13 12:06:05+00
20211007A	Update Presets	2025-04-13 12:06:05+00
20211009A	Add Auth Data	2025-04-13 12:06:06+00
20211016A	Add Webhook Headers	2025-04-13 12:06:06+00
20211103A	Set Unique to User Token	2025-04-13 12:06:06+00
20211103B	Update Special Geometry	2025-04-13 12:06:06+00
20211104A	Remove Collections Listing	2025-04-13 12:06:06+00
20211118A	Add Notifications	2025-04-13 12:06:06+00
20211211A	Add Shares	2025-04-13 12:06:06+00
20211230A	Add Project Descriptor	2025-04-13 12:06:06+00
20220303A	Remove Default Project Color	2025-04-13 12:06:06+00
20220308A	Add Bookmark Icon and Color	2025-04-13 12:06:06+00
20220314A	Add Translation Strings	2025-04-13 12:06:07+00
20220322A	Rename Field Typecast Flags	2025-04-13 12:06:07+00
20220323A	Add Field Validation	2025-04-13 12:06:07+00
20220325A	Fix Typecast Flags	2025-04-13 12:06:07+00
20220325B	Add Default Language	2025-04-13 12:06:07+00
20220402A	Remove Default Value Panel Icon	2025-04-13 12:06:07+00
20220429A	Add Flows	2025-04-13 12:06:07+00
20220429B	Add Color to Insights Icon	2025-04-13 12:06:07+00
20220429C	Drop Non Null From IP of Activity	2025-04-13 12:06:07+00
20220429D	Drop Non Null From Sender of Notifications	2025-04-13 12:06:07+00
20220614A	Rename Hook Trigger to Event	2025-04-13 12:06:07+00
20220801A	Update Notifications Timestamp Column	2025-04-13 12:06:07+00
20220802A	Add Custom Aspect Ratios	2025-04-13 12:06:08+00
20220826A	Add Origin to Accountability	2025-04-13 12:06:08+00
20230401A	Update Material Icons	2025-04-13 12:06:08+00
20230525A	Add Preview Settings	2025-04-13 12:06:08+00
20230526A	Migrate Translation Strings	2025-04-13 12:06:08+00
20230721A	Require Shares Fields	2025-04-13 12:06:08+00
20230823A	Add Content Versioning	2025-04-13 12:06:08+00
20230927A	Themes	2025-04-13 12:06:09+00
20231009A	Update CSV Fields to Text	2025-04-13 12:06:09+00
20231009B	Update Panel Options	2025-04-13 12:06:09+00
20231010A	Add Extensions	2025-04-13 12:06:09+00
20231215A	Add Focalpoints	2025-04-13 12:06:09+00
20240122A	Add Report URL Fields	2025-04-13 12:06:09+00
20240204A	Marketplace	2025-04-13 12:06:09+00
20240305A	Change Useragent Type	2025-04-13 12:06:10+00
20240311A	Deprecate Webhooks	2025-04-13 12:06:10+00
20240422A	Public Registration	2025-04-13 12:06:08+00
20240515A	Add Session Window	2025-04-13 12:06:08+00
20240701A	Add Tus Data	2025-04-13 12:06:08+00
20240716A	Update Files Date Fields	2025-04-13 12:06:08+00
20240806A	Permissions Policies	2025-04-13 12:06:14+00
20240817A	Update Icon Fields Length	2025-04-13 12:06:14+00
20240909A	Separate Comments	2025-04-13 12:06:14+00
20240909B	Consolidate Content Versioning	2025-04-13 12:06:14+00
20240924A	Migrate Legacy Comments	2025-04-13 12:06:14+00
20240924B	Populate Versioning Deltas	2025-04-13 12:06:14+00
20250224A	Visual Editor	2025-04-13 12:06:14+00
20250609A	License Banner	2025-08-05 16:16:07.07056+00
20250613A	Add Project ID	2025-08-05 16:16:07.228565+00
20250718A	Add Direction	2025-08-05 16:16:07.272388+00
\.


--
-- TOC entry 5085 (class 0 OID 16571)
-- Dependencies: 233
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- TOC entry 5086 (class 0 OID 16582)
-- Dependencies: 234
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- TOC entry 5087 (class 0 OID 16592)
-- Dependencies: 235
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- TOC entry 5089 (class 0 OID 16604)
-- Dependencies: 237
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
2	educations	read	{"_and": [{"status": {"_eq": "published"}}]}	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
3	experiences	read	{"_and": [{"status": {"_eq": "published"}}]}	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
5	languanges	read	{"_and": [{"status": {"_eq": "published"}}]}	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
7	main_contents	read	{"_and": [{"status": {"_eq": "published"}}]}	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
8	projects_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
10	specialties	read	{"_and": [{"status": {"_eq": "published"}}]}	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
11	project_types	read	{"_and": [{"status": {"_eq": "published"}}]}	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
13	job_types	read	{"_and": [{"status": {"_eq": "published"}}]}	\N	\N	id,sort,user_updated,date_updated,user_created,name,status,date_created	abf8a154-5b1c-4a46-ac9c-7300570f4f17
14	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
1	projects	read	{"_and":[{"status":{"_eq":"published"}}]}	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
9	skills	read	{"_and":[{"status":{"_eq":"published"}}]}	\N	\N	id,icon,sort,user_created,date_created,user_updated,date_updated,title,status	abf8a154-5b1c-4a46-ac9c-7300570f4f17
15	projects_skills	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
16	projects_skills_1	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
17	experiences_skills	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
\.


--
-- TOC entry 5090 (class 0 OID 16610)
-- Dependencies: 238
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
92e59311-464c-4d00-9257-23c39aa0324c	Administrator	verified	$t:admin_description	\N	f	t	t
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
\.


--
-- TOC entry 5092 (class 0 OID 16620)
-- Dependencies: 240
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	directus_users	\N	cards	{"cards": {"page": 1, "sort": ["email"]}}	{"cards": {"icon": "account_circle", "size": 4, "title": "{{ first_name }} {{ last_name }}", "subtitle": "{{ email }}"}}	\N	\N	bookmark	\N
3	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	directus_activity	\N	tabular	{"tabular": {"page": 1, "sort": ["-timestamp"], "fields": ["action", "collection", "timestamp", "user"]}}	{"tabular": {"widths": {"user": 240, "action": 120, "timestamp": 240, "collection": 210}}}	\N	\N	bookmark	\N
4	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	educations	\N	tabular	{"map": {"limit": 1000}, "tabular": {"fields": ["date_start", "institution", "major", "status", "education_type", "sequence"]}}	{"kanban": {"groupOrder": {"sortMap": {"draft": 1, "archived": 2, "published": 0}, "groupField": "status"}}, "tabular": {"widths": {"date_start": 291.199951171875}, "spacing": "comfortable"}}	\N	\N	bookmark	\N
6	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	experiences	\N	\N	{"tabular": {"fields": ["company", "date_start", "position", "status", "job_type", "sequence"]}}	\N	\N	\N	bookmark	\N
7	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	languanges	\N	\N	{"tabular": {"page": 1, "fields": ["name", "status", "level_types"]}}	\N	\N	\N	bookmark	\N
9	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	specialties	\N	tabular	{"map": {"limit": 1000}, "tabular": {"fields": ["description", "icon", "status", "title"]}}	{"cards": {"title": "{{title}}", "subtitle": "{{description}}"}, "tabular": {"widths": {"description": 361}, "spacing": "comfortable"}}	\N	\N	bookmark	\N
8	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	languanges_undefined	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
10	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	skills	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
5	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	\N	projects	\N	\N	{"tabular":{"fields":["description","images","skills_used.skills_id.title","status","title","type"]}}	{"tabular":{"widths":{"description":160,"images":160,"skills_used.skills_id.title":160,"status":160,"title":550.0001220703125,"type":160}}}	\N	\N	bookmark	\N
\.


--
-- TOC entry 5094 (class 0 OID 16635)
-- Dependencies: 242
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
5	educations	user_created	directus_users	\N	\N	\N	\N	\N	nullify
6	educations	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
7	experiences	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
8	experiences	user_created	directus_users	\N	\N	\N	\N	\N	nullify
9	main_contents	user_created	directus_users	\N	\N	\N	\N	\N	nullify
10	main_contents	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
11	projects	user_created	directus_users	\N	\N	\N	\N	\N	nullify
12	projects	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
13	skills	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
14	skills	user_created	directus_users	\N	\N	\N	\N	\N	nullify
15	specialties	user_created	directus_users	\N	\N	\N	\N	\N	nullify
16	specialties	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
17	languanges	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
18	languanges	user_created	directus_users	\N	\N	\N	\N	\N	nullify
21	specialties	icon	directus_files	\N	\N	\N	\N	\N	nullify
23	projects_files	directus_files_id	directus_files	\N	\N	\N	projects_id	\N	nullify
24	projects_files	projects_id	projects	images	\N	\N	directus_files_id	\N	nullify
27	skills	icon	directus_files	\N	\N	\N	\N	\N	nullify
28	project_types	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
29	project_types	user_created	directus_users	\N	\N	\N	\N	\N	nullify
30	projects	type	project_types	\N	\N	\N	\N	\N	nullify
31	job_types	user_created	directus_users	\N	\N	\N	\N	\N	nullify
32	job_types	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
33	experiences	job_type	job_types	\N	\N	\N	\N	\N	nullify
40	project_types	icon	directus_files	\N	\N	\N	\N	\N	nullify
42	projects_skills	skills_id	skills	\N	\N	\N	projects_id	\N	nullify
43	projects_skills	projects_id	projects	skills_used	\N	\N	skills_id	\N	nullify
44	experiences_skills	skills_id	skills	\N	\N	\N	experiences_id	\N	nullify
45	experiences_skills	experiences_id	experiences	skills_used	\N	\N	skills_id	\N	nullify
46	projects_skills_1	skills_id	skills	\N	\N	\N	projects_id	\N	nullify
47	projects_skills_1	projects_id	projects	\N	\N	\N	skills_id	\N	nullify
\.


--
-- TOC entry 5096 (class 0 OID 16648)
-- Dependencies: 244
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_files	0fcda0d3-1462-44ff-bbf2-089b329221f8	{"type": "image/jpeg", "title": "P1150823", "storage": "local", "filename_download": "P1150823.JPG"}	{"type": "image/jpeg", "title": "P1150823", "storage": "local", "filename_download": "P1150823.JPG"}	\N	\N
2	3	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	{"id": "a89509b5-964d-4f8d-9e09-d6e79c368399", "role": "8a883d4d-af7e-4354-98a4-176b474e9fcc", "tags": null, "email": "khairulanamstud@gmail.com", "title": null, "token": null, "avatar": "0fcda0d3-1462-44ff-bbf2-089b329221f8", "status": "active", "language": null, "location": null, "password": "**********", "policies": [], "provider": "default", "auth_data": null, "last_name": "Anam", "last_page": "/users/a89509b5-964d-4f8d-9e09-d6e79c368399", "appearance": null, "first_name": "Khoirul", "tfa_secret": null, "theme_dark": null, "description": null, "last_access": "2025-04-13T06:50:03.000Z", "theme_light": null, "email_notifications": true, "external_identifier": null, "theme_dark_overrides": null, "theme_light_overrides": null}	{"avatar": "0fcda0d3-1462-44ff-bbf2-089b329221f8", "last_name": "Anam", "first_name": "Khoirul"}	\N	\N
3	5	directus_files	edbfd472-67cc-4dd9-a032-17c13e755b77	{"type": "image/png", "title": "Erben Noerman", "storage": "cloudinary", "filename_download": "Erben Noerman.png"}	{"type": "image/png", "title": "Erben Noerman", "storage": "cloudinary", "filename_download": "Erben Noerman.png"}	\N	\N
4	6	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	{"id": "a89509b5-964d-4f8d-9e09-d6e79c368399", "role": "8a883d4d-af7e-4354-98a4-176b474e9fcc", "tags": null, "email": "khairulanamstud@gmail.com", "title": null, "token": null, "avatar": "edbfd472-67cc-4dd9-a032-17c13e755b77", "status": "active", "language": null, "location": null, "password": "**********", "policies": [], "provider": "default", "auth_data": null, "last_name": "Anam", "last_page": "/users/a89509b5-964d-4f8d-9e09-d6e79c368399", "appearance": null, "first_name": "Khoirul", "tfa_secret": null, "theme_dark": null, "description": null, "last_access": "2025-04-13T06:56:30.000Z", "theme_light": null, "email_notifications": true, "external_identifier": null, "theme_dark_overrides": null, "theme_light_overrides": null}	{"avatar": "edbfd472-67cc-4dd9-a032-17c13e755b77"}	\N	\N
5	8	directus_files	edd7abe3-0790-40f8-9a31-c8c308171741	{"type": "image/jpeg", "title": "P1150823", "storage": "cloudinary", "filename_download": "P1150823.JPG"}	{"type": "image/jpeg", "title": "P1150823", "storage": "cloudinary", "filename_download": "P1150823.JPG"}	\N	\N
6	9	directus_users	a89509b5-964d-4f8d-9e09-d6e79c368399	{"id": "a89509b5-964d-4f8d-9e09-d6e79c368399", "role": "8a883d4d-af7e-4354-98a4-176b474e9fcc", "tags": null, "email": "khairulanamstud@gmail.com", "title": null, "token": null, "avatar": "edd7abe3-0790-40f8-9a31-c8c308171741", "status": "active", "language": null, "location": null, "password": "**********", "policies": [], "provider": "default", "auth_data": null, "last_name": "Anam", "last_page": "/content", "appearance": null, "first_name": "Khoirul", "tfa_secret": null, "theme_dark": null, "description": null, "last_access": "2025-04-13T06:56:30.000Z", "theme_light": null, "email_notifications": true, "external_identifier": null, "theme_dark_overrides": null, "theme_light_overrides": null}	{"avatar": "edd7abe3-0790-40f8-9a31-c8c308171741"}	\N	\N
7	10	directus_fields	1	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "educations"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "educations"}	\N	\N
8	11	directus_fields	2	{"sort": 2, "field": "sort", "hidden": true, "interface": "input", "collection": "educations"}	{"sort": 2, "field": "sort", "hidden": true, "interface": "input", "collection": "educations"}	\N	\N
9	12	directus_fields	3	{"sort": 3, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	{"sort": 3, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	\N	\N
10	13	directus_fields	4	{"sort": 4, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	{"sort": 4, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	\N	\N
11	14	directus_fields	5	{"sort": 5, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	{"sort": 5, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	\N	\N
12	15	directus_fields	6	{"sort": 6, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	{"sort": 6, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	\N	\N
13	16	directus_collections	educations	{"singleton": false, "collection": "educations", "sort_field": "sort"}	{"singleton": false, "collection": "educations", "sort_field": "sort"}	\N	\N
14	17	directus_fields	7	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "experiences"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "experiences"}	\N	\N
15	18	directus_fields	8	{"sort": 2, "field": "sort", "hidden": true, "interface": "input", "collection": "experiences"}	{"sort": 2, "field": "sort", "hidden": true, "interface": "input", "collection": "experiences"}	\N	\N
16	19	directus_fields	9	{"sort": 3, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	{"sort": 3, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	\N	\N
308	338	directus_fields	118	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "job_types"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "job_types"}	\N	\N
17	20	directus_fields	10	{"sort": 4, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	{"sort": 4, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	\N	\N
18	21	directus_fields	11	{"sort": 5, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	{"sort": 5, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	\N	\N
19	22	directus_fields	12	{"sort": 6, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	{"sort": 6, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	\N	\N
20	23	directus_collections	experiences	{"singleton": false, "collection": "experiences", "sort_field": "sort"}	{"singleton": false, "collection": "experiences", "sort_field": "sort"}	\N	\N
21	38	directus_fields	13	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "educations"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "educations"}	\N	\N
22	39	directus_fields	14	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "educations", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "educations", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
23	40	directus_fields	15	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "educations"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "educations"}	\N	\N
24	41	directus_fields	16	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	\N	\N
25	42	directus_fields	17	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	\N	\N
26	43	directus_fields	18	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "educations"}	\N	\N
27	44	directus_fields	19	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "educations", "display_options": {"relative": true}}	\N	\N
28	45	directus_collections	educations	{"singleton": false, "collection": "educations", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "educations", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
29	46	directus_fields	20	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "experiences"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "experiences"}	\N	\N
309	339	directus_fields	119	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "job_types"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "job_types"}	\N	\N
30	47	directus_fields	21	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "experiences", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "experiences", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
31	48	directus_fields	22	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "experiences"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "experiences"}	\N	\N
32	49	directus_fields	23	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	\N	\N
33	50	directus_fields	24	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	\N	\N
34	51	directus_fields	25	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	\N	\N
35	52	directus_fields	26	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "experiences", "display_options": {"relative": true}}	\N	\N
36	53	directus_collections	experiences	{"singleton": false, "collection": "experiences", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "experiences", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
37	54	directus_fields	27	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "main_contents"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "main_contents"}	\N	\N
38	55	directus_fields	28	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "main_contents", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "main_contents", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
39	56	directus_fields	29	{"sort": 3, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "main_contents"}	{"sort": 3, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "main_contents"}	\N	\N
40	57	directus_fields	30	{"sort": 4, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "main_contents", "display_options": {"relative": true}}	{"sort": 4, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "main_contents", "display_options": {"relative": true}}	\N	\N
41	58	directus_fields	31	{"sort": 5, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "main_contents"}	{"sort": 5, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "main_contents"}	\N	\N
42	59	directus_fields	32	{"sort": 6, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "main_contents", "display_options": {"relative": true}}	{"sort": 6, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "main_contents", "display_options": {"relative": true}}	\N	\N
43	60	directus_collections	main_contents	{"singleton": true, "collection": "main_contents", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": true, "collection": "main_contents", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
44	61	directus_fields	33	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "projects"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "projects"}	\N	\N
45	62	directus_fields	34	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "projects", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "projects", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
46	63	directus_fields	35	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "projects"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "projects"}	\N	\N
47	64	directus_fields	36	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "projects"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "projects"}	\N	\N
48	65	directus_fields	37	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "projects", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "projects", "display_options": {"relative": true}}	\N	\N
49	66	directus_fields	38	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "projects"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "projects"}	\N	\N
50	67	directus_fields	39	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "projects", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "projects", "display_options": {"relative": true}}	\N	\N
51	68	directus_collections	projects	{"singleton": false, "collection": "projects", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "projects", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
52	69	directus_fields	40	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "skills"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "skills"}	\N	\N
310	340	directus_fields	120	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "job_types", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "job_types", "display_options": {"relative": true}}	\N	\N
53	70	directus_fields	41	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "skills", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "skills", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
54	71	directus_fields	42	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "skills"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "skills"}	\N	\N
55	72	directus_fields	43	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "skills"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "skills"}	\N	\N
56	73	directus_fields	44	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "skills", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "skills", "display_options": {"relative": true}}	\N	\N
57	74	directus_fields	45	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "skills"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "skills"}	\N	\N
58	75	directus_fields	46	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "skills", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "skills", "display_options": {"relative": true}}	\N	\N
59	76	directus_collections	skills	{"singleton": false, "collection": "skills", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "skills", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
60	77	directus_collections	educations	{"icon": "school", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"icon": "school"}	\N	\N
61	78	directus_collections	experiences	{"icon": "work", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"icon": "work"}	\N	\N
62	79	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"icon": "workspace_premium"}	\N	\N
63	80	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"icon": "interactive_space"}	\N	\N
64	82	directus_fields	47	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "specialties"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "specialties"}	\N	\N
311	341	directus_fields	121	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "job_types"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "job_types"}	\N	\N
65	83	directus_fields	48	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "specialties", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "specialties", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
66	84	directus_fields	49	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "specialties"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "specialties"}	\N	\N
67	85	directus_fields	50	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "specialties"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "specialties"}	\N	\N
68	86	directus_fields	51	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "specialties", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "specialties", "display_options": {"relative": true}}	\N	\N
69	87	directus_fields	52	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "specialties"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "specialties"}	\N	\N
70	88	directus_fields	53	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "specialties", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "specialties", "display_options": {"relative": true}}	\N	\N
71	89	directus_collections	specialties	{"singleton": false, "collection": "specialties", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "specialties", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
72	90	directus_fields	54	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "languanges"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "languanges"}	\N	\N
73	91	directus_fields	55	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "languanges", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "languanges", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
74	92	directus_fields	56	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "languanges"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "languanges"}	\N	\N
75	93	directus_fields	57	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "languanges"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "languanges"}	\N	\N
76	94	directus_fields	58	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "languanges", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "languanges", "display_options": {"relative": true}}	\N	\N
77	95	directus_fields	59	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "languanges"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "languanges"}	\N	\N
78	96	directus_fields	60	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "languanges", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "languanges", "display_options": {"relative": true}}	\N	\N
79	97	directus_collections	languanges	{"singleton": false, "collection": "languanges", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "languanges", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
80	98	directus_collections	languanges	{"icon": "select_to_speak", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"icon": "select_to_speak"}	\N	\N
81	99	directus_collections	specialties	{"icon": "eda", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "specialties", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"icon": "eda"}	\N	\N
82	100	directus_collections	specialties	{"icon": "eda", "note": null, "sort": 1, "color": null, "group": "main_contents", "hidden": false, "collapse": "open", "singleton": false, "collection": "specialties", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": "main_contents"}	\N	\N
83	101	directus_collections	educations	{"icon": "school", "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
84	102	directus_collections	experiences	{"icon": "work", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
85	103	directus_collections	languanges	{"icon": "select_to_speak", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
86	104	directus_collections	main_contents	{"icon": null, "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
87	105	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
88	106	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 6, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 6, "group": null}	\N	\N
89	107	directus_collections	main_contents	{"icon": null, "note": null, "sort": 1, "color": null, "group": "experiences", "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": "experiences"}	\N	\N
541	629	directus_files	ca6bc938-1974-4e0d-8eae-83b1c77e518e	{"title":"Group 503","filename_download":"Group 503.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 503","filename_download":"Group 503.png","type":"image/png","storage":"cloudinary"}	\N	\N
90	108	directus_collections	educations	{"icon": "school", "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
91	109	directus_collections	experiences	{"icon": "work", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
92	110	directus_collections	languanges	{"icon": "select_to_speak", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
93	111	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
94	112	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
95	113	directus_collections	main_contents	{"icon": null, "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
96	114	directus_collections	educations	{"icon": "school", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
97	115	directus_collections	experiences	{"icon": "work", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
98	116	directus_collections	languanges	{"icon": "select_to_speak", "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
99	117	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
100	118	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 6, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 6, "group": null}	\N	\N
101	119	directus_collections	main_contents	{"icon": null, "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
102	120	directus_collections	specialties	{"icon": "eda", "note": null, "sort": 1, "color": null, "group": "main_contents", "hidden": false, "collapse": "open", "singleton": false, "collection": "specialties", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": "main_contents"}	\N	\N
103	121	directus_collections	educations	{"icon": "school", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
652	746	projects_skills	2	{"projects_id":"11","skills_id":{"id":"4"}}	{"projects_id":"11","skills_id":{"id":"4"}}	655	\N
104	122	directus_collections	experiences	{"icon": "work", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
105	123	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
106	124	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
107	125	directus_collections	languanges	{"icon": "select_to_speak", "note": null, "sort": 2, "color": null, "group": "main_contents", "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": "main_contents"}	\N	\N
108	126	directus_fields	61	{"sort": 7, "field": "about_desc", "options": {"softLength": null}, "special": null, "interface": "input-multiline", "collection": "main_contents"}	{"sort": 7, "field": "about_desc", "options": {"softLength": null}, "special": null, "interface": "input-multiline", "collection": "main_contents"}	\N	\N
109	127	directus_fields	27	{"id": 27, "note": null, "sort": 1, "field": "id", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": true, "required": false, "interface": "input", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 1, "field": "id", "group": null, "collection": "main_contents"}	\N	\N
110	128	directus_fields	61	{"id": 61, "note": null, "sort": 2, "field": "about_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 2, "field": "about_desc", "group": null, "collection": "main_contents"}	\N	\N
111	129	directus_fields	28	{"id": 28, "note": null, "sort": 3, "field": "status", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "special": null, "readonly": false, "required": false, "interface": "select-dropdown", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}, "validation_message": null}	{"sort": 3, "field": "status", "group": null, "collection": "main_contents"}	\N	\N
112	130	directus_fields	29	{"id": 29, "note": null, "sort": 4, "field": "user_created", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 4, "field": "user_created", "group": null, "collection": "main_contents"}	\N	\N
113	131	directus_fields	30	{"id": 30, "note": null, "sort": 5, "field": "date_created", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-created"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 5, "field": "date_created", "group": null, "collection": "main_contents"}	\N	\N
114	132	directus_fields	31	{"id": 31, "note": null, "sort": 6, "field": "user_updated", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 6, "field": "user_updated", "group": null, "collection": "main_contents"}	\N	\N
115	133	directus_fields	32	{"id": 32, "note": null, "sort": 7, "field": "date_updated", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-updated"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 7, "field": "date_updated", "group": null, "collection": "main_contents"}	\N	\N
116	134	directus_fields	62	{"note": null, "sort": 8, "field": "project_desc", "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"note": null, "sort": 8, "field": "project_desc", "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	\N	\N
117	135	directus_fields	27	{"id": 27, "note": null, "sort": 1, "field": "id", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": true, "required": false, "interface": "input", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 1, "field": "id", "group": null, "collection": "main_contents"}	\N	\N
118	136	directus_fields	61	{"id": 61, "note": null, "sort": 2, "field": "about_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 2, "field": "about_desc", "group": null, "collection": "main_contents"}	\N	\N
119	137	directus_fields	62	{"id": 62, "note": null, "sort": 3, "field": "project_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 3, "field": "project_desc", "group": null, "collection": "main_contents"}	\N	\N
120	138	directus_fields	28	{"id": 28, "note": null, "sort": 4, "field": "status", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "special": null, "readonly": false, "required": false, "interface": "select-dropdown", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}, "validation_message": null}	{"sort": 4, "field": "status", "group": null, "collection": "main_contents"}	\N	\N
121	139	directus_fields	29	{"id": 29, "note": null, "sort": 5, "field": "user_created", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 5, "field": "user_created", "group": null, "collection": "main_contents"}	\N	\N
122	140	directus_fields	30	{"id": 30, "note": null, "sort": 6, "field": "date_created", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-created"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 6, "field": "date_created", "group": null, "collection": "main_contents"}	\N	\N
123	141	directus_fields	31	{"id": 31, "note": null, "sort": 7, "field": "user_updated", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 7, "field": "user_updated", "group": null, "collection": "main_contents"}	\N	\N
124	142	directus_fields	32	{"id": 32, "note": null, "sort": 8, "field": "date_updated", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-updated"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 8, "field": "date_updated", "group": null, "collection": "main_contents"}	\N	\N
125	143	directus_fields	63	{"note": null, "sort": 9, "field": "education_desc", "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"note": null, "sort": 9, "field": "education_desc", "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	\N	\N
126	144	directus_fields	27	{"id": 27, "note": null, "sort": 1, "field": "id", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": true, "required": false, "interface": "input", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 1, "field": "id", "group": null, "collection": "main_contents"}	\N	\N
127	145	directus_fields	61	{"id": 61, "note": null, "sort": 2, "field": "about_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 2, "field": "about_desc", "group": null, "collection": "main_contents"}	\N	\N
128	146	directus_fields	62	{"id": 62, "note": null, "sort": 3, "field": "project_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 3, "field": "project_desc", "group": null, "collection": "main_contents"}	\N	\N
129	147	directus_fields	63	{"id": 63, "note": null, "sort": 4, "field": "education_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 4, "field": "education_desc", "group": null, "collection": "main_contents"}	\N	\N
130	148	directus_fields	28	{"id": 28, "note": null, "sort": 5, "field": "status", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "special": null, "readonly": false, "required": false, "interface": "select-dropdown", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}, "validation_message": null}	{"sort": 5, "field": "status", "group": null, "collection": "main_contents"}	\N	\N
131	149	directus_fields	29	{"id": 29, "note": null, "sort": 6, "field": "user_created", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 6, "field": "user_created", "group": null, "collection": "main_contents"}	\N	\N
132	150	directus_fields	30	{"id": 30, "note": null, "sort": 7, "field": "date_created", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-created"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 7, "field": "date_created", "group": null, "collection": "main_contents"}	\N	\N
133	151	directus_fields	31	{"id": 31, "note": null, "sort": 8, "field": "user_updated", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 8, "field": "user_updated", "group": null, "collection": "main_contents"}	\N	\N
134	152	directus_fields	32	{"id": 32, "note": null, "sort": 9, "field": "date_updated", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-updated"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 9, "field": "date_updated", "group": null, "collection": "main_contents"}	\N	\N
135	153	directus_fields	64	{"note": null, "sort": 10, "field": "experience_desc", "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"note": null, "sort": 10, "field": "experience_desc", "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	\N	\N
136	154	directus_fields	27	{"id": 27, "note": null, "sort": 1, "field": "id", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": true, "required": false, "interface": "input", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 1, "field": "id", "group": null, "collection": "main_contents"}	\N	\N
137	155	directus_fields	61	{"id": 61, "note": null, "sort": 2, "field": "about_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 2, "field": "about_desc", "group": null, "collection": "main_contents"}	\N	\N
138	156	directus_fields	62	{"id": 62, "note": null, "sort": 3, "field": "project_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 3, "field": "project_desc", "group": null, "collection": "main_contents"}	\N	\N
139	157	directus_fields	63	{"id": 63, "note": null, "sort": 4, "field": "education_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 4, "field": "education_desc", "group": null, "collection": "main_contents"}	\N	\N
140	158	directus_fields	64	{"id": 64, "note": null, "sort": 5, "field": "experience_desc", "group": null, "width": "full", "hidden": false, "display": null, "options": {"softLength": null}, "special": null, "readonly": false, "required": false, "interface": "input-multiline", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 5, "field": "experience_desc", "group": null, "collection": "main_contents"}	\N	\N
312	342	directus_fields	122	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "job_types", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "job_types", "display_options": {"relative": true}}	\N	\N
313	343	directus_collections	job_types	{"singleton": false, "collection": "job_types", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "job_types", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
141	159	directus_fields	28	{"id": 28, "note": null, "sort": 6, "field": "status", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "special": null, "readonly": false, "required": false, "interface": "select-dropdown", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}, "validation_message": null}	{"sort": 6, "field": "status", "group": null, "collection": "main_contents"}	\N	\N
142	160	directus_fields	29	{"id": 29, "note": null, "sort": 7, "field": "user_created", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 7, "field": "user_created", "group": null, "collection": "main_contents"}	\N	\N
143	161	directus_fields	30	{"id": 30, "note": null, "sort": 8, "field": "date_created", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-created"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 8, "field": "date_created", "group": null, "collection": "main_contents"}	\N	\N
144	162	directus_fields	31	{"id": 31, "note": null, "sort": 9, "field": "user_updated", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 9, "field": "user_updated", "group": null, "collection": "main_contents"}	\N	\N
145	163	directus_fields	32	{"id": 32, "note": null, "sort": 10, "field": "date_updated", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-updated"], "readonly": true, "required": false, "interface": "datetime", "collection": "main_contents", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 10, "field": "date_updated", "group": null, "collection": "main_contents"}	\N	\N
146	164	directus_fields	65	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "language_levels"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "language_levels"}	\N	\N
147	165	directus_fields	66	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "language_levels", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "language_levels", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
148	166	directus_fields	67	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "language_levels"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "language_levels"}	\N	\N
149	167	directus_fields	68	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "language_levels"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "language_levels"}	\N	\N
150	168	directus_fields	69	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "language_levels", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "language_levels", "display_options": {"relative": true}}	\N	\N
151	169	directus_fields	70	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "language_levels"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "language_levels"}	\N	\N
152	170	directus_fields	71	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "language_levels", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "language_levels", "display_options": {"relative": true}}	\N	\N
153	171	directus_collections	language_levels	{"singleton": false, "collection": "language_levels", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "language_levels", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
154	172	directus_collections	language_levels	{"icon": "tools_level", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "language_levels", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"icon": "tools_level"}	\N	\N
155	173	directus_collections	language_levels	{"icon": "tools_level", "note": null, "sort": 1, "color": null, "group": "languanges", "hidden": false, "collapse": "open", "singleton": false, "collection": "language_levels", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": "languanges"}	\N	\N
156	174	directus_collections	main_contents	{"icon": null, "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
157	175	directus_collections	educations	{"icon": "school", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
158	176	directus_collections	experiences	{"icon": "work", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
159	177	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
160	178	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
161	179	directus_fields	72	{"sort": 8, "field": "title", "special": null, "required": true, "interface": "input", "collection": "specialties"}	{"sort": 8, "field": "title", "special": null, "required": true, "interface": "input", "collection": "specialties"}	\N	\N
162	180	directus_fields	73	{"sort": 9, "field": "description", "special": null, "interface": "input-multiline", "collection": "specialties"}	{"sort": 9, "field": "description", "special": null, "interface": "input-multiline", "collection": "specialties"}	\N	\N
163	181	directus_fields	73	{"id": 73, "note": null, "sort": 9, "field": "description", "group": null, "width": "full", "hidden": false, "display": null, "options": null, "special": null, "readonly": false, "required": true, "interface": "input-multiline", "collection": "specialties", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "description", "required": true, "collection": "specialties"}	\N	\N
164	182	directus_fields	74	{"sort": 10, "field": "icon", "display": null, "options": {}, "special": ["file"], "interface": "file-image", "collection": "specialties", "display_options": {}}	{"sort": 10, "field": "icon", "display": null, "options": {}, "special": ["file"], "interface": "file-image", "collection": "specialties", "display_options": {}}	\N	\N
165	183	directus_fields	74	{"id": 74, "note": null, "sort": 10, "field": "icon", "group": null, "width": "full", "hidden": false, "display": null, "options": {}, "special": ["file"], "readonly": false, "required": true, "interface": "file-image", "collection": "specialties", "conditions": null, "validation": null, "translations": null, "display_options": {}, "validation_message": null}	{"field": "icon", "required": true, "collection": "specialties"}	\N	\N
166	184	directus_fields	75	{"sort": 8, "field": "name", "special": null, "interface": "input", "collection": "languanges"}	{"sort": 8, "field": "name", "special": null, "interface": "input", "collection": "languanges"}	\N	\N
167	185	directus_fields	76	{"sort": 9, "field": "levels", "options": {"enableLink": true}, "special": ["m2o"], "required": true, "interface": "select-dropdown-m2o", "collection": "languanges"}	{"sort": 9, "field": "levels", "options": {"enableLink": true}, "special": ["m2o"], "required": true, "interface": "select-dropdown-m2o", "collection": "languanges"}	\N	\N
168	186	directus_fields	75	{"id": 75, "note": null, "sort": 8, "field": "name", "group": null, "width": "full", "hidden": false, "display": null, "options": null, "special": null, "readonly": false, "required": true, "interface": "input", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "name", "required": true, "collection": "languanges"}	\N	\N
169	187	directus_fields	77	{"sort": 8, "field": "level_name", "special": null, "required": true, "interface": "input", "collection": "language_levels"}	{"sort": 8, "field": "level_name", "special": null, "required": true, "interface": "input", "collection": "language_levels"}	\N	\N
170	188	directus_fields	76	{"id": 76, "note": null, "sort": 9, "field": "levels", "group": null, "width": "full", "hidden": false, "display": "related-values", "options": {"enableLink": true}, "special": ["m2o"], "readonly": false, "required": true, "interface": "select-dropdown-m2o", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"template": "{{level_name}}"}, "validation_message": null}	{"field": "levels", "display": "related-values", "collection": "languanges", "display_options": {"template": "{{level_name}}"}}	\N	\N
171	189	directus_fields	78	{"sort": 8, "field": "institution", "special": null, "required": true, "interface": "input", "collection": "educations"}	{"sort": 8, "field": "institution", "special": null, "required": true, "interface": "input", "collection": "educations"}	\N	\N
172	190	directus_fields	79	{"sort": 9, "field": "major", "special": null, "required": true, "interface": "input", "collection": "educations"}	{"sort": 9, "field": "major", "special": null, "required": true, "interface": "input", "collection": "educations"}	\N	\N
173	191	directus_fields	80	{"sort": 10, "field": "date_start", "options": {}, "special": null, "required": true, "interface": "datetime", "collection": "educations"}	{"sort": 10, "field": "date_start", "options": {}, "special": null, "required": true, "interface": "datetime", "collection": "educations"}	\N	\N
174	192	directus_fields	81	{"sort": 11, "field": "date_end", "options": {"use24": false}, "special": null, "interface": "datetime", "collection": "educations"}	{"sort": 11, "field": "date_end", "options": {"use24": false}, "special": null, "interface": "datetime", "collection": "educations"}	\N	\N
175	193	directus_fields	82	{"sort": 12, "field": "sequence", "options": {"min": 0}, "special": null, "interface": "input", "collection": "educations"}	{"sort": 12, "field": "sequence", "options": {"min": 0}, "special": null, "interface": "input", "collection": "educations"}	\N	\N
176	194	directus_fields	83	{"sort": 13, "field": "education_type", "special": null, "required": true, "interface": "input", "collection": "educations"}	{"sort": 13, "field": "education_type", "special": null, "required": true, "interface": "input", "collection": "educations"}	\N	\N
177	195	directus_fields	84	{"sort": 14, "field": "detail", "special": null, "interface": "input-rich-text-html", "collection": "educations"}	{"sort": 14, "field": "detail", "special": null, "interface": "input-rich-text-html", "collection": "educations"}	\N	\N
178	196	directus_fields	85	{"sort": 8, "field": "company", "special": null, "required": true, "interface": "input", "collection": "experiences"}	{"sort": 8, "field": "company", "special": null, "required": true, "interface": "input", "collection": "experiences"}	\N	\N
179	197	directus_fields	86	{"sort": 9, "field": "position", "special": null, "required": true, "interface": "input", "collection": "experiences"}	{"sort": 9, "field": "position", "special": null, "required": true, "interface": "input", "collection": "experiences"}	\N	\N
180	198	directus_fields	87	{"sort": 10, "field": "job_types", "options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}]}, "special": null, "required": true, "interface": "select-dropdown", "collection": "experiences"}	{"sort": 10, "field": "job_types", "options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}]}, "special": null, "required": true, "interface": "select-dropdown", "collection": "experiences"}	\N	\N
181	199	directus_fields	88	{"sort": 11, "field": "date_start", "options": {"use24": false}, "special": null, "required": true, "interface": "datetime", "collection": "experiences"}	{"sort": 11, "field": "date_start", "options": {"use24": false}, "special": null, "required": true, "interface": "datetime", "collection": "experiences"}	\N	\N
182	200	directus_fields	89	{"sort": 12, "field": "date_end", "options": {"use24": false}, "special": null, "interface": "datetime", "collection": "experiences"}	{"sort": 12, "field": "date_end", "options": {"use24": false}, "special": null, "interface": "datetime", "collection": "experiences"}	\N	\N
183	201	directus_fields	90	{"sort": 13, "field": "job_detail", "special": null, "interface": "input-rich-text-html", "collection": "experiences"}	{"sort": 13, "field": "job_detail", "special": null, "interface": "input-rich-text-html", "collection": "experiences"}	\N	\N
184	202	directus_fields	91	{"sort": 8, "field": "title", "special": null, "required": true, "interface": "input", "collection": "projects"}	{"sort": 8, "field": "title", "special": null, "required": true, "interface": "input", "collection": "projects"}	\N	\N
185	203	directus_fields	92	{"sort": 9, "field": "description", "special": null, "required": true, "interface": "input-multiline", "collection": "projects"}	{"sort": 9, "field": "description", "special": null, "required": true, "interface": "input-multiline", "collection": "projects"}	\N	\N
186	204	directus_fields	93	{"sort": 10, "field": "project_types", "options": {"choices": [{"text": "Data Analysis", "value": "0"}, {"text": "Back End", "value": "1"}]}, "special": null, "required": true, "interface": "select-radio", "collection": "projects"}	{"sort": 10, "field": "project_types", "options": {"choices": [{"text": "Data Analysis", "value": "0"}, {"text": "Back End", "value": "1"}]}, "special": null, "required": true, "interface": "select-radio", "collection": "projects"}	\N	\N
187	205	directus_fields	94	{"sort": 11, "field": "images", "special": ["files"], "interface": "files", "collection": "projects"}	{"sort": 11, "field": "images", "special": ["files"], "interface": "files", "collection": "projects"}	\N	\N
188	206	directus_fields	95	{"sort": 1, "field": "id", "hidden": true, "collection": "projects_files"}	{"sort": 1, "field": "id", "hidden": true, "collection": "projects_files"}	\N	\N
189	207	directus_collections	projects_files	{"icon": "import_export", "hidden": true, "collection": "projects_files"}	{"icon": "import_export", "hidden": true, "collection": "projects_files"}	\N	\N
190	208	directus_fields	96	{"sort": 2, "field": "projects_id", "hidden": true, "collection": "projects_files"}	{"sort": 2, "field": "projects_id", "hidden": true, "collection": "projects_files"}	\N	\N
191	209	directus_fields	97	{"sort": 3, "field": "directus_files_id", "hidden": true, "collection": "projects_files"}	{"sort": 3, "field": "directus_files_id", "hidden": true, "collection": "projects_files"}	\N	\N
192	210	directus_fields	98	{"sort": 12, "field": "detail", "special": null, "interface": "input-rich-text-html", "collection": "projects"}	{"sort": 12, "field": "detail", "special": null, "interface": "input-rich-text-html", "collection": "projects"}	\N	\N
193	211	directus_fields	99	{"sort": 8, "field": "title", "special": null, "required": true, "interface": "input", "collection": "skills"}	{"sort": 8, "field": "title", "special": null, "required": true, "interface": "input", "collection": "skills"}	\N	\N
194	212	directus_fields	100	{"sort": 9, "field": "icon_title", "special": null, "required": true, "interface": "input", "collection": "skills"}	{"sort": 9, "field": "icon_title", "special": null, "required": true, "interface": "input", "collection": "skills"}	\N	\N
195	214	directus_fields	101	{"sort": 9, "field": "nuxt_icon_title", "special": null, "required": true, "interface": "input", "collection": "skills"}	{"sort": 9, "field": "nuxt_icon_title", "special": null, "required": true, "interface": "input", "collection": "skills"}	\N	\N
196	216	main_contents	1	{"about_desc": "Anam is a graduate Bachelor of Information Systems and Diploma in English (double degree program) at Merdeka Malang University. Graduated in BackEnd JavaScript Bootcamp by Binar Academy and BackEnd Golang by Hacktiv8 in Kampus Merdeka Program. Have knowledge of Back-End development using NodeJS. Also has the knowledge of Mobile App Development using Dart and Flutter."}	{"about_desc": "Anam is a graduate Bachelor of Information Systems and Diploma in English (double degree program) at Merdeka Malang University. Graduated in BackEnd JavaScript Bootcamp by Binar Academy and BackEnd Golang by Hacktiv8 in Kampus Merdeka Program. Have knowledge of Back-End development using NodeJS. Also has the knowledge of Mobile App Development using Dart and Flutter."}	\N	\N
201	221	languanges	1	{"name": "Indonesia", "levels": 1, "status": "published"}	{"name": "Indonesia", "levels": 1, "status": "published"}	\N	\N
202	223	directus_fields	102	{"sort": 9, "field": "levels", "options": {"allowDuplicates": true}, "special": ["m2m"], "interface": "list-m2m", "collection": "languanges"}	{"sort": 9, "field": "levels", "options": {"allowDuplicates": true}, "special": ["m2m"], "interface": "list-m2m", "collection": "languanges"}	\N	\N
203	224	directus_fields	103	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_language_levels"}	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_language_levels"}	\N	\N
204	225	directus_collections	languanges_language_levels	{"icon": "import_export", "hidden": true, "collection": "languanges_language_levels"}	{"icon": "import_export", "hidden": true, "collection": "languanges_language_levels"}	\N	\N
205	226	directus_fields	104	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_language_levels"}	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_language_levels"}	\N	\N
206	227	directus_fields	105	{"sort": 3, "field": "language_levels_id", "hidden": true, "collection": "languanges_language_levels"}	{"sort": 3, "field": "language_levels_id", "hidden": true, "collection": "languanges_language_levels"}	\N	\N
211	232	languanges	1	{"id": 1, "name": "Indonesia", "sort": null, "levels": [1, 2, 3, 4], "status": "published", "date_created": "2025-04-16T14:04:25.000Z", "date_updated": "2025-04-16T14:08:52.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"date_updated": "2025-04-16T14:08:51.582Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
216	237	languanges	2	{"name": "English", "levels": {"create": [{"languanges_id": "+", "language_levels_id": {"id": 1}}, {"languanges_id": "+", "language_levels_id": {"id": 2}}, {"languanges_id": "+", "language_levels_id": {"id": 3}}, {"languanges_id": "+", "language_levels_id": {"id": 4}}], "delete": [], "update": []}, "status": "published"}	{"name": "English", "levels": {"create": [{"languanges_id": "+", "language_levels_id": {"id": 1}}, {"languanges_id": "+", "language_levels_id": {"id": 2}}, {"languanges_id": "+", "language_levels_id": {"id": 3}}, {"languanges_id": "+", "language_levels_id": {"id": 4}}], "delete": [], "update": []}, "status": "published"}	\N	\N
217	238	educations	1	{"major": "Diploma in English", "date_end": "2022-08-01T12:00:00", "sequence": 0, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "education_type": "Diploma Study"}	{"major": "Diploma in English", "date_end": "2022-08-01T12:00:00", "sequence": 0, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "education_type": "Diploma Study"}	\N	\N
218	239	educations	2	{"major": "Information System", "date_end": "2023-09-01T12:00:00", "sequence": 1, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "education_type": "Bachelor Study"}	{"major": "Information System", "date_end": "2023-09-01T12:00:00", "sequence": 1, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "education_type": "Bachelor Study"}	\N	\N
219	240	educations	3	{"major": "Backend Javascript", "date_end": "2022-07-01T12:00:00", "sequence": 2, "date_start": "2022-01-01T12:00:00", "institution": "Binar Academy", "education_type": "Independent Study"}	{"major": "Backend Javascript", "date_end": "2022-07-01T12:00:00", "sequence": 2, "date_start": "2022-01-01T12:00:00", "institution": "Binar Academy", "education_type": "Independent Study"}	\N	\N
220	241	educations	4	{"major": "Golang for Back End Programmer", "date_end": "2022-12-01T12:00:00", "sequence": 3, "date_start": "2022-08-01T12:00:00", "institution": "Hacktiv8", "education_type": "Independent Study"}	{"major": "Golang for Back End Programmer", "date_end": "2022-12-01T12:00:00", "sequence": 3, "date_start": "2022-08-01T12:00:00", "institution": "Hacktiv8", "education_type": "Independent Study"}	\N	\N
221	242	experiences	1	{"company": "Cataliz", "date_end": "2023-08-01T12:00:00", "position": "Back End Developer", "job_types": "2", "date_start": "2023-02-01T12:00:00"}	{"company": "Cataliz", "date_end": "2023-08-01T12:00:00", "position": "Back End Developer", "job_types": "2", "date_start": "2023-02-01T12:00:00"}	\N	\N
222	243	projects	1	{"title": "LMS Application", "description": "Lorem ipsum dolor sit amet", "project_types": "1"}	{"title": "LMS Application", "description": "Lorem ipsum dolor sit amet", "project_types": "1"}	\N	\N
223	244	directus_fields	93	{"id": 93, "note": null, "sort": 10, "field": "project_types", "group": null, "width": "full", "hidden": false, "display": null, "options": {"choices": [{"text": "Data Analysis", "value": "0"}, {"text": "Back End", "value": "1"}, {"text": "Front End", "value": "2"}, {"text": "Full Stack", "value": "3"}, {"text": "Graphic Design", "value": "4"}]}, "special": null, "readonly": false, "required": true, "interface": "select-radio", "collection": "projects", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "project_types", "options": {"choices": [{"text": "Data Analysis", "value": "0"}, {"text": "Back End", "value": "1"}, {"text": "Front End", "value": "2"}, {"text": "Full Stack", "value": "3"}, {"text": "Graphic Design", "value": "4"}]}, "collection": "projects"}	\N	\N
224	245	projects	2	{"title": "Think Action REST API", "description": "Lorem ipsum dolor sit amet", "project_types": "1"}	{"title": "Think Action REST API", "description": "Lorem ipsum dolor sit amet", "project_types": "1"}	\N	\N
225	247	directus_files	38808ea0-ac80-475b-998d-b4aa6788c58f	{"type": "image/png", "title": "Icons8 Web Development 96", "storage": "cloudinary", "filename_download": "icons8-web-development-96.png"}	{"type": "image/png", "title": "Icons8 Web Development 96", "storage": "cloudinary", "filename_download": "icons8-web-development-96.png"}	\N	\N
226	248	specialties	1	{"icon": "38808ea0-ac80-475b-998d-b4aa6788c58f", "title": "Web Development", "description": "Lorem Ipsum dolor sit amet"}	{"icon": "38808ea0-ac80-475b-998d-b4aa6788c58f", "title": "Web Development", "description": "Lorem Ipsum dolor sit amet"}	\N	\N
227	249	directus_files	7e228bab-3258-4919-97d2-95cd07fe7cc6	{"type": "image/png", "title": "Icons8 Positive Dynamic 96", "storage": "cloudinary", "filename_download": "icons8-positive-dynamic-96.png"}	{"type": "image/png", "title": "Icons8 Positive Dynamic 96", "storage": "cloudinary", "filename_download": "icons8-positive-dynamic-96.png"}	\N	\N
228	250	specialties	2	{"icon": "7e228bab-3258-4919-97d2-95cd07fe7cc6", "title": "Data Analysis", "description": "Lorem ipsum dolor sit amet"}	{"icon": "7e228bab-3258-4919-97d2-95cd07fe7cc6", "title": "Data Analysis", "description": "Lorem ipsum dolor sit amet"}	\N	\N
229	251	directus_files	bb9979d1-0ee2-4ea0-a926-aafba0432619	{"type": "image/png", "title": "Icons8 Employee 96", "storage": "cloudinary", "filename_download": "icons8-employee-96.png"}	{"type": "image/png", "title": "Icons8 Employee 96", "storage": "cloudinary", "filename_download": "icons8-employee-96.png"}	\N	\N
230	252	specialties	3	{"icon": "bb9979d1-0ee2-4ea0-a926-aafba0432619", "title": "HRIS Analyst", "description": "Lorem ipsum dolor sit amet"}	{"icon": "bb9979d1-0ee2-4ea0-a926-aafba0432619", "title": "HRIS Analyst", "description": "Lorem ipsum dolor sit amet"}	\N	\N
231	253	directus_files	cb0092ff-3471-474d-8b0e-270664d600fa	{"type": "image/png", "title": "Icons8 Mockup 96", "storage": "cloudinary", "filename_download": "icons8-mockup-96.png"}	{"type": "image/png", "title": "Icons8 Mockup 96", "storage": "cloudinary", "filename_download": "icons8-mockup-96.png"}	\N	\N
232	255	directus_files	b5761b06-fdc3-405d-9e2e-9fb176400c86	{"type": "image/png", "title": "Icons8 Mockup 96", "storage": "cloudinary", "filename_download": "icons8-mockup-96.png"}	{"type": "image/png", "title": "Icons8 Mockup 96", "storage": "cloudinary", "filename_download": "icons8-mockup-96.png"}	\N	\N
233	256	specialties	4	{"icon": "b5761b06-fdc3-405d-9e2e-9fb176400c86", "title": "Graphic Design", "description": "Lorem ipsum dolor sit amet"}	{"icon": "b5761b06-fdc3-405d-9e2e-9fb176400c86", "title": "Graphic Design", "description": "Lorem ipsum dolor sit amet"}	\N	\N
234	257	directus_fields	74	{"id": 74, "note": null, "sort": 10, "field": "icon", "group": null, "width": "full", "hidden": false, "display": "image", "options": {}, "special": ["file"], "readonly": false, "required": true, "interface": "file-image", "collection": "specialties", "conditions": null, "validation": null, "translations": null, "display_options": {}, "validation_message": null}	{"field": "icon", "display": "image", "collection": "specialties", "display_options": {}}	\N	\N
235	258	directus_fields	106	{"sort": 10, "field": "icon", "options": {}, "special": ["file"], "required": true, "interface": "file-image", "collection": "skills"}	{"sort": 10, "field": "icon", "options": {}, "special": ["file"], "required": true, "interface": "file-image", "collection": "skills"}	\N	\N
236	260	directus_fields	106	{"id": 106, "note": null, "sort": 10, "field": "icon", "group": null, "width": "full", "hidden": false, "display": "image", "options": {}, "special": ["file"], "readonly": false, "required": true, "interface": "file-image", "collection": "skills", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "icon", "display": "image", "collection": "skills"}	\N	\N
237	261	directus_files	7e0aaaf6-fc6f-45d5-8736-7035c6f044dc	{"type": "image/png", "title": "Icons8 Typescript 100", "storage": "cloudinary", "filename_download": "icons8-typescript-100.png"}	{"type": "image/png", "title": "Icons8 Typescript 100", "storage": "cloudinary", "filename_download": "icons8-typescript-100.png"}	\N	\N
238	262	directus_files	60913cc8-ac74-4123-8054-e645daf166f3	{"type": "image/png", "title": "Icons8 Typescript 100", "storage": "cloudinary", "filename_download": "icons8-typescript-100.png"}	{"type": "image/png", "title": "Icons8 Typescript 100", "storage": "cloudinary", "filename_download": "icons8-typescript-100.png"}	\N	\N
239	263	skills	1	{"icon": "60913cc8-ac74-4123-8054-e645daf166f3", "title": "Typescript", "status": "published"}	{"icon": "60913cc8-ac74-4123-8054-e645daf166f3", "title": "Typescript", "status": "published"}	\N	\N
240	264	directus_files	0bbcdfb5-3d07-4877-9047-d96c480bc3c3	{"type": "image/png", "title": "Icons8 Javascript 96", "storage": "cloudinary", "filename_download": "icons8-javascript-96.png"}	{"type": "image/png", "title": "Icons8 Javascript 96", "storage": "cloudinary", "filename_download": "icons8-javascript-96.png"}	\N	\N
241	265	skills	2	{"icon": "0bbcdfb5-3d07-4877-9047-d96c480bc3c3", "title": "Javascript"}	{"icon": "0bbcdfb5-3d07-4877-9047-d96c480bc3c3", "title": "Javascript"}	\N	\N
242	266	directus_files	d4a3abb5-6770-4e03-a792-8192b8b92138	{"type": "image/png", "title": "Icons8 HTML 96", "storage": "cloudinary", "filename_download": "icons8-html-96.png"}	{"type": "image/png", "title": "Icons8 HTML 96", "storage": "cloudinary", "filename_download": "icons8-html-96.png"}	\N	\N
243	267	skills	3	{"icon": "d4a3abb5-6770-4e03-a792-8192b8b92138", "title": "HTML"}	{"icon": "d4a3abb5-6770-4e03-a792-8192b8b92138", "title": "HTML"}	\N	\N
244	268	directus_files	cb7e94b4-45ab-4edb-8d67-94e93f4d6702	{"type": "image/png", "title": "Icons8 CSS Filetype 96", "storage": "cloudinary", "filename_download": "icons8-css-filetype-96.png"}	{"type": "image/png", "title": "Icons8 CSS Filetype 96", "storage": "cloudinary", "filename_download": "icons8-css-filetype-96.png"}	\N	\N
245	269	skills	4	{"icon": "cb7e94b4-45ab-4edb-8d67-94e93f4d6702", "title": "CSS"}	{"icon": "cb7e94b4-45ab-4edb-8d67-94e93f4d6702", "title": "CSS"}	\N	\N
246	271	directus_permissions	1	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects", "validation": null, "permissions": null}	\N	\N
247	272	directus_permissions	2	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "educations", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "educations", "validation": null, "permissions": null}	\N	\N
314	344	directus_fields	123	{"sort": 8, "field": "name", "special": null, "interface": "input", "collection": "job_types"}	{"sort": 8, "field": "name", "special": null, "interface": "input", "collection": "job_types"}	\N	\N
248	273	directus_permissions	3	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "experiences", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "experiences", "validation": null, "permissions": null}	\N	\N
249	274	directus_permissions	4	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "language_levels", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "language_levels", "validation": null, "permissions": null}	\N	\N
250	275	directus_permissions	5	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges", "validation": null, "permissions": null}	\N	\N
251	276	directus_permissions	6	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges_language_levels", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges_language_levels", "validation": null, "permissions": null}	\N	\N
252	277	directus_permissions	7	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "main_contents", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "main_contents", "validation": null, "permissions": null}	\N	\N
253	278	directus_permissions	8	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects_files", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects_files", "validation": null, "permissions": null}	\N	\N
254	279	directus_permissions	9	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "skills", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "skills", "validation": null, "permissions": null}	\N	\N
255	280	directus_permissions	10	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "specialties", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "specialties", "validation": null, "permissions": null}	\N	\N
256	282	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id": "75adc3f9-1874-4865-a8c9-bb09d6f79b7c", "role": null, "sort": 1, "user": null, "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
257	283	directus_permissions	2	{"id": 2, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "educations", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "educations", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
258	284	directus_permissions	3	{"id": 3, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "experiences", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "experiences", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
259	285	directus_permissions	4	{"id": 4, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "language_levels", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "language_levels", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
260	286	directus_permissions	5	{"id": 5, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
261	287	directus_permissions	6	{"id": 6, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges_language_levels", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "languanges_language_levels", "validation": null, "permissions": null}	\N	\N
262	288	directus_permissions	7	{"id": 7, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "main_contents", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "main_contents", "validation": null, "permissions": null}	\N	\N
263	289	directus_permissions	1	{"id": 1, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
264	290	directus_permissions	8	{"id": 8, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects_files", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "projects_files", "validation": null, "permissions": null}	\N	\N
265	291	directus_permissions	9	{"id": 9, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "skills", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "skills", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
266	292	directus_permissions	10	{"id": 10, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "specialties", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "specialties", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
267	294	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id": "75adc3f9-1874-4865-a8c9-bb09d6f79b7c", "role": null, "sort": 1, "user": null, "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
268	295	projects	1	{"id": 1, "sort": null, "title": "LMS Application", "detail": null, "images": [], "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-16T14:40:35.000Z", "date_updated": "2025-05-12T13:57:04.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "project_types": "1"}	{"status": "published", "date_updated": "2025-05-12T13:57:03.767Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
269	296	projects	2	{"id": 2, "sort": null, "title": "Think Action REST API", "detail": null, "images": [], "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-05-12T13:57:11.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "project_types": "1"}	{"status": "published", "date_updated": "2025-05-12T13:57:10.872Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
270	297	directus_fields	107	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "project_types"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "project_types"}	\N	\N
271	298	directus_fields	108	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "project_types", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "project_types", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
272	299	directus_fields	109	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "project_types"}	{"sort": 3, "field": "sort", "hidden": true, "interface": "input", "collection": "project_types"}	\N	\N
273	300	directus_fields	110	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "project_types"}	{"sort": 4, "field": "user_created", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "project_types"}	\N	\N
274	301	directus_fields	111	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "project_types", "display_options": {"relative": true}}	{"sort": 5, "field": "date_created", "width": "half", "hidden": true, "display": "datetime", "special": ["date-created"], "readonly": true, "interface": "datetime", "collection": "project_types", "display_options": {"relative": true}}	\N	\N
275	302	directus_fields	112	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "project_types"}	{"sort": 6, "field": "user_updated", "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "interface": "select-dropdown-m2o", "collection": "project_types"}	\N	\N
276	303	directus_fields	113	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "project_types", "display_options": {"relative": true}}	{"sort": 7, "field": "date_updated", "width": "half", "hidden": true, "display": "datetime", "special": ["date-updated"], "readonly": true, "interface": "datetime", "collection": "project_types", "display_options": {"relative": true}}	\N	\N
277	304	directus_collections	project_types	{"singleton": false, "collection": "project_types", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	{"singleton": false, "collection": "project_types", "sort_field": "sort", "archive_field": "status", "archive_value": "archived", "unarchive_value": "draft"}	\N	\N
278	305	directus_fields	114	{"sort": 8, "field": "name", "special": null, "required": true, "interface": "input", "collection": "project_types"}	{"sort": 8, "field": "name", "special": null, "required": true, "interface": "input", "collection": "project_types"}	\N	\N
279	306	directus_fields	107	{"id": 107, "note": null, "sort": 1, "field": "id", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": true, "required": false, "interface": "input", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 1, "field": "id", "group": null, "collection": "project_types"}	\N	\N
280	307	directus_fields	114	{"id": 114, "note": null, "sort": 2, "field": "name", "group": null, "width": "full", "hidden": false, "display": null, "options": null, "special": null, "readonly": false, "required": true, "interface": "input", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 2, "field": "name", "group": null, "collection": "project_types"}	\N	\N
281	308	directus_fields	108	{"id": 108, "note": null, "sort": 3, "field": "status", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "special": null, "readonly": false, "required": false, "interface": "select-dropdown", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}, "validation_message": null}	{"sort": 3, "field": "status", "group": null, "collection": "project_types"}	\N	\N
282	309	directus_fields	109	{"id": 109, "note": null, "sort": 4, "field": "sort", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": false, "required": false, "interface": "input", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 4, "field": "sort", "group": null, "collection": "project_types"}	\N	\N
283	310	directus_fields	110	{"id": 110, "note": null, "sort": 5, "field": "user_created", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 5, "field": "user_created", "group": null, "collection": "project_types"}	\N	\N
284	311	directus_fields	111	{"id": 111, "note": null, "sort": 6, "field": "date_created", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-created"], "readonly": true, "required": false, "interface": "datetime", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 6, "field": "date_created", "group": null, "collection": "project_types"}	\N	\N
285	312	directus_fields	112	{"id": 112, "note": null, "sort": 7, "field": "user_updated", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 7, "field": "user_updated", "group": null, "collection": "project_types"}	\N	\N
286	313	directus_fields	113	{"id": 113, "note": null, "sort": 8, "field": "date_updated", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-updated"], "readonly": true, "required": false, "interface": "datetime", "collection": "project_types", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 8, "field": "date_updated", "group": null, "collection": "project_types"}	\N	\N
287	314	directus_fields	115	{"sort": 13, "field": "type", "options": {"template": "{{name}}"}, "special": ["m2o"], "required": true, "interface": "select-dropdown-m2o", "collection": "projects"}	{"sort": 13, "field": "type", "options": {"template": "{{name}}"}, "special": ["m2o"], "required": true, "interface": "select-dropdown-m2o", "collection": "projects"}	\N	\N
288	316	project_types	1	{"name": "Back-End", "status": "published"}	{"name": "Back-End", "status": "published"}	\N	\N
289	317	project_types	2	{"name": "Data Analysis", "status": "published"}	{"name": "Data Analysis", "status": "published"}	\N	\N
290	318	project_types	3	{"name": "Graphic Design", "status": "published"}	{"name": "Graphic Design", "status": "published"}	\N	\N
291	319	project_types	4	{"name": "HRIS Specialist", "status": "published"}	{"name": "HRIS Specialist", "status": "published"}	\N	\N
292	320	projects	1	{"id": 1, "sort": null, "type": 1, "title": "LMS Application", "detail": null, "images": [], "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-16T14:40:35.000Z", "date_updated": "2025-05-12T14:16:04.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"type": 1, "date_updated": "2025-05-12T14:16:03.542Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
293	321	directus_fields	115	{"id": 115, "note": null, "sort": 13, "field": "type", "group": null, "width": "full", "hidden": false, "display": "related-values", "options": {"template": "{{name}}"}, "special": ["m2o"], "readonly": false, "required": true, "interface": "select-dropdown-m2o", "collection": "projects", "conditions": null, "validation": null, "translations": null, "display_options": {"template": "{{name}}"}, "validation_message": null}	{"field": "type", "display": "related-values", "collection": "projects", "display_options": {"template": "{{name}}"}}	\N	\N
294	322	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": null, "images": [], "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-05-12T14:16:34.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"type": 2, "date_updated": "2025-05-12T14:16:33.743Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
295	323	directus_permissions	11	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "project_types", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "project_types", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
296	325	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id": "75adc3f9-1874-4865-a8c9-bb09d6f79b7c", "role": null, "sort": 1, "user": null, "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
297	326	experiences	1	{"id": 1, "sort": null, "status": "published", "company": "Cataliz", "date_end": "2023-08-01T12:00:00", "position": "Back End Developer", "job_types": "2", "date_start": "2023-02-01T12:00:00", "job_detail": null, "date_created": "2025-04-16T14:39:35.000Z", "date_updated": "2025-05-12T14:22:55.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-05-12T14:22:54.696Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
298	327	directus_fields	83	{"id": 83, "note": null, "sort": 13, "field": "education_type", "group": null, "width": "full", "hidden": false, "display": "formatted-value", "options": null, "special": null, "readonly": false, "required": true, "interface": "input", "collection": "educations", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "education_type", "display": "formatted-value", "collection": "educations"}	\N	\N
299	328	educations	1	{"id": 1, "sort": null, "major": "Diploma in English", "detail": null, "status": "published", "date_end": "2022-08-01T12:00:00", "sequence": 0, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "date_created": "2025-04-16T14:14:11.000Z", "date_updated": "2025-05-12T14:24:58.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Diploma Study"}	{"status": "published", "date_updated": "2025-05-12T14:24:57.674Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
300	329	educations	2	{"id": 2, "sort": null, "major": "Information System", "detail": null, "status": "published", "date_end": "2023-09-01T12:00:00", "sequence": 1, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "date_created": "2025-04-16T14:16:10.000Z", "date_updated": "2025-05-12T14:25:02.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Bachelor Study"}	{"status": "published", "date_updated": "2025-05-12T14:25:01.563Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
301	330	directus_fields	87	{"id": 87, "note": null, "sort": 10, "field": "job_types", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}]}, "special": null, "readonly": false, "required": true, "interface": "select-dropdown", "collection": "experiences", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "job_types", "display": "labels", "collection": "experiences"}	\N	\N
302	331	directus_fields	87	{"id": 87, "note": null, "sort": 10, "field": "job_types", "group": null, "width": "full", "hidden": false, "display": "formatted-value", "options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}]}, "special": null, "readonly": false, "required": true, "interface": "select-dropdown", "collection": "experiences", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "job_types", "display": "formatted-value", "collection": "experiences"}	\N	\N
303	332	directus_fields	87	{"id": 87, "note": null, "sort": 10, "field": "job_types", "group": null, "width": "full", "hidden": false, "display": "formatted-value", "options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}]}, "special": null, "readonly": false, "required": true, "interface": "select-dropdown", "collection": "experiences", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "job_types", "display": "formatted-value", "collection": "experiences"}	\N	\N
304	333	directus_fields	87	{"id": 87, "note": null, "sort": 10, "field": "job_types", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}]}, "special": null, "readonly": false, "required": true, "interface": "select-dropdown", "collection": "experiences", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}], "showAsDot": true, "conditionalFormatting": null}, "validation_message": null}	{"field": "job_types", "display": "labels", "interface": "select-dropdown", "collection": "experiences", "display_options": {"choices": [{"text": "Full Time", "value": "1"}, {"text": "Internship", "value": "2"}], "showAsDot": true, "conditionalFormatting": null}}	\N	\N
305	334	experiences	1	{"id": 1, "sort": null, "status": "published", "company": "Cataliz", "date_end": "2023-08-01T12:00:00", "position": "Back End Developer", "job_types": "1", "date_start": "2023-02-01T12:00:00", "job_detail": null, "date_created": "2025-04-16T14:39:35.000Z", "date_updated": "2025-05-12T14:37:31.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"job_types": "1", "date_updated": "2025-05-12T14:37:31.361Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
306	336	directus_fields	116	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "job_types"}	{"sort": 1, "field": "id", "hidden": true, "readonly": true, "interface": "input", "collection": "job_types"}	\N	\N
307	337	directus_fields	117	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "job_types", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	{"sort": 2, "field": "status", "width": "full", "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "interface": "select-dropdown", "collection": "job_types", "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}}	\N	\N
315	345	directus_fields	116	{"id": 116, "note": null, "sort": 1, "field": "id", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": true, "required": false, "interface": "input", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 1, "field": "id", "group": null, "collection": "job_types"}	\N	\N
316	346	directus_fields	123	{"id": 123, "note": null, "sort": 2, "field": "name", "group": null, "width": "full", "hidden": false, "display": null, "options": null, "special": null, "readonly": false, "required": false, "interface": "input", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 2, "field": "name", "group": null, "collection": "job_types"}	\N	\N
317	347	directus_fields	117	{"id": 117, "note": null, "sort": 3, "field": "status", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived"}]}, "special": null, "readonly": false, "required": false, "interface": "select-dropdown", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "$t:published", "color": "var(--theme--primary)", "value": "published", "background": "var(--theme--primary-background)", "foreground": "var(--theme--primary)"}, {"text": "$t:draft", "color": "var(--theme--foreground)", "value": "draft", "background": "var(--theme--background-normal)", "foreground": "var(--theme--foreground)"}, {"text": "$t:archived", "color": "var(--theme--warning)", "value": "archived", "background": "var(--theme--warning-background)", "foreground": "var(--theme--warning)"}], "showAsDot": true}, "validation_message": null}	{"sort": 3, "field": "status", "group": null, "collection": "job_types"}	\N	\N
318	348	directus_fields	118	{"id": 118, "note": null, "sort": 4, "field": "sort", "group": null, "width": "full", "hidden": true, "display": null, "options": null, "special": null, "readonly": false, "required": false, "interface": "input", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 4, "field": "sort", "group": null, "collection": "job_types"}	\N	\N
319	349	directus_fields	119	{"id": 119, "note": null, "sort": 5, "field": "user_created", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-created"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 5, "field": "user_created", "group": null, "collection": "job_types"}	\N	\N
320	350	directus_fields	120	{"id": 120, "note": null, "sort": 6, "field": "date_created", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-created"], "readonly": true, "required": false, "interface": "datetime", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 6, "field": "date_created", "group": null, "collection": "job_types"}	\N	\N
321	351	directus_fields	121	{"id": 121, "note": null, "sort": 7, "field": "user_updated", "group": null, "width": "half", "hidden": true, "display": "user", "options": {"template": "{{avatar}} {{first_name}} {{last_name}}"}, "special": ["user-updated"], "readonly": true, "required": false, "interface": "select-dropdown-m2o", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"sort": 7, "field": "user_updated", "group": null, "collection": "job_types"}	\N	\N
322	352	directus_fields	122	{"id": 122, "note": null, "sort": 8, "field": "date_updated", "group": null, "width": "half", "hidden": true, "display": "datetime", "options": null, "special": ["date-updated"], "readonly": true, "required": false, "interface": "datetime", "collection": "job_types", "conditions": null, "validation": null, "translations": null, "display_options": {"relative": true}, "validation_message": null}	{"sort": 8, "field": "date_updated", "group": null, "collection": "job_types"}	\N	\N
323	353	directus_fields	124	{"sort": 14, "field": "job_type", "options": {"template": "{{name}}"}, "special": ["m2o"], "required": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	{"sort": 14, "field": "job_type", "options": {"template": "{{name}}"}, "special": ["m2o"], "required": true, "interface": "select-dropdown-m2o", "collection": "experiences"}	\N	\N
324	354	job_types	1	{"name": "Full Time", "status": "published"}	{"name": "Full Time", "status": "published"}	\N	\N
325	355	job_types	2	{"name": "Internship", "status": "published"}	{"name": "Internship", "status": "published"}	\N	\N
326	356	experiences	1	{"id": 1, "sort": null, "status": "published", "company": "Cataliz", "date_end": "2023-08-01T12:00:00", "job_type": 1, "position": "Back End Developer", "date_start": "2023-02-01T12:00:00", "job_detail": null, "date_created": "2025-04-16T14:39:35.000Z", "date_updated": "2025-05-12T14:44:31.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"job_type": 1, "date_updated": "2025-05-12T14:44:31.069Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
327	357	directus_fields	124	{"id": 124, "note": null, "sort": 14, "field": "job_type", "group": null, "width": "full", "hidden": false, "display": "related-values", "options": {"template": "{{name}}"}, "special": ["m2o"], "readonly": false, "required": true, "interface": "select-dropdown-m2o", "collection": "experiences", "conditions": null, "validation": null, "translations": null, "display_options": {"template": "{{name}}"}, "validation_message": null}	{"field": "job_type", "display": "related-values", "collection": "experiences", "display_options": {"template": "{{name}}"}}	\N	\N
328	359	directus_files	64e895f2-499f-4854-b12d-ca8c275c4e0d	{"type": "image/png", "title": "Frame Yoga", "storage": "cloudinary", "filename_download": "FRAME YOGA.png"}	{"type": "image/png", "title": "Frame Yoga", "storage": "cloudinary", "filename_download": "FRAME YOGA.png"}	\N	\N
329	361	directus_files	72093f65-8ce2-4300-b9ba-3059b281d7b2	{"type": "image/png", "title": "Slide 16 9   4", "storage": "cloudinary", "filename_download": "Slide 16_9 - 4.png"}	{"type": "image/png", "title": "Slide 16 9   4", "storage": "cloudinary", "filename_download": "Slide 16_9 - 4.png"}	\N	\N
330	363	directus_files	087543f8-ff31-4bea-8566-7f62107d5b16	{"type": "image/png", "title": "Frame Yoga", "storage": "cloudinary", "filename_download": "FRAME YOGA.png"}	{"type": "image/png", "title": "Frame Yoga", "storage": "cloudinary", "filename_download": "FRAME YOGA.png"}	\N	\N
331	365	directus_files	da01b238-2d05-4f4e-b2ef-d1c4706d219d	{"type": "image/jpeg", "title": "Loker Spv Admin 16.05.2025", "storage": "cloudinary", "filename_download": "Loker SPV Admin 16.05.2025.jpg"}	{"type": "image/jpeg", "title": "Loker Spv Admin 16.05.2025", "storage": "cloudinary", "filename_download": "Loker SPV Admin 16.05.2025.jpg"}	\N	\N
332	368	main_contents	1	{"id": 1, "status": "published", "about_desc": "Anam is a graduate Bachelor of Information Systems and Diploma in English (double degree program) at Merdeka Malang University. Graduated in BackEnd JavaScript Bootcamp by Binar Academy and BackEnd Golang by Hacktiv8 in Kampus Merdeka Program. Have knowledge of Back-End development using NodeJS. Also has the knowledge of Mobile App Development using Dart and Flutter.", "date_created": "2025-04-16T14:02:18.000Z", "date_updated": "2025-06-03T14:59:10.000Z", "project_desc": "This is Project Description", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_desc": "This is Education Description", "experience_desc": "Experience Description"}	{"status": "published", "date_updated": "2025-06-03T14:59:10.478Z", "project_desc": "This is Project Description", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_desc": "This is Education Description", "experience_desc": "Experience Description"}	\N	\N
333	369	directus_permissions	7	{"id": 7, "action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "main_contents", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "main_contents", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
334	371	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id": "75adc3f9-1874-4865-a8c9-bb09d6f79b7c", "role": null, "sort": 1, "user": null, "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
335	372	specialties	1	{"id": 1, "icon": "38808ea0-ac80-475b-998d-b4aa6788c58f", "sort": null, "title": "Web Development", "status": "published", "description": "Lorem Ipsum dolor sit amet", "date_created": "2025-04-23T14:36:01.000Z", "date_updated": "2025-06-03T15:10:34.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-03T15:10:33.786Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
336	373	specialties	2	{"id": 2, "icon": "7e228bab-3258-4919-97d2-95cd07fe7cc6", "sort": null, "title": "Data Analysis", "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-23T14:36:56.000Z", "date_updated": "2025-06-03T15:10:40.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-03T15:10:39.877Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
337	374	specialties	3	{"id": 3, "icon": "bb9979d1-0ee2-4ea0-a926-aafba0432619", "sort": null, "title": "HRIS Analyst", "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-23T14:37:38.000Z", "date_updated": "2025-06-03T15:10:44.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-03T15:10:43.844Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
338	375	specialties	4	{"id": 4, "icon": "b5761b06-fdc3-405d-9e2e-9fb176400c86", "sort": null, "title": "Graphic Design", "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-23T14:38:47.000Z", "date_updated": "2025-06-03T15:10:47.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-03T15:10:47.488Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
343	380	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [], "status": "published", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-03T15:54:39.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"date_updated": "2025-06-03T15:54:38.905Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
344	381	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [], "status": "draft", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-03T15:54:51.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "draft", "date_updated": "2025-06-03T15:54:51.313Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
349	386	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [9, 10, 11, 12], "status": "draft", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-03T15:55:02.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"date_updated": "2025-06-03T15:55:02.273Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
350	387	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [9, 10, 11, 12], "status": "published", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-03T15:55:41.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-03T15:55:40.588Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
351	388	directus_fields	102	{"id": 102, "note": null, "sort": 9, "field": "levels", "group": null, "width": "full", "hidden": false, "display": null, "options": {"template": "{{language_levels_id.level_name}}"}, "special": ["m2m"], "readonly": false, "required": false, "interface": "list-m2m", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "levels", "options": {"template": "{{language_levels_id.level_name}}"}, "interface": "list-m2m", "collection": "languanges"}	\N	\N
352	389	directus_fields	102	{"id": 102, "note": null, "sort": 9, "field": "levels", "group": null, "width": "full", "hidden": false, "display": "related-values", "options": {"template": "{{language_levels_id.level_name}}"}, "special": ["m2m"], "readonly": false, "required": false, "interface": "list-m2m", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"template": "{{language_levels_id.level_name}}"}, "validation_message": null}	{"field": "levels", "display": "related-values", "collection": "languanges", "display_options": {"template": "{{language_levels_id.level_name}}"}}	\N	\N
357	394	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [], "status": "published", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-03T15:57:43.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"date_updated": "2025-06-03T15:57:43.127Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
362	399	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [13, 14, 15, 16], "status": "published", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-03T15:57:52.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"date_updated": "2025-06-03T15:57:51.662Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
363	400	directus_fields	102	{"id": 102, "note": null, "sort": 9, "field": "levels", "group": null, "width": "full", "hidden": false, "display": "related-values", "options": {"template": "{{language_levels_id.level_name}}{{id}}", "enableLink": true}, "special": ["m2m"], "readonly": false, "required": false, "interface": "list-m2m", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"template": "{{language_levels_id.level_name}}"}, "validation_message": null}	{"field": "levels", "options": {"template": "{{language_levels_id.level_name}}{{id}}", "enableLink": true}, "collection": "languanges"}	\N	\N
364	401	directus_fields	125	{"sort": 10, "field": "languange_level", "options": {"template": "{{level_name}}"}, "special": ["m2o"], "interface": "select-dropdown-m2o", "collection": "languanges"}	{"sort": 10, "field": "languange_level", "options": {"template": "{{level_name}}"}, "special": ["m2o"], "interface": "select-dropdown-m2o", "collection": "languanges"}	\N	\N
365	402	languanges	1	{"id": 1, "name": "Indonesia", "sort": null, "levels": [1, 2, 3, 4], "status": "published", "date_created": "2025-04-16T14:04:25.000Z", "date_updated": "2025-06-03T16:05:30.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "languange_level": 1}	{"date_updated": "2025-06-03T16:05:29.635Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "languange_level": 1}	\N	\N
366	404	directus_fields	126	{"sort": 10, "field": "language_levels", "options": {"template": "{{level_name}}", "selectedCollection": "language_levels"}, "special": ["cast-json"], "interface": "collection-item-dropdown", "collection": "languanges"}	{"sort": 10, "field": "language_levels", "options": {"template": "{{level_name}}", "selectedCollection": "language_levels"}, "special": ["cast-json"], "interface": "collection-item-dropdown", "collection": "languanges"}	\N	\N
367	405	directus_fields	127	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_undefined"}	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_undefined"}	\N	\N
368	406	directus_collections	languanges_undefined	{"icon": "import_export", "hidden": true, "collection": "languanges_undefined"}	{"icon": "import_export", "hidden": true, "collection": "languanges_undefined"}	\N	\N
369	407	directus_fields	128	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_undefined"}	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_undefined"}	\N	\N
370	408	directus_fields	129	{"sort": 3, "field": "item", "hidden": true, "collection": "languanges_undefined"}	{"sort": 3, "field": "item", "hidden": true, "collection": "languanges_undefined"}	\N	\N
371	409	directus_fields	130	{"sort": 4, "field": "collection", "hidden": true, "collection": "languanges_undefined"}	{"sort": 4, "field": "collection", "hidden": true, "collection": "languanges_undefined"}	\N	\N
376	415	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [], "status": "published", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-07T03:05:32.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "language_levels": null}	{"date_updated": "2025-06-07T03:05:31.823Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
379	418	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [17, 18], "status": "published", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-07T03:05:48.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "language_levels": null}	{"date_updated": "2025-06-07T03:05:48.408Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
380	419	directus_fields	126	{"id": 126, "note": null, "sort": 10, "field": "language_levels", "group": null, "width": "full", "hidden": false, "display": null, "options": {"template": "{{level_name}}", "selectedCollection": "language_levels"}, "special": ["cast-json"], "readonly": false, "required": false, "interface": "select-multiple-checkbox", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "language_levels", "interface": "select-multiple-checkbox", "collection": "languanges"}	\N	\N
381	420	directus_fields	126	{"id": 126, "note": null, "sort": 10, "field": "language_levels", "group": null, "width": "full", "hidden": false, "display": null, "options": {"fields": [], "choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}], "template": "{{level_name}}", "selectedCollection": "language_levels"}, "special": ["cast-json"], "readonly": false, "required": false, "interface": "select-multiple-checkbox", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": null, "validation_message": null}	{"field": "language_levels", "options": {"fields": [], "choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}], "template": "{{level_name}}", "selectedCollection": "language_levels"}, "interface": "select-multiple-checkbox", "collection": "languanges"}	\N	\N
382	421	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [17, 18], "status": "published", "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-07T03:09:25.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "language_levels": ["1", "0", "2"]}	{"date_updated": "2025-06-07T03:09:25.147Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "language_levels": ["1", "0", "2"]}	\N	\N
383	422	directus_fields	126	{"id": 126, "note": null, "sort": 10, "field": "language_levels", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"fields": [], "choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}], "template": "{{level_name}}", "selectedCollection": "language_levels"}, "special": ["cast-json"], "readonly": false, "required": false, "interface": "select-multiple-checkbox", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": null, "showAsDot": true}, "validation_message": null}	{"field": "language_levels", "display": "labels", "collection": "languanges", "display_options": {"choices": null, "showAsDot": true}}	\N	\N
384	423	directus_fields	126	{"id": 126, "note": null, "sort": 10, "field": "language_levels", "group": null, "width": "full", "hidden": false, "display": "labels", "options": {"fields": [], "choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}], "template": "{{level_name}}", "selectedCollection": "language_levels"}, "special": ["cast-json"], "readonly": false, "required": false, "interface": "select-multiple-checkbox", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}]}, "validation_message": null}	{"field": "language_levels", "collection": "languanges", "display_options": {"choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}]}}	\N	\N
385	424	directus_fields	126	{"id": 126, "note": null, "sort": 10, "field": "language_levels", "group": null, "width": "full", "hidden": false, "display": "formatted-json-value", "options": {"fields": [], "choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}], "template": "{{level_name}}", "selectedCollection": "language_levels"}, "special": ["cast-json"], "readonly": false, "required": false, "interface": "select-multiple-checkbox", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"format": "{{text}}", "choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}]}, "validation_message": null}	{"field": "language_levels", "display": "formatted-json-value", "collection": "languanges", "display_options": {"format": "{{text}}", "choices": [{"text": "Reader", "value": "1"}, {"text": "Written", "value": "0"}, {"text": "Spoken", "value": "2"}, {"text": "Listener", "value": "3"}]}}	\N	\N
386	425	directus_collections	languanges_undefined	{"icon": "import_export", "note": null, "sort": null, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges_undefined", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": null, "archive_value": null, "accountability": "all", "unarchive_value": null, "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"hidden": false}	\N	\N
387	426	directus_fields	131	{"sort": 11, "field": "level_type", "options": {"fields": [{"meta": {"type": "string", "field": "level_type", "width": "full", "display": "formatted-value", "options": {"choices": [{"text": "Written", "value": "0"}, {"text": "Spoken", "value": "1"}, {"text": "Read", "value": "2"}, {"text": "Listener", "value": "3"}]}, "required": true, "interface": "select-radio", "display_options": {"conditionalFormatting": null}}, "name": "level_type", "type": "string", "field": "level_type"}]}, "special": ["cast-json"], "interface": "list", "collection": "languanges"}	{"sort": 11, "field": "level_type", "options": {"fields": [{"meta": {"type": "string", "field": "level_type", "width": "full", "display": "formatted-value", "options": {"choices": [{"text": "Written", "value": "0"}, {"text": "Spoken", "value": "1"}, {"text": "Read", "value": "2"}, {"text": "Listener", "value": "3"}]}, "required": true, "interface": "select-radio", "display_options": {"conditionalFormatting": null}}, "name": "level_type", "type": "string", "field": "level_type"}]}, "special": ["cast-json"], "interface": "list", "collection": "languanges"}	\N	\N
388	427	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [17, 18], "status": "published", "level_type": [{"level_type": "1"}, {"level_type": "0"}], "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-07T03:26:34.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "language_levels": ["1", "0", "2"]}	{"level_type": [{"level_type": "1"}, {"level_type": "0"}], "date_updated": "2025-06-07T03:26:34.287Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
389	428	directus_fields	102	{"id": 102, "note": null, "sort": 9, "field": "levels", "group": null, "width": "full", "hidden": false, "display": "related-values", "options": {"template": "{{language_levels_id.level_name}}{{id}}", "enableLink": true, "allowDuplicates": true}, "special": ["m2m"], "readonly": false, "required": false, "interface": "list-m2m", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"template": "{{language_levels_id.level_name}}"}, "validation_message": null}	{"field": "levels", "display": "related-values", "options": {"template": "{{language_levels_id.level_name}}{{id}}", "enableLink": true, "allowDuplicates": true}, "collection": "languanges", "translations": null}	\N	\N
390	431	directus_fields	132	{"sort": 10, "field": "level_types", "options": {"template": "{{level_name}}"}, "special": ["m2o"], "interface": "select-dropdown-m2o", "collection": "languanges"}	{"sort": 10, "field": "level_types", "options": {"template": "{{level_name}}"}, "special": ["m2o"], "interface": "select-dropdown-m2o", "collection": "languanges"}	\N	\N
391	432	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [17, 18], "status": "published", "level_types": 1, "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-07T03:44:52.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"level_types": 1, "date_updated": "2025-06-07T03:44:51.720Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
392	433	directus_fields	132	{"id": 132, "note": null, "sort": 10, "field": "level_types", "group": null, "width": "full", "hidden": false, "display": "related-values", "options": {"template": "{{level_name}}"}, "special": ["m2o"], "readonly": false, "required": false, "interface": "select-dropdown-m2o", "collection": "languanges", "conditions": null, "validation": null, "translations": null, "display_options": {"template": "{{level_name}}"}, "validation_message": null}	{"field": "level_types", "display": "related-values", "collection": "languanges", "display_options": {"template": "{{level_name}}"}}	\N	\N
393	434	directus_permissions	12	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "directus_fields", "validation": null, "permissions": null}	{"action": "read", "fields": ["*"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "directus_fields", "validation": null, "permissions": null}	\N	\N
394	436	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id": "75adc3f9-1874-4865-a8c9-bb09d6f79b7c", "role": null, "sort": 1, "user": null, "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
395	439	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id": "75adc3f9-1874-4865-a8c9-bb09d6f79b7c", "role": null, "sort": 1, "user": null, "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
396	440	directus_fields	133	{"sort": 11, "field": "language_level_type", "display": null, "options": {"layout": "table", "enableLink": true, "allowDuplicates": true}, "special": ["m2m"], "interface": "list-m2m", "collection": "languanges"}	{"sort": 11, "field": "language_level_type", "display": null, "options": {"layout": "table", "enableLink": true, "allowDuplicates": true}, "special": ["m2m"], "interface": "list-m2m", "collection": "languanges"}	\N	\N
397	441	directus_fields	134	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_language_levels_1"}	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_language_levels_1"}	\N	\N
398	442	directus_collections	languanges_language_levels_1	{"icon": "import_export", "hidden": true, "collection": "languanges_language_levels_1"}	{"icon": "import_export", "hidden": true, "collection": "languanges_language_levels_1"}	\N	\N
399	443	directus_fields	135	{"sort": 9, "field": "languanges", "special": ["m2m"], "interface": "list-m2m", "collection": "language_levels"}	{"sort": 9, "field": "languanges", "special": ["m2m"], "interface": "list-m2m", "collection": "language_levels"}	\N	\N
400	444	directus_fields	136	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_language_levels_1"}	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_language_levels_1"}	\N	\N
401	445	directus_fields	137	{"sort": 3, "field": "language_levels_id", "hidden": true, "collection": "languanges_language_levels_1"}	{"sort": 3, "field": "language_levels_id", "hidden": true, "collection": "languanges_language_levels_1"}	\N	\N
402	448	directus_fields	138	{"sort": 11, "field": "language_level_type", "display": null, "options": {"layout": "table", "enableLink": true, "allowDuplicates": true}, "special": ["m2m"], "interface": "list-m2m", "collection": "languanges", "translations": null}	{"sort": 11, "field": "language_level_type", "display": null, "options": {"layout": "table", "enableLink": true, "allowDuplicates": true}, "special": ["m2m"], "interface": "list-m2m", "collection": "languanges", "translations": null}	\N	\N
403	449	directus_fields	139	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_language_levels_2"}	{"sort": 1, "field": "id", "hidden": true, "collection": "languanges_language_levels_2"}	\N	\N
404	450	directus_collections	languanges_language_levels_2	{"icon": "import_export", "hidden": true, "collection": "languanges_language_levels_2"}	{"icon": "import_export", "hidden": true, "collection": "languanges_language_levels_2"}	\N	\N
405	451	directus_fields	140	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_language_levels_2"}	{"sort": 2, "field": "languanges_id", "hidden": true, "collection": "languanges_language_levels_2"}	\N	\N
406	452	directus_fields	141	{"sort": 3, "field": "language_levels_id", "hidden": true, "collection": "languanges_language_levels_2"}	{"sort": 3, "field": "language_levels_id", "hidden": true, "collection": "languanges_language_levels_2"}	\N	\N
411	457	languanges	1	{"id": 1, "name": "Indonesia", "sort": null, "levels": [1, 2, 3, 4], "status": "published", "level_types": null, "date_created": "2025-04-16T14:04:25.000Z", "date_updated": "2025-06-07T03:57:48.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "language_level_type": [1, 2, 3, 4]}	{"date_updated": "2025-06-07T03:57:48.187Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
416	462	languanges	2	{"id": 2, "name": "English", "sort": null, "levels": [17, 18], "status": "published", "level_types": 1, "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-07T03:58:01.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "language_level_type": [5, 6, 7, 8]}	{"date_updated": "2025-06-07T03:58:00.768Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
417	465	directus_fields	142	{"sort": 10, "field": "level_types", "options": {"choices": [{"text": "Written", "value": "Written"}, {"text": "Read", "value": "Read"}, {"text": "Listening", "value": "Listening"}, {"text": "Spoken", "value": "Spoken"}]}, "special": ["cast-json"], "interface": "select-multiple-checkbox", "collection": "languanges"}	{"sort": 10, "field": "level_types", "options": {"choices": [{"text": "Written", "value": "Written"}, {"text": "Read", "value": "Read"}, {"text": "Listening", "value": "Listening"}, {"text": "Spoken", "value": "Spoken"}]}, "special": ["cast-json"], "interface": "select-multiple-checkbox", "collection": "languanges"}	\N	\N
418	467	languanges	1	{"id": 1, "name": "Indonesia", "sort": null, "status": "published", "level_types": ["Written", "Read"], "date_created": "2025-04-16T14:04:25.000Z", "date_updated": "2025-06-07T04:07:03.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"level_types": ["Written", "Read"], "date_updated": "2025-06-07T04:07:03.359Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
419	468	languanges	2	{"id": 2, "name": "English", "sort": null, "status": "published", "level_types": ["Listening", "Read"], "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-07T04:07:10.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"level_types": ["Listening", "Read"], "date_updated": "2025-06-07T04:07:09.582Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
420	491	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": "<p>Hello My friend</p>\\n<h1>This is the title bruh</h1>\\n<p><em>Well this is sub title</em></p>", "images": [], "status": "published", "description": "Lorem ipsum dolor sit amet", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-06-16T14:11:54.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"detail": "<p>Hello My friend</p>\\n<h1>This is the title bruh</h1>\\n<p><em>Well this is sub title</em></p>", "date_updated": "2025-06-16T14:11:53.645Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
421	492	directus_files	37ba7a02-2f69-483e-9898-26016a4c773a	{"type": "image/png", "title": "Unicharm Company Logo", "storage": "local", "filename_download": "Unicharm_company_logo.png"}	{"type": "image/png", "title": "Unicharm Company Logo", "storage": "local", "filename_download": "Unicharm_company_logo.png"}	\N	\N
422	495	directus_files	d0db82ce-7358-48d0-8182-2c1b969426c9	{"type": "image/png", "title": "Icons8 Warning 96 (1)", "storage": "cloudinary", "filename_download": "icons8-warning-96 (1).png"}	{"type": "image/png", "title": "Icons8 Warning 96 (1)", "storage": "cloudinary", "filename_download": "icons8-warning-96 (1).png"}	\N	\N
423	497	directus_collections	project_types	{"icon": null, "note": null, "sort": 1, "color": null, "group": "projects", "hidden": false, "collapse": "open", "singleton": false, "collection": "project_types", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": "projects"}	\N	\N
424	498	directus_collections	main_contents	{"icon": null, "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
425	499	directus_collections	educations	{"icon": "school", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
426	500	directus_collections	experiences	{"icon": "work", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
427	501	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
428	502	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
429	503	directus_collections	job_types	{"icon": null, "note": null, "sort": 6, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "job_types", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 6, "group": null}	\N	\N
430	504	directus_collections	languanges_undefined	{"icon": "import_export", "note": null, "sort": 7, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges_undefined", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": null, "archive_value": null, "accountability": "all", "unarchive_value": null, "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 7, "group": null}	\N	\N
431	505	directus_collections	projects_files	{"icon": "import_export", "note": null, "sort": 8, "color": null, "group": null, "hidden": true, "collapse": "open", "singleton": false, "collection": "projects_files", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": null, "archive_value": null, "accountability": "all", "unarchive_value": null, "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 8, "group": null}	\N	\N
432	506	directus_collections	main_contents	{"icon": null, "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
433	507	directus_collections	educations	{"icon": "school", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
434	508	directus_collections	experiences	{"icon": "work", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
435	509	directus_collections	job_types	{"icon": null, "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "job_types", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
436	510	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
764	860	projects_skills	6	{"projects_id":"9","skills_id":{"id":"13"}}	{"projects_id":"9","skills_id":{"id":"13"}}	766	\N
437	511	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 6, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 6, "group": null}	\N	\N
438	512	directus_collections	languanges_undefined	{"icon": "import_export", "note": null, "sort": 7, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges_undefined", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": null, "archive_value": null, "accountability": "all", "unarchive_value": null, "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 7, "group": null}	\N	\N
439	513	directus_collections	projects_files	{"icon": "import_export", "note": null, "sort": 8, "color": null, "group": null, "hidden": true, "collapse": "open", "singleton": false, "collection": "projects_files", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": null, "archive_value": null, "accountability": "all", "unarchive_value": null, "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 8, "group": null}	\N	\N
440	514	directus_collections	job_types	{"icon": null, "note": null, "sort": 1, "color": null, "group": "experiences", "hidden": false, "collapse": "open", "singleton": false, "collection": "job_types", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": "experiences"}	\N	\N
441	515	directus_collections	main_contents	{"icon": null, "note": null, "sort": 1, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": true, "collection": "main_contents", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 1, "group": null}	\N	\N
442	516	directus_collections	educations	{"icon": "school", "note": null, "sort": 2, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "educations", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 2, "group": null}	\N	\N
443	517	directus_collections	experiences	{"icon": "work", "note": null, "sort": 3, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "experiences", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 3, "group": null}	\N	\N
444	518	directus_collections	projects	{"icon": "workspace_premium", "note": null, "sort": 4, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "projects", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 4, "group": null}	\N	\N
445	519	directus_collections	skills	{"icon": "interactive_space", "note": null, "sort": 5, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "skills", "sort_field": "sort", "versioning": false, "preview_url": null, "translations": null, "archive_field": "status", "archive_value": "archived", "accountability": "all", "unarchive_value": "draft", "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 5, "group": null}	\N	\N
446	520	directus_collections	languanges_undefined	{"icon": "import_export", "note": null, "sort": 6, "color": null, "group": null, "hidden": false, "collapse": "open", "singleton": false, "collection": "languanges_undefined", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": null, "archive_value": null, "accountability": "all", "unarchive_value": null, "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 6, "group": null}	\N	\N
447	521	directus_collections	projects_files	{"icon": "import_export", "note": null, "sort": 7, "color": null, "group": null, "hidden": true, "collapse": "open", "singleton": false, "collection": "projects_files", "sort_field": null, "versioning": false, "preview_url": null, "translations": null, "archive_field": null, "archive_value": null, "accountability": "all", "unarchive_value": null, "display_template": null, "archive_app_filter": true, "item_duplication_fields": null}	{"sort": 7, "group": null}	\N	\N
448	522	directus_fields	143	{"sort": 9, "field": "icon", "options": {}, "special": ["file"], "required": true, "interface": "file-image", "collection": "project_types"}	{"sort": 9, "field": "icon", "options": {}, "special": ["file"], "required": true, "interface": "file-image", "collection": "project_types"}	\N	\N
449	523	directus_files	66e4e062-7f67-47f8-9eef-bbce6b99cae6	{"type": "image/png", "title": "Icons8 Web Development 96 (1)", "storage": "cloudinary", "filename_download": "icons8-web-development-96 (1).png"}	{"type": "image/png", "title": "Icons8 Web Development 96 (1)", "storage": "cloudinary", "filename_download": "icons8-web-development-96 (1).png"}	\N	\N
450	524	project_types	1	{"id": 1, "icon": "66e4e062-7f67-47f8-9eef-bbce6b99cae6", "name": "Web Development", "sort": null, "status": "published", "date_created": "2025-05-12T14:15:12.000Z", "date_updated": "2025-06-22T03:03:32.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"icon": "66e4e062-7f67-47f8-9eef-bbce6b99cae6", "name": "Web Development", "date_updated": "2025-06-22T03:03:31.679Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
451	525	directus_files	bf067a9b-72b9-47a2-a180-89188ba321d1	{"type": "image/png", "title": "Icons8 Web Development 96 (3)", "storage": "cloudinary", "filename_download": "icons8-web-development-96 (3).png"}	{"type": "image/png", "title": "Icons8 Web Development 96 (3)", "storage": "cloudinary", "filename_download": "icons8-web-development-96 (3).png"}	\N	\N
583	674	directus_files	8bf85679-a3c9-4051-9e18-f87f1869bcf1	{"title":"Devicon  Express","filename_download":"devicon--express.png","type":"image/png","storage":"cloudinary"}	{"title":"Devicon  Express","filename_download":"devicon--express.png","type":"image/png","storage":"cloudinary"}	\N	\N
452	526	project_types	1	{"id": 1, "icon": "bf067a9b-72b9-47a2-a180-89188ba321d1", "name": "Web Development", "sort": null, "status": "published", "date_created": "2025-05-12T14:15:12.000Z", "date_updated": "2025-06-22T03:08:08.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"icon": "bf067a9b-72b9-47a2-a180-89188ba321d1", "date_updated": "2025-06-22T03:08:08.233Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
453	527	directus_files	16a5c261-5fdd-4d5b-b8fa-169f40cb9217	{"type": "image/png", "title": "Icons8 Bar Chart 96 (1)", "storage": "cloudinary", "filename_download": "icons8-bar-chart-96 (1).png"}	{"type": "image/png", "title": "Icons8 Bar Chart 96 (1)", "storage": "cloudinary", "filename_download": "icons8-bar-chart-96 (1).png"}	\N	\N
454	528	project_types	2	{"id": 2, "icon": "16a5c261-5fdd-4d5b-b8fa-169f40cb9217", "name": "Data Analysis", "sort": null, "status": "published", "date_created": "2025-05-12T14:15:22.000Z", "date_updated": "2025-06-22T03:08:28.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"icon": "16a5c261-5fdd-4d5b-b8fa-169f40cb9217", "date_updated": "2025-06-22T03:08:27.757Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
455	529	directus_files	8d8ec497-dbfa-4a64-babd-a4b067c40c81	{"type": "image/png", "title": "Icons8 Mockup 96 (3)", "storage": "cloudinary", "filename_download": "icons8-mockup-96 (3).png"}	{"type": "image/png", "title": "Icons8 Mockup 96 (3)", "storage": "cloudinary", "filename_download": "icons8-mockup-96 (3).png"}	\N	\N
456	530	project_types	3	{"id": 3, "icon": "8d8ec497-dbfa-4a64-babd-a4b067c40c81", "name": "Graphic Design", "sort": null, "status": "published", "date_created": "2025-05-12T14:15:31.000Z", "date_updated": "2025-06-22T03:08:42.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"icon": "8d8ec497-dbfa-4a64-babd-a4b067c40c81", "date_updated": "2025-06-22T03:08:42.494Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
457	531	directus_files	74eee123-fd90-4c6b-9356-766d9ff7afe7	{"type": "image/png", "title": "Icons8 Employee 96 (1)", "storage": "cloudinary", "filename_download": "icons8-employee-96 (1).png"}	{"type": "image/png", "title": "Icons8 Employee 96 (1)", "storage": "cloudinary", "filename_download": "icons8-employee-96 (1).png"}	\N	\N
458	532	project_types	4	{"id": 4, "icon": "74eee123-fd90-4c6b-9356-766d9ff7afe7", "name": "HRIS Specialist", "sort": null, "status": "published", "date_created": "2025-05-12T14:15:49.000Z", "date_updated": "2025-06-22T03:09:02.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"icon": "74eee123-fd90-4c6b-9356-766d9ff7afe7", "date_updated": "2025-06-22T03:09:02.068Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
459	533	directus_files	eba4f0dd-0e95-48f4-84c2-f5b52812bbbf	{"type": "image/png", "title": "Icons8 Education 96", "storage": "cloudinary", "filename_download": "icons8-education-96.png"}	{"type": "image/png", "title": "Icons8 Education 96", "storage": "cloudinary", "filename_download": "icons8-education-96.png"}	\N	\N
460	534	directus_files	e152b968-e69a-4ffe-98e9-462259279d9a	{"type": "image/png", "title": "Icons8 Work 96", "storage": "cloudinary", "filename_download": "icons8-work-96.png"}	{"type": "image/png", "title": "Icons8 Work 96", "storage": "cloudinary", "filename_download": "icons8-work-96.png"}	\N	\N
461	535	directus_permissions	13	{"action": "read", "fields": ["id", "sort", "user_updated", "date_updated", "user_created", "name", "status", "date_created"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "job_types", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	{"action": "read", "fields": ["id", "sort", "user_updated", "date_updated", "user_created", "name", "status", "date_created"], "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17", "presets": null, "collection": "job_types", "validation": null, "permissions": {"_and": [{"status": {"_eq": "published"}}]}}	\N	\N
462	537	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id": "75adc3f9-1874-4865-a8c9-bb09d6f79b7c", "role": null, "sort": 1, "user": null, "policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"policy": "abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
463	538	skills	2	{"id": 2, "icon": "0bbcdfb5-3d07-4877-9047-d96c480bc3c3", "sort": null, "title": "Javascript", "status": "published", "date_created": "2025-04-23T14:48:46.000Z", "date_updated": "2025-06-22T14:12:21.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-22T14:12:20.852Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
464	539	skills	3	{"id": 3, "icon": "d4a3abb5-6770-4e03-a792-8192b8b92138", "sort": null, "title": "HTML", "status": "published", "date_created": "2025-04-23T14:49:10.000Z", "date_updated": "2025-06-22T14:12:26.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-22T14:12:26.154Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
465	540	skills	4	{"id": 4, "icon": "cb7e94b4-45ab-4edb-8d67-94e93f4d6702", "sort": null, "title": "CSS", "status": "published", "date_created": "2025-04-23T14:49:48.000Z", "date_updated": "2025-06-22T14:12:31.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"status": "published", "date_updated": "2025-06-22T14:12:30.947Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
466	541	directus_files	29037cce-65cc-4e03-a759-301e5c9fb41a	{"type": "image/png", "title": "Icons8 Laravel 100", "storage": "cloudinary", "filename_download": "icons8-laravel-100.png"}	{"type": "image/png", "title": "Icons8 Laravel 100", "storage": "cloudinary", "filename_download": "icons8-laravel-100.png"}	\N	\N
467	542	skills	5	{"icon": "29037cce-65cc-4e03-a759-301e5c9fb41a", "title": "Laravel", "status": "published"}	{"icon": "29037cce-65cc-4e03-a759-301e5c9fb41a", "title": "Laravel", "status": "published"}	\N	\N
468	543	directus_files	dab08913-0289-4378-9344-81799ff98187	{"type": "image/png", "title": "Icons8 Vue.js 48", "storage": "cloudinary", "filename_download": "icons8-vue.js-48.png"}	{"type": "image/png", "title": "Icons8 Vue.js 48", "storage": "cloudinary", "filename_download": "icons8-vue.js-48.png"}	\N	\N
469	544	skills	6	{"icon": "dab08913-0289-4378-9344-81799ff98187", "title": "Vue", "status": "published"}	{"icon": "dab08913-0289-4378-9344-81799ff98187", "title": "Vue", "status": "published"}	\N	\N
470	545	directus_files	12046594-82f6-4690-bd96-051087e33065	{"type": "image/png", "title": "Icons8 Tailwind CSS 24", "storage": "cloudinary", "filename_download": "icons8-tailwind-css-24.png"}	{"type": "image/png", "title": "Icons8 Tailwind CSS 24", "storage": "cloudinary", "filename_download": "icons8-tailwind-css-24.png"}	\N	\N
471	546	skills	7	{"icon": "12046594-82f6-4690-bd96-051087e33065", "title": "Tailwind", "status": "published"}	{"icon": "12046594-82f6-4690-bd96-051087e33065", "title": "Tailwind", "status": "published"}	\N	\N
472	548	languanges	2	{"id": 2, "name": "English", "sort": null, "status": "published", "level_types": ["Listening", "Read", "Spoken", "Written"], "date_created": "2025-04-16T14:09:13.000Z", "date_updated": "2025-06-27T14:33:53.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"level_types": ["Listening", "Read", "Spoken", "Written"], "date_updated": "2025-06-27T14:33:52.886Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
473	549	languanges	1	{"id": 1, "name": "Indonesia", "sort": null, "status": "published", "level_types": ["Written", "Read", "Spoken", "Listening"], "date_created": "2025-04-16T14:04:25.000Z", "date_updated": "2025-06-27T14:33:57.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"level_types": ["Written", "Read", "Spoken", "Listening"], "date_updated": "2025-06-27T14:33:57.409Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
474	550	experiences	2	{"status": "published", "company": "PT Rukun Mitra Sejati", "job_type": 1, "position": "Digital Effectiveness Specialist", "date_start": "2023-09-18T12:00:00"}	{"status": "published", "company": "PT Rukun Mitra Sejati", "job_type": 1, "position": "Digital Effectiveness Specialist", "date_start": "2023-09-18T12:00:00"}	\N	\N
475	551	educations	3	{"id": 3, "sort": null, "major": "Backend Javascript", "detail": null, "status": "published", "date_end": "2022-07-01T12:00:00", "sequence": 2, "date_start": "2022-01-01T12:00:00", "institution": "Binar Academy", "date_created": "2025-04-16T14:17:26.000Z", "date_updated": "2025-06-27T14:35:18.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Independent Study"}	{"status": "published", "date_updated": "2025-06-27T14:35:18.206Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
476	552	educations	4	{"id": 4, "sort": null, "major": "Golang for Back End Programmer", "detail": null, "status": "published", "date_end": "2022-12-01T12:00:00", "sequence": 3, "date_start": "2022-08-01T12:00:00", "institution": "Hacktiv8", "date_created": "2025-04-16T14:18:46.000Z", "date_updated": "2025-06-27T14:35:23.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Independent Study"}	{"status": "published", "date_updated": "2025-06-27T14:35:23.474Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
477	553	experiences	3	{"status": "published", "company": "Future is a Mistery", "job_type": 1, "position": "Experiencing new things", "date_start": "2001-02-21T12:00:00"}	{"status": "published", "company": "Future is a Mistery", "job_type": 1, "position": "Experiencing new things", "date_start": "2001-02-21T12:00:00"}	\N	\N
478	554	experiences	3	{"id": 3, "sort": null, "status": "published", "company": "Future is a Mistery", "date_end": null, "job_type": 2, "position": "Experiencing new things", "date_start": "2001-02-21T12:00:00", "job_detail": null, "date_created": "2025-06-27T14:45:58.000Z", "date_updated": "2025-06-27T14:47:20.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"job_type": 2, "date_updated": "2025-06-27T14:47:20.246Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
479	555	educations	5	{"major": "Lessons from the Past", "status": "published", "date_start": "2001-02-21T12:00:00", "institution": "Yesterday is a History", "education_type": "Life Study"}	{"major": "Lessons from the Past", "status": "published", "date_start": "2001-02-21T12:00:00", "institution": "Yesterday is a History", "education_type": "Life Study"}	\N	\N
480	556	directus_fields	144	{"sort": 15, "field": "sequence", "special": null, "interface": "input", "collection": "experiences"}	{"sort": 15, "field": "sequence", "special": null, "interface": "input", "collection": "experiences"}	\N	\N
481	557	experiences	3	{"id": 3, "sort": null, "status": "published", "company": "Future is a Mistery", "date_end": null, "job_type": 2, "position": "Experiencing new things", "sequence": 0, "date_start": "2001-02-21T12:00:00", "job_detail": null, "date_created": "2025-06-27T14:45:58.000Z", "date_updated": "2025-06-27T14:54:48.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"sequence": 0, "date_updated": "2025-06-27T14:54:48.060Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
482	558	experiences	2	{"id": 2, "sort": null, "status": "published", "company": "PT Rukun Mitra Sejati", "date_end": null, "job_type": 1, "position": "Digital Effectiveness Specialist", "sequence": 2, "date_start": "2023-09-18T12:00:00", "job_detail": null, "date_created": "2025-06-27T14:35:04.000Z", "date_updated": "2025-06-27T14:54:54.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"sequence": 2, "date_updated": "2025-06-27T14:54:54.274Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
483	559	experiences	1	{"id": 1, "sort": null, "status": "published", "company": "Cataliz", "date_end": "2023-08-01T12:00:00", "job_type": 1, "position": "Back End Developer", "sequence": 1, "date_start": "2023-02-01T12:00:00", "job_detail": null, "date_created": "2025-04-16T14:39:35.000Z", "date_updated": "2025-06-27T14:54:59.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"sequence": 1, "date_updated": "2025-06-27T14:54:59.083Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
484	560	educations	5	{"id": 5, "sort": null, "major": "Lessons from the Past", "detail": null, "status": "published", "date_end": null, "sequence": 0, "date_start": "2001-02-21T12:00:00", "institution": "Yesterday is a History", "date_created": "2025-06-27T14:53:09.000Z", "date_updated": "2025-06-27T14:55:21.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Life Study"}	{"sequence": 0, "date_updated": "2025-06-27T14:55:20.655Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
485	561	educations	1	{"id": 1, "sort": null, "major": "Diploma in English", "detail": null, "status": "published", "date_end": "2022-08-01T12:00:00", "sequence": 1, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "date_created": "2025-04-16T14:14:11.000Z", "date_updated": "2025-06-27T14:55:36.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Diploma Study"}	{"sequence": 1, "date_updated": "2025-06-27T14:55:36.093Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
584	675	skills	12	{"status":"published","title":"Express.js","icon":"8bf85679-a3c9-4051-9e18-f87f1869bcf1"}	{"status":"published","title":"Express.js","icon":"8bf85679-a3c9-4051-9e18-f87f1869bcf1"}	\N	\N
486	562	educations	2	{"id": 2, "sort": null, "major": "Information System", "detail": null, "status": "published", "date_end": "2023-09-01T12:00:00", "sequence": 2, "date_start": "2019-09-01T12:00:00", "institution": "Merdeka Malang University", "date_created": "2025-04-16T14:16:10.000Z", "date_updated": "2025-06-27T14:55:41.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Bachelor Study"}	{"sequence": 2, "date_updated": "2025-06-27T14:55:40.921Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
487	563	educations	3	{"id": 3, "sort": null, "major": "Backend Javascript", "detail": null, "status": "published", "date_end": "2022-07-01T12:00:00", "sequence": 4, "date_start": "2022-01-01T12:00:00", "institution": "Binar Academy", "date_created": "2025-04-16T14:17:26.000Z", "date_updated": "2025-06-27T14:55:57.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_type": "Independent Study"}	{"sequence": 4, "date_updated": "2025-06-27T14:55:56.674Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
488	565	main_contents	1	{"id": 1, "status": "published", "about_desc": "Anam is a digitalization specialist, focusing on website development and data analytic implementation. In almost two years of work experience, Anam has already done many projects in improving company digitalizations. He's a graduate in Bachelor of Information Systems and Diploma in English with double degree program .  He's also graduated in programming bootcamps like Javascript Backend bootcamp. His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like excel and slight of Python", "date_created": "2025-04-16T14:02:18.000Z", "date_updated": "2025-06-29T14:21:09.000Z", "project_desc": "This is Project Description", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_desc": "This is Education Description", "experience_desc": "Experience Description"}	{"about_desc": "Anam is a digitalization specialist, focusing on website development and data analytic implementation. In almost two years of work experience, Anam has already done many projects in improving company digitalizations. He's a graduate in Bachelor of Information Systems and Diploma in English with double degree program .  He's also graduated in programming bootcamps like Javascript Backend bootcamp. His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like excel and slight of Python", "date_updated": "2025-06-29T14:21:09.060Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
489	566	main_contents	1	{"id": 1, "status": "published", "about_desc": "Anam is a digitalization specialist, focusing on website development and data analytic implementation. In almost two years of work experience, Anam has already done many projects in improving company digitalizations. He's a graduate in Bachelor of Information Systems and Diploma in English with double degree program .  He's also graduated in programming bootcamps like Javascript Backend bootcamp. His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python", "date_created": "2025-04-16T14:02:18.000Z", "date_updated": "2025-06-29T14:21:43.000Z", "project_desc": "This is Project Description", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_desc": "This is Education Description", "experience_desc": "Experience Description"}	{"about_desc": "Anam is a digitalization specialist, focusing on website development and data analytic implementation. In almost two years of work experience, Anam has already done many projects in improving company digitalizations. He's a graduate in Bachelor of Information Systems and Diploma in English with double degree program .  He's also graduated in programming bootcamps like Javascript Backend bootcamp. His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python", "date_updated": "2025-06-29T14:21:42.676Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
490	567	specialties	1	{"id": 1, "icon": "38808ea0-ac80-475b-998d-b4aa6788c58f", "sort": null, "title": "Web Development", "status": "published", "description": "Bringing ideas online with functional, responsive, and optimized websites. With experience in Laravel, JavaScript, and Vue, I develop full-featured web applications tailored to real business needs. My work is grounded in clean architecture, maintainability, and performance, enabling companies to operate more efficiently in the digital space.", "date_created": "2025-04-23T14:36:01.000Z", "date_updated": "2025-06-29T14:34:34.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "Bringing ideas online with functional, responsive, and optimized websites. With experience in Laravel, JavaScript, and Vue, I develop full-featured web applications tailored to real business needs. My work is grounded in clean architecture, maintainability, and performance, enabling companies to operate more efficiently in the digital space.", "date_updated": "2025-06-29T14:34:34.033Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
491	568	specialties	1	{"id": 1, "icon": "38808ea0-ac80-475b-998d-b4aa6788c58f", "sort": 2, "title": "Web Development", "status": "published", "description": "Bringing ideas online with functional, responsive, and optimized websites. With experience in Laravel, JavaScript, and Vue, I develop web applications tailored to real business needs. My work is grounded in clean architecture, maintainability, and performance, enabling companies to operate more efficiently in the digital space.", "date_created": "2025-04-23T14:36:01.000Z", "date_updated": "2025-06-29T14:35:53.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "Bringing ideas online with functional, responsive, and optimized websites. With experience in Laravel, JavaScript, and Vue, I develop web applications tailored to real business needs. My work is grounded in clean architecture, maintainability, and performance, enabling companies to operate more efficiently in the digital space.", "date_updated": "2025-06-29T14:35:53.412Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
532	619	projects	8	{"title":"Automatic Warehouse Rent Reminder","status":"published","type":"2","description":"Developed to help field team (Operation & regional managers) with more than 100 branches to manage warehouse rent management (payment, movement, and extend) using Google App Script "}	{"title":"Automatic Warehouse Rent Reminder","status":"published","type":"2","description":"Developed to help field team (Operation & regional managers) with more than 100 branches to manage warehouse rent management (payment, movement, and extend) using Google App Script "}	\N	\N
586	677	skills	13	{"status":"published","icon":"efaa7459-6942-4d8c-bd1c-cd42b1b5d9b7","title":"Google Sheet"}	{"status":"published","icon":"efaa7459-6942-4d8c-bd1c-cd42b1b5d9b7","title":"Google Sheet"}	\N	\N
492	569	specialties	1	{"id": 1, "icon": "38808ea0-ac80-475b-998d-b4aa6788c58f", "sort": 2, "title": "Web Development", "status": "published", "description": "With experience in Laravel, JavaScript, and Vue, I develop web applications tailored to real business needs. My work is grounded in clean architecture, maintainability, and performance, enabling companies to operate more efficiently in the digital space.", "date_created": "2025-04-23T14:36:01.000Z", "date_updated": "2025-06-29T14:36:21.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "With experience in Laravel, JavaScript, and Vue, I develop web applications tailored to real business needs. My work is grounded in clean architecture, maintainability, and performance, enabling companies to operate more efficiently in the digital space.", "date_updated": "2025-06-29T14:36:20.914Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
493	570	specialties	2	{"id": 2, "icon": "7e228bab-3258-4919-97d2-95cd07fe7cc6", "sort": 1, "title": "Data Analysis", "status": "published", "description": "Transforming raw data into meaningful insights. I specialize in building dashboards, reports, and automation using tools like Power BI, Google Looker, App Script, and Excel. With a deep understanding of both data structure and business context, I help organizations make smarter, data-driven decisions", "date_created": "2025-04-23T14:36:56.000Z", "date_updated": "2025-06-29T14:37:03.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "Transforming raw data into meaningful insights. I specialize in building dashboards, reports, and automation using tools like Power BI, Google Looker, App Script, and Excel. With a deep understanding of both data structure and business context, I help organizations make smarter, data-driven decisions", "date_updated": "2025-06-29T14:37:03.135Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
494	571	specialties	2	{"id": 2, "icon": "7e228bab-3258-4919-97d2-95cd07fe7cc6", "sort": 1, "title": "Data Analysis", "status": "published", "description": "I specialize in building dashboards, reports, and automation using tools like Power BI, Google Looker, App Script, and Excel. With a deep understanding of both data structure and business context, I help organizations make smarter, data-driven decisions", "date_created": "2025-04-23T14:36:56.000Z", "date_updated": "2025-06-29T14:37:28.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "I specialize in building dashboards, reports, and automation using tools like Power BI, Google Looker, App Script, and Excel. With a deep understanding of both data structure and business context, I help organizations make smarter, data-driven decisions", "date_updated": "2025-06-29T14:37:27.830Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
495	572	specialties	3	{"id": 3, "icon": "bb9979d1-0ee2-4ea0-a926-aafba0432619", "sort": 3, "title": "HRIS Analyst", "status": "published", "description": "Supporting HR operations through data and system improvements. I’ve worked on optimizing HR workflows, implementing HRIS tools, and creating dashboards that provide clarity on workforce metrics.", "date_created": "2025-04-23T14:37:38.000Z", "date_updated": "2025-06-29T14:38:24.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "Supporting HR operations through data and system improvements. I’ve worked on optimizing HR workflows, implementing HRIS tools, and creating dashboards that provide clarity on workforce metrics.", "date_updated": "2025-06-29T14:38:24.191Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
496	573	specialties	4	{"id": 4, "icon": "b5761b06-fdc3-405d-9e2e-9fb176400c86", "sort": 4, "title": "Graphic Design", "status": "published", "description": "Creating visual assets that complement digital transformation efforts. Whether it’s UI mockups, internal branding materials, or social media creatives, I bring a designer’s eye to enhance user experience and communication", "date_created": "2025-04-23T14:38:47.000Z", "date_updated": "2025-06-29T14:38:56.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "Creating visual assets that complement digital transformation efforts. Whether it’s UI mockups, internal branding materials, or social media creatives, I bring a designer’s eye to enhance user experience and communication", "date_updated": "2025-06-29T14:38:55.713Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
497	577	projects	3	{"type": 1, "title": " PDP (Performance Development Plan) Web App for Scoring Employee", "status": "published", "description": "Lorem ipsum dolor sit amet"}	{"type": 1, "title": " PDP (Performance Development Plan) Web App for Scoring Employee", "status": "published", "description": "Lorem ipsum dolor sit amet"}	\N	\N
498	578	projects	4	{"type": 2, "title": "360 Degree Employee Scoring Dashboard (Manager Scoring)", "status": "published", "description": "Lorem ipsum dolor sit amet"}	{"type": 2, "title": "360 Degree Employee Scoring Dashboard (Manager Scoring)", "status": "published", "description": "Lorem ipsum dolor sit amet"}	\N	\N
499	579	projects	5	{"type": 1, "title": "Employee Job Scope Website", "status": "published", "description": "Lorem ipsum dolor sit amet"}	{"type": 1, "title": "Employee Job Scope Website", "status": "published", "description": "Lorem ipsum dolor sit amet"}	\N	\N
500	580	projects	6	{"type": 1, "title": " RDA Company Website", "status": "published", "description": "Lorem ipsum dolor sit amet"}	{"type": 1, "title": " RDA Company Website", "status": "published", "description": "Lorem ipsum dolor sit amet"}	\N	\N
501	582	directus_files	36af366b-87fb-4c43-b278-d14f36a032e2	{"type": "image/png", "title": "Screenshot 2025 07 16 204405", "storage": "cloudinary", "filename_download": "Screenshot 2025-07-16 204405.png"}	{"type": "image/png", "title": "Screenshot 2025 07 16 204405", "storage": "cloudinary", "filename_download": "Screenshot 2025-07-16 204405.png"}	\N	\N
502	583	projects_files	1	{"projects_id": "1", "directus_files_id": {"id": "36af366b-87fb-4c43-b278-d14f36a032e2"}}	{"projects_id": "1", "directus_files_id": {"id": "36af366b-87fb-4c43-b278-d14f36a032e2"}}	503	\N
533	620	projects	9	{"status":"published","title":"Automatic Data Parsing for Job Scope Website","description":"Utilizing Google App Script to convert user initiated data in Google Sheet to REST API for Job Scope Website.","type":"2"}	{"status":"published","title":"Automatic Data Parsing for Job Scope Website","description":"Utilizing Google App Script to convert user initiated data in Google Sheet to REST API for Job Scope Website.","type":"2"}	\N	\N
587	678	directus_files	64fb2000-857f-4936-82f9-35c1ec187957	{"title":"Arcticons  Microsoft Power BI","filename_download":"arcticons--microsoft-power-bi.png","type":"image/png","storage":"cloudinary"}	{"title":"Arcticons  Microsoft Power BI","filename_download":"arcticons--microsoft-power-bi.png","type":"image/png","storage":"cloudinary"}	\N	\N
503	584	projects	1	{"id": 1, "sort": null, "type": 1, "title": "LMS Application", "detail": null, "images": [1], "status": "published", "description": "This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.", "date_created": "2025-04-16T14:40:35.000Z", "date_updated": "2025-07-16T13:45:18.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.", "date_updated": "2025-07-16T13:45:18.262Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
504	585	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": "<p>Hello My friend</p>\\n<h1>This is the title bruh</h1>\\n<p><em>Well this is sub title</em></p>", "images": [], "status": "published", "description": "One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-07-16T13:59:18.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts", "date_updated": "2025-07-16T13:59:17.596Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
505	586	directus_files	2d36b909-4f2f-4199-bd59-3abf7cbc7b41	{"type": "image/png", "title": "Screenshot 2025 07 16 210614", "storage": "cloudinary", "filename_download": "Screenshot 2025-07-16 210614.png"}	{"type": "image/png", "title": "Screenshot 2025 07 16 210614", "storage": "cloudinary", "filename_download": "Screenshot 2025-07-16 210614.png"}	\N	\N
506	587	projects_files	2	{"projects_id": "3", "directus_files_id": {"id": "2d36b909-4f2f-4199-bd59-3abf7cbc7b41"}}	{"projects_id": "3", "directus_files_id": {"id": "2d36b909-4f2f-4199-bd59-3abf7cbc7b41"}}	507	\N
507	588	projects	3	{"id": 3, "sort": null, "type": 1, "title": " PDP (Performance Development Plan) Web App for Scoring Employee", "detail": null, "images": [2], "status": "published", "description": "This website was developed to make employee scoring for performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform.", "date_created": "2025-07-11T15:15:44.000Z", "date_updated": "2025-07-16T14:08:55.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "This website was developed to make employee scoring for performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform.", "date_updated": "2025-07-16T14:08:54.950Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
508	589	projects	4	{"id": 4, "sort": null, "type": 2, "title": "360 Degree Employee Scoring Dashboard (Manager Scoring)", "detail": null, "images": [], "status": "published", "description": "This dashboard is made for monitoring employee scoring with 360 degree. In this case, only managers are evaluated by their team. ", "date_created": "2025-07-11T15:16:18.000Z", "date_updated": "2025-07-16T14:14:08.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "This dashboard is made for monitoring employee scoring with 360 degree. In this case, only managers are evaluated by their team. ", "date_updated": "2025-07-16T14:14:07.672Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
509	590	projects	5	{"id": 5, "sort": null, "type": 1, "title": "Employee Job Scope Website", "detail": null, "images": [], "status": "published", "description": "This website was developed for mapping employee jobdesks by using RATSI system where every task of any position will have their own responsibility in charge, authorizer, supporters, and informed positions. ", "date_created": "2025-07-11T15:16:43.000Z", "date_updated": "2025-07-16T14:16:38.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "This website was developed for mapping employee jobdesks by using RATSI system where every task of any position will have their own responsibility in charge, authorizer, supporters, and informed positions. ", "date_updated": "2025-07-16T14:16:38.014Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
510	591	projects	6	{"id": 6, "sort": null, "type": 1, "title": " RDA Company Website", "detail": null, "images": [], "status": "published", "description": "Developed a company profile website for the related company. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.", "date_created": "2025-07-11T15:17:11.000Z", "date_updated": "2025-07-16T14:18:08.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"description": "Developed a company profile website for the related company. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.", "date_updated": "2025-07-16T14:18:08.112Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
511	593	projects	7	{"type": 2, "title": "Attendance Monitoring Dashboard", "status": "published", "description": "Developed for supervise employees with flexible attendance ability"}	{"type": 2, "title": "Attendance Monitoring Dashboard", "status": "published", "description": "Developed for supervise employees with flexible attendance ability"}	\N	\N
512	595	directus_files	bf689c1e-723f-4720-80ce-0d8dc8433f30	{"type": "image/jpeg", "title": "Whats App Image 2025 07 22 at 14.03.07 314a44e8", "storage": "cloudinary", "filename_download": "WhatsApp Image 2025-07-22 at 14.03.07_314a44e8.jpg"}	{"type": "image/jpeg", "title": "Whats App Image 2025 07 22 at 14.03.07 314a44e8", "storage": "cloudinary", "filename_download": "WhatsApp Image 2025-07-22 at 14.03.07_314a44e8.jpg"}	\N	\N
544	632	projects	3	{"id":"3","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:15:44.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-20T13:57:38.048Z","title":" PDP (Performance Development Plan) Web App for Scoring Employee","description":"This website was developed to make employee scoring for performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform.","detail":null,"type":"1","images":["2","3","4"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-20T13:57:38.048Z"}	\N	\N
513	596	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": "<h1>This is the title bruh</h1>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"></p>\\n<p><em>Well this is sub title</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "images": [], "status": "published", "description": "One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-07-28T15:30:54.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"detail": "<h1>This is the title bruh</h1>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"></p>\\n<p><em>Well this is sub title</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "date_updated": "2025-07-28T15:30:53.685Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
514	597	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": "<h3>This is the title bruh</h3>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"></p>\\n<p><em>Well this is sub title</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "images": [], "status": "published", "description": "One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-07-28T15:43:51.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"detail": "<h3>This is the title bruh</h3>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"></p>\\n<p><em>Well this is sub title</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "date_updated": "2025-07-28T15:43:50.703Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
515	598	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": "<h3>This is the title bruh</h3>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"><em>Well this is sub title<br></em><em>Hello</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "images": [], "status": "published", "description": "One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-07-28T15:44:22.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"detail": "<h3>This is the title bruh</h3>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"><em>Well this is sub title<br></em><em>Hello</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "date_updated": "2025-07-28T15:44:22.287Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
516	599	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": "<h1>This is the title bruh</h1>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"><em>Well this is sub title<br></em><em>Hello</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "images": [], "status": "published", "description": "One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-07-28T15:46:55.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"detail": "<h1>This is the title bruh</h1>\\n<p><img src=\\"http://localhost:8055/assets/bf689c1e-723f-4720-80ce-0d8dc8433f30.jpg?width=4080&amp;height=3060\\" alt=\\"Whats App Image 2025 07 22 at 14.03.07 314a44e8\\" loading=\\"lazy\\"><em>Well this is sub title<br></em><em>Hello</em></p>\\n<ul>\\n<li><em>Hello</em></li>\\n<li><em>Yes</em></li>\\n</ul>", "date_updated": "2025-07-28T15:46:54.635Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
517	600	projects	2	{"id": 2, "sort": null, "type": 2, "title": "Think Action REST API", "detail": "<h1>This is the title bruh</h1>\\n<p><em>Well this is sub title<br></em><em>Hello<br><br></em></p>", "images": [], "status": "published", "description": "One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts", "date_created": "2025-04-16T14:42:29.000Z", "date_updated": "2025-07-28T15:51:41.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"detail": "<h1>This is the title bruh</h1>\\n<p><em>Well this is sub title<br></em><em>Hello<br><br></em></p>", "date_updated": "2025-07-28T15:51:40.936Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
518	601	experiences	1	{"id": 1, "sort": null, "status": "published", "company": "Cataliz", "date_end": "2023-08-01T12:00:00", "job_type": 1, "position": "Back End Developer", "sequence": 1, "date_start": "2023-02-01T12:00:00", "job_detail": "<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improve employee&rsquo;s scoring and Job desk mapping workflow by developing dedicated Web Apps</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved HR data management by using advance formula and developing data dashboard using dashboard tools (Looker and Power BI)</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Streamlined repetitive administrative tasks (ex. sending emails, download images, and removing background) using python scripts and/or google app script</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Brainstormed company profile&rsquo;s video ideas &amp; concept, also Collaborated with videographers</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Managed employees ID Card production from head office to branches employees</p>\\n</li>\\n</ul>", "date_created": "2025-04-16T14:39:35.000Z", "date_updated": "2025-07-28T15:58:15.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"job_detail": "<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improve employee&rsquo;s scoring and Job desk mapping workflow by developing dedicated Web Apps</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved HR data management by using advance formula and developing data dashboard using dashboard tools (Looker and Power BI)</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Streamlined repetitive administrative tasks (ex. sending emails, download images, and removing background) using python scripts and/or google app script</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Brainstormed company profile&rsquo;s video ideas &amp; concept, also Collaborated with videographers</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Managed employees ID Card production from head office to branches employees</p>\\n</li>\\n</ul>", "date_updated": "2025-07-28T15:58:15.197Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
519	602	experiences	1	{"id": 1, "sort": null, "status": "published", "company": "Cataliz", "date_end": "2023-08-01T12:00:00", "job_type": 1, "position": "Back End Developer", "sequence": 1, "date_start": "2023-02-01T12:00:00", "job_detail": null, "date_created": "2025-04-16T14:39:35.000Z", "date_updated": "2025-07-28T15:58:25.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"job_detail": null, "date_updated": "2025-07-28T15:58:25.222Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
520	603	experiences	2	{"id": 2, "sort": null, "status": "published", "company": "PT Rukun Mitra Sejati", "date_end": null, "job_type": 1, "position": "Digital Effectiveness Specialist", "sequence": 2, "date_start": "2023-09-18T12:00:00", "job_detail": "<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improve employee&rsquo;s scoring and Job desk mapping workflow by developing dedicated Web Apps</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved HR data management by using advance formula and developing data dashboard using dashboard tools (Looker and Power BI)</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Streamlined repetitive administrative tasks (ex. sending emails, download images, and removing background) using python scripts and/or google app script</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Brainstormed company profile&rsquo;s video ideas &amp; concept, also Collaborated with videographers</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Managed employees ID Card production from head office to branches employees</p>\\n</li>\\n</ul>", "date_created": "2025-06-27T14:35:04.000Z", "date_updated": "2025-07-28T15:58:32.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"job_detail": "<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improve employee&rsquo;s scoring and Job desk mapping workflow by developing dedicated Web Apps</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved HR data management by using advance formula and developing data dashboard using dashboard tools (Looker and Power BI)</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Streamlined repetitive administrative tasks (ex. sending emails, download images, and removing background) using python scripts and/or google app script</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Brainstormed company profile&rsquo;s video ideas &amp; concept, also Collaborated with videographers</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Managed employees ID Card production from head office to branches employees</p>\\n</li>\\n</ul>", "date_updated": "2025-07-28T15:58:32.007Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
521	604	experiences	1	{"id": 1, "sort": null, "status": "published", "company": "Cataliz", "date_end": "2023-08-01T12:00:00", "job_type": 1, "position": "Back End Developer", "sequence": 1, "date_start": "2023-02-01T12:00:00", "job_detail": "<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Solved the complex data requirement using MongoDB Aggregation</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developed RESTful API based on documentation using Express.js.</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved application reliability by making API testing using Postman.</p>\\n</li>\\n</ul>", "date_created": "2025-04-16T14:39:35.000Z", "date_updated": "2025-07-28T15:58:58.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"job_detail": "<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Solved the complex data requirement using MongoDB Aggregation</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developed RESTful API based on documentation using Express.js.</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved application reliability by making API testing using Postman.</p>\\n</li>\\n</ul>", "date_updated": "2025-07-28T15:58:58.226Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
522	605	experiences	2	{"id": 2, "sort": null, "status": "published", "company": "PT Rukun Mitra Sejati", "date_end": null, "job_type": 1, "position": "Digital Effectiveness / Web Developer", "sequence": 2, "date_start": "2023-09-18T12:00:00", "job_detail": "<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improve employee&rsquo;s scoring and Job desk mapping workflow by developing dedicated Web Apps</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved HR data management by using advance formula and developing data dashboard using dashboard tools (Looker and Power BI)</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Streamlined repetitive administrative tasks (ex. sending emails, download images, and removing background) using python scripts and/or google app script</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Brainstormed company profile&rsquo;s video ideas &amp; concept, also Collaborated with videographers</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Managed employees ID Card production from head office to branches employees</p>\\n</li>\\n</ul>", "date_created": "2025-06-27T14:35:04.000Z", "date_updated": "2025-07-28T16:03:43.000Z", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	{"position": "Digital Effectiveness / Web Developer", "date_updated": "2025-07-28T16:03:43.183Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
523	606	main_contents	1	{"id": 1, "status": "published", "about_desc": "Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. He's a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python", "date_created": "2025-04-16T14:02:18.000Z", "date_updated": "2025-07-29T01:44:42.000Z", "project_desc": "This is Project Description", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_desc": "This is Education Description", "experience_desc": "Experience Description"}	{"about_desc": "Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. He's a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python", "date_updated": "2025-07-29T01:44:41.995Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
542	630	projects_files	3	{"projects_id":"3","directus_files_id":{"id":"a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55"}}	{"projects_id":"3","directus_files_id":{"id":"a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55"}}	544	\N
543	631	projects_files	4	{"projects_id":"3","directus_files_id":{"id":"ca6bc938-1974-4e0d-8eae-83b1c77e518e"}}	{"projects_id":"3","directus_files_id":{"id":"ca6bc938-1974-4e0d-8eae-83b1c77e518e"}}	544	\N
524	607	main_contents	1	{"id": 1, "status": "published", "about_desc": "Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. Also a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python", "date_created": "2025-04-16T14:02:18.000Z", "date_updated": "2025-07-29T01:45:51.000Z", "project_desc": "This is Project Description", "user_created": "a89509b5-964d-4f8d-9e09-d6e79c368399", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399", "education_desc": "This is Education Description", "experience_desc": "Experience Description"}	{"about_desc": "Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. Also a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python", "date_updated": "2025-07-29T01:45:51.473Z", "user_updated": "a89509b5-964d-4f8d-9e09-d6e79c368399"}	\N	\N
525	609	main_contents	1	{"id":"1","status":"published","user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:02:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-04T15:43:01.640Z","about_desc":"Anam Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. Also a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python","project_desc":"This is Project Description","education_desc":"This is Education Description","experience_desc":"Experience Description"}	{"about_desc":"Anam Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. Also a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-04T15:43:01.640Z"}	\N	\N
526	610	main_contents	1	{"id":"1","status":"published","user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:02:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-04T15:43:18.230Z","about_desc":"Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. Also a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python","project_desc":"This is Project Description","education_desc":"This is Education Description","experience_desc":"Experience Description"}	{"about_desc":"Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. Also a graduate in Bachelor of Information Systems and Diploma in English with double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-04T15:43:18.230Z"}	\N	\N
534	621	main_contents	1	{"id":"1","status":"published","user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:02:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-12T09:55:55.206Z","about_desc":"Digitalization Specialist with nearly two years of experience in web development and data analytics. Skilled in Laravel, Vue, Power BI, and automation tools. Also leveraged machine learning models and AI tools for workflow optimization and reducing redundant tasks. Graduated with a Bachelor of Information Systems and Diploma in English with a double degree program. His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic and BI tools like Looker, App script,  Excel and a slight of Python","project_desc":"This is Project Description","education_desc":"This is Education Description","experience_desc":"Experience Description"}	{"about_desc":"Digitalization Specialist with nearly two years of experience in web development and data analytics. Skilled in Laravel, Vue, Power BI, and automation tools. Also leveraged machine learning models and AI tools for workflow optimization and reducing redundant tasks. Graduated with a Bachelor of Information Systems and Diploma in English with a double degree program. His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic and BI tools like Looker, App script,  Excel and a slight of Python","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-12T09:55:55.206Z"}	\N	\N
545	633	directus_files	6bbda258-d18c-45c5-a58b-1877d057e78e	{"title":"Whats App Image 2025 07 03 at 13.13.26 5496ee1e","filename_download":"WhatsApp Image 2025-07-03 at 13.13.26_5496ee1e.jpg","type":"image/jpeg","storage":"cloudinary"}	{"title":"Whats App Image 2025 07 03 at 13.13.26 5496ee1e","filename_download":"WhatsApp Image 2025-07-03 at 13.13.26_5496ee1e.jpg","type":"image/jpeg","storage":"cloudinary"}	\N	\N
550	641	projects_files	2	{"id":"2","projects_id":null,"directus_files_id":"2d36b909-4f2f-4199-bd59-3abf7cbc7b41"}	{"projects_id":null}	554	\N
770	866	projects_skills	11	{"projects_id":"5","skills_id":{"id":"5"}}	{"projects_id":"5","skills_id":{"id":"5"}}	776	\N
527	612	directus_settings	2	{"id":"2","project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":"25","auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"01987b04-c62e-77da-90f7-0e12d5f219c7"}	{"accepted_terms":true}	\N	\N
535	623	directus_fields	94	{"id":"94","collection":"projects","field":"images","special":["files"],"interface":"files","options":{"template":"{{directus_files_id.filename_download}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":"11","width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"images","options":{"template":"{{directus_files_id.filename_download}}"}}	\N	\N
546	634	directus_files	fcbfac4f-7837-48ce-956c-fc3fa87ae2fd	{"title":"Slice 1","filename_download":"Slice 1.png","type":"image/png","storage":"cloudinary"}	{"title":"Slice 1","filename_download":"Slice 1.png","type":"image/png","storage":"cloudinary"}	\N	\N
554	645	projects	3	{"id":"3","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:15:44.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:04:47.580Z","title":" PDP (Performance Development Plan) Web App for Scoring Employee","description":"This website was developed to make employee scoring for performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform.","detail":null,"type":"1","images":[]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:04:47.580Z"}	\N	\N
551	642	projects_files	3	{"id":"3","projects_id":null,"directus_files_id":"a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55"}	{"projects_id":null}	554	\N
552	643	projects_files	4	{"id":"4","projects_id":null,"directus_files_id":"ca6bc938-1974-4e0d-8eae-83b1c77e518e"}	{"projects_id":null}	554	\N
553	644	projects_files	5	{"id":"5","projects_id":null,"directus_files_id":"e6c66500-f365-432b-b15e-35b57caafd68"}	{"projects_id":null}	554	\N
557	648	directus_files	ff8ea093-91e8-4dc3-ac3f-aa552e89cfe4	{"title":"Rms Hari Penting","filename_download":"RMS Hari Penting.jpg","type":"image/jpeg","storage":"cloudinary"}	{"title":"Rms Hari Penting","filename_download":"RMS Hari Penting.jpg","type":"image/jpeg","storage":"cloudinary"}	\N	\N
561	652	directus_files	7fcff390-a543-4e4f-abf9-2eae212261dd	{"title":"Upscaled Logo","filename_download":"upscaled_logo.png","type":"image/png","storage":"cloudinary"}	{"title":"Upscaled Logo","filename_download":"upscaled_logo.png","type":"image/png","storage":"cloudinary"}	\N	\N
563	654	directus_files	afa75bc7-8fb1-4eb2-82a9-2a43493ce4f7	{"title":"Avatar 20241102 082602 Image Cropper 1730510744766","filename_download":"avatar_20241102_082602_image_cropper_1730510744766.jpg","type":"image/jpeg","storage":"cloudinary"}	{"title":"Avatar 20241102 082602 Image Cropper 1730510744766","filename_download":"avatar_20241102_082602_image_cropper_1730510744766.jpg","type":"image/jpeg","storage":"cloudinary"}	\N	\N
569	660	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:07:05.770Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":null,"type":"1","images":["6","7","8","9"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:07:05.770Z"}	\N	\N
565	656	projects_files	6	{"projects_id":"1","directus_files_id":{"id":"abbc5f31-bef7-48b7-8524-38fcd16832f8"}}	{"projects_id":"1","directus_files_id":{"id":"abbc5f31-bef7-48b7-8524-38fcd16832f8"}}	569	\N
566	657	projects_files	7	{"projects_id":"1","directus_files_id":{"id":"7fcff390-a543-4e4f-abf9-2eae212261dd"}}	{"projects_id":"1","directus_files_id":{"id":"7fcff390-a543-4e4f-abf9-2eae212261dd"}}	569	\N
567	658	projects_files	8	{"projects_id":"1","directus_files_id":{"id":"bb279472-b39d-4e64-af00-87a62860614c"}}	{"projects_id":"1","directus_files_id":{"id":"bb279472-b39d-4e64-af00-87a62860614c"}}	569	\N
568	659	projects_files	9	{"projects_id":"1","directus_files_id":{"id":"e59518c0-ac31-4f5c-a8fb-e3972821c5e9"}}	{"projects_id":"1","directus_files_id":{"id":"e59518c0-ac31-4f5c-a8fb-e3972821c5e9"}}	569	\N
574	665	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:47:36.805Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":null,"type":"1","images":[]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:47:36.805Z"}	\N	\N
570	661	projects_files	6	{"id":"6","projects_id":null,"directus_files_id":"abbc5f31-bef7-48b7-8524-38fcd16832f8"}	{"projects_id":null}	574	\N
571	662	projects_files	7	{"id":"7","projects_id":null,"directus_files_id":"7fcff390-a543-4e4f-abf9-2eae212261dd"}	{"projects_id":null}	574	\N
572	663	projects_files	8	{"id":"8","projects_id":null,"directus_files_id":"bb279472-b39d-4e64-af00-87a62860614c"}	{"projects_id":null}	574	\N
528	613	projects	2	{"id":"2","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:42:29.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-07T05:07:15.886Z","title":"Think Action REST API","description":"One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts","detail":"<p><em><br><br></em></p>","type":"2","images":[]}	{"detail":"<p><em><br><br></em></p>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-07T05:07:15.886Z"}	\N	\N
536	624	directus_fields	94	{"id":"94","collection":"projects","field":"images","special":["files"],"interface":"files","options":{"template":"{{directus_files_id.filename_download}}"},"display":"related-values","display_options":{"template":"{{directus_files_id.filename_download}}"},"readonly":false,"hidden":false,"sort":"11","width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"images","display":"related-values","display_options":{"template":"{{directus_files_id.filename_download}}"}}	\N	\N
547	635	directus_files	e6c66500-f365-432b-b15e-35b57caafd68	{"title":"Whats App Image 2025 08 13 at 21.22.52 1306fb39","filename_download":"WhatsApp Image 2025-08-13 at 21.22.52_1306fb39.jpg","type":"image/jpeg","storage":"cloudinary"}	{"title":"Whats App Image 2025 08 13 at 21.22.52 1306fb39","filename_download":"WhatsApp Image 2025-08-13 at 21.22.52_1306fb39.jpg","type":"image/jpeg","storage":"cloudinary"}	\N	\N
556	647	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:04:52.819Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":null,"type":"1","images":[]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-11T15:04:52.819Z"}	\N	\N
555	646	projects_files	1	{"id":"1","projects_id":null,"directus_files_id":"36af366b-87fb-4c43-b278-d14f36a032e2"}	{"projects_id":null}	556	\N
573	664	projects_files	9	{"id":"9","projects_id":null,"directus_files_id":"e59518c0-ac31-4f5c-a8fb-e3972821c5e9"}	{"projects_id":null}	574	\N
588	679	skills	14	{"status":"published","icon":"64fb2000-857f-4936-82f9-35c1ec187957","title":"Power BI"}	{"status":"published","icon":"64fb2000-857f-4936-82f9-35c1ec187957","title":"Power BI"}	\N	\N
589	680	directus_files	b2728846-3610-4198-95f5-24fbf46c53fe	{"title":"Simple Icons  Bun","filename_download":"simple-icons--bun.png","type":"image/png","storage":"cloudinary"}	{"title":"Simple Icons  Bun","filename_download":"simple-icons--bun.png","type":"image/png","storage":"cloudinary"}	\N	\N
590	681	skills	15	{"status":"published","title":"Bun","icon":"b2728846-3610-4198-95f5-24fbf46c53fe"}	{"status":"published","title":"Bun","icon":"b2728846-3610-4198-95f5-24fbf46c53fe"}	\N	\N
591	682	directus_files	ec9d495e-e6bc-49db-803c-a0f25d0229f0	{"title":"Simple Icons  Looker","filename_download":"simple-icons--looker.png","type":"image/png","storage":"cloudinary"}	{"title":"Simple Icons  Looker","filename_download":"simple-icons--looker.png","type":"image/png","storage":"cloudinary"}	\N	\N
592	683	skills	16	{"icon":"ec9d495e-e6bc-49db-803c-a0f25d0229f0","status":"published","title":"Looker"}	{"icon":"ec9d495e-e6bc-49db-803c-a0f25d0229f0","status":"published","title":"Looker"}	\N	\N
595	686	directus_files	133327f2-4105-4866-a7c9-74491c28d826	{"title":"Tabler  SQL","filename_download":"tabler--sql.png","type":"image/png","storage":"cloudinary"}	{"title":"Tabler  SQL","filename_download":"tabler--sql.png","type":"image/png","storage":"cloudinary"}	\N	\N
596	687	skills	18	{"status":"published","title":"SQL","icon":"133327f2-4105-4866-a7c9-74491c28d826"}	{"status":"published","title":"SQL","icon":"133327f2-4105-4866-a7c9-74491c28d826"}	\N	\N
601	692	directus_files	6382aa4d-ee74-497f-9325-a43d0b0de8a9	{"title":"Teenyicons  Docker Outline","filename_download":"teenyicons--docker-outline.png","type":"image/png","storage":"cloudinary"}	{"title":"Teenyicons  Docker Outline","filename_download":"teenyicons--docker-outline.png","type":"image/png","storage":"cloudinary"}	\N	\N
602	693	skills	21	{"icon":"6382aa4d-ee74-497f-9325-a43d0b0de8a9","status":"published","title":"Docker"}	{"icon":"6382aa4d-ee74-497f-9325-a43d0b0de8a9","status":"published","title":"Docker"}	\N	\N
605	696	projects	10	{"type":"1","status":"published","title":"RMS Company Profile Website","description":"Maintaining and developing new features of a company profile website for the FMCG Distributor company. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia."}	{"type":"1","status":"published","title":"RMS Company Profile Website","description":"Maintaining and developing new features of a company profile website for the FMCG Distributor company. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia."}	\N	\N
607	698	directus_files	cd26c3bb-27ec-4203-9847-2e5c251a2a52	{"title":"Screenshot 2025 09 12 085638","filename_download":"Screenshot 2025-09-12 085638.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 085638","filename_download":"Screenshot 2025-09-12 085638.png","type":"image/png","storage":"cloudinary"}	\N	\N
615	706	directus_files	b9d3f4cf-3f8a-45d0-a061-b82529624510	{"title":"Whats App Image 2025 09 12 at 09.10.17 3f16bd5b","filename_download":"WhatsApp Image 2025-09-12 at 09.10.17_3f16bd5b.jpg","type":"image/jpeg","storage":"cloudinary"}	{"title":"Whats App Image 2025 09 12 at 09.10.17 3f16bd5b","filename_download":"WhatsApp Image 2025-09-12 at 09.10.17_3f16bd5b.jpg","type":"image/jpeg","storage":"cloudinary"}	\N	\N
623	714	projects_files	16	{"projects_id":"5","directus_files_id":{"id":"a6e3ea76-cc7f-4309-95c8-eae897aa1cd3"}}	{"projects_id":"5","directus_files_id":{"id":"a6e3ea76-cc7f-4309-95c8-eae897aa1cd3"}}	625	\N
624	715	projects_files	17	{"projects_id":"5","directus_files_id":{"id":"61a7d17f-61e4-491f-9119-0975c3164ff0"}}	{"projects_id":"5","directus_files_id":{"id":"61a7d17f-61e4-491f-9119-0975c3164ff0"}}	625	\N
627	718	directus_files	5b7f3df1-bf8b-48df-b1da-4afa49cb7f4b	{"title":"Group 525","filename_download":"Group 525.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 525","filename_download":"Group 525.png","type":"image/png","storage":"cloudinary"}	\N	\N
529	614	directus_permissions	14	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
538	626	directus_access	75adc3f9-1874-4865-a8c9-bb09d6f79b7c	{"id":"75adc3f9-1874-4865-a8c9-bb09d6f79b7c","role":null,"user":null,"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","sort":"1"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
537	625	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	{"id":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","name":"$t:public_label","icon":"public","description":"$t:public_description","ip_access":null,"enforce_tfa":false,"admin_access":true,"app_access":false,"permissions":["1","10","11","13","14","2","3","5","7","8","9"],"users":["75adc3f9-1874-4865-a8c9-bb09d6f79b7c"],"roles":["75adc3f9-1874-4865-a8c9-bb09d6f79b7c"]}	{"admin_access":true}	538	\N
549	637	projects	3	{"id":"3","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:15:44.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-20T14:03:28.864Z","title":" PDP (Performance Development Plan) Web App for Scoring Employee","description":"This website was developed to make employee scoring for performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform.","detail":null,"type":"1","images":["2","3","4","5"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-20T14:03:28.864Z"}	\N	\N
548	636	projects_files	5	{"projects_id":"3","directus_files_id":{"id":"e6c66500-f365-432b-b15e-35b57caafd68"}}	{"projects_id":"3","directus_files_id":{"id":"e6c66500-f365-432b-b15e-35b57caafd68"}}	549	\N
558	649	directus_files	2e781692-8cea-4eb2-a8e5-58fc0cd76095	{"title":"Rms Hari Penting (1)","filename_download":"RMS Hari Penting (1).mp4","type":"video/mp4","storage":"cloudinary"}	{"title":"Rms Hari Penting (1)","filename_download":"RMS Hari Penting (1).mp4","type":"video/mp4","storage":"cloudinary"}	\N	\N
560	651	directus_files	e67f18a7-970f-498d-992f-17f8b6873deb	{"title":"Rms Hari Penting (1)","filename_download":"RMS Hari Penting (1).mp4","type":"video/mp4","storage":"cloudinary"}	{"title":"Rms Hari Penting (1)","filename_download":"RMS Hari Penting (1).mp4","type":"video/mp4","storage":"cloudinary"}	\N	\N
562	653	directus_files	bb279472-b39d-4e64-af00-87a62860614c	{"title":"Rms Hari Penting (4)","filename_download":"RMS Hari Penting (4).png","type":"image/png","storage":"cloudinary"}	{"title":"Rms Hari Penting (4)","filename_download":"RMS Hari Penting (4).png","type":"image/png","storage":"cloudinary"}	\N	\N
575	666	directus_files	908bb409-ebbf-48b1-a25d-cd9e6f30bea1	{"title":"Mingcute  GitHub Line","filename_download":"mingcute--github-line.png","type":"image/png","storage":"cloudinary"}	{"title":"Mingcute  GitHub Line","filename_download":"mingcute--github-line.png","type":"image/png","storage":"cloudinary"}	\N	\N
576	667	skills	8	{"status":"published","title":"GitHub","icon":"908bb409-ebbf-48b1-a25d-cd9e6f30bea1"}	{"status":"published","title":"GitHub","icon":"908bb409-ebbf-48b1-a25d-cd9e6f30bea1"}	\N	\N
579	670	directus_files	a062e730-f061-4cf0-be31-c06e0c47aa10	{"title":"Solar  Figma Broken","filename_download":"solar--figma-broken.png","type":"image/png","storage":"cloudinary"}	{"title":"Solar  Figma Broken","filename_download":"solar--figma-broken.png","type":"image/png","storage":"cloudinary"}	\N	\N
580	671	skills	10	{"status":"published","title":"Figma","icon":"a062e730-f061-4cf0-be31-c06e0c47aa10"}	{"status":"published","title":"Figma","icon":"a062e730-f061-4cf0-be31-c06e0c47aa10"}	\N	\N
593	684	directus_files	66f7e096-70ac-4bc3-afba-6fed73813cee	{"title":"Lineicons  MySQL","filename_download":"lineicons--mysql.png","type":"image/png","storage":"cloudinary"}	{"title":"Lineicons  MySQL","filename_download":"lineicons--mysql.png","type":"image/png","storage":"cloudinary"}	\N	\N
594	685	skills	17	{"status":"published","title":"MySQL","icon":"66f7e096-70ac-4bc3-afba-6fed73813cee"}	{"status":"published","title":"MySQL","icon":"66f7e096-70ac-4bc3-afba-6fed73813cee"}	\N	\N
599	690	directus_files	7eb8efc8-adbc-4c70-ba33-63fba2a0a935	{"title":"Icon Park Outline  Excel","filename_download":"icon-park-outline--excel.png","type":"image/png","storage":"cloudinary"}	{"title":"Icon Park Outline  Excel","filename_download":"icon-park-outline--excel.png","type":"image/png","storage":"cloudinary"}	\N	\N
600	691	skills	20	{"status":"published","title":"Ms. Excel","icon":"7eb8efc8-adbc-4c70-ba33-63fba2a0a935"}	{"status":"published","title":"Ms. Excel","icon":"7eb8efc8-adbc-4c70-ba33-63fba2a0a935"}	\N	\N
606	697	directus_files	9236a3ed-40c1-41b0-83a5-9e2ea3106514	{"title":"Screenshot 2025 09 12 085538","filename_download":"Screenshot 2025-09-12 085538.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 085538","filename_download":"Screenshot 2025-09-12 085538.png","type":"image/png","storage":"cloudinary"}	\N	\N
617	708	projects	7	{"id":"7","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-20T17:09:21.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:13:18.137Z","title":"Attendance Monitoring Dashboard","description":"Developed for supervise employees with flexible attendance ability","detail":null,"type":"2","images":["14"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:13:18.137Z"}	\N	\N
616	707	projects_files	14	{"projects_id":"7","directus_files_id":{"id":"b9d3f4cf-3f8a-45d0-a061-b82529624510"}}	{"projects_id":"7","directus_files_id":{"id":"b9d3f4cf-3f8a-45d0-a061-b82529624510"}}	617	\N
625	716	projects	5	{"id":"5","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:43.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:24:02.500Z","title":"Employee Job Scope Website","description":"This website was developed for mapping employee jobdesks by using RATSI system where every task of any position will have their own responsibility in charge, authorizer, supporters, and informed positions. ","detail":null,"type":"1","images":["15","16","17"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:24:02.500Z"}	\N	\N
622	713	projects_files	15	{"projects_id":"5","directus_files_id":{"id":"76b87f11-940b-4e7e-860b-9b833ab012de"}}	{"projects_id":"5","directus_files_id":{"id":"76b87f11-940b-4e7e-860b-9b833ab012de"}}	625	\N
628	719	directus_files	11e3fb3f-5625-4060-a99e-76e628694e0d	{"title":"Screenshot 2025 09 12 092527","filename_download":"Screenshot 2025-09-12 092527.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 092527","filename_download":"Screenshot 2025-09-12 092527.png","type":"image/png","storage":"cloudinary"}	\N	\N
530	616	main_contents	1	{"id":"1","status":"published","user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:02:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-07T23:50:52.598Z","about_desc":"Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. He’s graduated with a Bachelor of Information Systems and Diploma in English with a double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python","project_desc":"This is Project Description","education_desc":"This is Education Description","experience_desc":"Experience Description"}	{"about_desc":"Digitalization Specialist with nearly two years of experience in web development and data analytics, skilled in Laravel, Vue, Power BI, and automation tools. Proven track record in optimizing HR and operational workflows for large-scale organizations. He’s graduated with a Bachelor of Information Systems and Diploma in English with a double degree program.  Having main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic tools like power BI, Looker, App script, and data processing tools like Excel and a slight of Python","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-07T23:50:52.598Z"}	\N	\N
539	627	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	{"id":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","name":"$t:public_label","icon":"public","description":"$t:public_description","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"permissions":["1","10","11","13","14","2","3","5","7","8","9"],"users":["75adc3f9-1874-4865-a8c9-bb09d6f79b7c"],"roles":["75adc3f9-1874-4865-a8c9-bb09d6f79b7c"]}	{"admin_access":false}	\N	\N
559	650	directus_files	abbc5f31-bef7-48b7-8524-38fcd16832f8	{"title":"Rms Hari Penting","filename_download":"RMS Hari Penting.jpg","type":"image/jpeg","storage":"cloudinary"}	{"title":"Rms Hari Penting","filename_download":"RMS Hari Penting.jpg","type":"image/jpeg","storage":"cloudinary"}	\N	\N
577	668	directus_files	7c6ecc43-2d33-4658-8f3d-786ea359a14e	{"title":"Iconoir  Git","filename_download":"iconoir--git.png","type":"image/png","storage":"cloudinary"}	{"title":"Iconoir  Git","filename_download":"iconoir--git.png","type":"image/png","storage":"cloudinary"}	\N	\N
578	669	skills	9	{"status":"published","title":"Git","icon":"7c6ecc43-2d33-4658-8f3d-786ea359a14e"}	{"status":"published","title":"Git","icon":"7c6ecc43-2d33-4658-8f3d-786ea359a14e"}	\N	\N
585	676	directus_files	efaa7459-6942-4d8c-bd1c-cd42b1b5d9b7	{"title":"Bx  Spreadsheet","filename_download":"bx--spreadsheet.png","type":"image/png","storage":"cloudinary"}	{"title":"Bx  Spreadsheet","filename_download":"bx--spreadsheet.png","type":"image/png","storage":"cloudinary"}	\N	\N
597	688	directus_files	69c7d811-7545-49a3-a314-239ac7866fb1	{"title":"Teenyicons  Mongodb Outline","filename_download":"teenyicons--mongodb-outline.png","type":"image/png","storage":"cloudinary"}	{"title":"Teenyicons  Mongodb Outline","filename_download":"teenyicons--mongodb-outline.png","type":"image/png","storage":"cloudinary"}	\N	\N
598	689	skills	19	{"status":"published","title":"MongoDB","icon":"69c7d811-7545-49a3-a314-239ac7866fb1"}	{"status":"published","title":"MongoDB","icon":"69c7d811-7545-49a3-a314-239ac7866fb1"}	\N	\N
608	699	directus_files	bf531657-9d74-43b2-9be3-fb8d9f534e76	{"title":"Screenshot 2025 09 12 085705","filename_download":"Screenshot 2025-09-12 085705.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 085705","filename_download":"Screenshot 2025-09-12 085705.png","type":"image/png","storage":"cloudinary"}	\N	\N
614	705	projects	10	{"id":"10","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-09-12T02:01:05.812Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:03:46.613Z","title":"RMS Company Profile Website","description":"Maintaining and developing new features of a company profile website for the FMCG Distributor company. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.","detail":null,"type":"1","images":["10","11","12","13"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:03:46.613Z"}	\N	\N
610	701	projects_files	10	{"projects_id":"10","directus_files_id":{"id":"9236a3ed-40c1-41b0-83a5-9e2ea3106514"}}	{"projects_id":"10","directus_files_id":{"id":"9236a3ed-40c1-41b0-83a5-9e2ea3106514"}}	614	\N
611	702	projects_files	11	{"projects_id":"10","directus_files_id":{"id":"cd26c3bb-27ec-4203-9847-2e5c251a2a52"}}	{"projects_id":"10","directus_files_id":{"id":"cd26c3bb-27ec-4203-9847-2e5c251a2a52"}}	614	\N
612	703	projects_files	12	{"projects_id":"10","directus_files_id":{"id":"bf531657-9d74-43b2-9be3-fb8d9f534e76"}}	{"projects_id":"10","directus_files_id":{"id":"bf531657-9d74-43b2-9be3-fb8d9f534e76"}}	614	\N
613	704	projects_files	13	{"projects_id":"10","directus_files_id":{"id":"aee44348-e25e-4d33-b889-d32a61ac7b22"}}	{"projects_id":"10","directus_files_id":{"id":"aee44348-e25e-4d33-b889-d32a61ac7b22"}}	614	\N
618	709	projects	7	{"id":"7","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-20T17:09:21.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:17:42.711Z","title":"Attendance Monitoring Dashboard","description":"Developed for supervise employees with flexible attendance ability using Looker Studio and Google Sheet, and Google App Script","detail":null,"type":"2","images":["14"]}	{"description":"Developed for supervise employees with flexible attendance ability using Looker Studio and Google Sheet, and Google App Script","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:17:42.711Z"}	\N	\N
619	710	directus_files	76b87f11-940b-4e7e-860b-9b833ab012de	{"title":"Screenshot 2025 09 12 092056","filename_download":"Screenshot 2025-09-12 092056.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 092056","filename_download":"Screenshot 2025-09-12 092056.png","type":"image/png","storage":"cloudinary"}	\N	\N
620	711	directus_files	a6e3ea76-cc7f-4309-95c8-eae897aa1cd3	{"title":"Screenshot 2025 09 12 092133","filename_download":"Screenshot 2025-09-12 092133.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 092133","filename_download":"Screenshot 2025-09-12 092133.png","type":"image/png","storage":"cloudinary"}	\N	\N
531	617	experiences	2	{"id":"2","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-06-27T21:35:04.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-08T00:04:46.991Z","company":"PT Rukun Mitra Sejati","position":"Digital Effectiveness / Web Developer","date_start":"2023-09-18T12:00:00.000Z","date_end":null,"job_detail":"<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improve employee&rsquo;s Job desk mapping workflow by developing dedicated Web Apps</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Automated company&rsquo;s warehouse rent notification by developing google app script (Javascript based) program</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved HR data management by using advance formula and developed data dashboard using dashboard tools</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Streamlined repetitive administrative tasks using python scripts and/or google app script</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Produced the content of official company profile collaborated with videographer team</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Managed employees ID Card production from head office to branches employees</p>\\n</li>\\n</ul>","job_type":"1","sequence":"2"}	{"job_detail":"<ul>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improve employee&rsquo;s Job desk mapping workflow by developing dedicated Web Apps</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Automated company&rsquo;s warehouse rent notification by developing google app script (Javascript based) program</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Improved HR data management by using advance formula and developed data dashboard using dashboard tools</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Streamlined repetitive administrative tasks using python scripts and/or google app script</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Produced the content of official company profile collaborated with videographer team</p>\\n</li>\\n<li dir=\\"ltr\\" aria-level=\\"1\\">\\n<p dir=\\"ltr\\" role=\\"presentation\\">Managed employees ID Card production from head office to branches employees</p>\\n</li>\\n</ul>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-08-08T00:04:46.991Z"}	\N	\N
540	628	directus_files	a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55	{"title":"Screenshot 2025 07 29 090007","filename_download":"Screenshot 2025-07-29 090007.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 07 29 090007","filename_download":"Screenshot 2025-07-29 090007.png","type":"image/png","storage":"cloudinary"}	\N	\N
564	655	directus_files	e59518c0-ac31-4f5c-a8fb-e3972821c5e9	{"title":"0820","filename_download":"0820.mov","type":"video/quicktime","storage":"cloudinary"}	{"title":"0820","filename_download":"0820.mov","type":"video/quicktime","storage":"cloudinary"}	\N	\N
581	672	directus_files	dc9db38f-d94d-4ee6-8db3-07fd4f729ad0	{"title":"Lineicons  Postman","filename_download":"lineicons--postman.png","type":"image/png","storage":"cloudinary"}	{"title":"Lineicons  Postman","filename_download":"lineicons--postman.png","type":"image/png","storage":"cloudinary"}	\N	\N
582	673	skills	11	{"status":"published","icon":"dc9db38f-d94d-4ee6-8db3-07fd4f729ad0","title":"Postman"}	{"status":"published","icon":"dc9db38f-d94d-4ee6-8db3-07fd4f729ad0","title":"Postman"}	\N	\N
603	694	directus_files	114e369d-06b3-41e9-b544-e6437a6349e5	{"title":"Ri  Nodejs Fill","filename_download":"ri--nodejs-fill.png","type":"image/png","storage":"cloudinary"}	{"title":"Ri  Nodejs Fill","filename_download":"ri--nodejs-fill.png","type":"image/png","storage":"cloudinary"}	\N	\N
604	695	skills	22	{"status":"published","icon":"114e369d-06b3-41e9-b544-e6437a6349e5","title":"Node.js"}	{"status":"published","icon":"114e369d-06b3-41e9-b544-e6437a6349e5","title":"Node.js"}	\N	\N
609	700	directus_files	aee44348-e25e-4d33-b889-d32a61ac7b22	{"title":"Screenshot 2025 09 12 085601","filename_download":"Screenshot 2025-09-12 085601.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 085601","filename_download":"Screenshot 2025-09-12 085601.png","type":"image/png","storage":"cloudinary"}	\N	\N
621	712	directus_files	61a7d17f-61e4-491f-9119-0975c3164ff0	{"title":"Screenshot 2025 09 12 092155","filename_download":"Screenshot 2025-09-12 092155.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 092155","filename_download":"Screenshot 2025-09-12 092155.png","type":"image/png","storage":"cloudinary"}	\N	\N
626	717	directus_files	90dd5416-6216-4e07-b513-792c3ac14543	{"title":"Group 526","filename_download":"Group 526.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 526","filename_download":"Group 526.png","type":"image/png","storage":"cloudinary"}	\N	\N
629	720	directus_files	f80e1f7d-f5d7-4849-afa3-f53168898a70	{"title":"Screenshot 2025 09 12 092657","filename_download":"Screenshot 2025-09-12 092657.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 12 092657","filename_download":"Screenshot 2025-09-12 092657.png","type":"image/png","storage":"cloudinary"}	\N	\N
634	725	projects	8	{"id":"8","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-08-12T03:59:08.951Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:35:35.669Z","title":"Automatic Warehouse Rent Reminder","description":"Developed to help field team (Operation & regional managers) with more than 100 branches to manage warehouse rent management (payment, movement, and extend) using Google App Script ","detail":null,"type":"2","images":["18","19","20","21"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-12T02:35:35.669Z"}	\N	\N
630	721	projects_files	18	{"projects_id":"8","directus_files_id":{"id":"90dd5416-6216-4e07-b513-792c3ac14543"}}	{"projects_id":"8","directus_files_id":{"id":"90dd5416-6216-4e07-b513-792c3ac14543"}}	634	\N
631	722	projects_files	19	{"projects_id":"8","directus_files_id":{"id":"5b7f3df1-bf8b-48df-b1da-4afa49cb7f4b"}}	{"projects_id":"8","directus_files_id":{"id":"5b7f3df1-bf8b-48df-b1da-4afa49cb7f4b"}}	634	\N
632	723	projects_files	20	{"projects_id":"8","directus_files_id":{"id":"11e3fb3f-5625-4060-a99e-76e628694e0d"}}	{"projects_id":"8","directus_files_id":{"id":"11e3fb3f-5625-4060-a99e-76e628694e0d"}}	634	\N
633	724	projects_files	21	{"projects_id":"8","directus_files_id":{"id":"f80e1f7d-f5d7-4849-afa3-f53168898a70"}}	{"projects_id":"8","directus_files_id":{"id":"f80e1f7d-f5d7-4849-afa3-f53168898a70"}}	634	\N
635	727	directus_files	6886e984-68de-4348-9bae-dda44b898d44	{"title":"Group 526 (1)","filename_download":"Group 526 (1).png","type":"image/png","storage":"cloudinary"}	{"title":"Group 526 (1)","filename_download":"Group 526 (1).png","type":"image/png","storage":"cloudinary"}	\N	\N
636	728	directus_files	70073d8e-ccea-47d3-8f45-a3c1c9c657fc	{"title":"Group 525 (1)","filename_download":"Group 525 (1).png","type":"image/png","storage":"cloudinary"}	{"title":"Group 525 (1)","filename_download":"Group 525 (1).png","type":"image/png","storage":"cloudinary"}	\N	\N
637	729	directus_files	68727a44-9735-472f-89e3-d9f570959082	{"title":"Group 528","filename_download":"Group 528.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 528","filename_download":"Group 528.png","type":"image/png","storage":"cloudinary"}	\N	\N
641	733	projects	4	{"id":"4","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-13T03:41:50.898Z","title":"360 Degree Employee Scoring Dashboard (Manager Scoring)","description":"This dashboard is made for monitoring employee scoring with 360 degree. In this case, only managers are evaluated by their team. ","detail":null,"type":"2","images":["22","23","24"]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-13T03:41:50.898Z"}	\N	\N
638	730	projects_files	22	{"projects_id":"4","directus_files_id":{"id":"6886e984-68de-4348-9bae-dda44b898d44"}}	{"projects_id":"4","directus_files_id":{"id":"6886e984-68de-4348-9bae-dda44b898d44"}}	641	\N
639	731	projects_files	23	{"projects_id":"4","directus_files_id":{"id":"70073d8e-ccea-47d3-8f45-a3c1c9c657fc"}}	{"projects_id":"4","directus_files_id":{"id":"70073d8e-ccea-47d3-8f45-a3c1c9c657fc"}}	641	\N
640	732	projects_files	24	{"projects_id":"4","directus_files_id":{"id":"68727a44-9735-472f-89e3-d9f570959082"}}	{"projects_id":"4","directus_files_id":{"id":"68727a44-9735-472f-89e3-d9f570959082"}}	641	\N
642	734	projects	11	{"title":"Official Company Profile of PT RMS","type":"3","description":"test"}	{"title":"Official Company Profile of PT RMS","type":"3","description":"test"}	\N	\N
643	736	directus_fields	145	{"sort":"131","interface":"input","special":null,"options":{"placeholder":"Enter Repo Link","iconLeft":"github"},"collection":"projects","field":"repo_Link"}	{"sort":"131","interface":"input","special":null,"options":{"placeholder":"Enter Repo Link","iconLeft":"github"},"collection":"projects","field":"repo_Link"}	\N	\N
644	737	directus_fields	146	{"sort":"1311","interface":"input","special":null,"options":{"placeholder":"Enter Url"},"collection":"projects","field":"Url"}	{"sort":"1311","interface":"input","special":null,"options":{"placeholder":"Enter Url"},"collection":"projects","field":"Url"}	\N	\N
645	738	directus_fields	147	{"sort":"13111","interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}","enableLink":true},"collection":"projects","field":"skills_used"}	{"sort":"13111","interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{title}}","enableLink":true},"collection":"projects","field":"skills_used"}	\N	\N
646	740	directus_fields	148	{"sort":"13111","interface":"list-m2m","special":["m2m"],"options":{"enableLink":true},"display":null,"collection":"projects","field":"skills_used"}	{"sort":"13111","interface":"list-m2m","special":["m2m"],"options":{"enableLink":true},"display":null,"collection":"projects","field":"skills_used"}	\N	\N
647	741	directus_fields	149	{"sort":1,"hidden":true,"field":"id","collection":"projects_skills"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_skills"}	\N	\N
648	742	directus_collections	projects_skills	{"hidden":true,"icon":"import_export","collection":"projects_skills"}	{"hidden":true,"icon":"import_export","collection":"projects_skills"}	\N	\N
649	743	directus_fields	150	{"sort":"11","hidden":true,"collection":"projects_skills","field":"projects_id"}	{"sort":"11","hidden":true,"collection":"projects_skills","field":"projects_id"}	\N	\N
650	744	directus_fields	151	{"sort":"111","hidden":true,"collection":"projects_skills","field":"skills_id"}	{"sort":"111","hidden":true,"collection":"projects_skills","field":"skills_id"}	\N	\N
656	750	directus_fields	148	{"id":"148","collection":"projects","field":"skills_used","special":["m2m"],"interface":"list-m2m","options":{"enableLink":true,"template":"{{skills_id.title}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":"13111","width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"skills_used","options":{"enableLink":true,"template":"{{skills_id.title}}"}}	\N	\N
655	749	projects	11	{"id":"11","status":"draft","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-09-13T03:45:46.482Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-23T14:18:18.762Z","title":"Official Company Profile of PT RMS","description":"test","detail":null,"type":"3","repo_Link":null,"Url":null,"images":[],"skills_used":[1,2,3,4]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-23T14:18:18.762Z"}	\N	\N
651	745	projects_skills	1	{"projects_id":"11","skills_id":{"id":"8"}}	{"projects_id":"11","skills_id":{"id":"8"}}	655	\N
653	747	projects_skills	3	{"projects_id":"11","skills_id":{"id":"7"}}	{"projects_id":"11","skills_id":{"id":"7"}}	655	\N
654	748	projects_skills	4	{"projects_id":"11","skills_id":{"id":"9"}}	{"projects_id":"11","skills_id":{"id":"9"}}	655	\N
657	751	directus_fields	152	{"sort":"151","interface":"list-m2m","special":["m2m"],"options":{"enableLink":true},"display":null,"collection":"experiences","field":"skills_used"}	{"sort":"151","interface":"list-m2m","special":["m2m"],"options":{"enableLink":true},"display":null,"collection":"experiences","field":"skills_used"}	\N	\N
658	752	directus_fields	153	{"sort":1,"hidden":true,"field":"id","collection":"experiences_skills"}	{"sort":1,"hidden":true,"field":"id","collection":"experiences_skills"}	\N	\N
659	753	directus_collections	experiences_skills	{"hidden":true,"icon":"import_export","collection":"experiences_skills"}	{"hidden":true,"icon":"import_export","collection":"experiences_skills"}	\N	\N
660	754	directus_fields	154	{"sort":"11","hidden":true,"collection":"experiences_skills","field":"experiences_id"}	{"sort":"11","hidden":true,"collection":"experiences_skills","field":"experiences_id"}	\N	\N
661	755	directus_fields	155	{"sort":"111","hidden":true,"collection":"experiences_skills","field":"skills_id"}	{"sort":"111","hidden":true,"collection":"experiences_skills","field":"skills_id"}	\N	\N
662	756	directus_fields	152	{"id":"152","collection":"experiences","field":"skills_used","special":["m2m"],"interface":"list-m2m","options":{"enableLink":true,"template":"{{skills_id.title}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":"151","width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"experiences","field":"skills_used","options":{"enableLink":true,"template":"{{skills_id.title}}"}}	\N	\N
663	757	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:44:51.851Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":"<p style=\\"language: en-US; line-height: normal; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt 0in;\\"><span style=\\"font-size: 20.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #a5cf27; mso-color-index: 5; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent2; mso-style-textfill-fill-color: #A5CF27; mso-style-textfill-fill-alpha: 100.0%;\\">Front-end:</span></p>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 12.0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Platform: </span><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #fcc642; mso-color-index: 16; text-transform: none; language: en-US; font-weight: bold; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: light2; mso-style-textfill-fill-color: #FCC642; mso-style-textfill-fill-alpha: 100.0%;\\">Vercel</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Platform hosting hanya melalui github</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Luaran: Link web dengan tampilan</span></div>\\n<p style=\\"language: en-US; line-height: normal; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 12.0pt 0in 0pt 0in;\\"><span style=\\"font-size: 20.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #dba0db; mso-color-index: 4; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent1; mso-style-textfill-fill-color: #DBA0DB; mso-style-textfill-fill-alpha: 100.0%;\\">Back-end:</span></p>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 12.0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Platform: </span><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #fcc642; mso-color-index: 16; text-transform: none; language: en-US; font-weight: bold; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: light2; mso-style-textfill-fill-color: #FCC642; mso-style-textfill-fill-alpha: 100.0%;\\">AWS Elastic Beanstalk</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Layanan untuk menjalankan aplikasi web dengan mudah</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Luaran: RESTful API sebagai dasar dari Front-end</span></div>","type":"1","repo_Link":null,"Url":null,"images":[],"skills_used":[]}	{"detail":"<p style=\\"language: en-US; line-height: normal; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt 0in;\\"><span style=\\"font-size: 20.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #a5cf27; mso-color-index: 5; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent2; mso-style-textfill-fill-color: #A5CF27; mso-style-textfill-fill-alpha: 100.0%;\\">Front-end:</span></p>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 12.0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Platform: </span><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #fcc642; mso-color-index: 16; text-transform: none; language: en-US; font-weight: bold; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: light2; mso-style-textfill-fill-color: #FCC642; mso-style-textfill-fill-alpha: 100.0%;\\">Vercel</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Platform hosting hanya melalui github</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Luaran: Link web dengan tampilan</span></div>\\n<p style=\\"language: en-US; line-height: normal; text-indent: 0in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 12.0pt 0in 0pt 0in;\\"><span style=\\"font-size: 20.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #dba0db; mso-color-index: 4; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent1; mso-style-textfill-fill-color: #DBA0DB; mso-style-textfill-fill-alpha: 100.0%;\\">Back-end:</span></p>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 12.0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Platform: </span><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #fcc642; mso-color-index: 16; text-transform: none; language: en-US; font-weight: bold; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: light2; mso-style-textfill-fill-color: #FCC642; mso-style-textfill-fill-alpha: 100.0%;\\">AWS Elastic Beanstalk</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Layanan untuk menjalankan aplikasi web dengan mudah</span></div>\\n<div class=\\"O0\\" style=\\"language: en-US; line-height: normal; text-indent: -.35in; text-align: left; direction: ltr; unicode-bidi: embed; margin: 0pt 0in 0pt .5in;\\"><span style=\\"font-size: 14.0pt; font-family: 'Fira Code'; mso-ascii-font-family: 'Fira Code'; mso-fareast-font-family: 'Fira Code'; mso-bidi-font-family: 'Fira Code'; font-variant: normal; color: #e7e7e7; mso-color-index: 6; text-transform: none; language: en-US; font-weight: normal; font-style: normal; mso-style-textfill-type: solid; mso-style-textfill-fill-themecolor: accent3; mso-style-textfill-fill-color: #E7E7E7; mso-style-textfill-fill-alpha: 100.0%;\\">Luaran: RESTful API sebagai dasar dari Front-end</span></div>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:44:51.851Z"}	\N	\N
664	758	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:47:29.421Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":"<p>Front-end:</p>\\n<ul>\\n<li>Hosting Platform: Vercel</li>\\n<li>Repository: Github</li>\\n</ul>\\n<p>Back-end (REST API):</p>\\n<ul>\\n<li>Platform: AWS Elastic Beanstalk</li>\\n<li>Repository: Github</li>\\n</ul>","type":"1","repo_Link":null,"Url":null,"images":[],"skills_used":[]}	{"detail":"<p>Front-end:</p>\\n<ul>\\n<li>Hosting Platform: Vercel</li>\\n<li>Repository: Github</li>\\n</ul>\\n<p>Back-end (REST API):</p>\\n<ul>\\n<li>Platform: AWS Elastic Beanstalk</li>\\n<li>Repository: Github</li>\\n</ul>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:47:29.421Z"}	\N	\N
665	759	directus_files	1cf2fb7b-3769-44b2-ae07-a994962832ef	{"title":"Picture1","filename_download":"Picture1.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture1","filename_download":"Picture1.png","type":"image/png","storage":"cloudinary"}	\N	\N
666	760	directus_files	820e72f9-7f20-4cbb-9987-7f13fa3bbce0	{"title":"Picture3","filename_download":"Picture3.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture3","filename_download":"Picture3.png","type":"image/png","storage":"cloudinary"}	\N	\N
667	761	directus_files	b2082e6b-fe28-4efa-a4ff-dde9500ec387	{"title":"Picture7","filename_download":"Picture7.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture7","filename_download":"Picture7.png","type":"image/png","storage":"cloudinary"}	\N	\N
668	762	directus_files	f92c9844-67d7-41c5-9a65-1e0b0f00323f	{"title":"Picture2","filename_download":"Picture2.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture2","filename_download":"Picture2.png","type":"image/png","storage":"cloudinary"}	\N	\N
669	763	directus_files	6f0eb1fd-3211-469e-8fab-93e1aa3e1fca	{"title":"Picture4","filename_download":"Picture4.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture4","filename_download":"Picture4.png","type":"image/png","storage":"cloudinary"}	\N	\N
670	764	directus_files	75d5253c-8e5f-450c-8c95-01dc67b3d263	{"title":"Picture5","filename_download":"Picture5.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture5","filename_download":"Picture5.png","type":"image/png","storage":"cloudinary"}	\N	\N
671	765	directus_files	b10f20fe-f1dc-4c82-8215-9e1879003e2e	{"title":"Picture6","filename_download":"Picture6.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture6","filename_download":"Picture6.png","type":"image/png","storage":"cloudinary"}	\N	\N
672	766	directus_files	55e1011d-e96a-4695-9336-651c71c831d8	{"title":"Picture8","filename_download":"Picture8.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture8","filename_download":"Picture8.png","type":"image/png","storage":"cloudinary"}	\N	\N
673	767	directus_files	c509123f-2c9d-4075-97df-011667a4b2d2	{"title":"Picture9","filename_download":"Picture9.png","type":"image/png","storage":"cloudinary"}	{"title":"Picture9","filename_download":"Picture9.png","type":"image/png","storage":"cloudinary"}	\N	\N
683	777	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:49:07.910Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":"<p>Front-end (Vue.js + Tailwind):</p>\\n<ul>\\n<li>Hosting Platform: Vercel</li>\\n<li>Repository: Github</li>\\n</ul>\\n<p>Back-end (REST API, Express.js):</p>\\n<ul>\\n<li>Platform: AWS Elastic Beanstalk</li>\\n<li>Repository: Github</li>\\n</ul>","type":"1","repo_Link":null,"Url":null,"images":["25","26","27","28","29","30","31","32","33"],"skills_used":[]}	{"detail":"<p>Front-end (Vue.js + Tailwind):</p>\\n<ul>\\n<li>Hosting Platform: Vercel</li>\\n<li>Repository: Github</li>\\n</ul>\\n<p>Back-end (REST API, Express.js):</p>\\n<ul>\\n<li>Platform: AWS Elastic Beanstalk</li>\\n<li>Repository: Github</li>\\n</ul>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:49:07.910Z"}	\N	\N
674	768	projects_files	25	{"projects_id":"1","directus_files_id":{"id":"1cf2fb7b-3769-44b2-ae07-a994962832ef"}}	{"projects_id":"1","directus_files_id":{"id":"1cf2fb7b-3769-44b2-ae07-a994962832ef"}}	683	\N
675	769	projects_files	26	{"projects_id":"1","directus_files_id":{"id":"f92c9844-67d7-41c5-9a65-1e0b0f00323f"}}	{"projects_id":"1","directus_files_id":{"id":"f92c9844-67d7-41c5-9a65-1e0b0f00323f"}}	683	\N
676	770	projects_files	27	{"projects_id":"1","directus_files_id":{"id":"820e72f9-7f20-4cbb-9987-7f13fa3bbce0"}}	{"projects_id":"1","directus_files_id":{"id":"820e72f9-7f20-4cbb-9987-7f13fa3bbce0"}}	683	\N
677	771	projects_files	28	{"projects_id":"1","directus_files_id":{"id":"6f0eb1fd-3211-469e-8fab-93e1aa3e1fca"}}	{"projects_id":"1","directus_files_id":{"id":"6f0eb1fd-3211-469e-8fab-93e1aa3e1fca"}}	683	\N
678	772	projects_files	29	{"projects_id":"1","directus_files_id":{"id":"75d5253c-8e5f-450c-8c95-01dc67b3d263"}}	{"projects_id":"1","directus_files_id":{"id":"75d5253c-8e5f-450c-8c95-01dc67b3d263"}}	683	\N
679	773	projects_files	30	{"projects_id":"1","directus_files_id":{"id":"b10f20fe-f1dc-4c82-8215-9e1879003e2e"}}	{"projects_id":"1","directus_files_id":{"id":"b10f20fe-f1dc-4c82-8215-9e1879003e2e"}}	683	\N
680	774	projects_files	31	{"projects_id":"1","directus_files_id":{"id":"b2082e6b-fe28-4efa-a4ff-dde9500ec387"}}	{"projects_id":"1","directus_files_id":{"id":"b2082e6b-fe28-4efa-a4ff-dde9500ec387"}}	683	\N
681	775	projects_files	32	{"projects_id":"1","directus_files_id":{"id":"55e1011d-e96a-4695-9336-651c71c831d8"}}	{"projects_id":"1","directus_files_id":{"id":"55e1011d-e96a-4695-9336-651c71c831d8"}}	683	\N
682	776	projects_files	33	{"projects_id":"1","directus_files_id":{"id":"c509123f-2c9d-4075-97df-011667a4b2d2"}}	{"projects_id":"1","directus_files_id":{"id":"c509123f-2c9d-4075-97df-011667a4b2d2"}}	683	\N
684	778	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:50:49.891Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":"<p><strong>Front-end</strong> (Vue.js + Tailwind):</p>\\n<ul>\\n<li>Hosting Platform: Vercel</li>\\n<li>Repository: Github</li>\\n</ul>\\n<p><strong>Back-end</strong> (REST API, Express.js):</p>\\n<ul>\\n<li>Platform: AWS Elastic Beanstalk</li>\\n<li>Repository: Github</li>\\n</ul>","type":"1","repo_Link":null,"Url":null,"images":["25","26","27","28","29","30","31","32","33"],"skills_used":[]}	{"detail":"<p><strong>Front-end</strong> (Vue.js + Tailwind):</p>\\n<ul>\\n<li>Hosting Platform: Vercel</li>\\n<li>Repository: Github</li>\\n</ul>\\n<p><strong>Back-end</strong> (REST API, Express.js):</p>\\n<ul>\\n<li>Platform: AWS Elastic Beanstalk</li>\\n<li>Repository: Github</li>\\n</ul>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:50:49.891Z"}	\N	\N
685	779	projects	2	{"id":"2","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:42:29.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:51:43.984Z","title":"Think Action REST API","description":"One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts","detail":"<p><em><br><br></em></p>","type":"1","repo_Link":null,"Url":null,"images":[],"skills_used":[]}	{"type":"1","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:51:43.984Z"}	\N	\N
686	780	directus_files	9220109c-9f88-41b2-9ebf-ee5404242c39	{"title":"Image 134","filename_download":"image 134.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 134","filename_download":"image 134.png","type":"image/png","storage":"cloudinary"}	\N	\N
687	781	directus_files	66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a	{"title":"Image 133","filename_download":"image 133.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 133","filename_download":"image 133.png","type":"image/png","storage":"cloudinary"}	\N	\N
688	782	directus_files	d0044ddf-3cf7-43cb-bdb8-0a3f413134a5	{"title":"Image 136","filename_download":"image 136.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 136","filename_download":"image 136.png","type":"image/png","storage":"cloudinary"}	\N	\N
689	783	directus_files	8936ab46-9022-4823-8ac5-728d4de7813b	{"title":"Image 135","filename_download":"image 135.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 135","filename_download":"image 135.png","type":"image/png","storage":"cloudinary"}	\N	\N
690	784	directus_files	dc50a198-a095-49e9-b3de-d5682a3fb6ca	{"title":"Image 137","filename_download":"image 137.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 137","filename_download":"image 137.png","type":"image/png","storage":"cloudinary"}	\N	\N
706	800	directus_files	75d60b48-6440-4a4a-932a-b53cbcf184bb	{"title":"Image 136","filename_download":"image 136.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 136","filename_download":"image 136.png","type":"image/png","storage":"cloudinary"}	\N	\N
696	790	projects	6	{"id":"6","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:17:11.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:57:23.649Z","title":" RDA Company Website","description":"Developed a company profile website for the FMCG distributor company with more than 15 branches. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia. Providing detailed information about product sector, principals, and distribution network. Integrated with interactive maps for branch locator. Mobile-first approach for seamless access on various devices. SEO optimized for better online visibility. Implementing secure contact form for inquiries.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["34","35","36","37","38"],"skills_used":[]}	{"description":"Developed a company profile website for the FMCG distributor company with more than 15 branches. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia. Providing detailed information about product sector, principals, and distribution network. Integrated with interactive maps for branch locator. Mobile-first approach for seamless access on various devices. SEO optimized for better online visibility. Implementing secure contact form for inquiries.","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T02:57:23.649Z"}	\N	\N
691	785	projects_files	34	{"projects_id":"6","directus_files_id":{"id":"9220109c-9f88-41b2-9ebf-ee5404242c39"}}	{"projects_id":"6","directus_files_id":{"id":"9220109c-9f88-41b2-9ebf-ee5404242c39"}}	696	\N
692	786	projects_files	35	{"projects_id":"6","directus_files_id":{"id":"66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a"}}	{"projects_id":"6","directus_files_id":{"id":"66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a"}}	696	\N
693	787	projects_files	36	{"projects_id":"6","directus_files_id":{"id":"d0044ddf-3cf7-43cb-bdb8-0a3f413134a5"}}	{"projects_id":"6","directus_files_id":{"id":"d0044ddf-3cf7-43cb-bdb8-0a3f413134a5"}}	696	\N
694	788	projects_files	37	{"projects_id":"6","directus_files_id":{"id":"8936ab46-9022-4823-8ac5-728d4de7813b"}}	{"projects_id":"6","directus_files_id":{"id":"8936ab46-9022-4823-8ac5-728d4de7813b"}}	696	\N
695	789	projects_files	38	{"projects_id":"6","directus_files_id":{"id":"dc50a198-a095-49e9-b3de-d5682a3fb6ca"}}	{"projects_id":"6","directus_files_id":{"id":"dc50a198-a095-49e9-b3de-d5682a3fb6ca"}}	696	\N
702	796	projects	6	{"id":"6","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:17:11.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:01:10.966Z","title":" RDA Company Website","description":"Developed a company profile website for the FMCG distributor company with more than 15 branches. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia. Providing detailed information about product sector, principals, and distribution network. Integrated with interactive maps for branch locator. Mobile-first approach for seamless access on various devices. SEO optimized for better online visibility. Implementing secure contact form for inquiries.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":[],"skills_used":[]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:01:10.966Z"}	\N	\N
697	791	projects_files	34	{"id":"34","projects_id":null,"directus_files_id":"9220109c-9f88-41b2-9ebf-ee5404242c39"}	{"projects_id":null}	702	\N
698	792	projects_files	35	{"id":"35","projects_id":null,"directus_files_id":"66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a"}	{"projects_id":null}	702	\N
699	793	projects_files	36	{"id":"36","projects_id":null,"directus_files_id":"d0044ddf-3cf7-43cb-bdb8-0a3f413134a5"}	{"projects_id":null}	702	\N
700	794	projects_files	37	{"id":"37","projects_id":null,"directus_files_id":"8936ab46-9022-4823-8ac5-728d4de7813b"}	{"projects_id":null}	702	\N
701	795	projects_files	38	{"id":"38","projects_id":null,"directus_files_id":"dc50a198-a095-49e9-b3de-d5682a3fb6ca"}	{"projects_id":null}	702	\N
703	797	directus_files	5d8052af-cc38-42ea-a128-e0094a3a4fac	{"title":"Image 133","filename_download":"image 133.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 133","filename_download":"image 133.png","type":"image/png","storage":"cloudinary"}	\N	\N
704	798	directus_files	9d40c598-32a6-432b-87b5-7d413339057f	{"title":"Screenshot 2025 09 25 095935","filename_download":"Screenshot 2025-09-25 095935.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 25 095935","filename_download":"Screenshot 2025-09-25 095935.png","type":"image/png","storage":"cloudinary"}	\N	\N
705	799	directus_files	008a7468-4d4d-49d1-9e6b-8859a853a63a	{"title":"Screenshot 2025 09 25 100036","filename_download":"Screenshot 2025-09-25 100036.png","type":"image/png","storage":"cloudinary"}	{"title":"Screenshot 2025 09 25 100036","filename_download":"Screenshot 2025-09-25 100036.png","type":"image/png","storage":"cloudinary"}	\N	\N
707	801	directus_files	f8905818-2843-4a3a-aef7-59bc22cac963	{"title":"Image 134","filename_download":"image 134.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 134","filename_download":"image 134.png","type":"image/png","storage":"cloudinary"}	\N	\N
708	802	directus_files	94d8529c-eb6a-43ae-bfe6-483a1afb7a20	{"title":"Image 135","filename_download":"image 135.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 135","filename_download":"image 135.png","type":"image/png","storage":"cloudinary"}	\N	\N
709	803	directus_files	85b47526-2052-445c-a7bf-f316f30f3035	{"title":"Image 137","filename_download":"image 137.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 137","filename_download":"image 137.png","type":"image/png","storage":"cloudinary"}	\N	\N
710	804	directus_files	d1fbaed4-1e6f-492d-9baf-9ef64a2ec15b	{"title":"Image 136","filename_download":"image 136.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 136","filename_download":"image 136.png","type":"image/png","storage":"cloudinary"}	\N	\N
719	813	projects	6	{"id":"6","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:17:11.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:03:09.659Z","title":" RDA Company Website","description":"Developed a company profile website for the FMCG distributor company with more than 15 branches. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia. Providing detailed information about product sector, principals, and distribution network. Integrated with interactive maps for branch locator. Mobile-first approach for seamless access on various devices. SEO optimized for better online visibility. Implementing secure contact form for inquiries.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["39","40","41","42","43","44","45","46"],"skills_used":[]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:03:09.659Z"}	\N	\N
711	805	projects_files	39	{"projects_id":"6","directus_files_id":{"id":"5d8052af-cc38-42ea-a128-e0094a3a4fac"}}	{"projects_id":"6","directus_files_id":{"id":"5d8052af-cc38-42ea-a128-e0094a3a4fac"}}	719	\N
712	806	projects_files	40	{"projects_id":"6","directus_files_id":{"id":"9d40c598-32a6-432b-87b5-7d413339057f"}}	{"projects_id":"6","directus_files_id":{"id":"9d40c598-32a6-432b-87b5-7d413339057f"}}	719	\N
713	807	projects_files	41	{"projects_id":"6","directus_files_id":{"id":"008a7468-4d4d-49d1-9e6b-8859a853a63a"}}	{"projects_id":"6","directus_files_id":{"id":"008a7468-4d4d-49d1-9e6b-8859a853a63a"}}	719	\N
714	808	projects_files	42	{"projects_id":"6","directus_files_id":{"id":"75d60b48-6440-4a4a-932a-b53cbcf184bb"}}	{"projects_id":"6","directus_files_id":{"id":"75d60b48-6440-4a4a-932a-b53cbcf184bb"}}	719	\N
715	809	projects_files	43	{"projects_id":"6","directus_files_id":{"id":"f8905818-2843-4a3a-aef7-59bc22cac963"}}	{"projects_id":"6","directus_files_id":{"id":"f8905818-2843-4a3a-aef7-59bc22cac963"}}	719	\N
716	810	projects_files	44	{"projects_id":"6","directus_files_id":{"id":"94d8529c-eb6a-43ae-bfe6-483a1afb7a20"}}	{"projects_id":"6","directus_files_id":{"id":"94d8529c-eb6a-43ae-bfe6-483a1afb7a20"}}	719	\N
717	811	projects_files	45	{"projects_id":"6","directus_files_id":{"id":"d1fbaed4-1e6f-492d-9baf-9ef64a2ec15b"}}	{"projects_id":"6","directus_files_id":{"id":"d1fbaed4-1e6f-492d-9baf-9ef64a2ec15b"}}	719	\N
718	812	projects_files	46	{"projects_id":"6","directus_files_id":{"id":"85b47526-2052-445c-a7bf-f316f30f3035"}}	{"projects_id":"6","directus_files_id":{"id":"85b47526-2052-445c-a7bf-f316f30f3035"}}	719	\N
720	814	projects	10	{"id":"10","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-09-12T02:01:05.812Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:06:19.075Z","title":"RMS Company Profile Website","description":"Maintaining and developing new features of a company profile website for the FMCG Distributor company with more than 100 branches across Indonesia. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.Focus on improving user experience and engagement through interactive elements and seamless navigation. Implement robust SEO strategies to enhance online visibility and attract potential clients and partners. Ensure cross-browser compatibility and optimize website performance for faster loading times.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["10","11","12","13"],"skills_used":[]}	{"description":"Maintaining and developing new features of a company profile website for the FMCG Distributor company with more than 100 branches across Indonesia. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.Focus on improving user experience and engagement through interactive elements and seamless navigation. Implement robust SEO strategies to enhance online visibility and attract potential clients and partners. Ensure cross-browser compatibility and optimize website performance for faster loading times.","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:06:19.075Z"}	\N	\N
734	828	directus_files	cf3b2f9b-441a-4d93-88b3-c23f40d0f529	{"title":"Group 537","filename_download":"Group 537.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 537","filename_download":"Group 537.png","type":"image/png","storage":"cloudinary"}	\N	\N
740	834	directus_files	d33b2a90-dfa1-48e5-996a-058c542090c5	{"title":"Group 542","filename_download":"Group 542.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 542","filename_download":"Group 542.png","type":"image/png","storage":"cloudinary"}	\N	\N
745	839	projects_files	49	{"projects_id":"3","directus_files_id":{"id":"1cc182f4-1afe-4937-869b-f17be5cde070"}}	{"projects_id":"3","directus_files_id":{"id":"1cc182f4-1afe-4937-869b-f17be5cde070"}}	752	\N
746	840	projects_files	50	{"projects_id":"3","directus_files_id":{"id":"be68b2f9-89c6-4b8e-86ed-db5243fd8400"}}	{"projects_id":"3","directus_files_id":{"id":"be68b2f9-89c6-4b8e-86ed-db5243fd8400"}}	752	\N
747	841	projects_files	51	{"projects_id":"3","directus_files_id":{"id":"04323344-2faf-4a30-ad5f-97a18c73c831"}}	{"projects_id":"3","directus_files_id":{"id":"04323344-2faf-4a30-ad5f-97a18c73c831"}}	752	\N
748	842	projects_files	52	{"projects_id":"3","directus_files_id":{"id":"d33b2a90-dfa1-48e5-996a-058c542090c5"}}	{"projects_id":"3","directus_files_id":{"id":"d33b2a90-dfa1-48e5-996a-058c542090c5"}}	752	\N
772	868	projects_skills	13	{"projects_id":"5","skills_id":{"id":"18"}}	{"projects_id":"5","skills_id":{"id":"18"}}	776	\N
773	869	projects_skills	14	{"projects_id":"5","skills_id":{"id":"6"}}	{"projects_id":"5","skills_id":{"id":"6"}}	776	\N
774	870	projects_skills	15	{"projects_id":"5","skills_id":{"id":"8"}}	{"projects_id":"5","skills_id":{"id":"8"}}	776	\N
775	871	projects_skills	16	{"projects_id":"5","skills_id":{"id":"10"}}	{"projects_id":"5","skills_id":{"id":"10"}}	776	\N
789	888	projects_skills	23	{"projects_id":"1","skills_id":{"id":"3"}}	{"projects_id":"1","skills_id":{"id":"3"}}	794	\N
795	894	projects_skills	28	{"projects_id":"7","skills_id":{"id":"16"}}	{"projects_id":"7","skills_id":{"id":"16"}}	798	\N
721	815	projects	4	{"id":"4","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:10:43.336Z","title":"360 Degree Employee Scoring Dashboard (Manager Scoring)","description":"This dashboard is made for monitoring employee scoring with 360 degree using Power BI.The dashboard provides a comprehensive view of each manager's performance based on feedback from their team members. It includes various metrics such as overall satisfaction, communication skills, leadership abilities, and areas for improvement. The data is presented in an easily digestible format with visualizations like charts and graphs, allowing for quick identification of trends and patterns. Managers can use this feedback to understand their strengths and weaknesses, and to develop strategies for personal and professional growth. ","detail":"<h3>360 Degree Employee Scoring Dashboard</h3>\\n<ul>\\n<li>Data Collected: Google Form</li>\\n<li>Data processed: Google Spreadsheet</li>\\n<li>Data Visualization: Power BI</li>\\n</ul>","type":"2","repo_Link":null,"Url":null,"images":["22","23","24"],"skills_used":[]}	{"description":"This dashboard is made for monitoring employee scoring with 360 degree using Power BI.The dashboard provides a comprehensive view of each manager's performance based on feedback from their team members. It includes various metrics such as overall satisfaction, communication skills, leadership abilities, and areas for improvement. The data is presented in an easily digestible format with visualizations like charts and graphs, allowing for quick identification of trends and patterns. Managers can use this feedback to understand their strengths and weaknesses, and to develop strategies for personal and professional growth. ","detail":"<h3>360 Degree Employee Scoring Dashboard</h3>\\n<ul>\\n<li>Data Collected: Google Form</li>\\n<li>Data processed: Google Spreadsheet</li>\\n<li>Data Visualization: Power BI</li>\\n</ul>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:10:43.336Z"}	\N	\N
722	816	projects	4	{"id":"4","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:11:10.242Z","title":"360 Degree Employee Scoring Dashboard (Manager Scoring)","description":"This dashboard is made for monitoring employee scoring with 360 degree using Power BI.The dashboard provides a comprehensive view of each manager's performance based on feedback from their team members. It includes various metrics such as overall satisfaction, communication skills, leadership abilities, and areas for improvement. The data is presented in an easily digestible format with visualizations like charts and graphs, allowing for quick identification of trends and patterns. Managers can use this feedback to understand their strengths and weaknesses, and to develop strategies for personal and professional growth. ","detail":"<ul>\\n<li>Data Collected: Google Form</li>\\n<li>Data processed: Google Spreadsheet</li>\\n<li>Data Visualization: Power BI</li>\\n</ul>","type":"2","repo_Link":null,"Url":null,"images":["22","23","24"],"skills_used":[]}	{"detail":"<ul>\\n<li>Data Collected: Google Form</li>\\n<li>Data processed: Google Spreadsheet</li>\\n<li>Data Visualization: Power BI</li>\\n</ul>","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:11:10.242Z"}	\N	\N
723	817	projects	4	{"id":"4","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:11:57.063Z","title":"360 Degree Employee Scoring Dashboard (Manager Scoring)","description":"This dashboard is made for monitoring employee scoring with 360 degree using Power BI.The dashboard provides a comprehensive view of each manager's performance based on feedback from their team members. The data is presented in an easily digestible format with visualizations like charts and graphs, allowing for quick identification of trends and patterns. Managers can use this feedback to understand their strengths and weaknesses, and to develop strategies for personal and professional growth. ","detail":"<ul>\\n<li>Data Collected: Google Form</li>\\n<li>Data processed: Google Spreadsheet</li>\\n<li>Data Visualization: Power BI</li>\\n</ul>","type":"2","repo_Link":null,"Url":null,"images":["22","23","24"],"skills_used":[]}	{"description":"This dashboard is made for monitoring employee scoring with 360 degree using Power BI.The dashboard provides a comprehensive view of each manager's performance based on feedback from their team members. The data is presented in an easily digestible format with visualizations like charts and graphs, allowing for quick identification of trends and patterns. Managers can use this feedback to understand their strengths and weaknesses, and to develop strategies for personal and professional growth. ","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:11:57.063Z"}	\N	\N
724	818	directus_files	e66d6211-0c08-467d-86a3-e54ba0db0aca	{"title":"Image 138 Pdp","filename_download":"image 138PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 138 Pdp","filename_download":"image 138PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
725	819	directus_files	7de1c245-4eeb-42f6-94ef-48cc8da3b05b	{"title":"Image 140 Pdp","filename_download":"image 140PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 140 Pdp","filename_download":"image 140PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
726	820	directus_files	fc920da1-e2f8-4d09-95e9-e219aae8ab51	{"title":"Image 139 Pdp","filename_download":"image 139PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 139 Pdp","filename_download":"image 139PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
727	821	directus_files	de5b72f7-374d-4b21-aea9-da0fe567ac84	{"title":"Image 141 Pdp","filename_download":"image 141PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 141 Pdp","filename_download":"image 141PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
728	822	directus_files	e2c3417e-6db1-455e-9930-a65e4bc117c3	{"title":"Image 145 Pdp","filename_download":"image 145PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 145 Pdp","filename_download":"image 145PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
729	823	directus_files	56be0d32-b44d-40fa-9cbe-13aa24fed0d6	{"title":"Image 142 Pdp","filename_download":"image 142PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 142 Pdp","filename_download":"image 142PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
730	824	directus_files	4935c5ea-d91a-4a6a-a1e0-351b61032b42	{"title":"Image 144 Pdp","filename_download":"image 144PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 144 Pdp","filename_download":"image 144PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
731	825	directus_files	88084266-e7f7-413f-b5a8-8fc3bbb8ca4c	{"title":"Image 143 Pdp","filename_download":"image 143PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 143 Pdp","filename_download":"image 143PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
732	826	directus_files	a298debe-c993-41ba-91c1-05f8d5f9eaf1	{"title":"Image 146 Pdp","filename_download":"image 146PDP.png","type":"image/png","storage":"cloudinary"}	{"title":"Image 146 Pdp","filename_download":"image 146PDP.png","type":"image/png","storage":"cloudinary"}	\N	\N
733	827	projects	3	{"id":"3","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:15:44.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:30:47.820Z","title":" PDP (Performance Development Plan) Web App for Scoring Employee","description":"This website was developed to make employee scoring for yearly performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform. By using What (for hard skill measurement) and How (for soft skill measurement of how the employee able to get the hard skill)To ensure objectivity, transparency, and minimize bias, the platform incorporates predefined scoring rubrics aligned with company values and performance expectations.  By centralizing the appraisal process, the platform streamlines administrative tasks, freeing up HR professionals and managers to focus on providing meaningful feedback and supporting employee development.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":[],"skills_used":[]}	{"description":"This website was developed to make employee scoring for yearly performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform. By using What (for hard skill measurement) and How (for soft skill measurement of how the employee able to get the hard skill)To ensure objectivity, transparency, and minimize bias, the platform incorporates predefined scoring rubrics aligned with company values and performance expectations.  By centralizing the appraisal process, the platform streamlines administrative tasks, freeing up HR professionals and managers to focus on providing meaningful feedback and supporting employee development.","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:30:47.820Z"}	\N	\N
735	829	directus_files	be68b2f9-89c6-4b8e-86ed-db5243fd8400	{"title":"Group 540","filename_download":"Group 540.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 540","filename_download":"Group 540.png","type":"image/png","storage":"cloudinary"}	\N	\N
736	830	directus_files	eff256be-a612-46c6-bbe2-071c7d942118	{"title":"Group 538","filename_download":"Group 538.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 538","filename_download":"Group 538.png","type":"image/png","storage":"cloudinary"}	\N	\N
737	831	directus_files	1cc182f4-1afe-4937-869b-f17be5cde070	{"title":"Group 539","filename_download":"Group 539.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 539","filename_download":"Group 539.png","type":"image/png","storage":"cloudinary"}	\N	\N
738	832	directus_files	10a8bdb0-e9f0-4bbf-8321-b0829672a492	{"title":"Group 544","filename_download":"Group 544.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 544","filename_download":"Group 544.png","type":"image/png","storage":"cloudinary"}	\N	\N
739	833	directus_files	04323344-2faf-4a30-ad5f-97a18c73c831	{"title":"Group 541","filename_download":"Group 541.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 541","filename_download":"Group 541.png","type":"image/png","storage":"cloudinary"}	\N	\N
741	835	directus_files	07985fe1-d1a7-46b6-ac0e-0e848f6e34a8	{"title":"Group 543","filename_download":"Group 543.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 543","filename_download":"Group 543.png","type":"image/png","storage":"cloudinary"}	\N	\N
742	836	directus_files	933dfe12-6859-4f78-b3f7-79ba83b5b888	{"title":"Group 545","filename_download":"Group 545.png","type":"image/png","storage":"cloudinary"}	{"title":"Group 545","filename_download":"Group 545.png","type":"image/png","storage":"cloudinary"}	\N	\N
752	846	projects	3	{"id":"3","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:15:44.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:39:33.334Z","title":" PDP (Performance Development Plan) Web App for Scoring Employee","description":"This website was developed to make employee scoring for yearly performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform. By using What (for hard skill measurement) and How (for soft skill measurement of how the employee able to get the hard skill)To ensure objectivity, transparency, and minimize bias, the platform incorporates predefined scoring rubrics aligned with company values and performance expectations.  By centralizing the appraisal process, the platform streamlines administrative tasks, freeing up HR professionals and managers to focus on providing meaningful feedback and supporting employee development.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["47","48","49","50","51","52","53","54","55"],"skills_used":[]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T03:39:33.334Z"}	\N	\N
743	837	projects_files	47	{"projects_id":"3","directus_files_id":{"id":"cf3b2f9b-441a-4d93-88b3-c23f40d0f529"}}	{"projects_id":"3","directus_files_id":{"id":"cf3b2f9b-441a-4d93-88b3-c23f40d0f529"}}	752	\N
744	838	projects_files	48	{"projects_id":"3","directus_files_id":{"id":"eff256be-a612-46c6-bbe2-071c7d942118"}}	{"projects_id":"3","directus_files_id":{"id":"eff256be-a612-46c6-bbe2-071c7d942118"}}	752	\N
761	856	projects	9	{"id":"9","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-08-12T04:04:47.686Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:03:04.802Z","title":"Automatic Data Parsing for Job Scope Website","description":"Utilizing Google App Script to convert user initiated data in Google Sheet to REST API for Job Scope Website.","detail":null,"type":"2","repo_Link":null,"Url":null,"images":[],"skills_used":[],"tech_stacks":[1,2]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:03:04.802Z"}	\N	\N
759	854	projects_skills_1	1	{"projects_id":"9","skills_id":{"id":"2"}}	{"projects_id":"9","skills_id":{"id":"2"}}	761	\N
760	855	projects_skills_1	2	{"projects_id":"9","skills_id":{"id":"13"}}	{"projects_id":"9","skills_id":{"id":"13"}}	761	\N
783	882	projects_skills	17	{"projects_id":"1","skills_id":{"id":"19"}}	{"projects_id":"1","skills_id":{"id":"19"}}	794	\N
749	843	projects_files	53	{"projects_id":"3","directus_files_id":{"id":"07985fe1-d1a7-46b6-ac0e-0e848f6e34a8"}}	{"projects_id":"3","directus_files_id":{"id":"07985fe1-d1a7-46b6-ac0e-0e848f6e34a8"}}	752	\N
750	844	projects_files	54	{"projects_id":"3","directus_files_id":{"id":"10a8bdb0-e9f0-4bbf-8321-b0829672a492"}}	{"projects_id":"3","directus_files_id":{"id":"10a8bdb0-e9f0-4bbf-8321-b0829672a492"}}	752	\N
751	845	projects_files	55	{"projects_id":"3","directus_files_id":{"id":"933dfe12-6859-4f78-b3f7-79ba83b5b888"}}	{"projects_id":"3","directus_files_id":{"id":"933dfe12-6859-4f78-b3f7-79ba83b5b888"}}	752	\N
753	847	projects	5	{"id":"5","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:43.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T05:21:54.874Z","title":"Employee Job Scope Website","description":"This website was developed for mapping employee jobdesks by using RATSI (Responsible, Authorize, Task, Support, and Inform) system where every task of any position will have their own responsibility in charge, authorizer, supporters, and informed positions. To ensure clarity and accountability, the website provides a user-friendly interface for navigating the organizational structure and understanding task-related responsibilities. This streamlined approach fosters efficient collaboration and minimizes confusion regarding individual roles within the company.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["15","16","17"],"skills_used":[]}	{"description":"This website was developed for mapping employee jobdesks by using RATSI (Responsible, Authorize, Task, Support, and Inform) system where every task of any position will have their own responsibility in charge, authorizer, supporters, and informed positions. To ensure clarity and accountability, the website provides a user-friendly interface for navigating the organizational structure and understanding task-related responsibilities. This streamlined approach fosters efficient collaboration and minimizes confusion regarding individual roles within the company.","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-09-25T05:21:54.874Z"}	\N	\N
754	849	directus_fields	156	{"sort":"131111","interface":"list-m2m","special":["m2m"],"options":{"enableLink":true},"collection":"projects","field":"tech_stacks"}	{"sort":"131111","interface":"list-m2m","special":["m2m"],"options":{"enableLink":true},"collection":"projects","field":"tech_stacks"}	\N	\N
755	850	directus_fields	157	{"sort":1,"hidden":true,"field":"id","collection":"projects_skills_1"}	{"sort":1,"hidden":true,"field":"id","collection":"projects_skills_1"}	\N	\N
756	851	directus_collections	projects_skills_1	{"hidden":true,"icon":"import_export","collection":"projects_skills_1"}	{"hidden":true,"icon":"import_export","collection":"projects_skills_1"}	\N	\N
757	852	directus_fields	158	{"sort":"11","hidden":true,"collection":"projects_skills_1","field":"projects_id"}	{"sort":"11","hidden":true,"collection":"projects_skills_1","field":"projects_id"}	\N	\N
758	853	directus_fields	159	{"sort":"111","hidden":true,"collection":"projects_skills_1","field":"skills_id"}	{"sort":"111","hidden":true,"collection":"projects_skills_1","field":"skills_id"}	\N	\N
762	857	directus_fields	156	{"id":"156","collection":"projects","field":"tech_stacks","special":["m2m"],"interface":"list-m2m","options":{"enableLink":true,"template":"{{skills_id.title}}"},"display":"related-values","display_options":{"template":"{{skills_id}}"},"readonly":false,"hidden":false,"sort":"131111","width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"projects","field":"tech_stacks","options":{"enableLink":true,"template":"{{skills_id.title}}"},"display":"related-values","display_options":{"template":"{{skills_id}}"}}	\N	\N
766	862	projects	9	{"id":"9","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-08-12T04:04:47.686Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:05:19.666Z","title":"Automatic Data Parsing for Job Scope Website","description":"Utilizing Google App Script to convert user initiated data in Google Sheet to REST API for Job Scope Website.","detail":null,"type":"2","repo_Link":null,"Url":null,"images":[],"skills_used":[5,6,7]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:05:19.666Z"}	\N	\N
763	859	projects_skills	5	{"projects_id":"9","skills_id":{"id":"2"}}	{"projects_id":"9","skills_id":{"id":"2"}}	766	\N
765	861	projects_skills	7	{"projects_id":"9","skills_id":{"id":"20"}}	{"projects_id":"9","skills_id":{"id":"20"}}	766	\N
776	872	projects	5	{"id":"5","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:43.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:06:39.495Z","title":"Employee Job Scope Website","description":"This website was developed for mapping employee jobdesks by using RATSI (Responsible, Authorize, Task, Support, and Inform) system where every task of any position will have their own responsibility in charge, authorizer, supporters, and informed positions. To ensure clarity and accountability, the website provides a user-friendly interface for navigating the organizational structure and understanding task-related responsibilities. This streamlined approach fosters efficient collaboration and minimizes confusion regarding individual roles within the company.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["15","16","17"],"skills_used":[8,9,10,11,12,13,14,15,16]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:06:39.495Z"}	\N	\N
767	863	projects_skills	8	{"projects_id":"5","skills_id":{"id":"3"}}	{"projects_id":"5","skills_id":{"id":"3"}}	776	\N
768	864	projects_skills	9	{"projects_id":"5","skills_id":{"id":"4"}}	{"projects_id":"5","skills_id":{"id":"4"}}	776	\N
769	865	projects_skills	10	{"projects_id":"5","skills_id":{"id":"1"}}	{"projects_id":"5","skills_id":{"id":"1"}}	776	\N
771	867	projects_skills	12	{"projects_id":"5","skills_id":{"id":"2"}}	{"projects_id":"5","skills_id":{"id":"2"}}	776	\N
777	873	directus_permissions	1	{"id":"1","collection":"projects","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"collection":"projects","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
778	875	directus_permissions	1	{"id":"1","collection":"projects","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"collection":"projects","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
779	876	directus_permissions	9	{"id":"9","collection":"skills","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["id","icon","sort","user_created","date_created","user_updated","date_updated","title","status"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	{"collection":"skills","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["id","icon","sort","user_created","date_created","user_updated","date_updated","title","status"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
780	878	directus_permissions	15	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"projects_skills","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"projects_skills","action":"read"}	\N	\N
781	879	directus_permissions	16	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"projects_skills_1","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"projects_skills_1","action":"read"}	\N	\N
782	880	directus_permissions	17	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"experiences_skills","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"experiences_skills","action":"read"}	\N	\N
794	893	projects	1	{"id":"1","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:40:35.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:57:10.829Z","title":"LMS Application","description":"This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.","detail":"<p><strong>Front-end</strong> (Vue.js + Tailwind):</p>\\n<ul>\\n<li>Hosting Platform: Vercel</li>\\n<li>Repository: Github</li>\\n</ul>\\n<p><strong>Back-end</strong> (REST API, Express.js):</p>\\n<ul>\\n<li>Platform: AWS Elastic Beanstalk</li>\\n<li>Repository: Github</li>\\n</ul>","type":"1","repo_Link":null,"Url":null,"images":["25","26","27","28","29","30","31","32","33"],"skills_used":[17,18,19,20,21,22,23,24,25,26,27]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T14:57:10.829Z"}	\N	\N
784	883	projects_skills	18	{"projects_id":"1","skills_id":{"id":"12"}}	{"projects_id":"1","skills_id":{"id":"12"}}	794	\N
785	884	projects_skills	19	{"projects_id":"1","skills_id":{"id":"6"}}	{"projects_id":"1","skills_id":{"id":"6"}}	794	\N
786	885	projects_skills	20	{"projects_id":"1","skills_id":{"id":"22"}}	{"projects_id":"1","skills_id":{"id":"22"}}	794	\N
787	886	projects_skills	21	{"projects_id":"1","skills_id":{"id":"7"}}	{"projects_id":"1","skills_id":{"id":"7"}}	794	\N
788	887	projects_skills	22	{"projects_id":"1","skills_id":{"id":"1"}}	{"projects_id":"1","skills_id":{"id":"1"}}	794	\N
790	889	projects_skills	24	{"projects_id":"1","skills_id":{"id":"11"}}	{"projects_id":"1","skills_id":{"id":"11"}}	794	\N
791	890	projects_skills	25	{"projects_id":"1","skills_id":{"id":"8"}}	{"projects_id":"1","skills_id":{"id":"8"}}	794	\N
792	891	projects_skills	26	{"projects_id":"1","skills_id":{"id":"10"}}	{"projects_id":"1","skills_id":{"id":"10"}}	794	\N
793	892	projects_skills	27	{"projects_id":"1","skills_id":{"id":"2"}}	{"projects_id":"1","skills_id":{"id":"2"}}	794	\N
798	897	projects	7	{"id":"7","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-20T17:09:21.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:00:23.505Z","title":"Attendance Monitoring Dashboard","description":"Developed for supervise employees with flexible attendance ability using Looker Studio and Google Sheet, and Google App Script","detail":null,"type":"2","repo_Link":null,"Url":null,"images":["14"],"skills_used":[28,29,30]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:00:23.505Z"}	\N	\N
796	895	projects_skills	29	{"projects_id":"7","skills_id":{"id":"13"}}	{"projects_id":"7","skills_id":{"id":"13"}}	798	\N
797	896	projects_skills	30	{"projects_id":"7","skills_id":{"id":"2"}}	{"projects_id":"7","skills_id":{"id":"2"}}	798	\N
802	901	projects	8	{"id":"8","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-08-12T03:59:08.951Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:01:28.937Z","title":"Automatic Warehouse Rent Reminder","description":"Developed to help field team (Operation & regional managers) with more than 100 branches to manage warehouse rent management (payment, movement, and extend) using Google App Script ","detail":null,"type":"2","repo_Link":null,"Url":null,"images":["18","19","20","21"],"skills_used":[31,32,33]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:01:28.937Z"}	\N	\N
799	898	projects_skills	31	{"projects_id":"8","skills_id":{"id":"3"}}	{"projects_id":"8","skills_id":{"id":"3"}}	802	\N
800	899	projects_skills	32	{"projects_id":"8","skills_id":{"id":"13"}}	{"projects_id":"8","skills_id":{"id":"13"}}	802	\N
801	900	projects_skills	33	{"projects_id":"8","skills_id":{"id":"2"}}	{"projects_id":"8","skills_id":{"id":"2"}}	802	\N
806	905	projects	4	{"id":"4","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:16:18.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:02:11.039Z","title":"360 Degree Employee Scoring Dashboard (Manager Scoring)","description":"This dashboard is made for monitoring employee scoring with 360 degree using Power BI.The dashboard provides a comprehensive view of each manager's performance based on feedback from their team members. The data is presented in an easily digestible format with visualizations like charts and graphs, allowing for quick identification of trends and patterns. Managers can use this feedback to understand their strengths and weaknesses, and to develop strategies for personal and professional growth. ","detail":"<ul>\\n<li>Data Collected: Google Form</li>\\n<li>Data processed: Google Spreadsheet</li>\\n<li>Data Visualization: Power BI</li>\\n</ul>","type":"2","repo_Link":null,"Url":null,"images":["22","23","24"],"skills_used":[34,35,36]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:02:11.039Z"}	\N	\N
803	902	projects_skills	34	{"projects_id":"4","skills_id":{"id":"20"}}	{"projects_id":"4","skills_id":{"id":"20"}}	806	\N
804	903	projects_skills	35	{"projects_id":"4","skills_id":{"id":"13"}}	{"projects_id":"4","skills_id":{"id":"13"}}	806	\N
805	904	projects_skills	36	{"projects_id":"4","skills_id":{"id":"14"}}	{"projects_id":"4","skills_id":{"id":"14"}}	806	\N
818	917	projects	3	{"id":"3","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:15:44.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:03:22.745Z","title":" PDP (Performance Development Plan) Web App for Scoring Employee","description":"This website was developed to make employee scoring for yearly performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform. By using What (for hard skill measurement) and How (for soft skill measurement of how the employee able to get the hard skill)To ensure objectivity, transparency, and minimize bias, the platform incorporates predefined scoring rubrics aligned with company values and performance expectations.  By centralizing the appraisal process, the platform streamlines administrative tasks, freeing up HR professionals and managers to focus on providing meaningful feedback and supporting employee development.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["47","48","49","50","51","52","53","54","55"],"skills_used":[37,38,39,40,41,42,43,44,45,46,47]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:03:22.745Z"}	\N	\N
807	906	projects_skills	37	{"projects_id":"3","skills_id":{"id":"5"}}	{"projects_id":"3","skills_id":{"id":"5"}}	818	\N
808	907	projects_skills	38	{"projects_id":"3","skills_id":{"id":"6"}}	{"projects_id":"3","skills_id":{"id":"6"}}	818	\N
809	908	projects_skills	39	{"projects_id":"3","skills_id":{"id":"1"}}	{"projects_id":"3","skills_id":{"id":"1"}}	818	\N
810	909	projects_skills	40	{"projects_id":"3","skills_id":{"id":"18"}}	{"projects_id":"3","skills_id":{"id":"18"}}	818	\N
811	910	projects_skills	41	{"projects_id":"3","skills_id":{"id":"17"}}	{"projects_id":"3","skills_id":{"id":"17"}}	818	\N
812	911	projects_skills	42	{"projects_id":"3","skills_id":{"id":"3"}}	{"projects_id":"3","skills_id":{"id":"3"}}	818	\N
813	912	projects_skills	43	{"projects_id":"3","skills_id":{"id":"4"}}	{"projects_id":"3","skills_id":{"id":"4"}}	818	\N
814	913	projects_skills	44	{"projects_id":"3","skills_id":{"id":"8"}}	{"projects_id":"3","skills_id":{"id":"8"}}	818	\N
815	914	projects_skills	45	{"projects_id":"3","skills_id":{"id":"10"}}	{"projects_id":"3","skills_id":{"id":"10"}}	818	\N
816	915	projects_skills	46	{"projects_id":"3","skills_id":{"id":"7"}}	{"projects_id":"3","skills_id":{"id":"7"}}	818	\N
817	916	projects_skills	47	{"projects_id":"3","skills_id":{"id":"9"}}	{"projects_id":"3","skills_id":{"id":"9"}}	818	\N
828	927	projects	6	{"id":"6","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:17:11.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:05:15.347Z","title":" RDA Company Website","description":"Developed a company profile website for the FMCG distributor company with more than 15 branches. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia. Providing detailed information about product sector, principals, and distribution network. Integrated with interactive maps for branch locator. Mobile-first approach for seamless access on various devices. SEO optimized for better online visibility. Implementing secure contact form for inquiries.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["39","40","41","42","43","44","45","46"],"skills_used":[48,49,50,51,52,53,54,55,56]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:05:15.347Z"}	\N	\N
819	918	projects_skills	48	{"projects_id":"6","skills_id":{"id":"5"}}	{"projects_id":"6","skills_id":{"id":"5"}}	828	\N
820	919	projects_skills	49	{"projects_id":"6","skills_id":{"id":"6"}}	{"projects_id":"6","skills_id":{"id":"6"}}	828	\N
821	920	projects_skills	50	{"projects_id":"6","skills_id":{"id":"8"}}	{"projects_id":"6","skills_id":{"id":"8"}}	828	\N
822	921	projects_skills	51	{"projects_id":"6","skills_id":{"id":"3"}}	{"projects_id":"6","skills_id":{"id":"3"}}	828	\N
823	922	projects_skills	52	{"projects_id":"6","skills_id":{"id":"4"}}	{"projects_id":"6","skills_id":{"id":"4"}}	828	\N
824	923	projects_skills	53	{"projects_id":"6","skills_id":{"id":"17"}}	{"projects_id":"6","skills_id":{"id":"17"}}	828	\N
825	924	projects_skills	54	{"projects_id":"6","skills_id":{"id":"10"}}	{"projects_id":"6","skills_id":{"id":"10"}}	828	\N
826	925	projects_skills	55	{"projects_id":"6","skills_id":{"id":"1"}}	{"projects_id":"6","skills_id":{"id":"1"}}	828	\N
827	926	projects_skills	56	{"projects_id":"6","skills_id":{"id":"2"}}	{"projects_id":"6","skills_id":{"id":"2"}}	828	\N
835	934	projects	2	{"id":"2","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-04-16T21:42:29.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:05:48.139Z","title":"Think Action REST API","description":"One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts","detail":"<p><em><br><br></em></p>","type":"1","repo_Link":null,"Url":null,"images":[],"skills_used":[57,58,59,60,61,62]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:05:48.139Z"}	\N	\N
829	928	projects_skills	57	{"projects_id":"2","skills_id":{"id":"12"}}	{"projects_id":"2","skills_id":{"id":"12"}}	835	\N
830	929	projects_skills	58	{"projects_id":"2","skills_id":{"id":"19"}}	{"projects_id":"2","skills_id":{"id":"19"}}	835	\N
831	930	projects_skills	59	{"projects_id":"2","skills_id":{"id":"11"}}	{"projects_id":"2","skills_id":{"id":"11"}}	835	\N
832	931	projects_skills	60	{"projects_id":"2","skills_id":{"id":"8"}}	{"projects_id":"2","skills_id":{"id":"8"}}	835	\N
833	932	projects_skills	61	{"projects_id":"2","skills_id":{"id":"22"}}	{"projects_id":"2","skills_id":{"id":"22"}}	835	\N
834	933	projects_skills	62	{"projects_id":"2","skills_id":{"id":"1"}}	{"projects_id":"2","skills_id":{"id":"1"}}	835	\N
842	941	projects	10	{"id":"10","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-09-12T02:01:05.812Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:06:22.030Z","title":"RMS Company Profile Website","description":"Maintaining and developing new features of a company profile website for the FMCG Distributor company with more than 100 branches across Indonesia. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.Focus on improving user experience and engagement through interactive elements and seamless navigation. Implement robust SEO strategies to enhance online visibility and attract potential clients and partners. Ensure cross-browser compatibility and optimize website performance for faster loading times.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["10","11","12","13"],"skills_used":[63,64,65,66,67,68]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:06:22.030Z"}	\N	\N
836	935	projects_skills	63	{"projects_id":"10","skills_id":{"id":"5"}}	{"projects_id":"10","skills_id":{"id":"5"}}	842	\N
837	936	projects_skills	64	{"projects_id":"10","skills_id":{"id":"2"}}	{"projects_id":"10","skills_id":{"id":"2"}}	842	\N
838	937	projects_skills	65	{"projects_id":"10","skills_id":{"id":"17"}}	{"projects_id":"10","skills_id":{"id":"17"}}	842	\N
839	938	projects_skills	66	{"projects_id":"10","skills_id":{"id":"8"}}	{"projects_id":"10","skills_id":{"id":"8"}}	842	\N
840	939	projects_skills	67	{"projects_id":"10","skills_id":{"id":"4"}}	{"projects_id":"10","skills_id":{"id":"4"}}	842	\N
841	940	projects_skills	68	{"projects_id":"10","skills_id":{"id":"3"}}	{"projects_id":"10","skills_id":{"id":"3"}}	842	\N
843	942	directus_files	59b61074-3cb5-406c-a9b8-5f0d84d83f96	{"title":"Mdi  React","filename_download":"mdi--react.png","type":"image/png","storage":"cloudinary"}	{"title":"Mdi  React","filename_download":"mdi--react.png","type":"image/png","storage":"cloudinary"}	\N	\N
844	943	skills	23	{"title":"React","icon":"59b61074-3cb5-406c-a9b8-5f0d84d83f96","status":"published"}	{"title":"React","icon":"59b61074-3cb5-406c-a9b8-5f0d84d83f96","status":"published"}	\N	\N
845	944	directus_files	34a4e7c8-9709-43a3-bdb5-87fd0864d516	{"title":"Simple Icons  Nuxt","filename_download":"simple-icons--nuxt.png","type":"image/png","storage":"cloudinary"}	{"title":"Simple Icons  Nuxt","filename_download":"simple-icons--nuxt.png","type":"image/png","storage":"cloudinary"}	\N	\N
846	945	skills	24	{"title":"Nuxt","icon":"34a4e7c8-9709-43a3-bdb5-87fd0864d516","status":"published"}	{"title":"Nuxt","icon":"34a4e7c8-9709-43a3-bdb5-87fd0864d516","status":"published"}	\N	\N
847	946	projects_skills	69	{"projects_id":"6","skills_id":{"id":"24"}}	{"projects_id":"6","skills_id":{"id":"24"}}	848	\N
848	947	projects	6	{"id":"6","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-07-11T22:17:11.000Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:08:29.294Z","title":" RDA Company Website","description":"Developed a company profile website for the FMCG distributor company with more than 15 branches. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia. Providing detailed information about product sector, principals, and distribution network. Integrated with interactive maps for branch locator. Mobile-first approach for seamless access on various devices. SEO optimized for better online visibility. Implementing secure contact form for inquiries.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["39","40","41","42","43","44","45","46"],"skills_used":[48,49,50,51,52,53,54,55,56,69]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:08:29.294Z"}	\N	\N
850	949	projects	10	{"id":"10","status":"published","sort":null,"user_created":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_created":"2025-09-12T02:01:05.812Z","user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:08:45.927Z","title":"RMS Company Profile Website","description":"Maintaining and developing new features of a company profile website for the FMCG Distributor company with more than 100 branches across Indonesia. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.Focus on improving user experience and engagement through interactive elements and seamless navigation. Implement robust SEO strategies to enhance online visibility and attract potential clients and partners. Ensure cross-browser compatibility and optimize website performance for faster loading times.","detail":null,"type":"1","repo_Link":null,"Url":null,"images":["10","11","12","13"],"skills_used":[63,64,65,66,67,68,70]}	{"user_updated":"a89509b5-964d-4f8d-9e09-d6e79c368399","date_updated":"2025-10-08T15:08:45.927Z"}	\N	\N
849	948	projects_skills	70	{"projects_id":"10","skills_id":{"id":"23"}}	{"projects_id":"10","skills_id":{"id":"23"}}	850	\N
\.


--
-- TOC entry 5097 (class 0 OID 16655)
-- Dependencies: 245
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
8a883d4d-af7e-4354-98a4-176b474e9fcc	Administrator	verified	$t:admin_description	\N
\.


--
-- TOC entry 5098 (class 0 OID 16662)
-- Dependencies: 246
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
SK8NGiESumENVfJux-TwPyL2m8D1JKPu7OQECh44jTFUGAhFHYTHDSomwVU3Wh4d	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-15 14:01:04.069+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	https://cms.itsanam.my.id	\N
\.


--
-- TOC entry 5100 (class 0 OID 16673)
-- Dependencies: 248
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id) FROM stdin;
2	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	01987b04-c62e-77da-90f7-0e12d5f219c7
\.


--
-- TOC entry 5101 (class 0 OID 16702)
-- Dependencies: 249
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- TOC entry 5102 (class 0 OID 16713)
-- Dependencies: 250
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- TOC entry 5103 (class 0 OID 16718)
-- Dependencies: 251
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
d905988c-2a94-4dd2-9a50-241e35df6866	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$/E/2pgaLpgzLjNzJDRPpjQ$IRzvAGTXQMoCtQ853jz2/EaT8yhv1MNQ6+UBrjW0/bc	\N	\N	\N	\N	\N	\N	\N	active	8a883d4d-af7e-4354-98a4-176b474e9fcc	\N	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N	auto
a89509b5-964d-4f8d-9e09-d6e79c368399	Khoirul	Anam	khairulanamstud@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$sPwkqaSvXW+kmWLTA63ZTw$Iz1Ll24c3C/hZPBugICdt9ZrXiRrIJoWPSt5fEQIKUQ	\N	\N	\N	\N	edd7abe3-0790-40f8-9a31-c8c308171741	\N	\N	active	8a883d4d-af7e-4354-98a4-176b474e9fcc	\N	2025-10-08 14:01:04.358+00	/content/projects	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- TOC entry 5104 (class 0 OID 16742)
-- Dependencies: 252
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- TOC entry 5106 (class 0 OID 16754)
-- Dependencies: 254
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- TOC entry 5108 (class 0 OID 16766)
-- Dependencies: 256
-- Data for Name: educations; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.educations (id, status, sort, user_created, date_created, user_updated, date_updated, institution, major, date_start, date_end, sequence, education_type, detail) FROM stdin;
1	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:14:11+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:36+00	Merdeka Malang University	Diploma in English	2019-09-01 12:00:00+00	2022-08-01 12:00:00+00	1	Diploma Study	\N
2	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:16:10+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:41+00	Merdeka Malang University	Information System	2019-09-01 12:00:00+00	2023-09-01 12:00:00+00	2	Bachelor Study	\N
3	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:17:26+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:57+00	Binar Academy	Backend Javascript	2022-01-01 12:00:00+00	2022-07-01 12:00:00+00	4	Independent Study	\N
4	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:18:46+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:35:23+00	Hacktiv8	Golang for Back End Programmer	2022-08-01 12:00:00+00	2022-12-01 12:00:00+00	3	Independent Study	\N
5	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:53:09+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:55:21+00	Yesterday is a History	Lessons from the Past	2001-02-21 12:00:00+00	\N	0	Life Study	\N
\.


--
-- TOC entry 5110 (class 0 OID 16779)
-- Dependencies: 258
-- Data for Name: experiences; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.experiences (id, status, sort, user_created, date_created, user_updated, date_updated, company, "position", date_start, date_end, job_detail, job_type, sequence) FROM stdin;
1	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:39:35+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-28 22:58:58+00	Cataliz	Back End Developer	2023-02-01 12:00:00+00	2023-08-01 12:00:00+00	<ul>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Solved the complex data requirement using MongoDB Aggregation</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Developed RESTful API based on documentation using Express.js.</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Improved application reliability by making API testing using Postman.</p>\n</li>\n</ul>	1	1
3	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:45:58+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:54:48+00	Future is a Mistery	Experiencing new things	2001-02-21 12:00:00+00	\N	\N	2	0
2	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:35:04+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-08 00:04:46.991+00	PT Rukun Mitra Sejati	Digital Effectiveness / Web Developer	2023-09-18 12:00:00+00	\N	<ul>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Improve employee&rsquo;s Job desk mapping workflow by developing dedicated Web Apps</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Developer for the company profile websites using popular web frameworks (Laravel, Vue, &amp; React).</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Automated company&rsquo;s warehouse rent notification by developing google app script (Javascript based) program</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Improved HR data management by using advance formula and developed data dashboard using dashboard tools</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Streamlined repetitive administrative tasks using python scripts and/or google app script</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Produced the content of official company profile collaborated with videographer team</p>\n</li>\n<li dir="ltr" aria-level="1">\n<p dir="ltr" role="presentation">Managed employees ID Card production from head office to branches employees</p>\n</li>\n</ul>	1	2
\.


--
-- TOC entry 5132 (class 0 OID 18114)
-- Dependencies: 280
-- Data for Name: experiences_skills; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.experiences_skills (id, experiences_id, skills_id) FROM stdin;
\.


--
-- TOC entry 5112 (class 0 OID 16791)
-- Dependencies: 260
-- Data for Name: job_types; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.job_types (id, status, sort, user_created, date_created, user_updated, date_updated, name) FROM stdin;
1	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:42:27+00	\N	\N	Full Time
2	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:42:34+00	\N	\N	Internship
\.


--
-- TOC entry 5114 (class 0 OID 16802)
-- Dependencies: 262
-- Data for Name: languanges; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.languanges (id, status, sort, user_created, date_created, user_updated, date_updated, name, level_types) FROM stdin;
1	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:04:25+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:33:57+00	Indonesia	["Written", "Read", "Spoken", "Listening"]
2	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:09:13+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-27 21:33:53+00	English	["Listening", "Read", "Spoken", "Written"]
\.


--
-- TOC entry 5116 (class 0 OID 16813)
-- Dependencies: 264
-- Data for Name: languanges_undefined; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.languanges_undefined (id, languanges_id, item, collection) FROM stdin;
\.


--
-- TOC entry 5118 (class 0 OID 16822)
-- Dependencies: 266
-- Data for Name: main_contents; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.main_contents (id, status, user_created, date_created, user_updated, date_updated, about_desc, project_desc, education_desc, experience_desc) FROM stdin;
1	published	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:02:18+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-12 09:55:55.206+00	Digitalization Specialist with nearly two years of experience in web development and data analytics. Skilled in Laravel, Vue, Power BI, and automation tools. Also leveraged machine learning models and AI tools for workflow optimization and reducing redundant tasks. Graduated with a Bachelor of Information Systems and Diploma in English with a double degree program. His main skills mostly in web development like Laravel, Javascript, and Vue. Also data analytic and BI tools like Looker, App script,  Excel and a slight of Python	This is Project Description	This is Education Description	Experience Description
\.


--
-- TOC entry 5124 (class 0 OID 16849)
-- Dependencies: 272
-- Data for Name: project_types; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.project_types (id, status, sort, user_created, date_created, user_updated, date_updated, name, icon) FROM stdin;
1	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:12+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:08+00	Web Development	bf067a9b-72b9-47a2-a180-89188ba321d1
2	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:22+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:28+00	Data Analysis	16a5c261-5fdd-4d5b-b8fa-169f40cb9217
3	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:31+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:08:42+00	Graphic Design	8d8ec497-dbfa-4a64-babd-a4b067c40c81
4	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-05-12 21:15:49+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 10:09:02+00	HRIS Specialist	74eee123-fd90-4c6b-9356-766d9ff7afe7
\.


--
-- TOC entry 5120 (class 0 OID 16832)
-- Dependencies: 268
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.projects (id, status, sort, user_created, date_created, user_updated, date_updated, title, description, detail, type, "repo_Link", "Url") FROM stdin;
3	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:15:44+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:03:22.745+00	 PDP (Performance Development Plan) Web App for Scoring Employee	This website was developed to make employee scoring for yearly performance appraisal more seamless by integrating the scoring system, scoring mechanism, and pulling result in one platform. By using What (for hard skill measurement) and How (for soft skill measurement of how the employee able to get the hard skill)To ensure objectivity, transparency, and minimize bias, the platform incorporates predefined scoring rubrics aligned with company values and performance expectations.  By centralizing the appraisal process, the platform streamlines administrative tasks, freeing up HR professionals and managers to focus on providing meaningful feedback and supporting employee development.	\N	1	\N	\N
5	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:16:43+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:06:39.495+00	Employee Job Scope Website	This website was developed for mapping employee jobdesks by using RATSI (Responsible, Authorize, Task, Support, and Inform) system where every task of any position will have their own responsibility in charge, authorizer, supporters, and informed positions. To ensure clarity and accountability, the website provides a user-friendly interface for navigating the organizational structure and understanding task-related responsibilities. This streamlined approach fosters efficient collaboration and minimizes confusion regarding individual roles within the company.	\N	1	\N	\N
7	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-20 17:09:21+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:00:23.505+00	Attendance Monitoring Dashboard	Developed for supervise employees with flexible attendance ability using Looker Studio and Google Sheet, and Google App Script	\N	2	\N	\N
2	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:42:29+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:05:48.139+00	Think Action REST API	One of the project of internship activity. Developed a backend social media app where users can interact themselves, posting images, and interact with the posts	<p><em><br><br></em></p>	1	\N	\N
11	draft	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-13 03:45:46.482+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-23 14:18:18.762+00	Official Company Profile of PT RMS	test	\N	3	\N	\N
9	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-12 04:04:47.686+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:05:19.666+00	Automatic Data Parsing for Job Scope Website	Utilizing Google App Script to convert user initiated data in Google Sheet to REST API for Job Scope Website.	\N	2	\N	\N
8	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-08-12 03:59:08.951+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:01:28.937+00	Automatic Warehouse Rent Reminder	Developed to help field team (Operation & regional managers) with more than 100 branches to manage warehouse rent management (payment, movement, and extend) using Google App Script 	\N	2	\N	\N
6	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:17:11+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:29.294+00	 RDA Company Website	Developed a company profile website for the FMCG distributor company with more than 15 branches. Using intuitive and responsive design for modern looks. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia. Providing detailed information about product sector, principals, and distribution network. Integrated with interactive maps for branch locator. Mobile-first approach for seamless access on various devices. SEO optimized for better online visibility. Implementing secure contact form for inquiries.	\N	1	\N	\N
1	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-16 21:40:35+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 14:57:10.829+00	LMS Application	This application is an internship project that became my bachelor thesis project. This project is a website-based LMS application. It connects teachers and students through a single platform that can facilitate learning with features such as a course catalog and management, video uploads, a commenting system, etc.	<p><strong>Front-end</strong> (Vue.js + Tailwind):</p>\n<ul>\n<li>Hosting Platform: Vercel</li>\n<li>Repository: Github</li>\n</ul>\n<p><strong>Back-end</strong> (REST API, Express.js):</p>\n<ul>\n<li>Platform: AWS Elastic Beanstalk</li>\n<li>Repository: Github</li>\n</ul>	1	\N	\N
4	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-07-11 22:16:18+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:02:11.039+00	360 Degree Employee Scoring Dashboard (Manager Scoring)	This dashboard is made for monitoring employee scoring with 360 degree using Power BI.The dashboard provides a comprehensive view of each manager's performance based on feedback from their team members. The data is presented in an easily digestible format with visualizations like charts and graphs, allowing for quick identification of trends and patterns. Managers can use this feedback to understand their strengths and weaknesses, and to develop strategies for personal and professional growth. 	<ul>\n<li>Data Collected: Google Form</li>\n<li>Data processed: Google Spreadsheet</li>\n<li>Data Visualization: Power BI</li>\n</ul>	2	\N	\N
10	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-12 02:01:05.812+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:45.927+00	RMS Company Profile Website	Maintaining and developing new features of a company profile website for the FMCG Distributor company with more than 100 branches across Indonesia. Using intuitive and responsive design for modern looks. Developed using React as Frontend and Laravel as backend. Also supports multi languange (Indonesia & English) to reach further audience beyond Indonesia.Focus on improving user experience and engagement through interactive elements and seamless navigation. Implement robust SEO strategies to enhance online visibility and attract potential clients and partners. Ensure cross-browser compatibility and optimize website performance for faster loading times.	\N	1	\N	\N
\.


--
-- TOC entry 5122 (class 0 OID 16843)
-- Dependencies: 270
-- Data for Name: projects_files; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.projects_files (id, projects_id, directus_files_id) FROM stdin;
2	\N	2d36b909-4f2f-4199-bd59-3abf7cbc7b41
3	\N	a8c7d44b-f313-4ac6-9e1f-17bd7d0b6c55
4	\N	ca6bc938-1974-4e0d-8eae-83b1c77e518e
5	\N	e6c66500-f365-432b-b15e-35b57caafd68
1	\N	36af366b-87fb-4c43-b278-d14f36a032e2
6	\N	abbc5f31-bef7-48b7-8524-38fcd16832f8
7	\N	7fcff390-a543-4e4f-abf9-2eae212261dd
8	\N	bb279472-b39d-4e64-af00-87a62860614c
9	\N	e59518c0-ac31-4f5c-a8fb-e3972821c5e9
10	10	9236a3ed-40c1-41b0-83a5-9e2ea3106514
11	10	cd26c3bb-27ec-4203-9847-2e5c251a2a52
12	10	bf531657-9d74-43b2-9be3-fb8d9f534e76
13	10	aee44348-e25e-4d33-b889-d32a61ac7b22
14	7	b9d3f4cf-3f8a-45d0-a061-b82529624510
15	5	76b87f11-940b-4e7e-860b-9b833ab012de
16	5	a6e3ea76-cc7f-4309-95c8-eae897aa1cd3
17	5	61a7d17f-61e4-491f-9119-0975c3164ff0
18	8	90dd5416-6216-4e07-b513-792c3ac14543
19	8	5b7f3df1-bf8b-48df-b1da-4afa49cb7f4b
20	8	11e3fb3f-5625-4060-a99e-76e628694e0d
21	8	f80e1f7d-f5d7-4849-afa3-f53168898a70
22	4	6886e984-68de-4348-9bae-dda44b898d44
23	4	70073d8e-ccea-47d3-8f45-a3c1c9c657fc
24	4	68727a44-9735-472f-89e3-d9f570959082
25	1	1cf2fb7b-3769-44b2-ae07-a994962832ef
26	1	f92c9844-67d7-41c5-9a65-1e0b0f00323f
27	1	820e72f9-7f20-4cbb-9987-7f13fa3bbce0
28	1	6f0eb1fd-3211-469e-8fab-93e1aa3e1fca
29	1	75d5253c-8e5f-450c-8c95-01dc67b3d263
30	1	b10f20fe-f1dc-4c82-8215-9e1879003e2e
31	1	b2082e6b-fe28-4efa-a4ff-dde9500ec387
32	1	55e1011d-e96a-4695-9336-651c71c831d8
33	1	c509123f-2c9d-4075-97df-011667a4b2d2
34	\N	9220109c-9f88-41b2-9ebf-ee5404242c39
35	\N	66c3e01d-5dfa-4fa6-bfee-dc2f71b95f0a
36	\N	d0044ddf-3cf7-43cb-bdb8-0a3f413134a5
37	\N	8936ab46-9022-4823-8ac5-728d4de7813b
38	\N	dc50a198-a095-49e9-b3de-d5682a3fb6ca
39	6	5d8052af-cc38-42ea-a128-e0094a3a4fac
40	6	9d40c598-32a6-432b-87b5-7d413339057f
41	6	008a7468-4d4d-49d1-9e6b-8859a853a63a
42	6	75d60b48-6440-4a4a-932a-b53cbcf184bb
43	6	f8905818-2843-4a3a-aef7-59bc22cac963
44	6	94d8529c-eb6a-43ae-bfe6-483a1afb7a20
45	6	d1fbaed4-1e6f-492d-9baf-9ef64a2ec15b
46	6	85b47526-2052-445c-a7bf-f316f30f3035
47	3	cf3b2f9b-441a-4d93-88b3-c23f40d0f529
48	3	eff256be-a612-46c6-bbe2-071c7d942118
49	3	1cc182f4-1afe-4937-869b-f17be5cde070
50	3	be68b2f9-89c6-4b8e-86ed-db5243fd8400
51	3	04323344-2faf-4a30-ad5f-97a18c73c831
52	3	d33b2a90-dfa1-48e5-996a-058c542090c5
53	3	07985fe1-d1a7-46b6-ac0e-0e848f6e34a8
54	3	10a8bdb0-e9f0-4bbf-8321-b0829672a492
55	3	933dfe12-6859-4f78-b3f7-79ba83b5b888
\.


--
-- TOC entry 5130 (class 0 OID 18096)
-- Dependencies: 278
-- Data for Name: projects_skills; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.projects_skills (id, projects_id, skills_id) FROM stdin;
1	11	8
2	11	4
3	11	7
4	11	9
5	9	2
6	9	13
7	9	20
8	5	3
9	5	4
10	5	1
11	5	5
12	5	2
13	5	18
14	5	6
15	5	8
16	5	10
17	1	19
18	1	12
19	1	6
20	1	22
21	1	7
22	1	1
23	1	3
24	1	11
25	1	8
26	1	10
27	1	2
28	7	16
29	7	13
30	7	2
31	8	3
32	8	13
33	8	2
34	4	20
35	4	13
36	4	14
37	3	5
38	3	6
39	3	1
40	3	18
41	3	17
42	3	3
43	3	4
44	3	8
45	3	10
46	3	7
47	3	9
48	6	5
49	6	6
50	6	8
51	6	3
52	6	4
53	6	17
54	6	10
55	6	1
56	6	2
57	2	12
58	2	19
59	2	11
60	2	8
61	2	22
62	2	1
63	10	5
64	10	2
65	10	17
66	10	8
67	10	4
68	10	3
69	6	24
70	10	23
\.


--
-- TOC entry 5134 (class 0 OID 18137)
-- Dependencies: 282
-- Data for Name: projects_skills_1; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.projects_skills_1 (id, projects_id, skills_id) FROM stdin;
1	9	2
2	9	13
\.


--
-- TOC entry 5126 (class 0 OID 16861)
-- Dependencies: 274
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.skills (id, status, sort, user_created, date_created, user_updated, date_updated, title, icon) FROM stdin;
1	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:48:06+00	\N	\N	Typescript	60913cc8-ac74-4123-8054-e645daf166f3
2	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:48:46+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:21+00	Javascript	0bbcdfb5-3d07-4877-9047-d96c480bc3c3
3	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:10+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:26+00	HTML	d4a3abb5-6770-4e03-a792-8192b8b92138
4	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:49:48+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:31+00	CSS	cb7e94b4-45ab-4edb-8d67-94e93f4d6702
5	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:12:49+00	\N	\N	Laravel	29037cce-65cc-4e03-a759-301e5c9fb41a
6	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:15:58+00	\N	\N	Vue	dab08913-0289-4378-9344-81799ff98187
7	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-22 21:16:16+00	\N	\N	Tailwind	12046594-82f6-4690-bd96-051087e33065
8	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:55:54.841+00	\N	\N	GitHub	908bb409-ebbf-48b1-a25d-cd9e6f30bea1
9	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:21.476+00	\N	\N	Git	7c6ecc43-2d33-4658-8f3d-786ea359a14e
10	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:41.331+00	\N	\N	Figma	a062e730-f061-4cf0-be31-c06e0c47aa10
11	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:56:59.337+00	\N	\N	Postman	dc9db38f-d94d-4ee6-8db3-07fd4f729ad0
12	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:57:16.732+00	\N	\N	Express.js	8bf85679-a3c9-4051-9e18-f87f1869bcf1
13	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:58:36.823+00	\N	\N	Google Sheet	efaa7459-6942-4d8c-bd1c-cd42b1b5d9b7
14	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:58:52.906+00	\N	\N	Power BI	64fb2000-857f-4936-82f9-35c1ec187957
15	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:12.826+00	\N	\N	Bun	b2728846-3610-4198-95f5-24fbf46c53fe
16	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:28.22+00	\N	\N	Looker	ec9d495e-e6bc-49db-803c-a0f25d0229f0
17	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 15:59:53.324+00	\N	\N	MySQL	66f7e096-70ac-4bc3-afba-6fed73813cee
18	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:07.985+00	\N	\N	SQL	133327f2-4105-4866-a7c9-74491c28d826
19	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:27.883+00	\N	\N	MongoDB	69c7d811-7545-49a3-a314-239ac7866fb1
20	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:00:53.161+00	\N	\N	Ms. Excel	7eb8efc8-adbc-4c70-ba33-63fba2a0a935
21	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:20.925+00	\N	\N	Docker	6382aa4d-ee74-497f-9325-a43d0b0de8a9
22	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-09-11 16:01:40.056+00	\N	\N	Node.js	114e369d-06b3-41e9-b544-e6437a6349e5
23	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:07:15.068+00	\N	\N	React	59b61074-3cb5-406c-a9b8-5f0d84d83f96
24	published	\N	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-10-08 15:08:09.933+00	\N	\N	Nuxt	34a4e7c8-9709-43a3-bdb5-87fd0864d516
\.


--
-- TOC entry 5128 (class 0 OID 16873)
-- Dependencies: 276
-- Data for Name: specialties; Type: TABLE DATA; Schema: public; Owner: avnadmin
--

COPY public.specialties (id, status, sort, user_created, date_created, user_updated, date_updated, title, description, icon) FROM stdin;
1	published	2	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:36:01+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:36:21+00	Web Development	With experience in Laravel, JavaScript, and Vue, I develop web applications tailored to real business needs. My work is grounded in clean architecture, maintainability, and performance, enabling companies to operate more efficiently in the digital space.	38808ea0-ac80-475b-998d-b4aa6788c58f
2	published	1	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:36:56+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:37:28+00	Data Analysis	I specialize in building dashboards, reports, and automation using tools like Power BI, Google Looker, App Script, and Excel. With a deep understanding of both data structure and business context, I help organizations make smarter, data-driven decisions	7e228bab-3258-4919-97d2-95cd07fe7cc6
3	published	3	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:37:38+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:38:24+00	HRIS Analyst	Supporting HR operations through data and system improvements. I’ve worked on optimizing HR workflows, implementing HRIS tools, and creating dashboards that provide clarity on workforce metrics.	bb9979d1-0ee2-4ea0-a926-aafba0432619
4	published	4	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-04-23 21:38:47+00	a89509b5-964d-4f8d-9e09-d6e79c368399	2025-06-29 21:38:56+00	Graphic Design	Creating visual assets that complement digital transformation efforts. Whether it’s UI mockups, internal branding materials, or social media creatives, I bring a designer’s eye to enhance user experience and communication	b5761b06-fdc3-405d-9e2e-9fb176400c86
\.


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 220
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 949, true);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 226
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 159, true);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 232
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, true);


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 236
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 17, true);


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 239
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 10, true);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 241
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 47, true);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 243
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 850, true);


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 247
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 2, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 253
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 255
-- Name: educations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.educations_id_seq', 5, true);


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 257
-- Name: experiences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.experiences_id_seq', 3, true);


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 279
-- Name: experiences_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.experiences_skills_id_seq', 1, false);


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 259
-- Name: job_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.job_types_id_seq', 2, true);


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 261
-- Name: languanges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.languanges_id_seq', 2, true);


--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 263
-- Name: languanges_undefined_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.languanges_undefined_id_seq', 1, true);


--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 265
-- Name: main_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.main_contents_id_seq', 1, true);


--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 271
-- Name: project_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.project_types_id_seq', 4, true);


--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 269
-- Name: projects_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.projects_files_id_seq', 55, true);


--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 267
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.projects_id_seq', 11, true);


--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 281
-- Name: projects_skills_1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.projects_skills_1_id_seq', 2, true);


--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 277
-- Name: projects_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.projects_skills_id_seq', 70, true);


--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 273
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.skills_id_seq', 24, true);


--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 275
-- Name: specialties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: avnadmin
--

SELECT pg_catalog.setval('public.specialties_id_seq', 4, true);


--
-- TOC entry 4848 (class 2606 OID 18119)
-- Name: experiences_skills experiences_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences_skills
    ADD CONSTRAINT experiences_skills_pkey PRIMARY KEY (id);


--
-- TOC entry 4694 (class 2606 OID 17026)
-- Name: directus_access idx_16455_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT idx_16455_primary PRIMARY KEY (id);


--
-- TOC entry 4697 (class 2606 OID 17013)
-- Name: directus_activity idx_16461_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT idx_16461_primary PRIMARY KEY (id);


--
-- TOC entry 4700 (class 2606 OID 17019)
-- Name: directus_collections idx_16471_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT idx_16471_primary PRIMARY KEY (collection);


--
-- TOC entry 4704 (class 2606 OID 17035)
-- Name: directus_comments idx_16491_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT idx_16491_primary PRIMARY KEY (id);


--
-- TOC entry 4707 (class 2606 OID 17034)
-- Name: directus_dashboards idx_16500_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT idx_16500_primary PRIMARY KEY (id);


--
-- TOC entry 4709 (class 2606 OID 17037)
-- Name: directus_extensions idx_16509_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT idx_16509_primary PRIMARY KEY (id);


--
-- TOC entry 4712 (class 2606 OID 17015)
-- Name: directus_fields idx_16517_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT idx_16517_primary PRIMARY KEY (id);


--
-- TOC entry 4717 (class 2606 OID 17017)
-- Name: directus_files idx_16531_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT idx_16531_primary PRIMARY KEY (id);


--
-- TOC entry 4721 (class 2606 OID 17036)
-- Name: directus_flows idx_16547_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT idx_16547_primary PRIMARY KEY (id);


--
-- TOC entry 4724 (class 2606 OID 17039)
-- Name: directus_folders idx_16560_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT idx_16560_primary PRIMARY KEY (id);


--
-- TOC entry 4726 (class 2606 OID 17012)
-- Name: directus_migrations idx_16564_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT idx_16564_primary PRIMARY KEY (version);


--
-- TOC entry 4730 (class 2606 OID 17038)
-- Name: directus_notifications idx_16571_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT idx_16571_primary PRIMARY KEY (id);


--
-- TOC entry 4736 (class 2606 OID 17041)
-- Name: directus_operations idx_16582_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT idx_16582_primary PRIMARY KEY (id);


--
-- TOC entry 4740 (class 2606 OID 17040)
-- Name: directus_panels idx_16592_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT idx_16592_primary PRIMARY KEY (id);


--
-- TOC entry 4744 (class 2606 OID 17018)
-- Name: directus_permissions idx_16604_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT idx_16604_primary PRIMARY KEY (id);


--
-- TOC entry 4746 (class 2606 OID 17029)
-- Name: directus_policies idx_16610_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT idx_16610_primary PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 17021)
-- Name: directus_presets idx_16620_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT idx_16620_primary PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 17016)
-- Name: directus_relations idx_16635_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT idx_16635_primary PRIMARY KEY (id);


--
-- TOC entry 4761 (class 2606 OID 17014)
-- Name: directus_revisions idx_16648_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT idx_16648_primary PRIMARY KEY (id);


--
-- TOC entry 4764 (class 2606 OID 17043)
-- Name: directus_roles idx_16655_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT idx_16655_primary PRIMARY KEY (id);


--
-- TOC entry 4768 (class 2606 OID 17028)
-- Name: directus_sessions idx_16662_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT idx_16662_primary PRIMARY KEY (token);


--
-- TOC entry 4776 (class 2606 OID 17042)
-- Name: directus_settings idx_16673_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT idx_16673_primary PRIMARY KEY (id);


--
-- TOC entry 4781 (class 2606 OID 17045)
-- Name: directus_shares idx_16702_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT idx_16702_primary PRIMARY KEY (id);


--
-- TOC entry 4783 (class 2606 OID 17044)
-- Name: directus_translations idx_16713_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT idx_16713_primary PRIMARY KEY (id);


--
-- TOC entry 4789 (class 2606 OID 17031)
-- Name: directus_users idx_16718_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT idx_16718_primary PRIMARY KEY (id);


--
-- TOC entry 4794 (class 2606 OID 17047)
-- Name: directus_versions idx_16742_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT idx_16742_primary PRIMARY KEY (id);


--
-- TOC entry 4797 (class 2606 OID 17046)
-- Name: directus_webhooks idx_16754_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT idx_16754_primary PRIMARY KEY (id);


--
-- TOC entry 4801 (class 2606 OID 17022)
-- Name: educations idx_16766_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT idx_16766_primary PRIMARY KEY (id);


--
-- TOC entry 4806 (class 2606 OID 17027)
-- Name: experiences idx_16779_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT idx_16779_primary PRIMARY KEY (id);


--
-- TOC entry 4810 (class 2606 OID 17030)
-- Name: job_types idx_16791_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.job_types
    ADD CONSTRAINT idx_16791_primary PRIMARY KEY (id);


--
-- TOC entry 4814 (class 2606 OID 17033)
-- Name: languanges idx_16802_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.languanges
    ADD CONSTRAINT idx_16802_primary PRIMARY KEY (id);


--
-- TOC entry 4816 (class 2606 OID 17049)
-- Name: languanges_undefined idx_16813_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.languanges_undefined
    ADD CONSTRAINT idx_16813_primary PRIMARY KEY (id);


--
-- TOC entry 4820 (class 2606 OID 17048)
-- Name: main_contents idx_16822_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.main_contents
    ADD CONSTRAINT idx_16822_primary PRIMARY KEY (id);


--
-- TOC entry 4822 (class 2606 OID 17020)
-- Name: projects idx_16832_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT idx_16832_primary PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 17032)
-- Name: projects_files idx_16843_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_files
    ADD CONSTRAINT idx_16843_primary PRIMARY KEY (id);


--
-- TOC entry 4831 (class 2606 OID 17025)
-- Name: project_types idx_16849_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.project_types
    ADD CONSTRAINT idx_16849_primary PRIMARY KEY (id);


--
-- TOC entry 4836 (class 2606 OID 17023)
-- Name: skills idx_16861_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT idx_16861_primary PRIMARY KEY (id);


--
-- TOC entry 4841 (class 2606 OID 17024)
-- Name: specialties idx_16873_primary; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT idx_16873_primary PRIMARY KEY (id);


--
-- TOC entry 4850 (class 2606 OID 18142)
-- Name: projects_skills_1 projects_skills_1_pkey; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills_1
    ADD CONSTRAINT projects_skills_1_pkey PRIMARY KEY (id);


--
-- TOC entry 4846 (class 2606 OID 18101)
-- Name: projects_skills projects_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills
    ADD CONSTRAINT projects_skills_pkey PRIMARY KEY (id);


--
-- TOC entry 4690 (class 1259 OID 16938)
-- Name: idx_16455_directus_access_policy_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16455_directus_access_policy_foreign ON public.directus_access USING btree (policy);


--
-- TOC entry 4691 (class 1259 OID 16935)
-- Name: idx_16455_directus_access_role_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16455_directus_access_role_foreign ON public.directus_access USING btree (role);


--
-- TOC entry 4692 (class 1259 OID 16936)
-- Name: idx_16455_directus_access_user_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16455_directus_access_user_foreign ON public.directus_access USING btree ("user");


--
-- TOC entry 4695 (class 1259 OID 16885)
-- Name: idx_16461_directus_activity_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16461_directus_activity_collection_foreign ON public.directus_activity USING btree (collection);


--
-- TOC entry 4698 (class 1259 OID 16902)
-- Name: idx_16471_directus_collections_group_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16471_directus_collections_group_foreign ON public.directus_collections USING btree ("group");


--
-- TOC entry 4701 (class 1259 OID 16966)
-- Name: idx_16491_directus_comments_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16491_directus_comments_user_created_foreign ON public.directus_comments USING btree (user_created);


--
-- TOC entry 4702 (class 1259 OID 16962)
-- Name: idx_16491_directus_comments_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16491_directus_comments_user_updated_foreign ON public.directus_comments USING btree (user_updated);


--
-- TOC entry 4705 (class 1259 OID 16963)
-- Name: idx_16500_directus_dashboards_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16500_directus_dashboards_user_created_foreign ON public.directus_dashboards USING btree (user_created);


--
-- TOC entry 4710 (class 1259 OID 16894)
-- Name: idx_16517_directus_fields_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16517_directus_fields_collection_foreign ON public.directus_fields USING btree (collection);


--
-- TOC entry 4713 (class 1259 OID 16895)
-- Name: idx_16531_directus_files_folder_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16531_directus_files_folder_foreign ON public.directus_files USING btree (folder);


--
-- TOC entry 4714 (class 1259 OID 16899)
-- Name: idx_16531_directus_files_modified_by_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16531_directus_files_modified_by_foreign ON public.directus_files USING btree (modified_by);


--
-- TOC entry 4715 (class 1259 OID 16900)
-- Name: idx_16531_directus_files_uploaded_by_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16531_directus_files_uploaded_by_foreign ON public.directus_files USING btree (uploaded_by);


--
-- TOC entry 4718 (class 1259 OID 16964)
-- Name: idx_16547_directus_flows_operation_unique; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE UNIQUE INDEX idx_16547_directus_flows_operation_unique ON public.directus_flows USING btree (operation);


--
-- TOC entry 4719 (class 1259 OID 16967)
-- Name: idx_16547_directus_flows_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16547_directus_flows_user_created_foreign ON public.directus_flows USING btree (user_created);


--
-- TOC entry 4722 (class 1259 OID 16970)
-- Name: idx_16560_directus_folders_parent_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16560_directus_folders_parent_foreign ON public.directus_folders USING btree (parent);


--
-- TOC entry 4727 (class 1259 OID 16973)
-- Name: idx_16571_directus_notifications_recipient_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16571_directus_notifications_recipient_foreign ON public.directus_notifications USING btree (recipient);


--
-- TOC entry 4728 (class 1259 OID 16969)
-- Name: idx_16571_directus_notifications_sender_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16571_directus_notifications_sender_foreign ON public.directus_notifications USING btree (sender);


--
-- TOC entry 4731 (class 1259 OID 16976)
-- Name: idx_16582_directus_operations_flow_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16582_directus_operations_flow_foreign ON public.directus_operations USING btree (flow);


--
-- TOC entry 4732 (class 1259 OID 16979)
-- Name: idx_16582_directus_operations_reject_unique; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE UNIQUE INDEX idx_16582_directus_operations_reject_unique ON public.directus_operations USING btree (reject);


--
-- TOC entry 4733 (class 1259 OID 16977)
-- Name: idx_16582_directus_operations_resolve_unique; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE UNIQUE INDEX idx_16582_directus_operations_resolve_unique ON public.directus_operations USING btree (resolve);


--
-- TOC entry 4734 (class 1259 OID 16981)
-- Name: idx_16582_directus_operations_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16582_directus_operations_user_created_foreign ON public.directus_operations USING btree (user_created);


--
-- TOC entry 4737 (class 1259 OID 16978)
-- Name: idx_16592_directus_panels_dashboard_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16592_directus_panels_dashboard_foreign ON public.directus_panels USING btree (dashboard);


--
-- TOC entry 4738 (class 1259 OID 16975)
-- Name: idx_16592_directus_panels_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16592_directus_panels_user_created_foreign ON public.directus_panels USING btree (user_created);


--
-- TOC entry 4741 (class 1259 OID 16904)
-- Name: idx_16604_directus_permissions_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16604_directus_permissions_collection_foreign ON public.directus_permissions USING btree (collection);


--
-- TOC entry 4742 (class 1259 OID 16901)
-- Name: idx_16604_directus_permissions_policy_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16604_directus_permissions_policy_foreign ON public.directus_permissions USING btree (policy);


--
-- TOC entry 4747 (class 1259 OID 16910)
-- Name: idx_16620_directus_presets_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16620_directus_presets_collection_foreign ON public.directus_presets USING btree (collection);


--
-- TOC entry 4748 (class 1259 OID 16909)
-- Name: idx_16620_directus_presets_role_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16620_directus_presets_role_foreign ON public.directus_presets USING btree (role);


--
-- TOC entry 4749 (class 1259 OID 16918)
-- Name: idx_16620_directus_presets_user_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16620_directus_presets_user_foreign ON public.directus_presets USING btree ("user");


--
-- TOC entry 4752 (class 1259 OID 16896)
-- Name: idx_16635_directus_relations_many_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16635_directus_relations_many_collection_foreign ON public.directus_relations USING btree (many_collection);


--
-- TOC entry 4753 (class 1259 OID 16893)
-- Name: idx_16635_directus_relations_one_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16635_directus_relations_one_collection_foreign ON public.directus_relations USING btree (one_collection);


--
-- TOC entry 4756 (class 1259 OID 16886)
-- Name: idx_16648_directus_revisions_activity_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16648_directus_revisions_activity_foreign ON public.directus_revisions USING btree (activity);


--
-- TOC entry 4757 (class 1259 OID 16889)
-- Name: idx_16648_directus_revisions_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16648_directus_revisions_collection_foreign ON public.directus_revisions USING btree (collection);


--
-- TOC entry 4758 (class 1259 OID 16891)
-- Name: idx_16648_directus_revisions_parent_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16648_directus_revisions_parent_foreign ON public.directus_revisions USING btree (parent);


--
-- TOC entry 4759 (class 1259 OID 16888)
-- Name: idx_16648_directus_revisions_version_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16648_directus_revisions_version_foreign ON public.directus_revisions USING btree (version);


--
-- TOC entry 4762 (class 1259 OID 16989)
-- Name: idx_16655_directus_roles_parent_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16655_directus_roles_parent_foreign ON public.directus_roles USING btree (parent);


--
-- TOC entry 4765 (class 1259 OID 16942)
-- Name: idx_16662_directus_sessions_share_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16662_directus_sessions_share_foreign ON public.directus_sessions USING btree (share);


--
-- TOC entry 4766 (class 1259 OID 16943)
-- Name: idx_16662_directus_sessions_user_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16662_directus_sessions_user_foreign ON public.directus_sessions USING btree ("user");


--
-- TOC entry 4769 (class 1259 OID 16982)
-- Name: idx_16673_directus_settings_project_logo_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16673_directus_settings_project_logo_foreign ON public.directus_settings USING btree (project_logo);


--
-- TOC entry 4770 (class 1259 OID 16987)
-- Name: idx_16673_directus_settings_public_background_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16673_directus_settings_public_background_foreign ON public.directus_settings USING btree (public_background);


--
-- TOC entry 4771 (class 1259 OID 16983)
-- Name: idx_16673_directus_settings_public_favicon_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16673_directus_settings_public_favicon_foreign ON public.directus_settings USING btree (public_favicon);


--
-- TOC entry 4772 (class 1259 OID 16986)
-- Name: idx_16673_directus_settings_public_foreground_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16673_directus_settings_public_foreground_foreign ON public.directus_settings USING btree (public_foreground);


--
-- TOC entry 4773 (class 1259 OID 16984)
-- Name: idx_16673_directus_settings_public_registration_role_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16673_directus_settings_public_registration_role_foreign ON public.directus_settings USING btree (public_registration_role);


--
-- TOC entry 4774 (class 1259 OID 16988)
-- Name: idx_16673_directus_settings_storage_default_folder_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16673_directus_settings_storage_default_folder_foreign ON public.directus_settings USING btree (storage_default_folder);


--
-- TOC entry 4777 (class 1259 OID 16994)
-- Name: idx_16702_directus_shares_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16702_directus_shares_collection_foreign ON public.directus_shares USING btree (collection);


--
-- TOC entry 4778 (class 1259 OID 16992)
-- Name: idx_16702_directus_shares_role_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16702_directus_shares_role_foreign ON public.directus_shares USING btree (role);


--
-- TOC entry 4779 (class 1259 OID 16995)
-- Name: idx_16702_directus_shares_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16702_directus_shares_user_created_foreign ON public.directus_shares USING btree (user_created);


--
-- TOC entry 4784 (class 1259 OID 16948)
-- Name: idx_16718_directus_users_email_unique; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE UNIQUE INDEX idx_16718_directus_users_email_unique ON public.directus_users USING btree (email);


--
-- TOC entry 4785 (class 1259 OID 16950)
-- Name: idx_16718_directus_users_external_identifier_unique; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE UNIQUE INDEX idx_16718_directus_users_external_identifier_unique ON public.directus_users USING btree (external_identifier);


--
-- TOC entry 4786 (class 1259 OID 16952)
-- Name: idx_16718_directus_users_role_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16718_directus_users_role_foreign ON public.directus_users USING btree (role);


--
-- TOC entry 4787 (class 1259 OID 16953)
-- Name: idx_16718_directus_users_token_unique; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE UNIQUE INDEX idx_16718_directus_users_token_unique ON public.directus_users USING btree (token);


--
-- TOC entry 4790 (class 1259 OID 16997)
-- Name: idx_16742_directus_versions_collection_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16742_directus_versions_collection_foreign ON public.directus_versions USING btree (collection);


--
-- TOC entry 4791 (class 1259 OID 17001)
-- Name: idx_16742_directus_versions_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16742_directus_versions_user_created_foreign ON public.directus_versions USING btree (user_created);


--
-- TOC entry 4792 (class 1259 OID 16999)
-- Name: idx_16742_directus_versions_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16742_directus_versions_user_updated_foreign ON public.directus_versions USING btree (user_updated);


--
-- TOC entry 4795 (class 1259 OID 16998)
-- Name: idx_16754_directus_webhooks_migrated_flow_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16754_directus_webhooks_migrated_flow_foreign ON public.directus_webhooks USING btree (migrated_flow);


--
-- TOC entry 4798 (class 1259 OID 16919)
-- Name: idx_16766_educations_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16766_educations_user_created_foreign ON public.educations USING btree (user_created);


--
-- TOC entry 4799 (class 1259 OID 16924)
-- Name: idx_16766_educations_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16766_educations_user_updated_foreign ON public.educations USING btree (user_updated);


--
-- TOC entry 4802 (class 1259 OID 16939)
-- Name: idx_16779_experiences_job_type_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16779_experiences_job_type_foreign ON public.experiences USING btree (job_type);


--
-- TOC entry 4803 (class 1259 OID 16941)
-- Name: idx_16779_experiences_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16779_experiences_user_created_foreign ON public.experiences USING btree (user_created);


--
-- TOC entry 4804 (class 1259 OID 16940)
-- Name: idx_16779_experiences_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16779_experiences_user_updated_foreign ON public.experiences USING btree (user_updated);


--
-- TOC entry 4807 (class 1259 OID 16949)
-- Name: idx_16791_job_types_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16791_job_types_user_created_foreign ON public.job_types USING btree (user_created);


--
-- TOC entry 4808 (class 1259 OID 16947)
-- Name: idx_16791_job_types_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16791_job_types_user_updated_foreign ON public.job_types USING btree (user_updated);


--
-- TOC entry 4811 (class 1259 OID 16957)
-- Name: idx_16802_languanges_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16802_languanges_user_created_foreign ON public.languanges USING btree (user_created);


--
-- TOC entry 4812 (class 1259 OID 16959)
-- Name: idx_16802_languanges_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16802_languanges_user_updated_foreign ON public.languanges USING btree (user_updated);


--
-- TOC entry 4817 (class 1259 OID 17003)
-- Name: idx_16822_main_contents_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16822_main_contents_user_created_foreign ON public.main_contents USING btree (user_created);


--
-- TOC entry 4818 (class 1259 OID 17004)
-- Name: idx_16822_main_contents_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16822_main_contents_user_updated_foreign ON public.main_contents USING btree (user_updated);


--
-- TOC entry 4823 (class 1259 OID 16906)
-- Name: idx_16832_projects_type_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16832_projects_type_foreign ON public.projects USING btree (type);


--
-- TOC entry 4824 (class 1259 OID 16911)
-- Name: idx_16832_projects_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16832_projects_user_created_foreign ON public.projects USING btree (user_created);


--
-- TOC entry 4825 (class 1259 OID 16907)
-- Name: idx_16832_projects_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16832_projects_user_updated_foreign ON public.projects USING btree (user_updated);


--
-- TOC entry 4828 (class 1259 OID 16958)
-- Name: idx_16843_projects_files_directus_files_id_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16843_projects_files_directus_files_id_foreign ON public.projects_files USING btree (directus_files_id);


--
-- TOC entry 4829 (class 1259 OID 16955)
-- Name: idx_16843_projects_files_projects_id_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16843_projects_files_projects_id_foreign ON public.projects_files USING btree (projects_id);


--
-- TOC entry 4832 (class 1259 OID 16932)
-- Name: idx_16849_project_types_icon_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16849_project_types_icon_foreign ON public.project_types USING btree (icon);


--
-- TOC entry 4833 (class 1259 OID 16934)
-- Name: idx_16849_project_types_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16849_project_types_user_created_foreign ON public.project_types USING btree (user_created);


--
-- TOC entry 4834 (class 1259 OID 16933)
-- Name: idx_16849_project_types_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16849_project_types_user_updated_foreign ON public.project_types USING btree (user_updated);


--
-- TOC entry 4837 (class 1259 OID 16922)
-- Name: idx_16861_skills_icon_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16861_skills_icon_foreign ON public.skills USING btree (icon);


--
-- TOC entry 4838 (class 1259 OID 16925)
-- Name: idx_16861_skills_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16861_skills_user_created_foreign ON public.skills USING btree (user_created);


--
-- TOC entry 4839 (class 1259 OID 16927)
-- Name: idx_16861_skills_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16861_skills_user_updated_foreign ON public.skills USING btree (user_updated);


--
-- TOC entry 4842 (class 1259 OID 16931)
-- Name: idx_16873_specialties_icon_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16873_specialties_icon_foreign ON public.specialties USING btree (icon);


--
-- TOC entry 4843 (class 1259 OID 16928)
-- Name: idx_16873_specialties_user_created_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16873_specialties_user_created_foreign ON public.specialties USING btree (user_created);


--
-- TOC entry 4844 (class 1259 OID 16929)
-- Name: idx_16873_specialties_user_updated_foreign; Type: INDEX; Schema: public; Owner: avnadmin
--

CREATE INDEX idx_16873_specialties_user_updated_foreign ON public.specialties USING btree (user_updated);


--
-- TOC entry 4925 (class 2620 OID 17391)
-- Name: directus_sessions on_update_current_timestamp; Type: TRIGGER; Schema: public; Owner: avnadmin
--

CREATE TRIGGER on_update_current_timestamp BEFORE UPDATE ON public.directus_sessions FOR EACH ROW EXECUTE FUNCTION public.on_update_current_timestamp_directus_sessions();


--
-- TOC entry 4851 (class 2606 OID 17050)
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4852 (class 2606 OID 17055)
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4853 (class 2606 OID 17060)
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4854 (class 2606 OID 17065)
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4855 (class 2606 OID 17070)
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4856 (class 2606 OID 17075)
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4857 (class 2606 OID 17080)
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4858 (class 2606 OID 17085)
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4859 (class 2606 OID 17090)
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4860 (class 2606 OID 17095)
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4861 (class 2606 OID 17100)
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4862 (class 2606 OID 17105)
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4863 (class 2606 OID 17110)
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4864 (class 2606 OID 17115)
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4865 (class 2606 OID 17120)
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4866 (class 2606 OID 17125)
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4867 (class 2606 OID 17130)
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4868 (class 2606 OID 17135)
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4869 (class 2606 OID 17140)
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4870 (class 2606 OID 17145)
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4871 (class 2606 OID 17150)
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4872 (class 2606 OID 17155)
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4873 (class 2606 OID 17160)
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4874 (class 2606 OID 17165)
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4875 (class 2606 OID 17170)
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4876 (class 2606 OID 17175)
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4877 (class 2606 OID 17180)
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4878 (class 2606 OID 17185)
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4879 (class 2606 OID 17190)
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4880 (class 2606 OID 17195)
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4881 (class 2606 OID 17200)
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4882 (class 2606 OID 17205)
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4883 (class 2606 OID 17210)
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4884 (class 2606 OID 17215)
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4885 (class 2606 OID 17220)
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4886 (class 2606 OID 17225)
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4887 (class 2606 OID 17230)
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4888 (class 2606 OID 17235)
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4889 (class 2606 OID 17240)
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4890 (class 2606 OID 17245)
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 4891 (class 2606 OID 17250)
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4892 (class 2606 OID 17255)
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4893 (class 2606 OID 17260)
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4894 (class 2606 OID 17265)
-- Name: educations educations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4895 (class 2606 OID 17270)
-- Name: educations educations_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4896 (class 2606 OID 17275)
-- Name: experiences experiences_job_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_job_type_foreign FOREIGN KEY (job_type) REFERENCES public.job_types(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4921 (class 2606 OID 18125)
-- Name: experiences_skills experiences_skills_experiences_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences_skills
    ADD CONSTRAINT experiences_skills_experiences_id_foreign FOREIGN KEY (experiences_id) REFERENCES public.experiences(id) ON DELETE SET NULL;


--
-- TOC entry 4922 (class 2606 OID 18120)
-- Name: experiences_skills experiences_skills_skills_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences_skills
    ADD CONSTRAINT experiences_skills_skills_id_foreign FOREIGN KEY (skills_id) REFERENCES public.skills(id) ON DELETE SET NULL;


--
-- TOC entry 4897 (class 2606 OID 17280)
-- Name: experiences experiences_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4898 (class 2606 OID 17285)
-- Name: experiences experiences_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.experiences
    ADD CONSTRAINT experiences_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4899 (class 2606 OID 17290)
-- Name: job_types job_types_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.job_types
    ADD CONSTRAINT job_types_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4900 (class 2606 OID 17295)
-- Name: job_types job_types_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.job_types
    ADD CONSTRAINT job_types_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4901 (class 2606 OID 17300)
-- Name: languanges languanges_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.languanges
    ADD CONSTRAINT languanges_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4902 (class 2606 OID 17305)
-- Name: languanges languanges_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.languanges
    ADD CONSTRAINT languanges_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4903 (class 2606 OID 17310)
-- Name: main_contents main_contents_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.main_contents
    ADD CONSTRAINT main_contents_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4904 (class 2606 OID 17315)
-- Name: main_contents main_contents_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.main_contents
    ADD CONSTRAINT main_contents_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4910 (class 2606 OID 17345)
-- Name: project_types project_types_icon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.project_types
    ADD CONSTRAINT project_types_icon_foreign FOREIGN KEY (icon) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4911 (class 2606 OID 17350)
-- Name: project_types project_types_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.project_types
    ADD CONSTRAINT project_types_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4912 (class 2606 OID 17355)
-- Name: project_types project_types_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.project_types
    ADD CONSTRAINT project_types_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4908 (class 2606 OID 17335)
-- Name: projects_files projects_files_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_files
    ADD CONSTRAINT projects_files_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4909 (class 2606 OID 17340)
-- Name: projects_files projects_files_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_files
    ADD CONSTRAINT projects_files_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4923 (class 2606 OID 18148)
-- Name: projects_skills_1 projects_skills_1_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills_1
    ADD CONSTRAINT projects_skills_1_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- TOC entry 4924 (class 2606 OID 18143)
-- Name: projects_skills_1 projects_skills_1_skills_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills_1
    ADD CONSTRAINT projects_skills_1_skills_id_foreign FOREIGN KEY (skills_id) REFERENCES public.skills(id) ON DELETE SET NULL;


--
-- TOC entry 4919 (class 2606 OID 18107)
-- Name: projects_skills projects_skills_projects_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills
    ADD CONSTRAINT projects_skills_projects_id_foreign FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- TOC entry 4920 (class 2606 OID 18102)
-- Name: projects_skills projects_skills_skills_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects_skills
    ADD CONSTRAINT projects_skills_skills_id_foreign FOREIGN KEY (skills_id) REFERENCES public.skills(id) ON DELETE SET NULL;


--
-- TOC entry 4905 (class 2606 OID 17320)
-- Name: projects projects_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_type_foreign FOREIGN KEY (type) REFERENCES public.project_types(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4906 (class 2606 OID 17325)
-- Name: projects projects_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4907 (class 2606 OID 17330)
-- Name: projects projects_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4913 (class 2606 OID 17360)
-- Name: skills skills_icon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_icon_foreign FOREIGN KEY (icon) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4914 (class 2606 OID 17365)
-- Name: skills skills_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4915 (class 2606 OID 17370)
-- Name: skills skills_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4916 (class 2606 OID 17375)
-- Name: specialties specialties_icon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT specialties_icon_foreign FOREIGN KEY (icon) REFERENCES public.directus_files(id) ON UPDATE RESTRICT ON DELETE SET NULL;


--
-- TOC entry 4917 (class 2606 OID 17380)
-- Name: specialties specialties_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT specialties_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 4918 (class 2606 OID 17385)
-- Name: specialties specialties_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: avnadmin
--

ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT specialties_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: avnadmin
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-03-07 11:20:59

--
-- PostgreSQL database dump complete
--

