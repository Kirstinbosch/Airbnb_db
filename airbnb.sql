--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Postgres.app)
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-21 19:28:33 CEST

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
-- TOC entry 917 (class 1247 OID 16606)
-- Name: amenity; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.amenity AS ENUM (
    'basic',
    'kitchen',
    'connectivity',
    'entertainment',
    'safety & security',
    'outdoor',
    'additional'
);


ALTER TYPE public.amenity OWNER TO kirstincathlin;

--
-- TOC entry 902 (class 1247 OID 16567)
-- Name: auxiliary; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.auxiliary AS ENUM (
    'cleaning fee',
    'extra guest fee',
    'service fee',
    'secuirty deposit'
);


ALTER TYPE public.auxiliary OWNER TO kirstincathlin;

--
-- TOC entry 881 (class 1247 OID 16509)
-- Name: booking_status; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.booking_status AS ENUM (
    'pending',
    'confirmed',
    'cancelled'
);


ALTER TYPE public.booking_status OWNER TO kirstincathlin;

--
-- TOC entry 938 (class 1247 OID 16676)
-- Name: categoryrules; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.categoryrules AS ENUM (
    'general conduct',
    'checkin/checkout',
    'noise',
    'cleanliness & maintenance',
    'safety & security',
    'usage of property',
    'sustainability',
    'neighbourhood respect',
    'children & accessibility',
    'internet & technology'
);


ALTER TYPE public.categoryrules OWNER TO kirstincathlin;

--
-- TOC entry 935 (class 1247 OID 16669)
-- Name: hoststatus; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.hoststatus AS ENUM (
    'active',
    'inactive',
    'superhost'
);


ALTER TYPE public.hoststatus OWNER TO kirstincathlin;

--
-- TOC entry 923 (class 1247 OID 16632)
-- Name: language; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.language AS ENUM (
    'english',
    'french',
    'spanish',
    'mandarin',
    'german'
);


ALTER TYPE public.language OWNER TO kirstincathlin;

--
-- TOC entry 926 (class 1247 OID 16644)
-- Name: media; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.media AS ENUM (
    'google',
    'facebook',
    'linkedin'
);


ALTER TYPE public.media OWNER TO kirstincathlin;

--
-- TOC entry 869 (class 1247 OID 16482)
-- Name: status; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.status AS ENUM (
    'pending',
    'completed',
    'failed'
);


ALTER TYPE public.status OWNER TO kirstincathlin;

--
-- TOC entry 875 (class 1247 OID 16497)
-- Name: title; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.title AS ENUM (
    'Mr',
    'Miss',
    'Mrs'
);


ALTER TYPE public.title OWNER TO kirstincathlin;

--
-- TOC entry 896 (class 1247 OID 16542)
-- Name: type; Type: TYPE; Schema: public; Owner: kirstincathlin
--

CREATE TYPE public.type AS ENUM (
    'apartment',
    'private room',
    'shared room',
    'house'
);


ALTER TYPE public.type OWNER TO kirstincathlin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16474)
-- Name: address; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.address (
    addressid integer NOT NULL,
    street character varying(200) NOT NULL,
    city character varying(200) NOT NULL,
    stateprovince character varying(200) NOT NULL,
    postalcode integer NOT NULL,
    country character varying(200) NOT NULL
);


ALTER TABLE public.address OWNER TO kirstincathlin;

--
-- TOC entry 228 (class 1259 OID 16621)
-- Name: amenities; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.amenities (
    amenityid integer NOT NULL,
    amenityname character varying(200) NOT NULL,
    category public.amenity NOT NULL
);


ALTER TABLE public.amenities OWNER TO kirstincathlin;

--
-- TOC entry 238 (class 1259 OID 16975)
-- Name: amenitiesavailability; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.amenitiesavailability (
    amenityid integer NOT NULL,
    listingid integer NOT NULL,
    available boolean NOT NULL
);


ALTER TABLE public.amenitiesavailability OWNER TO kirstincathlin;

--
-- TOC entry 219 (class 1259 OID 16515)
-- Name: booking; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.booking (
    bookingid integer NOT NULL,
    userid integer NOT NULL,
    checkindate date NOT NULL,
    checkoutdate date NOT NULL,
    bookingstatus public.booking_status NOT NULL,
    messageid integer NOT NULL,
    listingid integer NOT NULL
);


ALTER TABLE public.booking OWNER TO kirstincathlin;

--
-- TOC entry 222 (class 1259 OID 16536)
-- Name: calendar; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.calendar (
    calendarid integer NOT NULL,
    bookingid integer NOT NULL
);


ALTER TABLE public.calendar OWNER TO kirstincathlin;

--
-- TOC entry 218 (class 1259 OID 16503)
-- Name: cardholder; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.cardholder (
    cardholderid integer NOT NULL,
    title public.title NOT NULL,
    firstname character varying(200) NOT NULL,
    lastname character varying(200) NOT NULL
);


ALTER TABLE public.cardholder OWNER TO kirstincathlin;

--
-- TOC entry 229 (class 1259 OID 16654)
-- Name: guestinfo; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.guestinfo (
    guestid integer NOT NULL,
    languagepreferences public.language NOT NULL,
    socialmediaaccounts public.media,
    addressid integer NOT NULL,
    transactionid integer NOT NULL
);


ALTER TABLE public.guestinfo OWNER TO kirstincathlin;

--
-- TOC entry 230 (class 1259 OID 16659)
-- Name: hostinfo; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.hostinfo (
    hostid integer NOT NULL,
    responserate numeric NOT NULL,
    sincewhen date NOT NULL,
    hoststatus public.hoststatus NOT NULL,
    listingid integer NOT NULL
);


ALTER TABLE public.hostinfo OWNER TO kirstincathlin;

--
-- TOC entry 231 (class 1259 OID 16697)
-- Name: houserules; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.houserules (
    houserulesid integer NOT NULL,
    rulesdescription text NOT NULL
);


ALTER TABLE public.houserules OWNER TO kirstincathlin;

--
-- TOC entry 223 (class 1259 OID 16551)
-- Name: listing; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.listing (
    listingid integer NOT NULL,
    listingname character varying(200) NOT NULL,
    roomtype public.type NOT NULL,
    description text NOT NULL,
    minimumstay integer NOT NULL,
    maximumstay integer NOT NULL,
    wishlistid integer NOT NULL,
    addressid integer NOT NULL,
    pricingid integer NOT NULL,
    photoid integer NOT NULL,
    calendarid integer NOT NULL,
    hostid integer NOT NULL,
    houserulesid integer NOT NULL,
    amenityid integer NOT NULL,
    ratingid integer NOT NULL
);


ALTER TABLE public.listing OWNER TO kirstincathlin;

--
-- TOC entry 232 (class 1259 OID 16735)
-- Name: messagebooking; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.messagebooking (
    bookingid integer NOT NULL,
    messagingid integer NOT NULL
);


ALTER TABLE public.messagebooking OWNER TO kirstincathlin;

--
-- TOC entry 227 (class 1259 OID 16598)
-- Name: messaging; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.messaging (
    messageid integer NOT NULL,
    contenthash character varying(300) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    userid integer NOT NULL,
    bookingid integer NOT NULL
);


ALTER TABLE public.messaging OWNER TO kirstincathlin;

--
-- TOC entry 235 (class 1259 OID 16955)
-- Name: messagingbooking; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.messagingbooking (
    bookingid integer NOT NULL,
    messagingid integer NOT NULL
);


ALTER TABLE public.messagingbooking OWNER TO kirstincathlin;

--
-- TOC entry 217 (class 1259 OID 16489)
-- Name: paymentdetails; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.paymentdetails (
    transactionid integer NOT NULL,
    paymentamount numeric NOT NULL,
    paymentdate date NOT NULL,
    creditcardnumberhash character(60) NOT NULL,
    expirationdatehash character varying(60) NOT NULL,
    cardholderid integer NOT NULL,
    cardverificationcodehash character(3) NOT NULL,
    paymentstatus public.status NOT NULL,
    addressid integer NOT NULL
);


ALTER TABLE public.paymentdetails OWNER TO kirstincathlin;

--
-- TOC entry 225 (class 1259 OID 16582)
-- Name: photos; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.photos (
    photoid integer NOT NULL,
    photodata bytea NOT NULL,
    caption character varying(200)
);


ALTER TABLE public.photos OWNER TO kirstincathlin;

--
-- TOC entry 224 (class 1259 OID 16575)
-- Name: pricing; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.pricing (
    pricingid integer NOT NULL,
    value numeric NOT NULL,
    currency character varying(20) NOT NULL
);


ALTER TABLE public.pricing OWNER TO kirstincathlin;

--
-- TOC entry 215 (class 1259 OID 16447)
-- Name: profile; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.profile (
    userid integer NOT NULL,
    firstname character varying(200) NOT NULL,
    lastname character varying(200) NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(200) NOT NULL,
    photourl character varying(200) NOT NULL,
    passwordhash character(60) NOT NULL,
    verificationinfoid integer NOT NULL,
    ratingid integer NOT NULL,
    hostid integer NOT NULL,
    addressid integer NOT NULL,
    transactionid integer NOT NULL,
    guestid integer NOT NULL
);


ALTER TABLE public.profile OWNER TO kirstincathlin;

--
-- TOC entry 236 (class 1259 OID 16960)
-- Name: ratingsprofileuser; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.ratingsprofileuser (
    ratingid integer NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.ratingsprofileuser OWNER TO kirstincathlin;

--
-- TOC entry 226 (class 1259 OID 16591)
-- Name: reviews; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.reviews (
    ratingid integer NOT NULL,
    comment text NOT NULL,
    rating double precision NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.reviews OWNER TO kirstincathlin;

--
-- TOC entry 237 (class 1259 OID 16970)
-- Name: rulesavailability; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.rulesavailability (
    houserulesid integer NOT NULL,
    listingid integer NOT NULL,
    available boolean NOT NULL
);


ALTER TABLE public.rulesavailability OWNER TO kirstincathlin;

--
-- TOC entry 234 (class 1259 OID 16950)
-- Name: userprofilelisting; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.userprofilelisting (
    userid integer NOT NULL,
    listingid integer NOT NULL
);


ALTER TABLE public.userprofilelisting OWNER TO kirstincathlin;

--
-- TOC entry 220 (class 1259 OID 16522)
-- Name: userverificationinfo; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.userverificationinfo (
    verificationinfoid integer NOT NULL,
    verificationdate date NOT NULL,
    emailverified boolean DEFAULT false NOT NULL,
    iddocumentverified boolean DEFAULT false NOT NULL
);


ALTER TABLE public.userverificationinfo OWNER TO kirstincathlin;

--
-- TOC entry 221 (class 1259 OID 16531)
-- Name: wishlist; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.wishlist (
    wishlistid integer NOT NULL,
    guestid integer NOT NULL,
    creationdate date NOT NULL,
    listingid integer NOT NULL
);


ALTER TABLE public.wishlist OWNER TO kirstincathlin;

--
-- TOC entry 233 (class 1259 OID 16750)
-- Name: wishlisting; Type: TABLE; Schema: public; Owner: kirstincathlin
--

CREATE TABLE public.wishlisting (
    wishlistid integer NOT NULL,
    listingid integer NOT NULL
);


ALTER TABLE public.wishlisting OWNER TO kirstincathlin;

--
-- TOC entry 3615 (class 2606 OID 17070)
-- Name: address address_addressid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_addressid_key UNIQUE (addressid);


--
-- TOC entry 3617 (class 2606 OID 16480)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (addressid);


--
-- TOC entry 3685 (class 2606 OID 17078)
-- Name: amenities amenities_amenityid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.amenities
    ADD CONSTRAINT amenities_amenityid_key UNIQUE (amenityid);


--
-- TOC entry 3687 (class 2606 OID 16625)
-- Name: amenities amenities_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.amenities
    ADD CONSTRAINT amenities_pkey PRIMARY KEY (amenityid);


--
-- TOC entry 3723 (class 2606 OID 17096)
-- Name: amenitiesavailability amenitiesavailability_amenityid_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.amenitiesavailability
    ADD CONSTRAINT amenitiesavailability_amenityid_listingid_key UNIQUE (amenityid, listingid);


--
-- TOC entry 3725 (class 2606 OID 16979)
-- Name: amenitiesavailability amenitiesavailability_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.amenitiesavailability
    ADD CONSTRAINT amenitiesavailability_pkey PRIMARY KEY (amenityid, listingid);


--
-- TOC entry 3627 (class 2606 OID 17058)
-- Name: booking booking_bookingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_bookingid_key UNIQUE (bookingid);


--
-- TOC entry 3629 (class 2606 OID 17064)
-- Name: booking booking_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_listingid_key UNIQUE (listingid);


--
-- TOC entry 3631 (class 2606 OID 17060)
-- Name: booking booking_messageid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_messageid_key UNIQUE (messageid);


--
-- TOC entry 3633 (class 2606 OID 16521)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (bookingid);


--
-- TOC entry 3635 (class 2606 OID 17062)
-- Name: booking booking_userid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_userid_key UNIQUE (userid);


--
-- TOC entry 3647 (class 2606 OID 17049)
-- Name: calendar calendar_calendarid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT calendar_calendarid_key UNIQUE (calendarid);


--
-- TOC entry 3649 (class 2606 OID 16540)
-- Name: calendar calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT calendar_pkey PRIMARY KEY (calendarid);


--
-- TOC entry 3623 (class 2606 OID 17066)
-- Name: cardholder cardholder_cardholderid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.cardholder
    ADD CONSTRAINT cardholder_cardholderid_key UNIQUE (cardholderid);


--
-- TOC entry 3625 (class 2606 OID 16507)
-- Name: cardholder cardholder_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.cardholder
    ADD CONSTRAINT cardholder_pkey PRIMARY KEY (cardholderid);


--
-- TOC entry 3689 (class 2606 OID 17082)
-- Name: guestinfo guestinfo_guestid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.guestinfo
    ADD CONSTRAINT guestinfo_guestid_key UNIQUE (guestid);


--
-- TOC entry 3691 (class 2606 OID 16658)
-- Name: guestinfo guestinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.guestinfo
    ADD CONSTRAINT guestinfo_pkey PRIMARY KEY (guestid);


--
-- TOC entry 3693 (class 2606 OID 17080)
-- Name: hostinfo hostinfo_hostid_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.hostinfo
    ADD CONSTRAINT hostinfo_hostid_listingid_key UNIQUE (hostid, listingid);


--
-- TOC entry 3695 (class 2606 OID 16665)
-- Name: hostinfo hostinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.hostinfo
    ADD CONSTRAINT hostinfo_pkey PRIMARY KEY (hostid);


--
-- TOC entry 3697 (class 2606 OID 17084)
-- Name: houserules houserules_houserulesid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.houserules
    ADD CONSTRAINT houserules_houserulesid_key UNIQUE (houserulesid);


--
-- TOC entry 3699 (class 2606 OID 16703)
-- Name: houserules houserules_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.houserules
    ADD CONSTRAINT houserules_pkey PRIMARY KEY (houserulesid);


--
-- TOC entry 3651 (class 2606 OID 17043)
-- Name: listing listing_addressid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_addressid_key UNIQUE (addressid);


--
-- TOC entry 3653 (class 2606 OID 17047)
-- Name: listing listing_houserulesid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_houserulesid_key UNIQUE (houserulesid);


--
-- TOC entry 3655 (class 2606 OID 17041)
-- Name: listing listing_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_listingid_key UNIQUE (listingid);


--
-- TOC entry 3657 (class 2606 OID 16559)
-- Name: listing listing_listingname_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_listingname_key UNIQUE (listingname);


--
-- TOC entry 3659 (class 2606 OID 17045)
-- Name: listing listing_photoid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_photoid_key UNIQUE (photoid);


--
-- TOC entry 3661 (class 2606 OID 16557)
-- Name: listing listing_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_pkey PRIMARY KEY (listingid);


--
-- TOC entry 3663 (class 2606 OID 16565)
-- Name: listing listing_wishlistid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT listing_wishlistid_key UNIQUE (wishlistid);


--
-- TOC entry 3701 (class 2606 OID 17088)
-- Name: messagebooking messagebooking_bookingid_messagingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.messagebooking
    ADD CONSTRAINT messagebooking_bookingid_messagingid_key UNIQUE (bookingid, messagingid);


--
-- TOC entry 3703 (class 2606 OID 16739)
-- Name: messagebooking messagebooking_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.messagebooking
    ADD CONSTRAINT messagebooking_pkey PRIMARY KEY (bookingid, messagingid);


--
-- TOC entry 3681 (class 2606 OID 17076)
-- Name: messaging messaging_messageid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.messaging
    ADD CONSTRAINT messaging_messageid_key UNIQUE (messageid);


--
-- TOC entry 3683 (class 2606 OID 16604)
-- Name: messaging messaging_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.messaging
    ADD CONSTRAINT messaging_pkey PRIMARY KEY (messageid);


--
-- TOC entry 3713 (class 2606 OID 16959)
-- Name: messagingbooking messagingbooking_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.messagingbooking
    ADD CONSTRAINT messagingbooking_pkey PRIMARY KEY (bookingid, messagingid);


--
-- TOC entry 3619 (class 2606 OID 16495)
-- Name: paymentdetails paymentdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.paymentdetails
    ADD CONSTRAINT paymentdetails_pkey PRIMARY KEY (transactionid);


--
-- TOC entry 3621 (class 2606 OID 17068)
-- Name: paymentdetails paymentdetails_transactionid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.paymentdetails
    ADD CONSTRAINT paymentdetails_transactionid_key UNIQUE (transactionid);


--
-- TOC entry 3669 (class 2606 OID 16590)
-- Name: photos photos_photodata_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_photodata_key UNIQUE (photodata);


--
-- TOC entry 3671 (class 2606 OID 17037)
-- Name: photos photos_photodata_key1; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_photodata_key1 UNIQUE (photodata);


--
-- TOC entry 3673 (class 2606 OID 17035)
-- Name: photos photos_photoid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_photoid_key UNIQUE (photoid);


--
-- TOC entry 3675 (class 2606 OID 16588)
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (photoid);


--
-- TOC entry 3665 (class 2606 OID 16581)
-- Name: pricing pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_pkey PRIMARY KEY (pricingid);


--
-- TOC entry 3667 (class 2606 OID 17039)
-- Name: pricing pricing_pricingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_pricingid_key UNIQUE (pricingid);


--
-- TOC entry 3589 (class 2606 OID 16471)
-- Name: profile profile_addressid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_addressid_key UNIQUE (addressid);


--
-- TOC entry 3591 (class 2606 OID 16457)
-- Name: profile profile_email_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_email_key UNIQUE (email);


--
-- TOC entry 3593 (class 2606 OID 17074)
-- Name: profile profile_email_phone_photourl_passwordhash_verificationinfoi_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_email_phone_photourl_passwordhash_verificationinfoi_key UNIQUE (email, phone, photourl, passwordhash, verificationinfoid, ratingid, hostid, guestid, addressid, transactionid);


--
-- TOC entry 3595 (class 2606 OID 16469)
-- Name: profile profile_hostid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_hostid_key UNIQUE (hostid);


--
-- TOC entry 3597 (class 2606 OID 16463)
-- Name: profile profile_passwordhash_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_passwordhash_key UNIQUE (passwordhash);


--
-- TOC entry 3599 (class 2606 OID 16459)
-- Name: profile profile_phone_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_phone_key UNIQUE (phone);


--
-- TOC entry 3601 (class 2606 OID 16461)
-- Name: profile profile_photourl_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_photourl_key UNIQUE (photourl);


--
-- TOC entry 3603 (class 2606 OID 16453)
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (userid);


--
-- TOC entry 3605 (class 2606 OID 16779)
-- Name: profile profile_reviews_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_reviews_key UNIQUE (ratingid);


--
-- TOC entry 3607 (class 2606 OID 16473)
-- Name: profile profile_transactionid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_transactionid_key UNIQUE (transactionid);


--
-- TOC entry 3609 (class 2606 OID 17072)
-- Name: profile profile_userid_username_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_userid_username_key UNIQUE (userid, username);


--
-- TOC entry 3611 (class 2606 OID 16455)
-- Name: profile profile_username_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_username_key UNIQUE (username);


--
-- TOC entry 3613 (class 2606 OID 16465)
-- Name: profile profile_userverificationinfo_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_userverificationinfo_key UNIQUE (verificationinfoid);


--
-- TOC entry 3715 (class 2606 OID 16964)
-- Name: ratingsprofileuser ratingsprofileuser_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.ratingsprofileuser
    ADD CONSTRAINT ratingsprofileuser_pkey PRIMARY KEY (ratingid, userid);


--
-- TOC entry 3717 (class 2606 OID 17090)
-- Name: ratingsprofileuser ratingsprofileuser_ratingid_userid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.ratingsprofileuser
    ADD CONSTRAINT ratingsprofileuser_ratingid_userid_key UNIQUE (ratingid, userid);


--
-- TOC entry 3677 (class 2606 OID 16597)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (ratingid);


--
-- TOC entry 3679 (class 2606 OID 17033)
-- Name: reviews reviews_ratingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_ratingid_key UNIQUE (ratingid);


--
-- TOC entry 3719 (class 2606 OID 17094)
-- Name: rulesavailability rulesavailability_houserulesid_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.rulesavailability
    ADD CONSTRAINT rulesavailability_houserulesid_listingid_key UNIQUE (houserulesid, listingid);


--
-- TOC entry 3721 (class 2606 OID 16974)
-- Name: rulesavailability rulesavailability_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.rulesavailability
    ADD CONSTRAINT rulesavailability_pkey PRIMARY KEY (houserulesid, listingid);


--
-- TOC entry 3709 (class 2606 OID 16954)
-- Name: userprofilelisting userprofilelisting_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.userprofilelisting
    ADD CONSTRAINT userprofilelisting_pkey PRIMARY KEY (userid, listingid);


--
-- TOC entry 3711 (class 2606 OID 17086)
-- Name: userprofilelisting userprofilelisting_userid_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.userprofilelisting
    ADD CONSTRAINT userprofilelisting_userid_listingid_key UNIQUE (userid, listingid);


--
-- TOC entry 3637 (class 2606 OID 16526)
-- Name: userverificationinfo userverificationinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.userverificationinfo
    ADD CONSTRAINT userverificationinfo_pkey PRIMARY KEY (verificationinfoid);


--
-- TOC entry 3639 (class 2606 OID 17055)
-- Name: userverificationinfo userverificationinfo_verificationinfoid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.userverificationinfo
    ADD CONSTRAINT userverificationinfo_verificationinfoid_key UNIQUE (verificationinfoid);


--
-- TOC entry 3641 (class 2606 OID 17053)
-- Name: wishlist wishlist_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_listingid_key UNIQUE (listingid);


--
-- TOC entry 3643 (class 2606 OID 16535)
-- Name: wishlist wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_pkey PRIMARY KEY (wishlistid);


--
-- TOC entry 3645 (class 2606 OID 17051)
-- Name: wishlist wishlist_wishlistid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_wishlistid_key UNIQUE (wishlistid);


--
-- TOC entry 3705 (class 2606 OID 16754)
-- Name: wishlisting wishlisting_pkey; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.wishlisting
    ADD CONSTRAINT wishlisting_pkey PRIMARY KEY (wishlistid, listingid);


--
-- TOC entry 3707 (class 2606 OID 17092)
-- Name: wishlisting wishlisting_wishlistid_listingid_key; Type: CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.wishlisting
    ADD CONSTRAINT wishlisting_wishlistid_listingid_key UNIQUE (wishlistid, listingid);


--
-- TOC entry 3726 (class 2606 OID 16755)
-- Name: profile fk; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fk FOREIGN KEY (verificationinfoid) REFERENCES public.userverificationinfo(verificationinfoid);


--
-- TOC entry 3727 (class 2606 OID 16806)
-- Name: profile fk_address; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fk_address FOREIGN KEY (addressid) REFERENCES public.address(addressid);


--
-- TOC entry 3733 (class 2606 OID 16837)
-- Name: paymentdetails fk_address; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.paymentdetails
    ADD CONSTRAINT fk_address FOREIGN KEY (addressid) REFERENCES public.address(addressid);


--
-- TOC entry 3752 (class 2606 OID 16885)
-- Name: guestinfo fk_address; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.guestinfo
    ADD CONSTRAINT fk_address FOREIGN KEY (addressid) REFERENCES public.address(addressid);


--
-- TOC entry 3741 (class 2606 OID 16900)
-- Name: listing fk_address; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_address FOREIGN KEY (addressid) REFERENCES public.address(addressid);


--
-- TOC entry 3742 (class 2606 OID 16940)
-- Name: listing fk_amenity; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_amenity FOREIGN KEY (amenityid) REFERENCES public.amenities(amenityid);


--
-- TOC entry 3740 (class 2606 OID 16866)
-- Name: calendar fk_booking; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT fk_booking FOREIGN KEY (bookingid) REFERENCES public.booking(bookingid);


--
-- TOC entry 3735 (class 2606 OID 17000)
-- Name: booking fk_booking; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_booking FOREIGN KEY (bookingid) REFERENCES public.booking(bookingid);


--
-- TOC entry 3743 (class 2606 OID 16920)
-- Name: listing fk_calendar; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_calendar FOREIGN KEY (calendarid) REFERENCES public.calendar(calendarid);


--
-- TOC entry 3734 (class 2606 OID 16832)
-- Name: paymentdetails fk_cardholder; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.paymentdetails
    ADD CONSTRAINT fk_cardholder FOREIGN KEY (cardholderid) REFERENCES public.cardholder(cardholderid);


--
-- TOC entry 3738 (class 2606 OID 16856)
-- Name: wishlist fk_guest; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT fk_guest FOREIGN KEY (guestid) REFERENCES public.guestinfo(guestid);


--
-- TOC entry 3728 (class 2606 OID 16980)
-- Name: profile fk_guest; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fk_guest FOREIGN KEY (guestid) REFERENCES public.guestinfo(guestid);


--
-- TOC entry 3729 (class 2606 OID 16801)
-- Name: profile fk_host; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fk_host FOREIGN KEY (hostid) REFERENCES public.hostinfo(hostid);


--
-- TOC entry 3744 (class 2606 OID 16925)
-- Name: listing fk_host; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_host FOREIGN KEY (hostid) REFERENCES public.hostinfo(hostid);


--
-- TOC entry 3745 (class 2606 OID 16935)
-- Name: listing fk_houserules; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_houserules FOREIGN KEY (houserulesid) REFERENCES public.houserules(houserulesid);


--
-- TOC entry 3754 (class 2606 OID 16985)
-- Name: hostinfo fk_listing; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.hostinfo
    ADD CONSTRAINT fk_listing FOREIGN KEY (hostid) REFERENCES public.hostinfo(hostid);


--
-- TOC entry 3739 (class 2606 OID 17005)
-- Name: wishlist fk_listing; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT fk_listing FOREIGN KEY (listingid) REFERENCES public.listing(listingid);


--
-- TOC entry 3736 (class 2606 OID 16895)
-- Name: booking fk_message; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_message FOREIGN KEY (messageid) REFERENCES public.messaging(messageid);


--
-- TOC entry 3751 (class 2606 OID 16995)
-- Name: messaging fk_message; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.messaging
    ADD CONSTRAINT fk_message FOREIGN KEY (bookingid) REFERENCES public.booking(bookingid);


--
-- TOC entry 3746 (class 2606 OID 16910)
-- Name: listing fk_photo; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_photo FOREIGN KEY (photoid) REFERENCES public.photos(photoid);


--
-- TOC entry 3747 (class 2606 OID 16905)
-- Name: listing fk_pricing; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_pricing FOREIGN KEY (pricingid) REFERENCES public.pricing(pricingid);


--
-- TOC entry 3730 (class 2606 OID 16796)
-- Name: profile fk_rating; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fk_rating FOREIGN KEY (ratingid) REFERENCES public.reviews(ratingid);


--
-- TOC entry 3748 (class 2606 OID 16945)
-- Name: listing fk_rating; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_rating FOREIGN KEY (ratingid) REFERENCES public.reviews(ratingid);


--
-- TOC entry 3731 (class 2606 OID 16811)
-- Name: profile fk_transaction; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fk_transaction FOREIGN KEY (transactionid) REFERENCES public.paymentdetails(transactionid);


--
-- TOC entry 3753 (class 2606 OID 16890)
-- Name: guestinfo fk_transaction; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.guestinfo
    ADD CONSTRAINT fk_transaction FOREIGN KEY (transactionid) REFERENCES public.paymentdetails(transactionid);


--
-- TOC entry 3737 (class 2606 OID 16846)
-- Name: booking fk_user; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_user FOREIGN KEY (userid) REFERENCES public.profile(userid);


--
-- TOC entry 3750 (class 2606 OID 16990)
-- Name: reviews fk_user; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_user FOREIGN KEY (userid) REFERENCES public.profile(userid);


--
-- TOC entry 3732 (class 2606 OID 16821)
-- Name: profile fk_verification; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fk_verification FOREIGN KEY (verificationinfoid) REFERENCES public.userverificationinfo(verificationinfoid);


--
-- TOC entry 3749 (class 2606 OID 16930)
-- Name: listing fk_wishlist; Type: FK CONSTRAINT; Schema: public; Owner: kirstincathlin
--

ALTER TABLE ONLY public.listing
    ADD CONSTRAINT fk_wishlist FOREIGN KEY (wishlistid) REFERENCES public.wishlist(wishlistid);


-- Completed on 2024-07-21 19:28:37 CEST

--
-- PostgreSQL database dump complete
--

